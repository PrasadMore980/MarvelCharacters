@testable import MarvelCharacters
import XCTest

final class CharacterListUseCaseTest: XCTestCase {
    private var characterListUseCase: CharacterListUseCaseProtocol?
    private var repository = RepositoryMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterListUseCaseDependencies(repository: repository)
        characterListUseCase = CharacterListUseCase(dependancy: dependancy)
    }

    func testForGetCharacterListUseCaseWithSuccess() {
        let expectedResult = expectation(description: "Success")
        repository.getCharacterList = .success(CharacterListModel.stubData())
        characterListUseCase?.getCharacterList(offset: 1, limit: 10) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testForGetCharacterListUseCaseWithFailure() {
        let expectedResult = expectation(description: "Error")
        repository.getCharacterList = .failure(.invalidURL)
        characterListUseCase?.getCharacterList(offset: 1, limit: 10) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
