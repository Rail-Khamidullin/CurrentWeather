//
//  NetworkDataFetcher.swift
//  CurrentWeatherFinal
//
//  Created by Rail on 03.07.2022.
//

import Foundation

//   Фиксируем метод поведения в целом, таким образом его нельзя будет изменить после подписки
protocol DataFetcher {
    func genericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> ())
}

class NetworkDataFetcher: DataFetcher {
    
//    Установим внешнюю зависимость, таким образом класс будет зависеть от Абстракии (protocol)
    var networking: Networking
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
//     GET запрос
    func genericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> ()) {
        
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error recived requesting data \(error.localizedDescription)")
                response(nil)
            }
//            Получаем декодированные данные и передаём далее
            let decoded = self.genericDecodeJSON(type: T.self, data: data)
            response(decoded)
        }
    }
    
//    Декодируем данные
    func genericDecodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        
        let jsonDecoder = JSONDecoder()
        guard let data = data else { return nil }
        
        let string = String(data: data, encoding: .utf8)
        print(string)
        do {
            let objects = try jsonDecoder.decode(type.self, from: data)
            return objects
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
