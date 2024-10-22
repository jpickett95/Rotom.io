//
//  Errors.swift
//  Rotom.io
//
//  Created by Jonah Pickett on 10/16/24.
//

// MARK: - Error Entities
import Foundation


// MARK: - - Networking
/**
 Possible errors that can be thrown by NetworkManager networking functions.
 ### Error Cases:
 - invalidUrl
 - invalidResponse
 - dataError
 - invalidMethod
 - unknown
 */
enum NetworkingError: Error {
    /// The URL path is invalid or corrupted.
    case invalidUrl(_ url: String)
    /// The URLSession returned with a HTTPURLResponce status code outside of the range (200-299).
    case invalidResponse(_ response: String)
    /// An error occurred while decoding data.
    case dataError
    /// An error occured when switching the HTTP method
    case invalidMethod(_ method: HTTPMethod)
    /// An unknown error has occurred
    case unknownError(_ caller: String)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return String(localized: "Networking Error: Invalid URL")
        case .invalidResponse:
            return String(localized: "Networking Error: Invalid Response")
        case .dataError:
            return String(localized: "Networking Error: Data Error")
        case .invalidMethod:
            return String(localized: "Networking Error: Invalid HTTP Method")
        case .unknownError:
            return String(localized: "Networking Error: Unknown Error.")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .invalidUrl(let url):
            return String(localized: "Failed to construct url (\(url) with URLComponents.")
        case .invalidResponse(let response):
            return String(localized: "Failed with response: \(response).")
        case .dataError:
            return String(localized: "Data Error")
        case .invalidMethod(let method):
            return String(localized: "Url request method (\(method.rawValue)) is not supported.")
        case .unknownError(let caller):
            return String(localized: "Unknown error occurred. Thrown from \(caller).")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .invalidUrl:
            return String(localized: "Check for correct url components.")
        case .invalidMethod:
            return String(localized: "Use a different HTTP method, such as 'GET'.")
        default: return nil
        }
    }
}

// MARK: - - Decoding
/**
 Possible error that can be thrown from decoding
 ### Error Cases:
 - invalidJSON
 - invalidData
 - missingKey
 - typeMismatch
 */
enum DecodeError: Error {
    case invalidJSON
    case invalidData(_ description: String)
    case missingKey
    case typeMismatch
}

extension DecodeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidJSON:
            return String(localized: "Decoding Error: Invalid JSON")
        case .invalidData:
            return String(localized: "Decoding Error: Invalid Data")
        case .missingKey:
            return String(localized: "Decoding Error: Missing Key")
        case .typeMismatch:
            return String(localized: "Decoding Error: Type Mismatch")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .invalidJSON:
            return String(localized: "Invalid JSON")
        case .invalidData(let description):
            return String(localized: "Description: \(description)")
        case .missingKey:
            return String(localized: "Missing key")
        case .typeMismatch:
            return String(localized: "Type mismatch")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .invalidJSON:
            return String(localized: "Try to parse the JSON again")
        case .invalidData:
            return String(localized: "Try to parse the data again")
        case .missingKey:
            return String(localized: "Try to add the missing key")
        case .typeMismatch:
            return String(localized: "Try to cast the value to the correct type")
        }
    }
}

// MARK: - - Client Error
/**
 Possible errors thrown from http repsonse codes in the 400s range
 
 ### HTTP Repsonse Status Codes:
 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 425, 426, 428, 429, 431, 451
 */
enum ClientErrorResponse: Error {
    /// Response code 400
    case badRequest
    /// Response code 401
    case unauthorized
    /// Response code 402
    case paymentRequired
    /// Response code 403
    case forbidden
    /// Response code 404
    case notFound
    /// Response code 405
    case methodNotAllowed
    /// Response code 406
    case notAcceptable
    /// Response code 407
    case proxyAuthenticationRequired
    /// Response code 408
    case requestTimeout
    /// Response code 409
    case conflict
    /// Response code 410
    case gone
    /// Response code 411
    case lengthRequired
    /// Response code 412
    case preconditionFailed
    /// Response code 413
    case payloadTooLarge
    /// Response code 414
    case URITooLong
    /// Response code 415
    case unsupportedMediaType
    /// Response code 416
    case rangeNotSatisfiable
    /// Response code 417
    case expectationFailed
    /// Response code 418
    case imATeapot
    /// Response code 421
    case misdirectedRequest
    /// Response code 422
    case unprocessableContent
    /// Response code 423
    case locked
    /// Response code 424
    case failedDependency
    /// Response code 425
    case tooEarly
    /// Response code 426
    case upgradeRequired
    /// Response code 428
    case preconditionRequired
    /// Response code 429
    case tooManyRequests
    /// Repsonse code 431
    case requestHeaderFieldsTooLarge
    /// Repsonse code 451
    case unavailableForLegalReasons
}

extension ClientErrorResponse: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return String(localized: "Client Error: (400) Bad Request")
        case .unauthorized:
            return String(localized: "Client Error: (401) Unauthorized")
        case .paymentRequired:
            return String(localized: "Client Error: (402) Payment Required")
        case .forbidden:
            return String(localized: "Client Error: (403) Forbidden")
        case .notFound:
            return String(localized: "Client Error: (404) Not Found")
        case .methodNotAllowed:
            return String(localized: "Client Error: (405) Method Not Allowed")
        case .notAcceptable:
            return String(localized: "Client Error: (406) Not Acceptable")
        case .proxyAuthenticationRequired:
            return String(localized: "Client Error: (407) Proxy Authentication Required")
        case .requestTimeout:
            return String(localized: "Client Error: (408) Request Timeout")
        case .conflict:
            return String(localized: "Client Error: (409) Conflict")
        case .gone:
            return String(localized: "Client Error: (410) Gone")
        case .lengthRequired:
            return String(localized: "Client Error: (411) Length Required")
        case .preconditionFailed:
            return String(localized: "Client Error: (412) Precondition Failed")
        case .payloadTooLarge:
            return String(localized: "Client Error: (413) Payload Too Large")
        case .URITooLong:
            return String(localized: "Client Error: (414) URI Too Long")
        case .unsupportedMediaType:
            return String(localized: "Client Error: (415) Unsupported Media Type")
        case .rangeNotSatisfiable:
            return String(localized: "Client Error: (416) Range Not Satisfiable")
        case .expectationFailed:
            return String(localized: "Client Error: (417) Expectation Failed")
        case .imATeapot:
            return String(localized: "Client Error: (418) I'm A Teapot")
        case .misdirectedRequest:
            return String(localized: "Client Error: (421) Misdirected Request")
        case .unprocessableContent:
            return String(localized: "Client Error: (422) Unprocessable Content")
        case .locked:
            return String(localized: "Client Error: (423) Locked")
        case .failedDependency:
            return String(localized: "Client Error: (424) Failed Dependency")
        case .tooEarly:
            return String(localized: "Client Error: (425) Too Early")
        case .upgradeRequired:
            return String(localized: "Client Error: (426) Upgrade Required")
        case .preconditionRequired:
            return String(localized: "Client Error: (428) Precondition Required")
        case .tooManyRequests:
            return String(localized: "Client Error: (429) Too Many Requests")
        case .requestHeaderFieldsTooLarge:
            return String(localized: "Client Error: (431) Request Header Fields Too Large")
        case .unavailableForLegalReasons:
            return String(localized: "Client Error: (451) Unavailable For Legal Reasons")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .badRequest:
            return String(localized: "The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).")
        case .unauthorized:
            return String(localized: "Although the HTTP standard specifies \"unauthorized\", semantically this response means \"unauthenticated\". That is, the client must authenticate itself to get the requested response.")
        case .paymentRequired:
            return String(localized: "This response code is reserved for future use. The initial aim for creating this code was using it for digital payment systems, however this status code is used very rarely and no standard convention exists.")
        case .forbidden:
            return String(localized: "The client does not have access rights to the content; that is, it is unauthorized, so the server is refusing to give the requested resource. Unlike 401 Unauthorized, the client's identity is known to the server.")
        case .notFound:
            return String(localized: "The server cannot find the requested resource. In the browser, this means the URL is not recognized. In an API, this can also mean that the endpoint is valid but the resource itself does not exist. Servers may also send this response instead of 403 Forbidden to hide the existence of a resource from an unauthorized client. This response code is probably the most well known due to its frequent occurrence on the web.")
        case .methodNotAllowed:
            return String(localized: "The request method is known by the server but is not supported by the target resource. For example, an API may not allow calling DELETE to remove a resource.")
        case .notAcceptable:
            return String(localized: "This response is sent when the web server, after performing server-driven content negotiation, doesn't find any content that conforms to the criteria given by the user agent.")
        case .proxyAuthenticationRequired:
            return String(localized: "This is similar to 401 Unauthorized but authentication is needed to be done by a proxy.")
        case .requestTimeout:
            return String(localized: "This response is sent on an idle connection by some servers, even without any previous request by the client. It means that the server would like to shut down this unused connection. This response is used much more since some browsers, like Chrome, Firefox 27+, or IE9, use HTTP pre-connection mechanisms to speed up surfing. Also note that some servers merely shut down the connection without sending this message.")
        case .conflict:
            return String(localized: "This response is sent when a request conflicts with the current state of the server.")
        case .gone:
            return String(localized: "This response is sent when the requested content has been permanently deleted from server, with no forwarding address. Clients are expected to remove their caches and links to the resource. The HTTP specification intends this status code to be used for \"limited-time, promotional services\". APIs should not feel compelled to indicate resources that have been deleted with this status code.")
        case .lengthRequired:
            return String(localized: "Server rejected the request because the Content-Length header field is not defined and the server requires it.")
        case .preconditionFailed:
            return String(localized: "The client has indicated preconditions in its headers which the server does not meet.")
        case .payloadTooLarge:
            return String(localized: "Request entity is larger than limits defined by server. The server might close the connection or return an Retry-After header field.")
        case .URITooLong:
            return String(localized: "The URI requested by the client is longer than the server is willing to interpret.")
        case .unsupportedMediaType:
            return String(localized: "The media format of the requested data is not supported by the server, so the server is rejecting the request.")
        case .rangeNotSatisfiable:
            return String(localized: "The range specified by the Range header field in the request cannot be fulfilled. It's possible that the range is outside the size of the target URI's data.")
        case .expectationFailed:
            return String(localized: "This response code means the expectation indicated by the Expect request header field cannot be met by the server.")
        case .imATeapot:
            return String(localized: "The server refuses the attempt to brew coffee with a teapot.")
        case .misdirectedRequest:
            return String(localized: "The request was directed at a server that is not able to produce a response. This can be sent by a server that is not configured to produce responses for the combination of scheme and authority that are included in the request URI.")
        case .unprocessableContent:
            return String(localized: "The request was well-formed but was unable to be followed due to semantic errors.")
        case .locked:
            return String(localized: "The resource that is being accessed is locked.")
        case .failedDependency:
            return String(localized: "The request failed due to failure of a previous request.")
        case .tooEarly:
            return String(localized: "Indicates that the server is unwilling to risk processing a request that might be replayed.")
        case .upgradeRequired:
            return String(localized: "The server refuses to perform the request using the current protocol but might be willing to do so after the client upgrades to a different protocol. The server sends an Upgrade header in a 426 response to indicate the required protocol(s).")
        case .preconditionRequired:
            return String(localized: "The origin server requires the request to be conditional. This response is intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.")
        case .tooManyRequests:
            return String(localized: "The user has sent too many requests in a given amount of time (\"rate limiting\").")
        case .requestHeaderFieldsTooLarge:
            return String(localized: "The server is unwilling to process the request because its header fields are too large. The request may be resubmitted after reducing the size of the request header fields.")
        case .unavailableForLegalReasons:
            return String(localized: "The user agent requested a resource that cannot legally be provided, such as a web page censored by a government.")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        default: return nil
        }
    }
}


// MARK: - - Server Error
/**
 Possible errors thrown from http repsonse codes in the 500s range
 
 ### HTTP Repsonse Status Codes:
 500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511
 */
enum ServerErrorResponse: Error {
    /// Response code 500
    case internalServerError
    /// Response code 501
    case notImplemented
    /// Response code 502
    case badGateway
    /// Response code 503
    case serviceUnavailable
    /// Response code 504
    case gatewayTimeout
    /// Response code 505
    case httpVersionNotSupported
    /// Response code 506
    case variantAlsoNegotiates
    /// Response code 507
    case insufficientStorage
    /// Response code 508
    case loopDetected
    /// Response code 510
    case notExtended
    /// Repsonse code 511
    case networkAuthenticationRequired
}

extension ServerErrorResponse: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internalServerError:
            return String(localized: "Server Error: (500) Internal Server Error")
        case .notImplemented:
            return String(localized: "Server Error: (501) Not Implemented")
        case .badGateway:
            return String(localized: "Server Error: (502) Bad Gateway")
        case .serviceUnavailable:
            return String(localized: "Server Error: (503) Service Unavailable")
        case .gatewayTimeout:
            return String(localized: "Server Error: (504) Gateway Timeout")
        case .httpVersionNotSupported:
            return String(localized: "Server Error: (505) HTTP Version Not Supported")
        case .variantAlsoNegotiates:
            return String(localized: "Server Error: (506) Variant Also Negotiates")
        case .insufficientStorage:
            return String(localized: "Server Error: (507) Insufficient Storage")
        case .loopDetected:
            return String(localized: "Server Error: (508) Loop Detected")
        case .notExtended:
            return String(localized: "Server Error: (510) Not Extended")
        case .networkAuthenticationRequired:
            return String(localized: "Server Error: (511) Network Authentication Required")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .internalServerError:
            return String(localized: "The server has encountered a situation it does not know how to handle.")
        case .notImplemented:
            return String(localized: "The request method is not supported by the server and cannot be handled. The only methods that servers are required to support (and therefore that must not return this code) are GET and HEAD.")
        case .badGateway:
            return String(localized: "This error response means that the server, while working as a gateway to get a response needed to handle the request, got an invalid response.")
        case .serviceUnavailable:
            return String(localized: "The server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded. Note that together with this response, a user-friendly page explaining the problem should be sent. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time before the recovery of the service. The webmaster must also take care about the caching-related headers that are sent along with this response, as these temporary condition responses should usually not be cached.")
        case .gatewayTimeout:
            return String(localized: "This error response is given when the server is acting as a gateway and cannot get a response in time.")
        case .httpVersionNotSupported:
            return String(localized: "The HTTP version used in the request is not supported by the server.")
        case .variantAlsoNegotiates:
            return String(localized: "The server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.")
        case .insufficientStorage:
            return String(localized: "The method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request.")
        case .loopDetected:
            return String(localized: "The server detected an infinite loop while processing the request.")
        case .notExtended:
            return String(localized: "Further extensions to the request are required for the server to fulfill it.")
        case .networkAuthenticationRequired:
            return String(localized: "Indicates that the client needs to authenticate to gain network access.")
        }
    }
    
    
}
