import Foundation

typealias Parameters = [String : Any]

enum CharacterEndPoint {
    case characterList(offset: Int, limit: Int)
    case characterDetail(id: Int)
}

extension CharacterEndPoint: TargetType {
    var baseURL: URL {
        URL(string: "https://gateway.marvel.com/v1/public")!
    }

    var path: String {
        switch self {
        case .characterList:
            return "/characters"
        case .characterDetail(let id):
            return "/characters/\(id)"
        }
    }

    var method: Method {
        .get
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var task: Task {
        switch self {
        case .characterList(let offset, let limit):
            var parameters: Parameters = getCommonParameters()
            parameters["limit"] = limit
            parameters["offset"] = offset
            return .requestParameters(parameters: parameters, encoding: encoding)
        case .characterDetail:
            let parameters: Parameters = getCommonParameters()
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    var dataResource: String {
        switch self {
        case .characterList:
            return "CharacterList"
        case .characterDetail( _):
            return "CharacterDetail"
        }
    }
    
    var dataExtension: String {
        return "json"
    }

    func getCommonParameters() -> Parameters {
        var parameters: Parameters = [:]
        parameters["apikey"] = APIParameters.apiKey
        parameters["hash"] = APIParameters.hashed
        parameters["ts"] = APIParameters.timestamp
        return parameters
    }
}
