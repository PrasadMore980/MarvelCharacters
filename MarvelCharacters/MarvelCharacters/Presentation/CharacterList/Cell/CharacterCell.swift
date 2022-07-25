import UIKit
import Kingfisher

final class CharacterCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnail: UIImageView!
    @IBOutlet private weak var name: UILabel!
    
    func setup(_ cellViewModel: CharacterCellViewModel?) {
        guard let viewModel = cellViewModel else { return }
        name.text = viewModel.name
        thumbnail.kf.setImage(with: viewModel.thumbnailURL, placeholder:Constants.defaultImage)
    }
}
