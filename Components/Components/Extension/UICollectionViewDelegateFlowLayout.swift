import Foundation
import UIKit

extension UICollectionViewDelegateFlowLayout {
    public func UICollectionViewTwoItemPerWidth() -> CGSize {
        let paddingSpace = CGFloat(18 * (2 + 1))
        let availableWidth = ScreenSize.width - paddingSpace
        let widthPerItem = (availableWidth / 2) + 4
        let heightPerItem = widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    public func UICollectionViewOneItemPerWidth() -> CGSize {
        let paddingSpace = CGFloat(18 * (2 + 1))
        let availableWidth = ScreenSize.width - paddingSpace
        let widthPerItem = (availableWidth) + 4
        let heightPerItem = widthPerItem * 0.56
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
