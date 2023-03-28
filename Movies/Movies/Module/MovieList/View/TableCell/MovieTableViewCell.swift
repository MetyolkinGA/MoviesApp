// MovieTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class MovieTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            movieNameLabel.text = movie?.title
            movieRatingLabel.text = String(movie?.voteAverage ?? 0)
            movieRatingLabel.textColor = movie?.ratingMovieColor
            releaseDateMovieLabel.text = movie?.releaseDate
        }
    }

    // MARK: - Private Properties

    private let containerView = UIView()
    private let movieNameLabel = UILabel()
    private let movieImageView = UIImageView()
    private let releaseDateMovieLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let chevronRightImageView = UIImageView()

    private enum Constants {
        static let chevronRightIcon = "chevron.right"
        static let photoIcon = "photo"
    }

    // MARK: - Public Methods

    func configure() {
        contentView.backgroundColor = .black
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
        movieNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
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
        movieRatingLabel.font = .systemFont(ofSize: 16, weight: .bold)
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
