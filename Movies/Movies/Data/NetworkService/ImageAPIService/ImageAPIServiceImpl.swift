// ImageAPIServiceImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ImageAPIServiceImpl: ImageAPIService {
    // MARK: - Internal Methods

    func loadImageData(urlPhoto: String, completion: @escaping (Result<Data, Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                guard let url = URL(string: urlPhoto) else { return }
                let image = try Data(contentsOf: url)
                completion(.success(image))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
