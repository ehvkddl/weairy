//
//  NotificationViewController.swift
//  WeairyNotificationContentExtension
//
//  Created by do hee kim on 2024/03/24.
//

import UIKit
import UserNotifications
import UserNotificationsUI

import Lottie

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    private let loadingView = {
        let lottieView = LottieAnimationView(name: "Loading")
        lottieView.loopMode = .loop
        return lottieView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWeatherComponent(false)
        
        configureView()
        setConstraints()
        loadingView.play()
        
        weatherImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
    
    func didReceive(_ notification: UNNotification) {
        Task {
            let weather = await fetchWeather()
            guard let weather else {
                label.text = "날씨를 불러오지 못했어요!"
                return
            }
            
            loadingView.isHidden = true
            setWeatherComponent(true)
            
            tempLabel.text = " \(weather.current.temp)°"
            
            let weatherID = weather.current.weatherID
            weatherImageView.image = UIImage(named: WeatherCondition.from(statusCode: weatherID).rawValue)
            
            let minTemp = weather.daily[0].tempMin
            let maxTemp = weather.daily[0].tempMax
            label.text = "오늘의 최저 온도는 \(minTemp)° 최고 온도는 \(maxTemp)°입니다."
        }
        
        self.label?.text = notification.request.content.body
    }

}

extension NotificationViewController {
    
    private func configureView() {
        [loadingView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setWeatherComponent(_ isVisible: Bool) {
        tempLabel.isHidden = !isVisible
        weatherImageView.isHidden = !isVisible
        label.isHidden = !isVisible
    }
    
}

extension NotificationViewController {
    
    func fetchWeather() async -> Weather? {
        var urlComponents = URLComponents(string: "\(Configurations.baseURL)data/3.0/onecall?")
        
        let query = [
            "lat": "37.5665851",
            "lon": "126.9782038",
            "appid": Configurations.weatherKey,
            "units": "metric",
            "lang": "kr",
            "exclude": "minutely,alerts"
        ]
        
        print(Configurations.baseURL, Configurations.weatherKey)
        
        query.forEach { urlComponents?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return nil
            }
            let decodeData = try JSONDecoder().decode(AllWeatherResponseDTO.self, from: data)
            return decodeData.toModel()
        } catch {
            print(error)
            return nil
        }
    }
    
}
