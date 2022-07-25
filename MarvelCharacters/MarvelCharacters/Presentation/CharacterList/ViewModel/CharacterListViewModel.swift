import Foundation

protocol CharacterListViewModelProtocol {
    var characterListDataSource: Observable<[CharacterModel]> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }

    func fetchCharacterList()
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func getCharacterCellViewModel(_ indexPath: IndexPath) -> CharacterCellViewModel
    func navigateToDetailScene(_ fromScreen: CharacterListViewProtocol, indexPath: IndexPath)
    func didScrolledTo(rowIndex: Int)
}

struct CharacterListViewModelDependencies {
    let characterListUseCase: CharacterListUseCaseProtocol?
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    var characterListDataSource: Observable<[CharacterModel]> = Observable([])
    var loading: Observable<Bool> = Observable.init(false)
    var error: Observable<String> = Observable("")

    private var characterListUseCase: CharacterListUseCaseProtocol?
    private var limit: Int = Int(Constants.twenty)
    private var total: Int = Int(Constants.zero)
    private var offset: Int = Int(Constants.zero)
    private var lastIndex = Int(Constants.zero)

    init(dependancy: CharacterListViewModelDependencies) {
        self.characterListUseCase = dependancy.characterListUseCase
    }
        
    func numberOfSections() -> Int {
        return Int(Constants.one)
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return characterListDataSource.value.count
    }

    func getCharacterCellViewModel(_ indexPath: IndexPath) -> CharacterCellViewModel {
        let characterModel = characterListDataSource.value[indexPath.row]
        return CharacterCellViewModel(name: characterModel.name, thumbnailURL: characterModel.thumbnail)
    }
    
    func navigateToDetailScene(_ fromScreen: CharacterListViewProtocol, indexPath: IndexPath) {
        let characterModel = characterListDataSource.value[indexPath.row]
        NavigationCoordinator.sharedInstance.navigate(sceneType: .characterDetail(characterId: characterModel.id), fromScreen: fromScreen)
    }

    func fetchCharacterList() {
        loading.value = true
        characterListUseCase?.getCharacterList(offset: self.offset, limit: self.limit, completion: { [weak self] result in
            guard let self = self else { return }
            self.loading.value = false
            self.offset += self.limit
            switch result {
            case .success(let characterListModel):
                guard let list = characterListModel, !list.results.isEmpty else { return }
                self.total = list.total
                self.characterListDataSource.value.append(contentsOf: list.results)
                self.lastIndex = self.characterListDataSource.value.count
            case .failure:
                self.handle(error: ViewModelError.characterListError)
            }
        })
    }
    
    private func handle(error: ViewModelError) {
        self.error.value = error.errorDescription
    }
    
    func didScrolledTo(rowIndex: Int) {
        if (rowIndex == lastIndex - 1) && !loading.value {
            fetchCharacterList()
        }
    }
}
