// PosterTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            setPosterImage(movie: movie)
        }
    }

    // MARK: - Private Properteis

    private let posterMovieImageView = UIImageView()

    private var proxyService: ProxyService?

    private enum Constants {
        static let photoIcon = "photo"
    }

    // MARK: - Internal Methods

    func configure(proxyService: ProxyService) {
        contentView.backgroundColor = .black
        self.proxyService = proxyService
        setupPosterMovieImageView()
    }

    // MARK: - Private Methods

    private func setPosterImage(movie: Movie?) {
        guard let movie = movie else { return }
        proxyService?.getImage(url: movie.posterURL) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case let .success(image):
                        self.posterMovieImageView.image = image
                    case .failure:
                        self.posterMovieImageView.image = UIImage(systemName: Constants.photoIcon)
                }
            }
        }
    }

    private func setupPosterMovieImageView() {
        posterMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        posterMovieImageView.contentMode = .scaleToFill
        posterMovieImageView.layer.cornerRadius = 10
        posterMovieImageView.clipsToBounds = true
        contentView.addSubview(posterMovieImageView)
        NSLayoutConstraint.activate([
            posterMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterMovieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            posterMovieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            posterMovieImageView.heightAnchor.constraint(equalToConstant: 450),
            contentView.heightAnchor.constraint(equalTo: posterMovieImageView.heightAnchor)
        ])
    }
}
