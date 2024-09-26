//
//  UploadDataModel.swift
//  BaseProject
//
//  Created by Youssef on 7/24/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

struct UploadData {
    let data: Data
    let fileName: String
    let mimeType: String
    let name: String
    
    init(data: Data,
         name: String = "media",
         fileName: String = "media.jpeg",
         mimeType: String = "media/jpeg"
        ) {
        
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
        self.name = name
    }
    
    init(image: UIImage,
         name: String = "image",
         fileName: String = "image.jpeg",
         mimeType: String = "image/jpeg"
        ) {
        
        self.data = image.jpegData(compressionQuality: 0.5)!
        self.fileName = fileName
        self.mimeType = mimeType
        self.name = name
    }
}

// MARK: - Welcome
struct UploadImageDataModel: BaseCodable {
    var errors: [BaseError]?
    var meta: Meta?
    let data: [UploadImageData]?
}

// MARK: - Datum
struct UploadImageData: Codable {
    let type, id: String
}
