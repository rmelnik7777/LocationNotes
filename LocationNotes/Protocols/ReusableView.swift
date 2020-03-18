import UIKit

protocol ReusableView {
    static var reuseKey: String { get }
    static var nib: UINib { get }
}

extension ReusableView {
    static var reuseKey: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: reuseKey, bundle: Bundle.main)
    }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
