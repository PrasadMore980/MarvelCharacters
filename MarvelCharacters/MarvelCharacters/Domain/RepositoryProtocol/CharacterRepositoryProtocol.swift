import Foundation

public protocol CharacterRepositoryProtocol {
    typealias CharacterListCompletion = (_ result: Result<CharacterListModel?, UseCaseError>) -> Void
    typealias CharacterDetailCompletion = (_ result: Result<CharacterModel?, UseCaseError>) -> Void
    
    func getCharactersList(offset: Int, limit: Int, completion: @escaping CharacterListCompletion)
    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailCompletion)
}
