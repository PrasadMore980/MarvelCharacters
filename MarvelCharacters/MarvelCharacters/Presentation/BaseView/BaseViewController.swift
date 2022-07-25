import UIKit

class BaseViewController: UIViewController {

    private let spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSpinner()
    }

    func showErrorMessage(error: String) {
        if error.isEmpty { return }
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        self.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "button_title_OK".localizedString(), style: .cancel, handler: {_ in
            alert.dismiss(animated: true)
        }))
    }

    func showSpinner() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }

    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}

private extension BaseViewController {
    func setUpSpinner() {
        spinner.color = .systemBlue
        spinner.style = .large
        spinner.isHidden = true
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
