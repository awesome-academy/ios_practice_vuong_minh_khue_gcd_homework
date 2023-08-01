//
//  User.swift
//  GCD Homework
//
//  Created by Khue on 25/07/2023.
//

import Foundation
import CoreData

struct User: Decodable {
    let id: Int
    let avatarURL: String
    let name: String
    let account: String
    let followersURL: String
    let followingURL: String
    let reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case avatarURL = "avatar_url"
        case name = "login"
        case account = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
    }
    
    init(_ favouriteUser: FavouriteUser) {
        id = Int(favouriteUser.id)
        avatarURL = favouriteUser.avatarURL ?? ""
        name = favouriteUser.name ?? ""
        account = favouriteUser.account ?? ""
        followersURL = favouriteUser.followersURL ?? ""
        followingURL = favouriteUser.followingsURL ?? ""
        reposURL = favouriteUser.reposURL ?? ""
    }
}
