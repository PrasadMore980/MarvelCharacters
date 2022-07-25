import Foundation

public struct CharacterListModel: Equatable {
    public let offset: Int
    public let total: Int
    public let results: [CharacterModel]
    
    public init(offset: Int, total: Int, results: [CharacterModel]) {
        self.offset = offset
        self.total = total
        self.results = results
    }
}
