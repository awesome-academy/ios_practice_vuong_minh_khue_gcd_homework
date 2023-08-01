//
//  DetailViewController.swift
//  GCD Homework
//
//  Created by Khue on 01/08/2023.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var numberFollowersLabel: UILabel!
    @IBOutlet private weak var numberFollowingsLabel: UILabel!
    @IBOutlet private weak var numberRepositoryLabel: UILabel!
    @IBOutlet private weak var followingsButton: UIButton!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var user: User?
    private var followingsUsers: [User] = []
    private var followersUsers: [User] = []
    private var tableViewUsers: [User] = []
    private var favouriteUser: FavouriteUser?
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followersButton.layer.cornerRadius = Constant.DetailVC.cornerRadiusTab
        followingsButton.layer.cornerRadius = Constant.DetailVC.cornerRadiusTab
        avatarImageView.layer.cornerRadius = Constant.DetailVC.cornerRadiusImage
        favouriteButton.layer.cornerRadius = Constant.DetailVC.cornerRadiusFavouriteButton
        
        guard let user = user else { return }
        APIManager.shared.getImage(url: user.avatarURL, completionHandler: { [weak self] image in
            self?.avatarImageView.image = image
        })
        nameLabel.text = user.name
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: UserTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: UserTableViewCell.defaultReuseIdentifier)
        
        loadUser()
    }
    
    private func loadUser(){
        guard let user = user else { return }
        APIManager.shared.performRequest(url: user.followersURL, type: [User].self) { [weak self] result in
            self?.followersUsers = result
            self?.tableViewUsers = result
            DispatchQueue.main.async { [weak self] in
                self?.numberFollowersLabel.text = "\(result.count)"
                self?.tableView.reloadData()
            }
        } failureHandler: {
            print("Error fetching followers API")
        }
        
        let allUserFollowingURL = user.followingURL.components(separatedBy: "{").first!
        APIManager.shared.performRequest(url: allUserFollowingURL, type: [User].self) { [weak self] result in
            self?.followingsUsers = result
            DispatchQueue.main.async { [weak self] in
                self?.numberFollowingsLabel.text = "\(result.count)"
            }
        } failureHandler: {
            print("Error fetching following API")
        }
        
        APIManager.shared.performRequest(url: user.reposURL, type: [Repository].self) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                self?.numberRepositoryLabel.text = "\(result.count)"
            }
        } failureHandler: {
            print("Error fetching repos API")
        }
        
        //Check is favouriteUser
        guard let context = context else { return }
        do {
            let favouriteUsers = try context.fetch(FavouriteUser.fetchRequest())
            favouriteUser = favouriteUsers.filter({$0.id == user.id}).first
            updateFavouriteButton()
        } catch {
            print("Error fetching data \(error)")
        }
    }
    
    private func updateFavouriteButton(){
        if favouriteUser != nil {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func setUser(user: User) {
        self.user = user
    }
     
    @IBAction private func followersButtonDidTap(_ sender: UIButton) {
        tableViewUsers = followersUsers
        tableView.reloadData()
        
        followersButton.setTitleColor(.systemTeal, for: .normal)
        followersButton.backgroundColor = .systemBackground
        followingsButton.setTitleColor(.systemBackground, for: .normal)
        followingsButton.backgroundColor = .clear
    }
    @IBAction private func followingButtonDidTap(_ sender: Any) {
        tableViewUsers = followingsUsers
        tableView.reloadData()
        
        followingsButton.setTitleColor(.systemTeal, for: .normal)
        followingsButton.backgroundColor = .systemBackground
        followersButton.setTitleColor(.systemBackground, for: .normal)
        followersButton.backgroundColor = .clear
    }
    @IBAction func favouriteButtonDidTap(_ sender: UIButton) {
        guard let context = context else { return }
        guard let user = user else { return }
        if let favouriteUser = favouriteUser {
            context.delete(favouriteUser)
            self.favouriteUser = nil
        } else {
            favouriteUser = FavouriteUser(context: context)
            favouriteUser?.id = Int64(user.id)
            favouriteUser?.account = user.account
            favouriteUser?.avatarURL = user.avatarURL
            favouriteUser?.followersURL = user.followersURL
            favouriteUser?.followingsURL = user.followingURL
            favouriteUser?.name = user.name
            favouriteUser?.reposURL = user.reposURL
        }
        try? context.save()
        updateFavouriteButton()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.defaultReuseIdentifier) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.setUser(tableViewUsers[indexPath.row])
        return cell
    }
}
