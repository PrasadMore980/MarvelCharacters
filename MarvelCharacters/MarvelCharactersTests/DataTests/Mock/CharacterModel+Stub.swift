import Foundation
@testable import MarvelCharacters

extension CharacterModel {
    static func stubData() -> CharacterModel {
        return CharacterModel(id: 0, name: "Prasad", thumbnail: URL(string: "www.globant.com")!, description: "BIG, Storng")
    }
}
