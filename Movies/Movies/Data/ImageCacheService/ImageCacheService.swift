// ImageCacheService.swift
// Copyright © Movie. All rights reserved.

import UIKit

protocol ImageCacheService {
    func saveImageToCache(url: String, image: UIImage)
    func getImageFromCache(url: String) -> UIImage?
}
