//
//  CurrentWeather.swift
//  CurrentWeatherFinal
//
//  Created by Rail on 03.07.2022.
//

import Foundation

//   Модель данных куда будем присваивать данные из сервера
class CurrentWeather: Decodable {
    
    //    Город
    let cityName: String
    //    Текущая температура
    let temp: Double
    var currentTemperature: String {
        //        Поскольку наш Лейбл принимает только значения Стринг, преобразуем значение температуры в Стринг. Возвращаем форматированную строку, где указываем кол-во чисел после запятой, в нашем случае 0
        return String(format: "%.0f", temp)
    }
    //    Ощущаемая температура
    let feelsTemp: Double
    var currentFeelsTemperature: String {
        //        Возвращаем форматированную строку, где указываем кол-во чисел после запятой, в нашем случае 0
        return String(format: "%.0f", feelsTemp)
    }
    
    let pressure: Int
    var currentPressure: String {
        return String(pressure)
    }
    let speedWind: Double
    var currentSpeedWind: String {
        return String(format: "%.0f", speedWind)
    }
    let humidity: Int
    var currentHumidity: String {
        return String(humidity)
    }
    let sunrise: Int
    var currentSunrise: String {
        //        Конвертируем полученную данные из Unix в часы, минуты и секунды
        let epochDate = Date(timeIntervalSince1970: TimeInterval(sunrise) as! TimeInterval)
        let calendar = Calendar.current
        let epochHour = calendar.component(.hour, from: epochDate)
        let epochMinute = calendar.component(.minute, from: epochDate)
        let epochSecond = calendar.component(.second, from: epochDate)
        let sunriseTime = "\(epochHour):\(epochMinute):\(epochSecond)"
        return String(sunriseTime)
    }
    let sunset: Int
    var currentSunset: String {
        //        Конвертируем полученную данные из Unix в часы, минуты и секунды
        let epochDate = Date(timeIntervalSince1970: TimeInterval(sunset) as! TimeInterval)
        print(epochDate)
        let calendar = Calendar.current
        let epochHour = calendar.component(.hour, from: epochDate)
        let epochMinute = calendar.component(.minute, from: epochDate)
        let epochSecond = calendar.component(.second, from: epochDate)
        let sunsetTime = "\(epochHour):\(epochMinute):\(epochSecond)"
        return String(sunsetTime)
    }
    
    let conditionCode: Int
    
    //    Напишем доп св-ва, чтобы подставить в метод по обновлению интерфейса приложения. conditionCode мы получаем с сайта"
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosign"
        }
    }
    //    Напишем доп св-ва для добавления описания
    var dictionaryWeather: String {
        switch conditionCode {
        case 200...232:
            return "Гроза"
        case 300...321:
            return "Моросящий дождь"
        case 500...531:
            return "Дождь"
        case 600...622:
            return "Снег"
        case 701...781:
            return "Туман"
        case 800:
            return "Ясно"
        case 801...804:
            return "Облачно"
        default:
            return ""
        }
    }
    
    init?(currentWeatherData: CurrrentWeatherData) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        feelsTemp = currentWeatherData.main.feelsLike
        pressure = currentWeatherData.main.pressure
        speedWind = currentWeatherData.wind.speed
        humidity = currentWeatherData.main.humidity
        sunrise = currentWeatherData.sys.sunrise
        sunset = currentWeatherData.sys.sunset
        conditionCode = currentWeatherData.weather.first!.id
    }
}
