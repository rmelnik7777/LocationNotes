import UIKit

protocol ShadowRounded {
    func addRoundShadow(color: UIColor?, radius: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat)
}

extension UIView: ShadowRounded {
    
    func addRoundShadow(color: UIColor? = UIColor.black, radius: CGFloat = 9, shadowOffset: CGSize = CGSize(width: 2, height: 2), shadowRadius: CGFloat = 3.0) {
        layer.cornerRadius = radius
        layer.shadowColor = color?.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 0.8
        layer.shadowRadius = shadowRadius
    }
}
