//
//  UsersViewController.swift
//  RecruitmentTask
//
//  Created by gese on 04/09/2021.
//

import UIKit

final class UsersViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let viewModel: UsersViewModel

    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTable()
        initViewModel()
    }

    func setUpView() {
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func initViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.handle(error)
            }
        }
        viewModel.queryUsers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getFullName(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = UserDetailsViewController(viewModel: UserDetailsViewModel(user: viewModel.users[indexPath.row]))
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

private extension UsersViewController {
    func handle(_ error: NetworkError) {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: "Users could not be loaded",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        if case .serverError = error {
            let action = UIAlertAction(
                title: "Try again",
                style: .default,
                handler: { [weak self] _ in
                    self?.viewModel.queryUsers()
                }
            )
            alert.addAction(action)
        }

        present(alert, animated: true)
    }
}
