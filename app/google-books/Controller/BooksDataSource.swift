//
//  BooksDataSource.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit

class BooksDataSource: NSObject, UITableViewDataSource {
    var books = [Book]()
    
    init(books: [Book]) {
        self.books = books
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //retorna o tamanho de books
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Criando a nossa celula modificada
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell") as! BookCell
        
        //pegando a URL e transformando em String
        let urlString = "\(books[indexPath.row].thumbnail)"
        //colocando imagem do livro na imagem da celula da table
        cell.imagem.imageFromServerURL(urlString: urlString) { (res, err) in
            if (err != nil) {
                print(err as Any)
            }
        }
        
        //pegando nome do livro na da celula da table
        cell.nome.text = books[indexPath.row].title
        
        //pegando tipo, se é livro ou nao e add e colocando descricao da celula da table
        cell.descricao.text = books[indexPath.row].printType
        
        return cell
    }
}
