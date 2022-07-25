import Foundation

@testable import MarvelCharacters

final class RepositoryMock: CharacterRepositoryProtocol {
    
    var getCharacterList: Result<CharacterListModel?, UseCaseError>?
    var getCharacterDetail: Result<CharacterModel?, UseCaseError>?

    func getCharactersList(offset: Int, limit: Int, completion: @escaping CharacterListCompletion) {
        guard let result = getCharacterList else {
            fatalError("getCharacterList mock error")
        }
        completion(result)
    }

    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailCompletion) {
        guard let result = getCharacterDetail else {
            fatalError("getCharacterDetail mock error")
        }
        completion(result)
    }
}
