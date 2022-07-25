import UIKit

protocol CharacterDetailViewProtocol: ViewProtocol {
    var viewModel: CharacterDetailViewModelProtocol! { get }
}

class CharacterDetailController: BaseViewController, CharacterDetailViewProtocol {
    let viewModel: CharacterDetailViewModelProtocol!

    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var thumbnail: UIImageView!

    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CharacterDetailController.self), bundle: Bundle(for: CharacterDetailController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        bind(to: viewModel)
        fetchCharacterDetails()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "detail_title".localizedString()
    }

    private func bind(to viewModel: CharacterDetailViewModelProtocol) {
        viewModel.name.observe(on: self, observerBlock: { [weak self] name in self?.name.text = name })
        viewModel.description.observe(on: self, observerBlock: { [weak self] description in self?.descriptionLabel.text = description })
        viewModel.thumbnail.observe(on: self, observerBlock: { [weak self] thumbnailURL in
            self?.thumbnail.kf.setImage(with: thumbnailURL, placeholder: Constants.defaultImage)
        })
        viewModel.loading.observe(on: self, observerBlock: { [weak self] (isLoading) in
            if isLoading {
                self?.showSpinner()
            } else {
                self?.hideSpinner()
            }
        })
        viewModel.error.observe(on: self, observerBlock: { [weak self] in self?.showErrorMessage(error: $0) })
    }

    private func fetchCharacterDetails() {
        viewModel.fetchCharacterDetail()
    }
}
