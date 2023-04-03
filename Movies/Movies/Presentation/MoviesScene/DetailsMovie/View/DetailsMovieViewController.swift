// DetailsMovieViewController.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DetailsMovieViewController: UIViewController {
    // MARK: - Private Properties

    private let tableView = UITableView()

    private var detailsMovieViewModel: DetailsMovieViewModel?

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

    func configure(detailsMovieViewModel: DetailsMovieViewModel) {
        self.detailsMovieViewModel = detailsMovieViewModel
    }

    // MARK: - Private Methods

    private func reloadTableView() {
        detailsMovieViewModel?.updateDataTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.title = self.detailsMovieViewModel?.getMovie()?.title
                self.tableView.reloadData()
            }
        }
    }

    private func presentErrorAlerController() {
        detailsMovieViewModel?.presentErrorAlerController = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(
                    title: Constants.alertControllerTitle,
                    message: error,
                    titleAction: Constants.alertActionTitle
                )
            }
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
        tableView.separatorStyle = .none
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

extension DetailsMovieViewController: UITableViewDataSource {
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
                let proxyService = ProxyServiceImpl()
                proxyService.configure(
                    imageAPIService: ImageAPIServiceImpl(),
                    imageCacheService: ImageCacheServiceImpl()
                )
                cellPoster.configure(proxyService: proxyService)
                cellPoster.movie = detailsMovieViewModel?.getMovie()
                return cellPoster
            case IndexTableViewCell.descriptionTableViewCell.rawValue:
                guard let cellDescription = tableView.dequeueReusableCell(
                    withIdentifier: Constants.descriptionTableViewCell,
                    for: indexPath
                ) as? DescriptionTableViewCell else { return UITableViewCell() }
                cellDescription.configure()
                cellDescription.movie = detailsMovieViewModel?.getMovie()
                return cellDescription
            default:
                return UITableViewCell()
        }
    }
}
