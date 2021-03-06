import UIKit

public class Toast: UIView {
    // MARK: - UI Matrix
    private struct UIMatrix {
        static let baseMargin =  CGFloat(10)
        static let baseWidth =  CGFloat(300)
        static let baseHeight = CGFloat(35)
        static let minimumAlpha = CGFloat(0.0100000003)
        static let buttonSize = CGSize(width: 50.0, height: 35.0)
    }
    public var toastDirection: ToastDirection = .bottom
    public var leadconstraint: NSLayoutConstraint?
    public var trailconstraint: NSLayoutConstraint?
    public var toastMessage: String = ""
    public var toastButton: UIButton = UIButton()
    var toastMessageLabel: UILabel = UILabel()
    var parentViewController: UIWindow = UIApplication.shared.keyWindow!
    private var action: (() -> Void)?
    public var multiLines: Bool = true {
        didSet {
            self.toastMessageLabel.numberOfLines = multiLines ? 0 : 1
        }
    }
    // MARK: - UI Initialize
    public convenience init(_ message: String, _ setupAfterUI: ((Toast) -> Void)? = nil, direction: ToastDirection = .bottom) {
        
        self.init(frame: CGRect())
        self.action = nil
        self.toastMessage = message
        UIApplication.shared.keyWindow!.addSubview(self)
        self.toastDirection = direction
        setupUI()
        if let `setupAfterUI` = setupAfterUI  {
            setupAfterUI(self)
        }
        setupConstraints(size: getTextSize(message: message))
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
        toastMessageLabel.frame = CGRect.zero
        toastMessageLabel.textColor = UIColor.white
        toastMessageLabel.text = toastMessage
        toastMessageLabel.lineBreakMode = .byCharWrapping
        //Button
        toastButton.frame = CGRect.zero
        toastButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        [toastMessageLabel, toastButton].forEach {addSubview($0)}
    }
    private func setupConstraints(size: CGSize) {
        // bottom
        if toastDirection == .bottom {
            self.centerXAnchor.constraint(equalTo: parentViewController.centerXAnchor).isActive = true
            leadconstraint = self.leadingAnchor.constraint(equalTo: parentViewController.leadingAnchor, constant: 10)
            leadconstraint?.isActive = true
            trailconstraint =  self.trailingAnchor.constraint(equalTo: parentViewController.trailingAnchor, constant: -10)
            trailconstraint?.isActive = true
            bottomAnchor.constraint(equalTo: parentViewController.bottomAnchor, constant: -UIMatrix.baseHeight).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
        } else if toastDirection == .top {
            self.centerXAnchor.constraint(equalTo: parentViewController.centerXAnchor).isActive = true
            leadconstraint = self.leadingAnchor.constraint(equalTo: parentViewController.leadingAnchor, constant: 10)
            leadconstraint?.isActive = true
            trailconstraint =  self.trailingAnchor.constraint(equalTo: parentViewController.trailingAnchor, constant: -10)
            trailconstraint?.isActive = true
            topAnchor.constraint(equalTo:UIApplication.shared.keyWindow!.topAnchor, constant: UIMatrix.baseHeight).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
        } else if toastDirection == .center {
            self.centerXAnchor.constraint(equalTo: parentViewController.centerXAnchor).isActive = true
            leadconstraint = self.leadingAnchor.constraint(equalTo: parentViewController.leadingAnchor, constant: 10)
            leadconstraint?.isActive = true
            trailconstraint =  self.trailingAnchor.constraint(equalTo: parentViewController.trailingAnchor, constant: -10)
            trailconstraint?.isActive = true
            centerXAnchor.constraint(equalTo:UIApplication.shared.keyWindow!.centerXAnchor, constant: 0).isActive = true
            centerYAnchor.constraint(equalTo:UIApplication.shared.keyWindow!.centerYAnchor, constant: 0).isActive = true
            translatesAutoresizingMaskIntoConstraints = false
        }
        if toastButton.titleLabel?.text == "" || toastButton.titleLabel?.text == nil {
            toastButton.widthAnchor.constraint(equalToConstant: 0).isActive = true
            toastButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            // label algin
            self.toastMessageLabel.textAlignment = .center
        } else {
            toastButton.widthAnchor.constraint(equalToConstant: UIMatrix.buttonSize.width).isActive = true
            toastButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            self.toastMessageLabel.textAlignment = .left
        }
        toastButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        toastButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        toastButton.translatesAutoresizingMaskIntoConstraints = false
        // label
        toastMessageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        toastMessageLabel.trailingAnchor.constraint(equalTo: toastButton.leadingAnchor, constant: -10).isActive = true
        toastMessageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        toastMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        toastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
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
        UIApplication.shared.keyWindow!.subviews.filter({$0 is Toast && !$0.isEqual(self)}).forEach {$0.removeFromSuperview()}
    }
    private func removeCurrentToast() {
        UIApplication.shared.keyWindow!.subviews.filter {$0.isEqual(self)}.forEach {$0.removeFromSuperview()}
    }
    private func getTextSize(message: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 13)
        let fontAttributes = [NSAttributedString.Key.font: font]
        return (message as NSString).size(withAttributes: fontAttributes)
    }
    public func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = toastMessage
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    public func textLine(_ lines: Int = 0) -> Self {
        toastMessageLabel.numberOfLines = lines
        return self
    }
    public func viewWidth(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        leadconstraint?.isActive = false
        trailconstraint?.isActive = false
        self.layoutIfNeeded()
        return self
    }
    public func touchupInside(action: (() -> Void)?) -> Self {
        let tapGesture = UITapGestureRecognizer.init()
        self.action = action
        tapGesture.addTarget(self, action: #selector(executeToast))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
        return self
    }
    @objc private func executeToast() {
        if let act = action {
            act()
        }
        self.removeCurrentToast()
        self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
    }
}


public enum ToastDirection {
    
    case top
    case center
    case bottom
    
}

extension ToastDirection: RawRepresentable {
    
    public typealias RawValue = UIEdgeInsets
    
    public init?(rawValue: UIEdgeInsets) {
        switch  rawValue {
        case UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0):
            self = .top
        case UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: -10):
            self = .bottom
        case UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: -10):
            self = .center
        default:
            return nil
        }
        
    }
    
    public var rawValue: RawValue {
        
        switch self{
        case .top:
            return UIEdgeInsets.zero
        case .bottom:
            return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: -10)
        case .center:
            return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: -10)
        }
    }
    
}

