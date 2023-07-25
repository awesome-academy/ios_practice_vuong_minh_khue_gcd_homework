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
    
    private func configUI(){
        userBackgroundView.clipsToBounds = false
        userBackgroundView.layer.cornerRadius = 20
        userBackgroundView.layer.shadowOpacity = 0.2
        userBackgroundView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        userBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        userBackgroundView.layer.shadowRadius = 4
        
        avatarImageView.layer.cornerRadius = 25
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
