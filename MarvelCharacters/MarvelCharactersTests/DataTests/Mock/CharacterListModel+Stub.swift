import Foundation
@testable import MarvelCharacters

extension CharacterListModel {
    static func stubData() -> CharacterListModel {
        return CharacterListModel(offset: 0, total: 100, results: [CharacterModel.stubData()])
    }
}
