// DetailedMovieViewController.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DetailedMovieViewController: UIViewController {
    // MARK: - Private Properties

    private let tableView = UITableView()

    private var detailedMovieViewModel: DetailedMovieViewModel?

    private enum Constants {
        static let posterTableViewCell = "PosterTableViewCell"
        static let descriptionTableViewCell = "DescriptionTableViewCell"
        static let alertControllerTitle = "Ошибка!"
        static let alertActionTitle = "OK"
    }

    private enum IndexTableViewCell: Int {
        case posterTableViewCell
        case descriptionTableViewCell
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        setupNavigationBar()
        reloadTableView()
        presentErrorAlerController()
    }

    // MARK: - Internal Methods

    func configure(detailedMovieViewModel: DetailedMovieViewModel) {
        self.detailedMovieViewModel = detailedMovieViewModel
    }

    // MARK: - Private Methods

    private func reloadTableView() {
        detailedMovieViewModel?.updateDataTableView = { [weak tableView] in
            tableView?.reloadData()
        }
    }

    private func presentErrorAlerController() {
        detailedMovieViewModel?.presentErrorAlerController = { [weak self] error in
            self?.showAlert(
                title: Constants.alertControllerTitle,
                message: error,
                titleAction: Constants.alertActionTitle
            )
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: String(),
            style: .plain,
            target: nil, action: nil
        )
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.backgroundColor = .black
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: Constants.posterTableViewCell)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: Constants.descriptionTableViewCell)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension DetailedMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case IndexTableViewCell.posterTableViewCell.rawValue:
                guard let cellPoster = tableView.dequeueReusableCell(
                    withIdentifier: Constants.posterTableViewCell,
                    for: indexPath
                ) as? PosterTableViewCell else { return UITableViewCell() }
                cellPoster.configure(imageAPIService: ImageAPIServiceImpl())
                cellPoster.movie = detailedMovieViewModel?.getMovie()
                return cellPoster
            case IndexTableViewCell.descriptionTableViewCell.rawValue:
                guard let cellDescription = tableView.dequeueReusableCell(
                    withIdentifier: Constants.descriptionTableViewCell,
                    for: indexPath
                ) as? DescriptionTableViewCell else { return UITableViewCell() }
                cellDescription.configure()
                cellDescription.movie = detailedMovieViewModel?.getMovie()
                return cellDescription
            default:
                return UITableViewCell()
        }
    }
}
