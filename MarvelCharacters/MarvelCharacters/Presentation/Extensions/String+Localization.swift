import Foundation

extension String {
    func localizedString() -> String {
        NSLocalizedString(self, comment: "")
    }
}
