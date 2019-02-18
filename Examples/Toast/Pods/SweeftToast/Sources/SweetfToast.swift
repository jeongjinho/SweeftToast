import UIKit

public class Toast: UIView {
    //MARK: - UI Matrix
    private struct UI {
        static let baseMargin =  CGFloat(10)
        static let baseWidth =  CGFloat(300)
        static let baseHeight = CGFloat(35)
        static let minimumAlpha = CGFloat(0.0100000003)
        static let buttonSize = CGSize(width: 35.0, height: 35.0)
    }
    public var toastMessage: String = ""
    var toastMessageLabel: UILabel = UILabel()
    var toastButton: UIButton = UIButton()
    var parentViewController: UIViewController?
    
    //MARK: - UI Initialize
    public convenience init(_ frontViewController: UIViewController, _ message: String = "") {
        self.init(frame: CGRect())
        self.parentViewController = frontViewController
        self.toastMessage = message
        self.parentViewController?.view.addSubview(self)
        setupUI()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //Container
        self.alpha = 0.0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        self.layer.cornerRadius = 10.0
        //Label
        toastMessageLabel.frame = CGRect(x: UI.baseMargin, y: 0, width: UI.baseWidth - UI.baseMargin * 3 - UI.buttonSize.width, height: UI.baseHeight)
        toastMessageLabel.textColor = UIColor.white
        toastMessageLabel.text = toastMessage
        //Button
        toastButton.frame = CGRect(x: UI.baseWidth - UI.buttonSize.width - UI.baseMargin , y: 0, width: UI.buttonSize.width, height: UI.buttonSize.height)
        [toastMessageLabel,toastButton].forEach{addSubview($0)}
    }
    
    private func setupConstraints() {
        guard let `parentViewController` = parentViewController else {return}
        self.centerXAnchor.constraint(equalTo: parentViewController.view.centerXAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: UI.baseWidth).isActive = true
        heightAnchor.constraint(equalToConstant: UI.baseHeight).isActive = true
        bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor, constant: -UI.baseHeight).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    //MARK: - UI Actions
    public func startToastView(duration: CGFloat) {
        removeExitedToast()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: TimeInterval(duration), delay: 5.0, options: [.allowUserInteraction], animations: {
                self.alpha =  UI.minimumAlpha
            }) { [weak self] _ in
                guard let `self` = self else {return}
                self.removeCurrentToast()
            }
        }
    }
    
    private func removeExitedToast() {
        parentViewController?.view.subviews.filter({$0 is Toast && !$0.isEqual(self)}).forEach{$0.removeFromSuperview()}
    }
    
    private func removeCurrentToast() {
        parentViewController?.view.subviews.filter{$0.isEqual(self)}.forEach{$0.removeFromSuperview()}
    }
}
