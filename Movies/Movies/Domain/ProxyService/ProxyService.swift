// ProxyService.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ProxyService {
    func configure(imageAPIService: ImageAPIService, imageCacheService: ImageCacheService)
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ())
}
