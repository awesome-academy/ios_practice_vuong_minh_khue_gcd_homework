//
//  Constant.swift
//  GCD Homework
//
//  Created by Khue on 26/07/2023.
//

import Foundation

class Constant {
    static let getUserURL = "https://api.github.com/search/users?q=abc+in:login"
    
    struct UserTableViewCell {
        static let cornerRadiusBackground: CGFloat = 20
        static let cornerRadiusImage: CGFloat = 25
        static let shadowOpacityBackground: Float = 0.2
        static let shadowRadiusBackground: CGFloat = 4
        static let shadowOffsetBackground = CGSize(width: 0, height: 0)
    }
}
