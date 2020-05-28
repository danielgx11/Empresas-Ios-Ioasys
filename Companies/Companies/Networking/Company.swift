//
//  Company.swift
//  Companies
//
//  Created by Daniel Gx on 18/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Moya

public enum Company {
    static var loginKey = "testeapple@ioasys.com.br"
    static var passwordKey = "12341234"
    
    case companies
    case login
}

extension Company: TargetType {
    public var baseURL: URL {
        return URL(string: "https://empresas.ioasys.com.br/api/v1")!
    }
    
    public var path: String {
        switch self {
        case .companies: return "/enterprises/"
        case .login: return "/users/auth/sign_in"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .companies: return .get
        case .login: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .companies:
            return .requestPlain
        case .login:
            let authParams = [ "email" : Company.loginKey, "password" : Company.passwordKey ]
            return .requestCompositeParameters(bodyParameters: authParams, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    var validate: Bool {
        return false
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}