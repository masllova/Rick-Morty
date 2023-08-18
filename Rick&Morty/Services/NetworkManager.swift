//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingManager {
        
    func loadPersonages(from url: URL, completion: @escaping ([Personage]?) -> Void) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = json["results"].arrayValue

                var personages: [Personage] = []
                var processedResults = 0 // счетчик обработанных результатов
                let dispatchGroup = DispatchGroup() // Создаем группу диспетчера
                
                for result in results {
                    let id = result["id"].intValue
                    let name = result["name"].stringValue
                    let image = result["image"].stringValue
                    let status = Status(rawValue: result["status"].stringValue) ?? .unknown
                    let species = Species(rawValue: result["species"].stringValue) ?? .unknown
                    let type = result["type"].stringValue
                    let gender = Gender(rawValue: result["gender"].stringValue) ?? .unknown
                    
                    var myOrigin: Origin? = nil
                    
                    let originURLString = result["origin"]["url"].stringValue
                    if !originURLString.isEmpty,
                       let originURL = URL(string: originURLString) {
                        dispatchGroup.enter() // Входим в группу
                        
                        self.loadOrigin(originURL: originURL) { origin in
                            guard let origin = origin else {
                                completion(nil)
                                return
                            }
                            myOrigin = origin
                            
                            dispatchGroup.leave() // Выходим из группы
                        }
                    } else {
                        myOrigin = Origin(id: 0, name: "", type: "")
                    }
                    
                    var episodes: [Episode] = []
                    let episodeURLs = result["episode"].arrayValue.map { $0.stringValue }
                    
                    // Создаем отдельную очередь для каждого персонажа
                    let personageQueue = DispatchQueue(label: "com.example.personage\(id)", qos: .userInitiated)
                    
                    for episodeURL in episodeURLs {
                        if let episodeURL = URL(string: episodeURL) {
                            dispatchGroup.enter() // Входим в группу
                            
                            // Помещаем операцию в отдельную очередь для этого персонажа
                            personageQueue.async {
                                self.loadEpisode(episodeURL: episodeURL) { episode in
                                    if let episode = episode {
                                        episodes.append(episode)
                                        if episodes.count == episodeURLs.count {
                                            let personage = Personage(id: id, name: name, image: image, status: status, species: species, type: type, gender: gender, origin: myOrigin, episodes: episodes)
                                            personages.append(personage)
                                            processedResults += 1
                                            if processedResults == results.count {
                                                completion(personages)
                                            }
                                        }
                                    } else {
                                        completion(nil)
                                    }
                                    dispatchGroup.leave() // Выходим из группы
                                }
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    // Все операции завершились, выполним завершающую логику
                    completion(personages)
                }
                
            case .failure(let error):
                print("Ошибка при загрузке персонажей: \(error)")
                completion(nil)
            }
        }
    }

    /// Загрузка данных для origin
    private func loadOrigin(originURL: URL, completion: @escaping (Origin?) -> Void) {
        AF.request(originURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let origin = Origin(id: json["id"].intValue,
                                    name: json["name"].stringValue,
                                    type: json["type"].stringValue)
                completion(origin) // Передаем результат через замыкание
            case .failure(let error):
                print("Ошибка при загрузке origin: \(error)")
                completion(nil)
            }
        }
    }

    /// Загрузка данных для каждого episode
    private func loadEpisode(episodeURL: URL, completion: @escaping (Episode?) -> Void) {
        AF.request(episodeURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let episode = Episode(id: json["id"].intValue,
                                      name: json["name"].stringValue,
                                      airDate: json["air_date"].stringValue,
                                      episodeCode: json["episode"].stringValue)
                completion(episode) // Передаем результат через замыкание
            case .failure(let error):
                print("Ошибка при загрузке episode: \(error)")
                completion(nil)
            }
        }
    }

}
