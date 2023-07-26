//
//  ViewController.swift
//  GCD Homework
//
//  Created by Khue on 25/07/2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUsers()
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .systemBackground
        }
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    // TODO: Mock data, will update after fetch API task
    private func addUsers(){
        users.append(User(avatarURL: "person", name: "Name1", account: "account1"))
        users.append(User(avatarURL: "person", name: "Name2", account: "account2"))
        users.append(User(avatarURL: "person", name: "Name3", account: "account3"))
        users.append(User(avatarURL: "person", name: "Name4", account: "account4"))
        users.append(User(avatarURL: "person", name: "Name5", account: "account5"))
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.setUser(users[indexPath.row])
        return cell
    }    
}
