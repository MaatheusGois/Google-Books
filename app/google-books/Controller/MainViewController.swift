//
//  MainViewController.swift
//  google-books
//
//  Created by Matheus Gois on 13/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//
import UIKit

class MainViewController: UIViewController, UITableViewDelegate {
    
    //Search Bar
    @IBOutlet weak var barraDePesquisar: UITextField!
    
    //Search Button
    @IBAction func botaoDePesquisar(_ sender: UIButton) {
        guard let pesquisa:String = barraDePesquisar.text else {
            return
        }
        //Show loading
        self.showSpinner(onView: self.view)
        //Hide Keyboard
        self.dismissKeyboard()
        
        //Fetch books from web
        BookHandler.fetchFromWeb(pesquisa) { (res) in
            switch (res) {
            case .success(let books):
                self.dataSource.books = books
                //Async reload
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            case .error(let description):
                print(description)
                self.removeSpinner()
            }
        }
    }
    
    //Table
    @IBOutlet weak var tableView: UITableView!
    
    //Create DataSource
    let dataSource: BooksDataSource = BooksDataSource(books: [])
    
    //Config TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //retorna o tamanho da celula
        return 101
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.dataSource
    
        // Hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    //Light statusbar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    //Hide Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
