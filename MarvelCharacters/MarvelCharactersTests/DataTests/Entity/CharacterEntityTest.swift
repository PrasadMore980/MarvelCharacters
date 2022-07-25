import XCTest
@testable import MarvelCharacters

class CharacterEntityTest: XCTestCase {

    func testForCharacterEntityToDomain() {
        let entity = CharacterEntity(id: 9, name: "Prasad", description: "", thumbnail: CharacterImageEntity(path: "default", fileExtension: "png"))
        let expectedModel = CharacterModel(id: 9, name: "Prasad", thumbnail: URL(string: "default.png")!, description: "" )
        XCTAssertEqual(try entity.toDomainModel(), expectedModel)
    }

    func testForInvalidId() {
        let entity = CharacterEntity(id: nil, name: "Prasad", description: "", thumbnail: CharacterImageEntity(path: "default", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("id", String(describing: context.codingPath[0].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }

    func testForInvalidName() {
        let entity = CharacterEntity(id: 1, name: nil, description: "", thumbnail: CharacterImageEntity(path: "www.google.com", fileExtension: "png"))
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("name", String(describing: context.codingPath[1].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
    
    func testForInvalidThumbnail() {
        let entity = CharacterEntity(id: 1, name: "Prasad", description: "", thumbnail: nil)
        XCTAssertThrowsError(try entity.toDomainModel()) { error in
            if case let .valueNotFound(_, context)? = error as? DecodingError {
                XCTAssertEqual("thumbnail", String(describing: context.codingPath[2].stringValue))
            } else {
                XCTFail("Expected '.valueNotFound' but got \(error)")
            }
        }
    }
}
