import Foundation

struct CharacterImageEntity: Codable {
    let path: String?
    let fileExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
    
    func toDomainModel() throws -> URL? {
        guard let path = path, let fileExtension = fileExtension else {
            throw DecodingError.valueNotFound(CharacterImageEntity.self,
                                              DecodingError.Context(codingPath: [CharacterImageEntity.CodingKeys.path,
                                                                                 CharacterImageEntity.CodingKeys.fileExtension],
                                                                    debugDescription: "Failed to decode \(CharacterImageEntity.self)"))
        }
        
        let imageURL = "\(path).\(fileExtension)"
        return URL(string: imageURL)
    }
}
