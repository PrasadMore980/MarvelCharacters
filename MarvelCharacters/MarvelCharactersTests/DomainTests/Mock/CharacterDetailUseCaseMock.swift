import Foundation
@testable import MarvelCharacters

final class CharacterDetailUseCaseMock: CharacterDetailUseCaseProtocol {
    var result: Result<CharacterModel?, UseCaseError>?

    func getCharacterDetailWith(id: Int, completion: @escaping Completion) {
        guard let result = result else {
            fatalError("DetailUseCase mock error")
        }
        completion(result)
    }
}
