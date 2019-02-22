//
//  ToastTestTableViewCell.swift
//  Toast
//
//  Created by jeongjinho on 21/02/2019.
//  Copyright © 2019 jeongjinho. All rights reserved.
//

import UIKit

class ToastTestTableViewCell: UITableViewCell {

    @IBOutlet weak var userAlarmTimeLabel: UILabel!
    @IBOutlet weak var userAlarmTitleLabel: UILabel!
    @IBOutlet weak var userContentImageView: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    internal func configure(model: Alarm) {
        setupUI()
        userAlarmTitleLabel.text = model.title
        userProfileImageView.image = model.profileImage
        userContentImageView.image = model.contentImage
        userAlarmTimeLabel.text = model.time
        contentView.backgroundColor =  model.isClicked ? UIColor.white : UIColor.init(rgb: 0xFFF7F7)
    }
    internal func setupUI() {
        self.selectionStyle = .none
        userContentImageView.backgroundColor = UIColor.blue
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.width / 2
        userProfileImageView.clipsToBounds = true
        userAlarmTitleLabel.baselineAdjustment = .alignCenters
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
