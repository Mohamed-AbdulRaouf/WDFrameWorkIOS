//
//  CustomFileManager.swift
//  BLL
//
//  Created by SimpleTouch on 3/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
//import SwiftyJSON
class CustomFileManagerBLL {
    static func getSaveFileUrl(fileName: String) -> String{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
            } else {
                print("FILE NOT AVAILABLE")
                fileManager.createFile(atPath: pathComponent.absoluteString, contents: nil, attributes: nil)
            }
            return pathComponent.absoluteString
        }
        print("FILE PATH NOT AVAILABLE")
        return ""
    }
    static func readFile(_ url : URL) -> [CustomErrorDTODAL]?{

        do {
            let data = try Data(contentsOf: url)
            guard let json = try? JSON(data: data).arrayValue else {
                return nil
            }
            let errors =  json.map({try! CustomErrorDTODAL.init(json: $0)})
            let str = String(decoding: data, as: UTF8.self)
            print(str);
            return errors
            
        } catch {
            // catch errors here
        }
        
        return nil
    }
}
