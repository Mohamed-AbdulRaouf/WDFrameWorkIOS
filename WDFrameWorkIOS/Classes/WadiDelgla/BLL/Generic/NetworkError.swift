//
//  NetworkError.swift
//  SwinjectMVVMExample
//
//  Created by Yoichi Tagaya on 8/22/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation

public enum NetworkErrorBLL: Error, CustomStringConvertible {
    /// Unknown or not supported error.
    case Unknown

    /// Not connected to the internet.
    case NotConnectedToInternet

    /// International data roaming turned off.
    case InternationalRoamingOff

    /// Cannot reach the server.
    case NotReachedServer

    /// Connection is lost.
    case ConnectionLost

    /// Incorrect data returned from the server.
    case IncorrectDataReturned

    internal init(error: NSError) {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorUnknown:
                self = .Unknown
            case NSURLErrorCancelled:
                self = .Unknown // Cancellation is not used in this project.
            case NSURLErrorBadURL:
                self = .IncorrectDataReturned // Because it is caused by a bad URL returned in a JSON response from the server.
            case NSURLErrorTimedOut:
                self = .NotReachedServer
            case NSURLErrorUnsupportedURL:
                self = .IncorrectDataReturned
            case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                self = .NotReachedServer
            case NSURLErrorDataLengthExceedsMaximum:
                self = .IncorrectDataReturned
            case NSURLErrorNetworkConnectionLost:
                self = .ConnectionLost
            case NSURLErrorDNSLookupFailed:
                self = .NotReachedServer
            case NSURLErrorHTTPTooManyRedirects:
                self = .Unknown
            case NSURLErrorResourceUnavailable:
                self = .IncorrectDataReturned
            case NSURLErrorNotConnectedToInternet:
                self = .NotConnectedToInternet
            case NSURLErrorRedirectToNonExistentLocation, NSURLErrorBadServerResponse:
                self = .IncorrectDataReturned
            case NSURLErrorUserCancelledAuthentication, NSURLErrorUserAuthenticationRequired:
                self = .Unknown
            case NSURLErrorZeroByteResource, NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData:
                self = .IncorrectDataReturned
            case NSURLErrorCannotParseResponse:
                self = .IncorrectDataReturned
            case NSURLErrorInternationalRoamingOff:
                self = .InternationalRoamingOff
            case NSURLErrorCallIsActive, NSURLErrorDataNotAllowed, NSURLErrorRequestBodyStreamExhausted:
                self = .Unknown
            case NSURLErrorFileDoesNotExist, NSURLErrorFileIsDirectory:
                self = .IncorrectDataReturned
            case
            NSURLErrorNoPermissionsToReadFile,
            NSURLErrorSecureConnectionFailed,
            NSURLErrorServerCertificateHasBadDate,
            NSURLErrorServerCertificateUntrusted,
            NSURLErrorServerCertificateHasUnknownRoot,
            NSURLErrorServerCertificateNotYetValid,
            NSURLErrorClientCertificateRejected,
            NSURLErrorClientCertificateRequired,
            NSURLErrorCannotLoadFromNetwork,
            NSURLErrorCannotCreateFile,
            NSURLErrorCannotOpenFile,
            NSURLErrorCannotCloseFile,
            NSURLErrorCannotWriteToFile,
            NSURLErrorCannotRemoveFile,
            NSURLErrorCannotMoveFile,
            NSURLErrorDownloadDecodingFailedMidStream,
            NSURLErrorDownloadDecodingFailedToComplete:
                self = .Unknown
            default:
                self = .Unknown
            }
        }
        else {
            self = .Unknown
        }
    }
    
    public var description: String {
        let text: String
        switch self {
        case .Unknown:
            text = RBLL.string.localizable.networkError_Unknown()
        case .NotConnectedToInternet:
            text = RBLL.string.localizable.networkError_NotConnectedToInternet()
        case .InternationalRoamingOff:
            text = RBLL.string.localizable.networkError_InternationalRoamingOff()
        case .NotReachedServer:
            text = RBLL.string.localizable.networkError_NotReachedServer()
        case .ConnectionLost:
            text = RBLL.string.localizable.networkError_ConnectionLost()
        case .IncorrectDataReturned:
            text = RBLL.string.localizable.networkError_IncorrectDataReturned()
        }
        return text
    }
}
