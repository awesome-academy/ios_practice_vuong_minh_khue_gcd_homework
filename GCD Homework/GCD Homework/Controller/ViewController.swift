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
    
    private var users: [User] = []
    private var tableViewUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .systemBackground
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: UserTableViewCell.defaultReuseIdentifier)
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: Constant.DetailVC.identifier) as? DetailViewController else {
            return
        }
        detailVC.setUser(user: tableViewUsers[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
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
