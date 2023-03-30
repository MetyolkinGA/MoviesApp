// ImageAPIServiceImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ImageAPIServiceImpl: ImageAPIService {
    // MARK: - Internal Methods

    func getImage(posterURL: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: posterURL) else { return }
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: url)
                let posterImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    completion(.success(posterImage ?? UIImage()))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
