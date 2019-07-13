//
//  BookHandler.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation

enum TaskLoadResponse: Error {
    case success(books: [Book])
    case error(description: String)
}

class BookHandler {
    static func fetchFromWeb(_ pesquisa:String, completion: @escaping (TaskLoadResponse) -> Void) {
        //Server Em Producao
        let serverURL = "https://booksgoglee.herokuapp.com"
        //Server Em Desenvolvimento
        //let serverURL = "http://192.168.1.58:3000"
        
        //tira os espacos e coloca tracos
        let pesquisaFormatada = pesquisa.replace(string: " ", replacement: "-")
        
        //Cria a url de acesso ao servidor
        let BASE_URL:String = "\(serverURL)/books/search/\(pesquisaFormatada)"
        
        //Valida a URL
        guard let url = URL(string: BASE_URL) else {
            completion(TaskLoadResponse.error(description: "URL not initiated"))
            return;
        }
        
        //Faz a chamada no Servidor
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            guard error == nil, let jsonData = data else {
                completion(TaskLoadResponse.error(description: "Error to unwrapp data variable"))
                return
            }
            
            if let books = try? JSONDecoder().decode([Book].self, from: jsonData) {
                completion(TaskLoadResponse.success(books: books))
            } else {
                completion(TaskLoadResponse.error(description: "Error to convert data to [Task]"))
            }
        }).resume()
    }
}


