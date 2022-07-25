import Foundation

final class CharacterRepository: CharacterRepositoryProtocol {
    private let decoder = JSONDecoder()
    private var serviceProvider: Provider<CharacterEndPoint>
    convenience init() {
        self.init(serviceProvider: Provider<CharacterEndPoint>())
    }

    init(serviceProvider: Provider<CharacterEndPoint>) {
        self.serviceProvider = serviceProvider
    }

    func getCharactersList(offset: Int, limit: Int, completion: @escaping CharacterListCompletion) {
        serviceProvider.request(.characterList(offset: offset, limit: limit)) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try self.decoder.decode(CharacterDataWrapperEntity.self, from: response.data)
                    if let entity = json.data {
                        completion(.success(try entity.toDomainModel()))
                    } else {
                        completion(.failure(.invalidDataRecieved))
                    }
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                if case let .underlying(_, response) = error, let statusCode = response?.statusCode {
                    switch statusCode {
                    case 400...499:
                        completion(.failure(.marvelComicsApi(.error400(error))))
                    case 500...599:
                        completion(.failure(.marvelComicsApi(.error500(error))))
                    default:
                        completion(.failure(.generic(error)))
                    }
                }
                completion(.failure(.generic(error)))
            }
        }
    }

    func getCharacterDetails(id: Int, completion: @escaping CharacterDetailCompletion) {
        serviceProvider.request(.characterDetail(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try self.decoder.decode(CharacterDataWrapperEntity.self, from: response.data)
                    if let entity = json.data?.results?.first {
                        completion(.success(try entity.toDomainModel()))
                    } else {
                        completion(.failure(.invalidDataRecieved))
                    }
                } catch {
                    completion(.failure(.mapping(error)))
                }
            case .failure(let error):
                if case let .underlying(_, response) = error, let statusCode = response?.statusCode {
                    switch statusCode {
                    case 400...499:
                        completion(.failure(.marvelComicsApi(.error400(error))))
                    case 500...599:
                        completion(.failure(.marvelComicsApi(.error500(error))))
                    default:
                        completion(.failure(.generic(error)))
                    }
                }
                completion(.failure(.generic(error)))
            }
        }
    }
}
