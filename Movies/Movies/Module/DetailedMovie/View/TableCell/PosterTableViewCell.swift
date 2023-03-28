// PosterTableViewCell.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: - Internal Properties

    var movie: Movie? {
        didSet {
            imageAPIService?.getImage(posterURL: movie?.posterURL ?? String()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                    case let .success(poster):
                        self.photoMovieImageView.image = poster
                    case .failure:
                        self.photoMovieImageView.image = UIImage(systemName: Constants.photoIcon)
                }
            }
        }
    }

    // MARK: - Private Properteis

    private let photoMovieImageView = UIImageView()

    private var imageAPIService: ImageAPIService?

    private enum Constants {
        static let photoIcon = "photo"
    }

    // MARK: - Internal Methods

    func configure(imageAPIService: ImageAPIService) {
        contentView.backgroundColor = .black
        self.imageAPIService = imageAPIService
        setupPhotoMovieImageView()
    }

    // MARK: - Private Methods

    private func setupPhotoMovieImageView() {
        photoMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        photoMovieImageView.contentMode = .scaleToFill
        photoMovieImageView.layer.cornerRadius = 10
        photoMovieImageView.clipsToBounds = true
        contentView.addSubview(photoMovieImageView)
        NSLayoutConstraint.activate([
            photoMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoMovieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            photoMovieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            photoMovieImageView.heightAnchor.constraint(equalToConstant: 400),
            contentView.heightAnchor.constraint(equalTo: photoMovieImageView.heightAnchor)
        ])
    }
}
