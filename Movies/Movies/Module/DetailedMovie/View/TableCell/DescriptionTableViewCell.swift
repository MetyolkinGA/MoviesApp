// DescriptionTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            nameMovieLabel.text = movie?.title
            movieRatingLabel.text = String(movie?.voteAverage ?? 0)
            movieRatingLabel.textColor = movie?.ratingMovieColor
            descriptionMovieLabel.text = movie?.overview
            releaseDateMovieLabel.text = movie?.releaseDate
        }
    }

    // MARK: - Private Properties

    private let nameMovieLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let releaseDateMovieLabel = UILabel()
    private let descriptionMovieLabel = UILabel()

    // MARK: - Internal Methods

    func configure() {
        contentView.backgroundColor = .black
        setupNameMovieLabel()
        setupMovieRatingLabel()
        setuprReleaseDateMovieLabel()
        setupDescriptionMovieLabel()
    }

    // MARK: - Private Methods

    private func setupNameMovieLabel() {
        nameMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMovieLabel.font = .systemFont(ofSize: 19, weight: .bold)
        nameMovieLabel.textColor = .white
        nameMovieLabel.numberOfLines = 0
        nameMovieLabel.textAlignment = .center
        contentView.addSubview(nameMovieLabel)
        NSLayoutConstraint.activate([
            nameMovieLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameMovieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setupMovieRatingLabel() {
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.font = .systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(movieRatingLabel)
        NSLayoutConstraint.activate([
            movieRatingLabel.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 10),
            movieRatingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setuprReleaseDateMovieLabel() {
        releaseDateMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateMovieLabel.font = .systemFont(ofSize: 18, weight: .bold)
        releaseDateMovieLabel.textColor = .gray
        contentView.addSubview(releaseDateMovieLabel)
        NSLayoutConstraint.activate([
            releaseDateMovieLabel.topAnchor.constraint(equalTo: movieRatingLabel.bottomAnchor, constant: 10),
            releaseDateMovieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setupDescriptionMovieLabel() {
        descriptionMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionMovieLabel.font = .systemFont(ofSize: 15, weight: .bold)
        descriptionMovieLabel.textColor = .white
        descriptionMovieLabel.textAlignment = .center
        descriptionMovieLabel.numberOfLines = 0
        contentView.addSubview(descriptionMovieLabel)
        NSLayoutConstraint.activate([
            descriptionMovieLabel.topAnchor.constraint(equalTo: releaseDateMovieLabel.bottomAnchor, constant: 5),
            descriptionMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionMovieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
