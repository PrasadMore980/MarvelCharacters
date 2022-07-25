@testable import MarvelCharacters
import Foundation
class CharacterListUseCaseMock: CharacterListUseCaseProtocol {
    var result: Result<CharacterListModel?, UseCaseError>?

    func getCharacterList(offset: Int, limit: Int, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("CharacterListUseCase mock error")
        }
        completion(result)
    }
    
}
