//
//  TestViewController.swift
//  Toast
//
//  Created by jeongjinho on 20/02/2019.
//  Copyright © 2019 jeongjinho. All rights reserved.
//

import UIKit
import SweeftToast

struct Alarm {
    var title: String
    var time: String
    var contentImage: UIImage
    var profileImage: UIImage
    var isClicked: Bool = false
}

class TestViewController: UIViewController {
    private var alarmDataArray: Array<Alarm> = []
    private struct ViewUI {
        static let tableViewFrame = UIScreen.main.bounds
    }
    lazy var tableView: UITableView = {
      let tableview = UITableView(frame: ViewUI.tableViewFrame, style: .plain)
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmDataArray = [Alarm(title: "iron man added three pictures to the Avengers group.", time: "50 o'clok after", contentImage:#imageLiteral(resourceName: "hulk"), profileImage: #imageLiteral(resourceName: "ironMan"), isClicked: false),
                          Alarm(title: "Shared in Facebook post. Caption has started the broadcast.", time: "9hour after", contentImage:#imageLiteral(resourceName: "hulk"), profileImage:#imageLiteral(resourceName: "captionAmerica"), isClicked: true),
                          Alarm(title: "The widow has started the broadcast. I uploaded the video. Please check the answer.", time: "12hour after", contentImage:#imageLiteral(resourceName: "hulk"), profileImage: #imageLiteral(resourceName: "blackWidow"), isClicked: false),
                          Alarm(title: "followed in Facebook. hulk has started", time: "11hour after", contentImage:#imageLiteral(resourceName: "hulk"), profileImage: #imageLiteral(resourceName: "blackWidow"), isClicked: false),
                          Alarm(title: "tor added three pictures to the Avengers group.", time: "12hour after", contentImage:#imageLiteral(resourceName: "hulk"), profileImage:#imageLiteral(resourceName: "blackWidow"), isClicked: true)
                            ]
        setupUI()
    }
    private func setupUI() {
        // navigation
        navigationItem.title = "Alarm"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.init(rgb: 0x216ae0)
        //tableView
        tableView.registerForNib(cell: ToastTestTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //navigationBarItem
        let allReadButton = UIButton(type: .custom)
        allReadButton.addTarget(self, action: #selector(touchUpInsideAlllRoadButton), for: .touchUpInside)
        allReadButton.setTitle("모두 읽음", for: .normal)
        allReadButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        allReadButton.setTitleColor(UIColor.white, for: .normal)
        let allReadBarButtonItem = UIBarButtonItem(customView: allReadButton)
         //navigationBarItem
        let moreButton = UIButton(type: .custom)
        moreButton.frame = CGRect.init(x: 30, y: 0, width: 30, height: 30)
        moreButton.setImage(#imageLiteral(resourceName: "more.png"), for: .normal)
        moreButton.setTitleColor(UIColor.white, for: .normal)
       let moreBarButtonItem = UIBarButtonItem(customView: moreButton)
        moreButton.imageView?.contentMode = .scaleAspectFit
        let currWidth = moreBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 20)
        currWidth?.isActive = true
        let currHeight = moreBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight?.isActive = true
        self.navigationItem.setRightBarButtonItems([moreBarButtonItem, allReadBarButtonItem], animated: false)
    }
    @objc private func touchUpInsideAlllRoadButton() {
        print("모두 읽음")
    }
    @available(iOS 11.0, *)
    private func contextualDeleteButton(indexPath: IndexPath) -> UIContextualAction {
      return UIContextualAction(style: .destructive, title: "Delete") { (_, _, comleteHandler) in
        Toast2(self, "알림이 나왔습니다", { (toast) in
            toast.toastButton.setTitle("cancel", for: .normal)
            toast.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        }).textLine().viewWidth(300.0).startToastView(duration: 3.0)
            comleteHandler(false)
        }
    }
    @available(iOS 11.0, *)
    private func contextualMoreButton(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "modify") { (_, _, comleteHandler) in
            Toast2(self, "more Button Clickedmore Button Clickedmore Button Clickedmore Button Clickedmore Button Clickedmore Button Clicked").startToastView(duration: 3.0)
            comleteHandler(false)
        }
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToastTestTableViewCell.reuseIdentifier, for: indexPath) as? ToastTestTableViewCell
        cell?.configure(model: alarmDataArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        alarmDataArray[indexPath.row].isClicked = true
        cell?.contentView.backgroundColor = UIColor.init(rgb: 0xFFFFFF)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteButton = contextualDeleteButton(indexPath: indexPath)
            let moreButton = contextualMoreButton(indexPath: indexPath)
            let swipeConfig = UISwipeActionsConfiguration(actions: [moreButton, deleteButton])
            swipeConfig.performsFirstActionWithFullSwipe = false
            return swipeConfig
    }
}

import UIKit

public class Toast2: UIView {
    // MARK: - UI Matrix
    private struct UIMatrix {
        static let baseMargin =  CGFloat(10)
        static let baseWidth =  CGFloat(300)
        static let baseHeight = CGFloat(35)
        static let minimumAlpha = CGFloat(0.0100000003)
        static let buttonSize = CGSize(width: 50.0, height: 35.0)
    }
    public var leadconstraint: NSLayoutConstraint?
    public var trailconstraint: NSLayoutConstraint?
    public var toastMessage: String = ""
    public var toastButton: UIButton = UIButton()
    var toastMessageLabel: UILabel = UILabel()
    var parentViewController: UIViewController?
    var multiLines: Bool = true {
        didSet {
            self.toastMessageLabel.numberOfLines = multiLines ? 0 : 1
        }
    }
    // MARK: - UI Initialize
    public convenience init(_ parent: UIViewController, _ message: String, _ setupAfterUI: ((Toast2) -> Void)? = nil) {
        self.init(frame: CGRect())
        self.parentViewController = parent
        self.toastMessage = message
        self.parentViewController?.view.addSubview(self)
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
        toastMessageLabel.lineBreakMode = .byWordWrapping
        //Button
        toastButton.frame = CGRect.zero
        toastButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        [toastMessageLabel, toastButton].forEach {addSubview($0)}
    }
    
    private func setupConstraints(size: CGSize) {
        guard let `parent` = parentViewController else {return}
        self.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
        leadconstraint = self.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor, constant: 10)
        leadconstraint?.isActive = true
        trailconstraint =  self.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor, constant: -10)
        trailconstraint?.isActive = true
        bottomAnchor.constraint(equalTo: parent.view.bottomAnchor, constant: -UIMatrix.baseHeight).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        // button
        if toastButton.titleLabel?.text == "" || toastButton.titleLabel?.text == nil {
            toastButton.widthAnchor.constraint(equalToConstant: 0).isActive = true
            toastButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        } else {
            toastButton.widthAnchor.constraint(equalToConstant: UIMatrix.buttonSize.width).isActive = true
            toastButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
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
        toastButton.layoutIfNeeded()
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
        parent.view.subviews.filter({$0 is Toast2 && !$0.isEqual(self)}).forEach {$0.removeFromSuperview()}
    }
    private func removeCurrentToast() {
        parentViewController?.view.subviews.filter {$0.isEqual(self)}.forEach {$0.removeFromSuperview()}
    }
    private func getTextSize(message: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 13)
        let fontAttributes = [NSAttributedString.Key.font: font]
        return (message as NSString).size(withAttributes: fontAttributes)
    }
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = toastMessage
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    func textLine(_ lines: Int = 0) -> Self {
        toastMessageLabel.numberOfLines = lines
        return self
    }
    func viewWidth(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        leadconstraint?.isActive = false
        trailconstraint?.isActive = false
        self.layoutIfNeeded()
        return self
    }
}

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

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
