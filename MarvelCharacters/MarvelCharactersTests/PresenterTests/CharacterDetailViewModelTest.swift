import XCTest
@testable import MarvelCharacters

class CharacterDetailViewModelTest: XCTestCase {
    private var viewModel: CharacterDetailViewModelProtocol?
    private var detailUseCase = CharacterDetailUseCaseMock()

    override func setUp() {
        super.setUp()
        let dependancy = CharacterDetailViewModelDependencies(characterDetailUseCase: detailUseCase,
                                                              characterId: 1017100)
        viewModel = CharacterDetailViewModel(dependancy: dependancy)
    }
    
    func testForCharacterDetailSuccess() {
        let expectedResult = expectation(description: "Success")
        detailUseCase.result = .success(CharacterModel.stubData())
        viewModel?.fetchCharacterDetail()
        if viewModel?.name.value != nil && viewModel?.thumbnail.value != nil && viewModel?.description.value != nil {
            expectedResult.fulfill()
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testForCharacterDetailFailure()  {
        let expectedResult = expectation(description: "Error")
        detailUseCase.result = .failure(.invalidURL)
        viewModel?.fetchCharacterDetail()
        if viewModel?.error.value != nil {
            expectedResult.fulfill()
        }
        wait(for: [expectedResult], timeout: 1)
    }
}
