@testable import MarvelCharacters
import XCTest

final class CharacterDetailUseCaseTest: XCTestCase {
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol?
    private var characterRepository = RepositoryMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterDetailUseCaseDependencies(repository: characterRepository)
        characterDetailUseCase = CharacterDetailUseCase(dependancy: dependancy)
    }

    func testForGetCharacterDetailUseCaseWithSuccess() {
        let expectedResult = expectation(description: "Success")
        characterRepository.getCharacterDetail = .success(CharacterModel.stubData())
        characterDetailUseCase?.getCharacterDetailWith(id: 1, completion: { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        })
        wait(for: [expectedResult], timeout: 1)
    }

    func testForGetCharacterDetailUseCaseWithFailure() {
        let expectedResult = expectation(description: "Error")
        characterRepository.getCharacterDetail = .failure(.invalidURL)
        characterDetailUseCase?.getCharacterDetailWith(id:1) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
