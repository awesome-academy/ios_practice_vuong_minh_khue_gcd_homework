//
//  User.swift
//  GCD Homework
//
//  Created by Khue on 25/07/2023.
//

import Foundation

struct User: Decodable {
    let avatarURL: String
    let name: String
    let account: String
    let followersURL: String
    let followingURL: String
    let reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name = "login"
        case account = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
    }
}
