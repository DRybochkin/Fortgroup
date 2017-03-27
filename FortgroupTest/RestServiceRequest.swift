//
//  RestServiceRequest.swift
//  AppBuilder
//
//  Created by Dmitry Rybochkin on 10/02/2017.
//  Copyright © 2017 Turing. All rights reserved.
//

import Foundation
import Alamofire

public class RestServiceRequest {
    // MARK: - Variables
    private var url: String
    private var method: HTTPMethod = .get
    private var headers: [String:String] = [:]
    private var parameters: [String:String] = [:]
    private var content: Data?

    // MARK: - Lifecycle methods
    public init(_ url: String, method: HTTPMethod = .get) {
        self.url = url
        self.method = method
    }

    // MARK: - Custom public/internal methods
    public func addHeaders(_ headers: [String:String]) -> RestServiceRequest {
        headers.forEach {
            self.headers.updateValue($0.value, forKey: $0.key)
        }
        return self
    }

    public func addHeaders(_ headers:(key: String, value: String)...) -> RestServiceRequest {
        headers.forEach {
            self.headers.updateValue($0.value, forKey: $0.key)
        }
        return self
    }

    public func addParameters(_ parameters: [String:String]) -> RestServiceRequest {
        parameters.forEach {
            self.parameters.updateValue($0.value, forKey: $0.key)
        }
        return self
    }

    public func addParameters(_ parameters:(key: String, value: String)...) -> RestServiceRequest {
        parameters.forEach {
            self.parameters.updateValue($0.value, forKey: $0.key)
        }
        return self
    }

    public func setContent(_ data: Data) -> RestServiceRequest {
        content = data
        return self
    }

    public func send(_ resultHandler:@escaping (_ succeed: Bool, _ response: String?, _ webException: Error?) -> Void) {
        do {
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            urlRequest.httpMethod = method.rawValue

            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }

            if content != nil {
                urlRequest.httpBody = content
            }

            Alamofire.request(urlRequest)
                .responseString { resp in
                    let success = resp.result.isSuccess && resp.response!.statusCode < 400
                    resultHandler(success,
                                  success ? resp.result.value : "\(resp.response!.statusCode):\(resp.result.value!)",
                        resp.error)
            }
        } catch {
            resultHandler(false, nil, error)
        }
    }
}
