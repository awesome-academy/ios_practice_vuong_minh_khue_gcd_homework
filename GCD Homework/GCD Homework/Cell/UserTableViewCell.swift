//
//  UserTableViewCell.swift
//  GCD Homework
//
//  Created by Khue on 25/07/2023.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var userBackgroundView: UIView!
    @IBOutlet private weak var accountLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configUI(){
        userBackgroundView.clipsToBounds = false

        userBackgroundView.layer.shadowColor = UIColor.black.cgColor
        userBackgroundView.layer.cornerRadius = Constant.cornerRadiusBackgroundTableView
        userBackgroundView.layer.shadowOpacity = Constant.shadowOpacityBackgroundTableView
        userBackgroundView.layer.shadowOffset = Constant.shadowOffsetBackgroundTableView
        userBackgroundView.layer.shadowRadius = Constant.shadowRadiusBackgroundTableView
        
        avatarImageView.layer.cornerRadius = Constant.cornerRadiusImageTableView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(_ user: User){
        avatarImageView.image = UIImage(named: user.avatarURL)
        nameLabel.text = user.name
        accountLabel.text = user.account
    }
}
