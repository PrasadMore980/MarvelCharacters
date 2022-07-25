import XCTest
@testable import MarvelCharacters

class CharacterImageEntityTest: XCTestCase {
    
    func testForCharacterImageEntityToDomain() {
        func testForCharacterImageEntityToDomain() {
            let entity = CharacterImageEntity(path: "www.globant.com", fileExtension: "png")
            let expectedURL = URL(string: "www.globant.com.png")
            XCTAssertEqual(try entity.toDomainModel(), expectedURL)
        }
    }
}
