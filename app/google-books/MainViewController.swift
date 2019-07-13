//
//  MainViewController.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//
import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UILabel!
    
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let cellHeight:CGFloat = 101
    var imagensDosLivros = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var barraDePesquisar: UITextField!
    
    @IBAction func botaoDePesquisar(_ sender: UIButton) {
        guard let pesquisa:String = barraDePesquisar.text else {
            return
        }
        BookHandler.fetchFromWeb(pesquisa) { (res) in
            switch (res) {
            case .success(let books):
                self.books = books
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
//                self.tableView.reloadData()
            case .error(let description):
                print(description)
            }
        }
    }
    
    var books = [Book]()
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell") as! BookCell
        let string = "\(books[indexPath.row].thumbnail)"
        cell.imagem.imageFromServerURL(urlString: string) { (res, err) in
            guard let res:String = res else {
                return
            }
            print(res)
        }
            
        
        //pegando nome do livro e colocando descricao da celula da table
        cell.nome.text = books[indexPath.row].title
        
        //pegando tipo, se é livro ou nao e add e colocando descricao da celula da table
        cell.descricao.text = books[indexPath.row].printType
        
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
