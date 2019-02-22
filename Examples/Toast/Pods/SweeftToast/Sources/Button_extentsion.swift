import UIKit
extension UIButton {
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct InternalAction {
            static var action :(() -> Void)?
        }
        if action != nil {
            InternalAction.action = action
        } else {
            InternalAction.action?()
        }
    }
    @objc private func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    func actionHandle(controlEvents control: UIControl.Event, ForAction action : @escaping () -> Void) {
        self.actionHandleBlock(action: action)
        self.addTarget(self, action: #selector(UIButton.triggerActionHandleBlock), for: control)
    }
}
