//
//  ForecastProvider.swift
//  Weather
//
//  Created by  Adele Shavalieva on 01/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import Moya

enum ForecastProvider{
    case forecast(Double,Double,String)
}

extension ForecastProvider: TargetType {
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
        case let .forecast(lat, lon, apiKey):
            return .requestParameters(
                parameters: [
                    "lat": lat,
                    "lon": lon,
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
