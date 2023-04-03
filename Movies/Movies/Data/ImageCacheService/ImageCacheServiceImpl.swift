// ImageCacheServiceImpl.swift
// Copyright © Movie. All rights reserved.

import UIKit

final class ImageCacheServiceImpl: ImageCacheService {
    // MARK: - Private Properties

    private var images = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60

    private static let pathName: String = {
        let pathName = Constants.images
        guard let cachesDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private enum Constants {
        static let images = "images"
        static let photoFormatPNG = ".png"
    }

    // MARK: - Internal Methods

    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() ?? image.jpegData(compressionQuality: 1) else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }

        let lifeTime = Date().timeIntervalSince(modificationDate)

        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }

        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return nil }
        let hashName = (url.split(separator: "/").last ?? Substring()) + Constants.photoFormatPNG
        return cachesDirectory.appendingPathComponent(ImageCacheServiceImpl.pathName + "/" + hashName).path
    }
}
