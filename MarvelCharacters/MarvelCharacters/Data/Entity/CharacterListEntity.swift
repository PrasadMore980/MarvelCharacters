import Foundation

struct CharacterListEntity: Codable {
    let offset: Int?
    let total: Int?
    let results: [CharacterEntity]?
    
    func toDomainModel() throws -> CharacterListModel {
        guard let offset = offset, let total = total else {
            throw DecodingError.valueNotFound(CharacterListEntity.self,
                                              DecodingError.Context(codingPath: [CharacterListEntity.CodingKeys.offset,
                                                                                 CharacterListEntity.CodingKeys.total],
                                                                    debugDescription: "Failed to decode \(CharacterListEntity.self)"))
        }

        guard let items = results?.compactMap({ charactersEntity in
            return try? charactersEntity.toDomainModel()
        })  else {
            throw DecodingError.valueNotFound([CharacterListEntity].self,
                                              DecodingError.Context(codingPath: [CharacterListEntity.CodingKeys.results],
                                                                    debugDescription: "Failed to decode \(CharacterListEntity.self)"))
        }

        return CharacterListModel(offset: offset, total: total, results: items)
    }
}
