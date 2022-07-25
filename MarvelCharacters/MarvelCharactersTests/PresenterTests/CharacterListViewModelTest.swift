@testable import MarvelCharacters
import XCTest

final class CharacterListViewModelTest: XCTestCase {
    private var viewModel: CharacterListViewModelProtocol?
    private var listUseCase = CharacterListUseCaseMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterListViewModelDependencies(characterListUseCase: listUseCase)
        viewModel = CharacterListViewModel(dependancy: dependancy)
    }
    
    func testForCharacterDetailSuccess() {
        let expectedResult = expectation(description: "Success")
        listUseCase.result = .success(CharacterListModel.stubData())
        viewModel?.fetchCharacterList()
        if viewModel?.characterListDataSource.value != nil {
            expectedResult.fulfill()
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testForCharacterDetailFailure()  {
        let expectedResult = expectation(description: "Error")
        listUseCase.result = .failure(.invalidURL)
        viewModel?.fetchCharacterList()
        if viewModel?.error.value != nil {
            expectedResult.fulfill()
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
