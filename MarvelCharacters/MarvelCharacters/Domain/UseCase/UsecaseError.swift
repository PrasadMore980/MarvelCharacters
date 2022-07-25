import Foundation

public enum UseCaseError: Error {
    case mapping(Swift.Error)
    case timeout(Swift.Error)
    case noConnection(Swift.Error)
    case marvelComicsApi(ApiError)
    case generic(Swift.Error)
    case invalidURL
    case invalidDataRecieved
}


public enum ApiError: Error {
    case error400(Swift.Error)
    case error500(Swift.Error)
}

public enum ViewModelError: Error {
    case characterListError
    case characterDetailError
    
    public var errorDescription: String {
        switch self {
        case .characterListError:
            return "list_error".localizedString()
        case .characterDetailError:
            return "detail_error".localizedString()
        }
    }
}
