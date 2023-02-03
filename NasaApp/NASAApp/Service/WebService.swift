//
//  WebService.swift
//  NASAApp
//
//  Created by Şehriban Yıldırım on 31.01.2023.
//

import Foundation

class WebService{
    
    func curiosityDownload(url : URL, completion : @escaping ([Photo]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                let dizi = try? JSONDecoder().decode(Nasa.self, from: data)
                if let dizi = dizi{
                    completion(dizi.photos)
                }
            }
        }.resume()
    }
    
    func filterRover(url: URL, completion: @escaping ([Photo]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                let dizi = try? JSONDecoder().decode(Nasa.self, from: data)
                if let dizi = dizi{
                    completion(dizi.photos)
                }
            }
        }.resume()
    }
    
    func filterRover2(url: URL, completion: @escaping ([SpiritPhoto]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                let dizi = try? JSONDecoder().decode(SpiritNasa.self, from: data)
                if let dizi = dizi{
                    completion(dizi.photos)
                }
            }
        }.resume()
    }
    
    func spiritandopportunityDownload(url : URL, completion : @escaping ([SpiritPhoto]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data{
                let dizi = try? JSONDecoder().decode(SpiritNasa.self, from: data)
                if let dizi = dizi{
                    completion(dizi.photos)
                }
            }
        }.resume()
    }
}


