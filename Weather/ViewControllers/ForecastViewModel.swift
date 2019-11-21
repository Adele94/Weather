//
//  ForecastViewModel.swift
//  Weather
//
//  Created by  Adele Shavalieva on 13/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import UIKit

struct ForecastViewModel{
    let city: String
    let temperature: Double
    let wind: Double
    let direction: String
    let image: UIImage?
    
    static func format(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    static func degToCompass(_ num: Int) -> String {
        let val = Int((Double(num) / 22.5) + 0.5)
        let arr = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        return arr[(val % 16)]
    }
}

extension ForecastViewModel {
    init?(Forecast: Forecast) {
        let num = Int(Forecast.wind.deg)
        city = Forecast.name
        temperature = Double(Forecast.main.temp)
        wind = Double(Forecast.wind.speed)
        direction = ForecastViewModel.degToCompass(num)
        image = UIImage(named: Forecast.weather[0].icon)
    }
}
