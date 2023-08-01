//
//  FavouriteViewController.swift
//  GCD Homework
//
//  Created by Khue on 01/08/2023.
//

import UIKit
import CoreData

final class FavouriteViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var favouriteUsers: [FavouriteUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: UserTableViewCell.defaultReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavouriteUser()
    }
    
    private func loadFavouriteUser(){
        guard let context = context else { return }
        do {
            favouriteUsers = try context.fetch(FavouriteUser.fetchRequest())
        } catch {
            print("Error fetching data \(error)")
        }
        tableView.reloadData()
    }
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.defaultReuseIdentifier) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = User(favouriteUsers[indexPath.row])
        cell.setUser(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: Constant.DetailVC.identifier) as? DetailViewController else {
            return
        }
        let user = User(favouriteUsers[indexPath.row])
        detailVC.setUser(user: user)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
