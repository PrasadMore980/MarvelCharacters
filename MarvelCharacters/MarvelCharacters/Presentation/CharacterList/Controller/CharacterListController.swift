import UIKit

protocol CharacterListViewProtocol: ViewProtocol {
    var viewModel: CharacterListViewModelProtocol! { get }
}

class CharacterListController: BaseViewController, CharacterListViewProtocol {
    let viewModel: CharacterListViewModelProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CharacterListController.self), bundle: Bundle(for: CharacterListController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        bind(to: viewModel)
        setUpTableView()
        fetchCharacterList()
    }

    private func setUpNavigation() {
        navigationItem.title = "list_title".localizedString()
    }

    private func bind(to viewModel: CharacterListViewModelProtocol?) {
        viewModel?.characterListDataSource.observe(on: self, observerBlock: { [weak self] _ in self?.updateTableView()
        })
        viewModel?.loading.observe(on: self, observerBlock: { [weak self] (loading) in
            if loading {
                self?.showSpinner()
            } else {
                self?.hideSpinner()
            }
        })
        viewModel?.error.observe(on: self, observerBlock: { [weak self] in self?.showErrorMessage(error: $0) })
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: CharacterCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = Constants.rowHeight
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = Constants.sectionHeaderFooterHeight
        tableView.estimatedSectionFooterHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = Constants.sectionHeaderFooterHeight
    }
    
    private func fetchCharacterList() {
        viewModel.fetchCharacterList()
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CharacterListController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier) as? CharacterCell else {
            return UITableViewCell()
        }
        cell.setup(viewModel.getCharacterCellViewModel(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToDetailScene(self, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.didScrolledTo(rowIndex: indexPath.row)
    }
}
