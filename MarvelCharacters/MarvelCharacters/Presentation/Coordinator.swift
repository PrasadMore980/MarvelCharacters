import Foundation
import UIKit

final class Coordinator {
    
    static let shared = Coordinator.init()
    
    func build() -> CharacterListController {
        let useCase = CharacterListUseCase(repository: CharacterRepository())
        let dependancies = CharacterListViewModelDependencies(characterListUseCase: useCase)
        let viewModel = CharacterListViewModel(dependancy: dependancies)
        let viewController: CharacterListController = CharacterListController(viewModel: viewModel)
        return viewController
    }
    
    func build(_ characterId: Int) -> CharacterDetailController {
        let useCase = CharacterDetailUseCase(repository: CharacterRepository())
        let dependancies = CharacterDetailViewModelDependencies(characterDetailUseCase: useCase, characterId: characterId)
        let viewModel = CharacterDetailViewModel(dependancy: dependancies)
        let viewController: CharacterDetailController = CharacterDetailController(viewModel: viewModel)
        return viewController
    }
}
