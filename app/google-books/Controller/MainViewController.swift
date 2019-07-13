//
//  MainViewController.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//
import UIKit




class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Barra de pesquisa
    @IBOutlet weak var barraDePesquisar: UITextField!
    
    
    //Botao de Pesquisar
    @IBAction func botaoDePesquisar(_ sender: UIButton) {
        guard let pesquisa:String = barraDePesquisar.text else {
            return
        }
        self.showSpinner(onView: self.view)
        //Vamos pegar os livros da internet
        BookHandler.fetchFromWeb(pesquisa) { (res) in
            switch (res) {
            //se houve resposta
            case .success(let books):
                self.books = books
                //faz reload da table asyncronamento, ou seja, em varias threads
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            //Caso tenha erro
            case .error(let description):
                print(description)
                self.removeSpinner()
            }
        }
    }
    
    
    
    //Table
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //retorna o tamanho da celula
        return 101
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
    
    //Hide Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //deixando a statusbar branca
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
