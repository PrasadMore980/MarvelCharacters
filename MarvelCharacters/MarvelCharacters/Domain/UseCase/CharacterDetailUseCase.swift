import Foundation

public protocol CharacterDetailUseCaseProtocol: AnyObject {
    typealias Completion = (_ result: Result<CharacterModel?, UseCaseError>) -> Void
    func getCharacterDetailWith(id: Int, completion: @escaping Completion)
}

public struct CharacterDetailUseCaseDependencies {
    let repository: CharacterRepositoryProtocol?
}

public final class CharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private var repository: CharacterRepositoryProtocol?

    public init(repository: CharacterRepositoryProtocol?) {
        self.repository = repository
    }
    
    convenience init(dependancy: CharacterDetailUseCaseDependencies) {
        self.init(repository: dependancy.repository)
    }

    public func getCharacterDetailWith(id: Int, completion: @escaping Completion) {
        repository?.getCharacterDetails(id: id, completion: completion)
    }
}
