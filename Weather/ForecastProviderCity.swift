//
//  ForecastProviderCity.swift
//  Weather
//
//  Created by  Adele Shavalieva on 15/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import Moya

enum ForecastProviderCity{
    case forecast(String,String)
}

extension ForecastProviderCity: TargetType {
    public var baseURL: URL {
        return URL (string: "https://api.openweathermap.org")!
    }
    
    public var path: String {
        switch self {
        case .forecast:
            return "/data/2.5/weather"
        }
    }
    
    public var method: Method {
        switch self {
        case .forecast:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .forecast:
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        case let .forecast(city, apiKey):
            return .requestParameters(
                parameters: [
                    "q": city,
                    "appid": apiKey
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
