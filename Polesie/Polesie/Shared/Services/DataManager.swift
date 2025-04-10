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
               completion(.failure(NSError(domain: "DataManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found."])))
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
       
       // Метод для загрузки JSON с использованием потокового чтения
       func loadJSONStream<T: Decodable>(from file: String, type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
           guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
               completion(.failure(NSError(domain: "DataManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found."])))
               return
           }
           
           let inputStream = InputStream(url: url)!
           inputStream.open()
           
           var buffer = [UInt8](repeating: 0, count: 4096)
           var jsonData = Data()
           var items: [T] = []
           
           while inputStream.hasBytesAvailable {
               let bytesRead = inputStream.read(&buffer, maxLength: buffer.count)
               
               if bytesRead > 0 {
                   jsonData.append(buffer, count: bytesRead)
                   
                   // Преобразуем накопленные данные в объект
                   let decoder = JSONDecoder()
                   do {
                       let decodedItems = try decoder.decode([T].self, from: jsonData)
                       items.append(contentsOf: decodedItems)
                       jsonData = Data() // очищаем данные для следующего пакета
                   } catch {
                       // Если еще не хватает данных для полного декодирования, продолжим читать
                       continue
                   }
               }
           }
           
           inputStream.close()
           
           if !items.isEmpty {
               completion(.success(items))
           } else {
               completion(.failure(NSError(domain: "DataManager", code: 500, userInfo: [NSLocalizedDescriptionKey: "No valid data found."])))
           }
       }
   }
