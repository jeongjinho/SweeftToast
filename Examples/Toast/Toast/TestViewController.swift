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
    private var alarmDataArray: Array<Alarm> = Array<Alarm>()
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
        allReadButton.addTarget(self, action:  #selector(touchUpInsideAlllRoadButton), for: .touchUpInside)
        allReadButton.setTitle("모두 읽음", for: .normal)
        allReadButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        allReadButton.setTitleColor(UIColor.white, for: .normal)
         //navigationBarItem
        let moreButton = UIButton(type: .custom)
        moreButton.frame = CGRect.init(x: 30, y: 0, width: 30, height: 30)
        moreButton.setImage(#imageLiteral(resourceName: "more.png"), for: .normal)
       let menuBarItem = UIBarButtonItem(customView: moreButton)
        moreButton.imageView?.contentMode = .scaleAspectFit
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 20)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight?.isActive = true
        moreButton.setTitleColor(UIColor.white, for: .normal)
        self.navigationItem.setRightBarButtonItems([menuBarItem,UIBarButtonItem(customView: allReadButton)], animated: false)
    }
    @objc private func touchUpInsideAlllRoadButton() {
        print("모두 읽음")
    }
    @available(iOS 11.0, *)
    private func contextualDeleteButton(indexPath: IndexPath) -> UIContextualAction {
      return UIContextualAction(style: .destructive, title: "Delete") { (_, _, comleteHandler) in
        Toast(self, "Alarm has been deleted", { (toast) in
            toast.toastButton.setTitle("cancel", for: .normal)
            toast.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        }).startToastView(duration: 3.0)
            comleteHandler(false)
        }
    }
    @available(iOS 11.0, *)
    private func contextualMoreButton(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "modify") { (_, _, comleteHandler) in
            Toast(self, "more Button Clicked").startToastView(duration: 3.0)
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
