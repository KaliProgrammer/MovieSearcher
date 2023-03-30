
import UIKit

class ButtonWithShadow: UIButton {
    private enum Constants {
        static let defaultAnimationDuration: CGFloat = 0.1
        static let shadowOpacity: Float = 1.7
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: Constants.defaultAnimationDuration) {
                self.layer.shadowOpacity = self.isHighlighted ? 0 : Constants.shadowOpacity
                self.backgroundColor = self.isHighlighted ? .systemYellow : .black
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.layer.shadowOpacity = self.isEnabled ? Constants.shadowOpacity : 0
            }
        }
    }
}
