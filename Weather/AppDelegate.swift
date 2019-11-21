//
//  AppDelegate.swift
//  Weather
//
//  Created by  Adele Shavalieva on 31/10/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import UIKit
import CoreLocation
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationService = LocationService()
    let ForecastProvider = MoyaProvider<ForecastProvider>()
    let ForecastProviderCity = MoyaProvider<ForecastProviderCity>()
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "OPENWEATHER_API_KEY") as! String

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Location service callbacks
        locationService.newestLocation = { [weak self] coordinate in
            guard let self = self, let coordinate = coordinate else { return }
            // print("Location is: \(coordinate)")
            
            let forecastTableViewController =
                AppDelegate.viewControllerInNav(
                    ofType: ForecastTableViewController.self,
                    in: self.window
                )
            
            self.getForecast(for: coordinate) { (viewModel : ForecastViewModel) in
                forecastTableViewController?.viewModels.append(viewModel)
               
               /* self.getCity(city: "London,uk") { (viewModel : ForecastViewModel) in
                    forecastTableViewController?.viewModels.append(viewModel)
 
                } */
            }
        }
        locationService.statusUpdated = { [weak self] status in
            if status == .authorizedWhenInUse {
                self?.locationService.getLocation()
            }
        }
        
        switch locationService.status {
        case .notDetermined:
            locationService.getPermission()
        case .authorizedWhenInUse:
            locationService.getLocation()
        default: assertionFailure("Location is: \(locationService.status)")
        }
        return true
    }
    
    func getForecast(for coordinates: CLLocationCoordinate2D, completion: @escaping (ForecastViewModel) -> ()) {
        ForecastProvider.request(.forecast(coordinates.latitude, coordinates.longitude, AppDelegate.apiKey)) {(result) in
            switch result {
            case .success(let response):
                var forecast: Forecast?
                do {
                    forecast = try Forecast(data: response.data)
                    
                    // print ("Forecast \n\n", forecast)
                    
                    completion(forecast.flatMap(ForecastViewModel.init) as! ForecastViewModel)
                } catch {
                    print("Failed to get forecast: \(error)")
                }
            case .failure(let error):
                print("Network request failed: \(error)")
            }
        }
    }
    
    func getCity(city: String, completion: @escaping (ForecastViewModel) -> ()) {
        ForecastProviderCity.request(.forecast(city, AppDelegate.apiKey)) { (result) in
            switch result {
            case .success(let response):
                var forecast: Forecast?
                do {
                    forecast = try Forecast(data: response.data)
                    
                    //print ("Forecast \n\n", forecast)
                    
                    completion(forecast.flatMap(ForecastViewModel.init) as! ForecastViewModel)
                } catch {
                    print("Failed to get forecast: \(error)")
                }
            case .failure(let error):
                print("Network request failed: \(error)")
            }
        }
    }
    
    static func viewControllerInNav<T>(ofType: T.Type, in window: UIWindow?) -> T? {
        return window?.rootViewController
            .flatMap { $0 as? UINavigationController }?
            .viewControllers
            .first(where: { $0 is T }) as? T
    }
}

