// DescriptionTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            guard let movie = movie, let releaseDate = movie.releaseDate else { return }
            nameMovieLabel.text = movie.title
            movieRatingLabel.text =
            movie.voteAverage == 0 ? "" : String(convertDouble(inputDouble: movie.voteAverage)) + Constants.starEmoji
            movieRatingLabel.textColor = movie.ratingMovieColor
            descriptionMovieLabel.text = movie.overview
            releaseDateMovieLabel.text =
            releaseDate.isEmpty ? Constants.comingOutSoon : convertDateFormat(inputDate: releaseDate)
        }
    }

    // MARK: - Private Properties

    private let nameMovieLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let releaseDateMovieLabel = UILabel()
    private let descriptionMovieLabel = UILabel()

    private enum Constants {
        static let comingOutSoon = "Скоро выйдет"
        static let starEmoji = " ⭐️"
        static let currentDateFormat = "yyyy-MM-dd"
        static let convertDateFormat = "dd.MM.yyyy"
    }

    // MARK: - Internal Methods

    func configure() {
        contentView.backgroundColor = .black
        setupNameMovieLabel()
        setupMovieRatingLabel()
        setuprReleaseDateMovieLabel()
        setupDescriptionMovieLabel()
    }

    // MARK: - Private Methods

    private func convertDouble(inputDouble: Double) -> Double {
        let xDouble = inputDouble
        let yDouble = Double(round(10 * xDouble) / 10)
        return yDouble
    }

    private func convertDateFormat(inputDate: String) -> String {
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = Constants.currentDateFormat
        guard let currentDate = currentDateFormatter.date(from: inputDate) else { return String() }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = Constants.convertDateFormat
        return convertDateFormatter.string(from: currentDate)
    }

    private func setupNameMovieLabel() {
        nameMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMovieLabel.font = .systemFont(ofSize: 21, weight: .bold)
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
        movieRatingLabel.font = .systemFont(ofSize: 19, weight: .bold)
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
        descriptionMovieLabel.font = .systemFont(ofSize: 16, weight: .bold)
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

extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
