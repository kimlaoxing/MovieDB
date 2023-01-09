import IGListKit
import UIKit
import Components

protocol IGListKitSectionViewControllerProtocol {
    func didSelectRow(with id: Int)
    func loadNextPage(with index: Int)
}

final class IGListKitSectionViewController: ListSectionController {

    private var object: IGListKitModel?
    var delegate: IGListKitSectionViewControllerProtocol?

    override func sizeForItem(at index: Int) -> CGSize {
        let availableWidth = ScreenSize.width
        let widthPerItem = (availableWidth) + 4
        
        return CGSize(width: widthPerItem, height: Padding.NORMAL_CONTENT_INSET + Padding.reguler)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: IGListKitCollectionCell = collectionContext?.dequeueReusableCell(of: IGListKitCollectionCell.self, for: self, at: index) as! IGListKitCollectionCell
        if let object = object {
            cell.setContent(with: object)
        }
        delegate?.loadNextPage(with: self.section)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? IGListKitModel
    }

    override func didSelectItem(at index: Int) {
        self.delegate?.didSelectRow(with: Int(self.object?.id ?? 0))
    }
}
