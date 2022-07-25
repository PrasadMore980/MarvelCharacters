import Foundation

public struct CharacterModel: Equatable {
    public let id: Int
    public let name: String
    public let thumbnail: URL?
    public let description: String?
    
    public init(id: Int, name: String, thumbnail: URL, description: String?){
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }
}
