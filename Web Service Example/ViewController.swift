//
//  ViewController.swift
//  Web Service Example
//
//  Created by Samira Baird on 1/9/16.
//  Copyright © 2016 Samira Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forecastLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=2de143494c0b295cca9337e1e96b00e0",
            parameters: nil,
            progress: nil,
            success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                if let responseObject = responseObject {
                    print("Response: " + responseObject.description)
                    if let listOfDays = responseObject["list"] as? NSArray {
                        if let tomorrow = listOfDays[0] as? NSDictionary {
                            if let tomorrowsWeather = tomorrow["weather"] as? NSArray {
                                if let firstWeatherOfDay = tomorrowsWeather[0] as? NSDictionary {
                                    if let forecast = firstWeatherOfDay["description"] as? String {
                                        self.forecastLabel.text = forecast
                                    }
                                }
                            }
                        }
                    }
                }
            },
            failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                print("Error: " + error.localizedDescription)
        })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

