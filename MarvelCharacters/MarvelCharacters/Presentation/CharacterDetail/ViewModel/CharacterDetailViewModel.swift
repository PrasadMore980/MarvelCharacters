import Foundation

protocol CharacterDetailViewModelProtocol {
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }
    var name: Observable<String> { get }
    var description: Observable<String> { get }
    var thumbnail: Observable<URL?> { get }
    
    func fetchCharacterDetail()
}

struct CharacterDetailViewModelDependencies {
    let characterDetailUseCase: CharacterDetailUseCaseProtocol?
    let characterId: Int
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol?
    private var characterId: Int = 0
    var name: Observable<String> = Observable("")
    var description: Observable<String> = Observable("")
    var thumbnail: Observable<URL?> = Observable(nil)
    var loading: Observable<Bool> = Observable.init(false)
    var error: Observable<String> = Observable("")

    init(dependancy: CharacterDetailViewModelDependencies) {
        self.characterDetailUseCase = dependancy.characterDetailUseCase
        self.characterId = dependancy.characterId
    }
    
    func fetchCharacterDetail() {
        characterDetailUseCase?.getCharacterDetailWith(id: characterId, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characterModel):
                if let detailModel = characterModel {
                    self.name.value = detailModel.name
                    self.description.value = detailModel.description ?? ""
                    self.thumbnail.value = detailModel.thumbnail
                } else {
                    self.handle(error: .characterDetailError)
                }
            case .failure:
                self.handle(error: .characterDetailError)
            }
        })
    }
    
    private func handle(error: ViewModelError) {
        self.error.value = error.errorDescription
    }
}
