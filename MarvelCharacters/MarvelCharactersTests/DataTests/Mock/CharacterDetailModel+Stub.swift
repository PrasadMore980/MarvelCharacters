import Foundation
@testable import MarvelCharacters

extension CharacterDetailModel {
    static func stubData() -> CharacterDetailModel {
        return CharacterDetailModel(id: 0, name: "Prasad", description: "BIG, Storng", thumbnail: URL(string: "www.globant.com")!)
        
    }
}
