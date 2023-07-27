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
        userBackgroundView.layer.cornerRadius = Constant.UserTableViewCell.cornerRadiusBackground
        userBackgroundView.layer.shadowOpacity = Constant.UserTableViewCell.shadowOpacityBackground
        userBackgroundView.layer.shadowOffset = Constant.UserTableViewCell.shadowOffsetBackground
        userBackgroundView.layer.shadowRadius = Constant.UserTableViewCell.shadowRadiusBackground
        
        avatarImageView.layer.cornerRadius = Constant.UserTableViewCell.cornerRadiusImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(_ user: User){
        APIManager.shared.getImage(url: user.avatarURL) { [weak self] image in
            self?.avatarImageView.image = image
        }
        nameLabel.text = user.name
        accountLabel.text = user.account
    }
}
