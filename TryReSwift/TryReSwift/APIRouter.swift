//
//  APIRouter.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Alamofire

extension API {
    public enum Router: URLRequestConvertible {
        case AllItem(page: String)
        case StockItem(page: String, id: String)
        
        private var method: Alamofire.Method {
            switch self {
            case .AllItem(_):
                return .GET
            case .StockItem(_, _):
                return .GET
            }
        }
        
        private var headers: [String: String] {
            var headers = [String: String]()
            // TODO:
            // get token after login.
            
            return headers
        }
        
        private var baseURL: String {
            return "https://qiita.com/api/v2"
        }
        
        private var path: String {
            switch self {
            case .AllItem(_):
                return "/items"
            case .StockItem(_, let id):
                return "/\(id)/stocks"
            }
        }
        
        private var parameters: [String: AnyObject] {
            var parameters = [String: AnyObject]()
            parameters["per_page"] = "20"
            
            switch self {
            case .AllItem(let page):
                parameters["page"] = page
            case .StockItem(let page, _):
                parameters["page"] = page
            }
            
            print(parameters)
            
            return parameters
        }
        
        public var URLRequest: NSMutableURLRequest {
            let URL = NSURL(string: self.baseURL)!
            let request = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(self.path))
            request.HTTPMethod = self.method.rawValue
            
            switch self {
            case .AllItem(_):
                return Alamofire.ParameterEncoding.URL.encode(request, parameters: self.parameters).0
            case .StockItem(_, _):
                return Alamofire.ParameterEncoding.URL.encode(request, parameters: self.parameters).0
            }
        }
    }
}
