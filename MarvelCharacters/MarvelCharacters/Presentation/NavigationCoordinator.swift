import Foundation
import UIKit

enum SceneType {
    case characterList
    case characterDetail(characterId: Int)
}

final class NavigationCoordinator {
    static let sharedInstance: NavigationCoordinator = NavigationCoordinator()

    func navigate(sceneType: SceneType, fromScreen: ViewProtocol) {
        switch sceneType {
        case let .characterDetail(characterId):
            let navigationController = (fromScreen as? UIViewController)?.navigationController
            let viewController = Coordinator.shared.build(characterId)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}
