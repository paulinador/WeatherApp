//
//  CurrentWeatherRequest.swift
//  WeatherApp
//
//  Created by Paulina Dorożko on 09/11/2023.
//

import Foundation

struct CurrentWeatherRequest: APIRequest {
    typealias ReturnType = CurrentWeatherResponse
    
    var path: String = "/data/2.5/weather"
    
    var queries: [URLQueryItem]? {
        [URLQueryItem(name: "lat", value: "52.2319581"),
         URLQueryItem(name: "lon", value: "21.0067249"),
         URLQueryItem(name: "appid", value: "47bbb439c12753bbe3e7d76461c0dc3c"),
        URLQueryItem(name: "units", value: "metric")
        ]
    }
}
