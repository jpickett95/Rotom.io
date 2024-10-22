//
//  ErrorHandlingService.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

// MARK: - Error Handling
import Foundation


// MARK: - - Protocol
protocol ErrorHandling {
    static func statusCodeSwitch(_ statusCode: Int) -> Error
}

// MARK: - - Service

/**
 Manager that handles Errors & error messages
 
 ### Methods:
    - statusCodeSwitch: returns a ClientErrorRespponse, ServerErrorResponse, or NetworkingError depending on the given status code input parameter.
 */
public struct ErrorManager: ErrorHandling {
    // MARK: - - Methods
    
    /**
     A static function that returns a ClientErrorResponse, ServerErrorResponse, or NetworkingError depending on the given status code input parameter.
     
     Called using 'ErrorManager.statusCodeSwitch(_ statusCode: Int)'
     
     - Parameters:
        - statusCode: A status code as an Int object
     
     - Returns: A ClientErrorResponse, ServerErrorResponse, or NetworkingError with a localized description, depending on the given status code input parameter.
     */
    public static func statusCodeSwitch(_ statusCode: Int) -> Error {
        switch(statusCode) {
        case 400:
            return ClientErrorResponse.badRequest
        case 401:
            return ClientErrorResponse.unauthorized
        case 402:
            return ClientErrorResponse.paymentRequired
        case 403:
            return ClientErrorResponse.forbidden
        case 404:
            return ClientErrorResponse.notFound
        case 405:
            return ClientErrorResponse.methodNotAllowed
        case 406:
            return ClientErrorResponse.notAcceptable
        case 407:
            return ClientErrorResponse.proxyAuthenticationRequired
        case 408:
            return ClientErrorResponse.requestTimeout
        case 409:
            return ClientErrorResponse.conflict
        case 410:
            return ClientErrorResponse.gone
        case 411:
            return ClientErrorResponse.lengthRequired
        case 412:
            return ClientErrorResponse.preconditionFailed
        case 413:
            return ClientErrorResponse.payloadTooLarge
        case 414:
            return ClientErrorResponse.URITooLong
        case 415:
            return ClientErrorResponse.unsupportedMediaType
        case 416:
            return ClientErrorResponse.rangeNotSatisfiable
        case 417:
            return ClientErrorResponse.expectationFailed
        case 418:
            return ClientErrorResponse.imATeapot
        case 421:
            return ClientErrorResponse.misdirectedRequest
        case 422:
            return ClientErrorResponse.unprocessableContent
        case 423:
            return ClientErrorResponse.locked
        case 424:
            return ClientErrorResponse.failedDependency
        case 425:
            return ClientErrorResponse.tooEarly
        case 426:
            return ClientErrorResponse.upgradeRequired
        case 428:
            return ClientErrorResponse.preconditionRequired
        case 429:
            return ClientErrorResponse.tooManyRequests
        case 431:
            return ClientErrorResponse.requestHeaderFieldsTooLarge
        case 451:
            return ClientErrorResponse.unavailableForLegalReasons
        case 500:
            return ServerErrorResponse.internalServerError
        case 501:
            return ServerErrorResponse.notImplemented
        case 502:
            return ServerErrorResponse.badGateway
        case 503:
            return ServerErrorResponse.serviceUnavailable
        case 504:
            return ServerErrorResponse.gatewayTimeout
        case 505:
            return ServerErrorResponse.httpVersionNotSupported
        case 506:
            return ServerErrorResponse.variantAlsoNegotiates
        case 507:
            return ServerErrorResponse.insufficientStorage
        case 508:
            return ServerErrorResponse.loopDetected
        case 510:
            return ServerErrorResponse.notExtended
        case 511:
            return ServerErrorResponse.networkAuthenticationRequired
        default:
            return NetworkingError.invalidResponse("Status Code - \(statusCode)")
        }
    }
    
    /**
     
     */
    public static func getErrorMessage(_ error: Error) -> String {
        switch error {
        case is NetworkingError:
            let error = error as! NetworkingError
            return concatenateErrorMessages(errorDescription: error.errorDescription, failureReason: error.failureReason, recoverySuggestion: error.recoverySuggestion)
        case is ClientErrorResponse:
            let error = error as! ClientErrorResponse
            return concatenateErrorMessages(errorDescription: error.errorDescription, failureReason: error.failureReason, recoverySuggestion: error.recoverySuggestion)
        case is ServerErrorResponse:
            let error = error as! ServerErrorResponse
            return concatenateErrorMessages(errorDescription: error.errorDescription, failureReason: error.failureReason, recoverySuggestion: error.recoverySuggestion)
        case is DecodeError:
            let error = error as! DecodeError
            return concatenateErrorMessages(errorDescription: error.errorDescription, failureReason: error.failureReason, recoverySuggestion: error.recoverySuggestion)
        default:
            return error.localizedDescription
        }
    }
    
    /**
     
     */
    private static func concatenateErrorMessages(errorDescription: String?, failureReason: String?, recoverySuggestion: String?) -> String {
        var errorMessage: String = ""
        if let errorDescription {
            errorMessage += errorDescription
        }
        if let failureReason {
            errorMessage += "\n\n\(failureReason)"
        }
        if let recoverySuggestion {
            errorMessage += "\n\n\(recoverySuggestion)"
        }
        return errorMessage
    }
}
