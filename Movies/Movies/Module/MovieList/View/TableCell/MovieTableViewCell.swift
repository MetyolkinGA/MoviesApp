// MovieTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class MovieTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            imageAPIService?.getImage(posterURL: movie?.posterURL ?? String()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                    case let .success(poster):
                        self.movieImageView.image = poster
                    case .failure:
                        self.movieImageView.image = UIImage(systemName: Constants.photoIcon)
                }
            }
            movieNameLabel.text = movie?.title
            movieRatingLabel.text = movie?.voteAverage == 0 ? "Скоро выйдет" : String(movie?.voteAverage ?? 0) + " ⭐️"
            movieRatingLabel.textColor = movie?.ratingMovieColor
            releaseDateMovieLabel.text = convertDateFormat(inputDate: movie?.releaseDate ?? String())
        }
    }

    // MARK: - Private Properties

    private let containerView = UIView()
    private let movieNameLabel = UILabel()
    private let movieImageView = UIImageView()
    private let releaseDateMovieLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let chevronRightImageView = UIImageView()

    private var imageAPIService: ImageAPIService?

    private enum Constants {
        static let chevronRightIcon = "chevron.right"
        static let photoIcon = "photo"
        static let currentDateFormat = "yyyy-MM-dd"
        static let convertDateFormat = "dd.MM.yyyy"
    }

    // MARK: - Public Methods

    func configure(imageAPIService: ImageAPIService) {
        contentView.backgroundColor = .black
        self.imageAPIService = imageAPIService
        setupMovieImageView()
        setupMovieNameLabel()
        setupReleaseDateMovieLabel()
        setupMovieRatingLabel()
        setupChevronRightImageView()
    }

    override func prepareForReuse() {
        movieImageView.image = nil
    }

    // MARK: - Private Methods

    private func convertDateFormat(inputDate: String) -> String {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = Constants.currentDateFormat
        guard let currentDate = currentDateFormatter.date(from: inputDate) else { return String() }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = Constants.convertDateFormat
        return convertDateFormatter.string(from: currentDate)
    }

    private func setupMovieImageView() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 5
        movieImageView.clipsToBounds = true
        contentView.addSubview(movieImageView)
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            movieImageView.widthAnchor.constraint(equalToConstant: 75),
            movieImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupMovieNameLabel() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        movieNameLabel.textColor = .white
        movieNameLabel.numberOfLines = 0
        contentView.addSubview(movieNameLabel)
        NSLayoutConstraint.activate([
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
    }

    private func setupReleaseDateMovieLabel() {
        releaseDateMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateMovieLabel.font = .systemFont(ofSize: 15, weight: .bold)
        releaseDateMovieLabel.textColor = .gray
        contentView.addSubview(releaseDateMovieLabel)
        NSLayoutConstraint.activate([
            releaseDateMovieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            releaseDateMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            releaseDateMovieLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            movieNameLabel.bottomAnchor.constraint(equalTo: releaseDateMovieLabel.topAnchor, constant: 0)
        ])
    }

    private func setupMovieRatingLabel() {
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.font = .systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(movieRatingLabel)
        NSLayoutConstraint.activate([
            movieRatingLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieRatingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            movieRatingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
    }

    private func setupChevronRightImageView() {
        chevronRightImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronRightImageView.image = UIImage(systemName: Constants.chevronRightIcon)
        chevronRightImageView.tintColor = .orange
        contentView.addSubview(chevronRightImageView)
        NSLayoutConstraint.activate([
            chevronRightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronRightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            chevronRightImageView.heightAnchor.constraint(equalToConstant: 18),
            chevronRightImageView.widthAnchor.constraint(equalTo: chevronRightImageView.heightAnchor)
        ])
    }
}
