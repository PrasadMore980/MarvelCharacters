import Foundation

struct CharacterEntity: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharacterImageEntity?
    
    func toDomainModel() throws -> CharacterModel {
        guard let id = id, let name = name, let thumbnail = thumbnail else {
            throw DecodingError.valueNotFound(CharacterEntity.self,
                                              DecodingError.Context(codingPath: [CharacterEntity.CodingKeys.id,
                                                                                 CharacterEntity.CodingKeys.name,
                                                                                 CharacterEntity.CodingKeys.thumbnail],
                                                                    debugDescription: "Failed to decode \(CharacterEntity.self)"))
        }
        
        return CharacterModel(id: id, name: name, thumbnail: try thumbnail.toDomainModel()!, description: description ?? "")
    }
}
