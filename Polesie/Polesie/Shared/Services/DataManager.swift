//
//  DataManager.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 10.04.25.
//

import Foundation

class DataManager {
    func loadData<T: Decodable>(from file: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
           guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
               completion(.failure(NSError(domain: "DataManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл не найден."])))
               return
           }
           
           do {
               let data = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               let decodedObject = try decoder.decode(T.self, from: data)
               completion(.success(decodedObject))
           } catch {
               completion(.failure(error))
           }
       }
   }
