// ProxyServiceImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ProxyServiceImpl: ProxyService {
    // MARK: - Private Properties

    private var imageAPIService: ImageAPIService?
    private var imageCacheService: ImageCacheService?

    // MARK: - Internal Methods

    func configure(imageAPIService: ImageAPIService, imageCacheService: ImageCacheService) {
        self.imageAPIService = imageAPIService
        self.imageCacheService = imageCacheService
    }

    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let image = imageCacheService?.getImageFromCache(url: url)
        if image == nil {
            imageAPIService?.loadImageData(urlPhoto: url) { result in
                switch result {
                    case let .success(dataImage):
                        guard let image = UIImage(data: dataImage) else { return }
                        self.imageCacheService?.saveImageToCache(url: url, image: image)
                        completion(.success(image))
                    case let .failure(error):
                        completion(.failure(error))
                }
            }
        } else {
            guard let image = image else { return }
            completion(.success(image))
        }
    }
}
