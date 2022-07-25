@testable import MarvelCharacters
import XCTest

class CharacterRepositoryTest: XCTestCase {
    private var stubClosure: Provider<CharacterEndPoint>.StubClosure = Provider.immediatelyStub
    private var completion = Provider<CharacterEndPoint>.defaultEndpointMapping
    private let timeOutResponse = EndpointSampleResponse.networkError(NSError(domain: NSURLErrorDomain, code: 409))
    private var successResponse : EndpointSampleResponse?
    private var successDetailsResponse : EndpointSampleResponse?

    override func setUp() {
        self.setupSuccessListResponse()
        self.setupSuccessDetailsResponse()
    }
    
    func setupSuccessDetailsResponse() {
        let thumbnail = CharacterImageEntity(path: "noPath", fileExtension: "jpg")
        let success = CharacterEntity(id: 0, name: "Prasad", description: "", thumbnail: thumbnail)
        let entity = CharacterListEntity.init(offset: 0, total: 0, results: [success])
        let data = CharacterDataWrapperEntity(code: 0, status: "success", data: entity)
        do {
            let successData = try JSONEncoder().encode(data)
            let successHTTPResponse = HTTPURLResponse(url: URL(string: "www.globant.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            successDetailsResponse = EndpointSampleResponse.response(successHTTPResponse!, successData)
        } catch {
            print(error)
        }
    }
    
    func setupSuccessListResponse() {
        let success = CharacterEntity(id: 0, name: "Prasad", description: "", thumbnail: nil)
        let entity = CharacterListEntity.init(offset: 0, total: 0, results: [success])
        let data = CharacterDataWrapperEntity(code: 0, status: "success", data: entity)
        do {
            let successData = try JSONEncoder().encode(data)
            let successHTTPResponse = HTTPURLResponse(url: URL(string: "www.globant.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            successResponse = EndpointSampleResponse.response(successHTTPResponse!, successData)
        } catch {
            print(error)
        }
    }
    
    func getEndpoints(response: EndpointSampleResponse) -> CharacterRepositoryProtocol {
        self.completion = { (target : CharacterEndPoint) -> Endpoint in
            return Endpoint(url: target.baseURL.absoluteString,
                           sampleResponseClosure: { response },
                           method: target.method,
                            task: target.task, httpHeaderFields: target.headers)
        }
        let serviceProvider = Provider<CharacterEndPoint>(endpointClosure: self.completion, stubClosure: stubClosure)
        let repo = CharacterRepository(serviceProvider: serviceProvider)
        return repo
    }
    
    func testForGetCharacterListUseCaseWithSuccess() {
        let expectedResult = expectation(description: "success")
        let repo = getEndpoints(response: successResponse!)
        repo.getCharactersList(offset: 1, limit: 10) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }
    
    func testForGetCharacterDetailsUseCaseWithSuccess() {
        let expectedResult = expectation(description: "success")
        let repo = getEndpoints(response: successDetailsResponse!)
        repo.getCharacterDetails(id: 1) { result in
            if case .success = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

    
    func testForGetCharacterListUseCaseWithFailure() {
        let expectedResult = expectation(description: "timeoutResponse")
        let repo = getEndpoints(response: timeOutResponse)
        repo.getCharactersList(offset: 1, limit: 10) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

    func testForGetDetailWithFailure() {
        let expectedResult = expectation(description: "timeoutResponse")
        let repo = getEndpoints(response: timeOutResponse)
        repo.getCharacterDetails(id: 1011334) { result in
            if case .failure = result {
                expectedResult.fulfill()
            }
        }
        wait(for: [expectedResult], timeout: 1)
    }

}
