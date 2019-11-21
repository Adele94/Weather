//
//  NetworkManager.swift
//  Weather
//
//  Created by  Adele Shavalieva on 15/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static let shared:NetworkManager = NetworkManager()
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPENWEATHER_API_KEY") as! String

    
    func getWeather(city: String, result: @escaping ((OfferModel?)-> ())){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "appid", value: NetworkManager.apiKey)]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        //let task
        
    }
}
