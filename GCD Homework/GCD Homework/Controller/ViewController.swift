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
    var tableViewUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
        navigationController?.isNavigationBarHidden = true
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .systemBackground
        }
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        searchBar.delegate = self
    }
    
    private func getUsers(){
        let url = Constant.getUserURL
        APIManager.shared.performRequest(url: url, type: TotalUser.self) { [weak self] totalUser in
            self?.users = totalUser.items
            self?.tableViewUsers = totalUser.items
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } failureHandler: {
            print("Error fetching API")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.setUser(tableViewUsers[indexPath.row])
        return cell
    }    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            tableViewUsers = users
        } else {
            tableViewUsers = users.filter({ user in
                user.name.contains(searchText)
            })
        }
        tableView.reloadData()
    }
}
