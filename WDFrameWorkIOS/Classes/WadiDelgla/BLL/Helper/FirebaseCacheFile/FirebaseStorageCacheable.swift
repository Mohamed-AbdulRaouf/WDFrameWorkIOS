//
//  FirebaseStorageCacheable.swift
//  BLL
//
//  Created by SimpleTouch on 3/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

/*
import Foundation
import FirebaseStorage
@objc public protocol FirebaseStorageCacheable {
    static var targetPath: String { set get }
    static var remotePath: String { set get }
    @objc optional static var bundledFileName: String { set get }
}

public enum FirebaseStorageCacheableStatus {
    case upToDate, updateAvailable
}

public enum FirebaseStorageCacheableError: Error {
    case unresolveableTargetUrl,
    unresolveableBundledUrl,
    bundledFileNameMissing,
    bundledFileNotFound,
    copyBundledToTargetFailed,
    unresolveableStorageReference,
    missingRemoteModified,
    remoteFileError,
    writeUpdateToTargetFailed
}

public extension FirebaseStorageCacheable {
   
    static func getRemoteModified(
        onComplete: @escaping ((_: Int64) -> Void),
        onError: @escaping ((_: FirebaseStorageCacheableError?) -> Void)) {
        
        guard let storageReference = storageReference else {
            onError(.unresolveableStorageReference)
            return
        }
        storageReference.getMetadata { metadata, error in
            guard error == nil else {
                onError(.remoteFileError)
                return
            }
            
            guard let remoteModified = metadata?.generation else {
                onError(.missingRemoteModified)
                return
            }
            
            onComplete(remoteModified)
        }
    }
    
    static func checkForUpdate(
        onComplete: @escaping ((_: FirebaseStorageCacheableStatus) -> Void),
        onError: @escaping ((_: FirebaseStorageCacheableError?) -> Void)) {
        
        getRemoteModified(onComplete: { remoteModified in
            
            guard let targetModified = targetModified else {
                onComplete(.updateAvailable)
                return
            }
            let status: FirebaseStorageCacheableStatus = remoteModified == targetModified ? .upToDate : .updateAvailable
            onComplete(status)
        }, onError: { error in
            onError(error)
        })
    }
    
    static func update(
        onComplete: @escaping (() -> Void),
        onError: @escaping ((_: FirebaseStorageCacheableError?) -> Void),
        inProgress: ((_: Double) -> Void)? = nil) {
        
        guard let storageReference = storageReference else {
            onError(.unresolveableStorageReference)
            return
        }
        
        guard let targetUrl = targetUrl else {
            onError(.unresolveableTargetUrl)
            return
        }
        
        inProgress?(0.0)
        let downloadTask = storageReference.write(toFile: targetUrl) { url, error in
            guard error == nil else {
                onError(.writeUpdateToTargetFailed)
                return
            }
            onComplete()
        }
        let _ = downloadTask.observe(.progress) { snapshot in
            if let fractionCompleted = snapshot.progress?.fractionCompleted {
                inProgress?(fractionCompleted)
            }
        }
    }
    
    static func startDownload( onComplete: @escaping ((URL?,Int64?) -> Void),
           onError: @escaping ((_: String?) -> Void)){
        guard let storageReference = storageReference else { return }
        
        // Create local filesystem URL
        let localURL: NSURL! = NSURL(string: targetPath)
        // Download to the local filesystem
        _ = storageReference.write(toFile: localURL as URL) { (URL, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
                print(error)
                onError(error?.localizedDescription)
            } else {
                // Local file URL for "images/island.jpg" is returned
                getRemoteModified(onComplete: { remoteModifiedGeneration in
                     onComplete(URL,remoteModifiedGeneration)
                    UserDefaults.fileGeneration = remoteModifiedGeneration
                       }, onError: { error in
                        onError("Error")
                       })
                onComplete(URL,nil)
            }
        }
    }

    
    static var targetFileExists: Bool {
        guard let targetUrl = targetUrl else { return false }
        return (try? targetUrl.checkResourceIsReachable()) ?? false
    }
    
    static var targetUrl: URL? {
        return URL(string: targetPath)
//        guard let firstDocumentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        return firstDocumentsUrl.appendingPathComponent(targetPath)
    }
    
//    static var targetModified: Date? {
//        guard let targetUrl = targetUrl else { return nil }
//        do {
//            let attr = try FileManager.default.attributesOfItem(atPath: targetUrl.path)
//            return attr[FileAttributeKey.creationDate] as? Date
//        } catch {
//            return nil
//        }
//
//    }
    static var targetModified: Int64? {
        return UserDefaults.fileGeneration
    }
    private static var storageReference: StorageReference? {
        return Storage.storage().reference().child("api_errors.txt")
    }
}
extension FirebaseStorageCacheable{
    static func writeFromBundle(
           onComplete: @escaping (() -> Void),
           onError: @escaping ((_: FirebaseStorageCacheableError?) -> Void)) {
           
           guard bundledFileName != nil else {
               onError(.bundledFileNameMissing)
               return
           }
           
           guard let targetUrl = targetUrl else {
               onError(.unresolveableTargetUrl)
               return
           }
           
           guard let sourceUrl = bundleSourceUrl else {
               onError(.unresolveableBundledUrl)
               return
           }
           
           do {
               let subDir = targetUrl.deletingLastPathComponent()
               try FileManager.default.createDirectory(at: subDir, withIntermediateDirectories: true, attributes: [:])
               try FileManager.default.copyItem(atPath: sourceUrl.path, toPath: targetUrl.path)
               onComplete()
           } catch {
               onError(.copyBundledToTargetFailed)
           }
       }
    private static var bundleSourceUrl: URL? {
           guard let bundledFileName = bundledFileName else { return nil }
           return Bundle.main.resourceURL?.appendingPathComponent(bundledFileName)
       }
}
*/
