//
//  DataImage.swift
//  TestApp
//
//  Created by Артем Ропавка on 29.09.2021.
//

import UIKit

enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    func toBase64(format: ImageFormat) -> String? {
        var imageData: Data?

        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }

        return imageData?.base64EncodedString()
    }
}
