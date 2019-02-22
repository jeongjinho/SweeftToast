import UIKit

public class Toast: UIView {
    // MARK: - UI Matrix
    private struct UIMatrix {
        static let baseMargin =  CGFloat(10)
        static let baseWidth =  CGFloat(300)
        static let baseHeight = CGFloat(35)
        static let minimumAlpha = CGFloat(0.0100000003)
        static let buttonSize = CGSize(width: 70.0, height: 35.0)
    }
    public var toastMessage: String = ""
    public var toastButton: UIButton = UIButton()
    var toastMessageLabel: UILabel = UILabel()
    var parentViewController: UIViewController?

    // MARK: - UI Initialize
    public convenience init(_ parent: UIViewController, _ message: String, _ setupAfterUI: ((Toast) -> Void)? = nil) {
        self.init(frame: CGRect())
        self.parentViewController = parent
        self.toastMessage = message
        self.parentViewController?.view.addSubview(self)
        setupUI()
        setupConstraints()
        guard let `setupAfterUI` = setupAfterUI  else { return }
        setupAfterUI(self)
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
        let totalMargin = UIMatrix.baseMargin * 3
        toastMessageLabel.frame = CGRect(x: UIMatrix.baseMargin,
                                         y: 0,
                                         width: UIMatrix.baseWidth - totalMargin - UIMatrix.buttonSize.width,
                                         height: UIMatrix.baseHeight)
        toastMessageLabel.textColor = UIColor.white
        toastMessageLabel.text = toastMessage
        //Button
        toastButton.frame = CGRect(x: UIMatrix.baseWidth - UIMatrix.buttonSize.width - UIMatrix.baseMargin,
                                   y: 0,
                                   width: UIMatrix.buttonSize.width,
                                   height: UIMatrix.buttonSize.height)
        toastButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        [toastMessageLabel, toastButton].forEach {addSubview($0)}
    }

    private func setupConstraints() {
        guard let `parent` = parentViewController else {return}
        self.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: UIMatrix.baseWidth).isActive = true
        heightAnchor.constraint(equalToConstant: UIMatrix.baseHeight).isActive = true
        bottomAnchor.constraint(equalTo: parent.view.bottomAnchor, constant: -UIMatrix.baseHeight).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - UI Actions
    public func startToastView(duration: CGFloat) {
        removeExitedToast()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: TimeInterval(duration), delay: 5.0,
                           options: [.allowUserInteraction],
                           animations: {
                            self.alpha =  UIMatrix.minimumAlpha
            }) { [weak self] _ in
                guard let `self` = self else {return}
                self.removeCurrentToast()
            }
        }
    }

    public func tapOnButton(tapAction: @escaping () -> Void) -> Self {
        toastButton.actionHandle(controlEvents: .touchUpInside, ForAction: tapAction)
        return self
    }

    public func startToastView(duration: CGFloat, after afterHandler: @escaping () -> Void) {
        removeExitedToast()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: TimeInterval(duration),
                           delay: 5.0,
                           options: [.allowUserInteraction],
                           animations: {
                            self.alpha =  UIMatrix.minimumAlpha
            }) { [weak self] _ in
                guard let `self` = self else { return }
                self.removeCurrentToast()
                afterHandler()
            }
        }
    }

    private func removeExitedToast() {
        guard let `parent` = parentViewController else {return}
        parent.view.subviews.filter({$0 is Toast && !$0.isEqual(self)}).forEach {$0.removeFromSuperview()}
    }

    private func removeCurrentToast() {
        parentViewController?.view.subviews.filter {$0.isEqual(self)}.forEach {$0.removeFromSuperview()}
    }
}
