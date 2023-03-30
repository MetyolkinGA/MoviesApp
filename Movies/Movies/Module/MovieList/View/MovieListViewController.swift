// MovieListViewController.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class MovieListViewController: UIViewController {
    // MARK: - Internal Properties

    var openDetailedMovieModule: StringHandler?

    // MARK: - Private Properties

    private let tableView = UITableView()
    private var movieSortSegmentController = UISegmentedControl()

    private var movieListViewModel: MovieListViewModel?

    private let movieSortSegmentControllerItems = [L10n.topRated, L10n.popular, L10n.upcoming]

    private enum Constants {
        static let movieTableViewCell = "MovieTableViewCell"
        static let alertControllerTitle = "Ошибка!"
        static let alertActionTitle = "OK"
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMovieSortSegmentController()
        setupTableView()
        reloadTableView()
        presentErrorAlerController()
    }

    // MARK: - Internal Methods

    func configure(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
    }

    // MARK: - Private Methods

    private func reloadTableView() {
        movieListViewModel?.updateDataTableView = { [weak tableView] in
            DispatchQueue.main.async {
                tableView?.reloadData()
            }
        }
    }

    private func presentErrorAlerController() {
        movieListViewModel?.presentErrorAlerController = { [weak self] error in
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
        title = L10n.movie
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupMovieSortSegmentController() {
        movieSortSegmentController = UISegmentedControl(items: movieSortSegmentControllerItems)
        movieSortSegmentController.backgroundColor = .orange
        movieSortSegmentController.selectedSegmentIndex = 0
        movieSortSegmentController.selectedSegmentTintColor = .black
        movieSortSegmentController.setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        movieSortSegmentController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        movieSortSegmentController.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        tableView.tableHeaderView = movieSortSegmentController
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieTableViewCell)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func selectedValue() {
        movieListViewModel?.selectedValue(index: movieSortSegmentController.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movieListViewModel?.getMovies()[indexPath.row] else { return }
        openDetailedMovieModule?(String(movie.id))
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieListViewModel?.getMovies().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellMovie = tableView.dequeueReusableCell(
            withIdentifier: Constants.movieTableViewCell,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell() }
        guard let movie = movieListViewModel?.getMovies()[indexPath.row] else { return UITableViewCell() }
        let proxyService = ProxyServiceImpl()
        proxyService.configure(
            imageAPIService: ImageAPIServiceImpl(),
            imageCacheService: ImageCacheServiceImpl()
        )
        cellMovie.configure(proxyService: proxyService)
        cellMovie.movie = movie
        return cellMovie
    }
}
