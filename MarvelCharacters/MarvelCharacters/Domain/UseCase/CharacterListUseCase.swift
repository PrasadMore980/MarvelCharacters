import Foundation

public protocol CharacterListUseCaseProtocol: AnyObject {
    typealias Completion = (_ result: Result<CharacterListModel?, UseCaseError>) -> Void
    func getCharacterList(offset: Int, limit: Int, completion: @escaping Completion)
}

public struct CharacterListUseCaseDependencies {
    let repository: CharacterRepositoryProtocol?
}

public final class CharacterListUseCase: CharacterListUseCaseProtocol {
    private var repository: CharacterRepositoryProtocol?

    public init(repository: CharacterRepositoryProtocol?) {
        self.repository = repository
    }
    
    convenience init(dependancy: CharacterListUseCaseDependencies) {
        self.init(repository: dependancy.repository)
    }

    public func getCharacterList(offset: Int, limit: Int, completion: @escaping Completion) {
        repository?.getCharactersList(offset: offset, limit: limit, completion: completion)
    }
}
