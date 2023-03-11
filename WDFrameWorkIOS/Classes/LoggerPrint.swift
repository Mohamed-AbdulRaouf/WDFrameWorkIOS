//
//  LoggerPrint.swift
//  WDFrameWorkIOS
//
//  Created by Raouf on 09/03/2023.
//

import Foundation

public class LoggerPrint {
    public init() {}
    
    public func printText(text: String) {
        print(text)
    }
    
    private func printTextPrivate(text: String) {
        print("Private \(text)")
    }
}
