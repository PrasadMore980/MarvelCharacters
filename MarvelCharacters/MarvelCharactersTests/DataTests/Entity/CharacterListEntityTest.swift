import XCTest
@testable import MarvelCharacters

class CharacterListEntityTest: XCTestCase {
    func testForCharacterListEntityToDomain() {
        let entity = CharacterListEntity(offset: 10, total: 10, results: [CharacterEntity]())
        let expectedModel = CharacterListModel(offset: 10, total: 10, results: [])
        XCTAssertEqual(try entity.toDomainModel(), expectedModel)
    }

    func testForInvalidOffSet() {
        let entity = CharacterListEntity(offset: nil, total: 10, results: [CharacterEntity]())
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("offset", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testForInvalidTotal() {
        let entity = CharacterListEntity(offset: 10, total: nil, results: [CharacterEntity]())
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("total", String(describing: context.codingPath[1].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testForInvalidResult() {
        let entity = CharacterListEntity(offset: 10, total: 10, results: nil)
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("results", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
}
