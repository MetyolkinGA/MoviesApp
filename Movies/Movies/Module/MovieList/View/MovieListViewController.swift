// MovieListViewController.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class MovieListViewController: UIViewController {
    // MARK: - Private Properties

    private let tableView = UITableView()
    private var movieSortSegmentController = UISegmentedControl()

    private var movieListViewModel: MovieListViewModel?

    private let movieSortSegmentControllerItems = ["Top Rate", "Top Popular", "Up Coming"]

    private enum Constants {
        static let movieTableViewCell = "MovieTableViewCell"
        static let titleNavigationBar = "Movie"
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
    }

    // MARK: - Internal Methods

    func configure(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
    }

    // MARK: - Private Methods

    private func reloadTableView() {
        movieListViewModel?.reloadTableView = { [weak tableView] in
            tableView?.reloadData()
        }
    }

    private func setupNavigationBar() {
        title = Constants.titleNavigationBar
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

    private func showAlert(title: String, message: String?, titleAction: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: titleAction, style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    @objc private func selectedValue() {
        movieListViewModel?.selectedValue(index: movieSortSegmentController.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedMovieViewController = DetailedMovieViewController()
        detailedMovieViewController.configure(detailedMovieViewModel: DetailedMovieViewModelImpl())
        navigationController?.pushViewController(detailedMovieViewController, animated: true)
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
        cellMovie.configure()
        cellMovie.movie = movie
        return cellMovie
    }
}
