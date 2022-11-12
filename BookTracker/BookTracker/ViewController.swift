//
//  ViewController.swift
//  BookTracker
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let books : [Book] = [
        Book(
            title: "Swift For Dummies",
            isbn10: 9788126554898,
            author: "Jesse Feiler",
            rating: Rating.four,
            notes: "A good resource for learning how to program with Swift",
            imageURL: "https://m.media-amazon.com/images/P/1119022223.01._TRSCLZZZ_SX500_.jpg"
            ),
        Book(
            title: "Shantaram: A Novel",
            isbn10: 0312330537,
            author: "Gregory David Roberts",
            rating: Rating.five,
            notes: "A novel about a man who escapes from a maximum security prison in Australia and finds a new life in Mumbai, India",
            imageURL: "https://m.media-amazon.com/images/P/0312330537.01._TRSCLZZZ_SX500_.jpg"
        ),
        Book(
            title: "Zen and the Art of Motorcycle Maintenance: An Inquiry Into Values",
            isbn10: 9780061907999,
            author: "Robert M. Pirsig",
            rating: Rating.five,
            notes: nil,
            imageURL: "https://m.media-amazon.com/images/P/B0026772N8.01._TRSCLZZZ_SX500_.jpg"
        )
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookViewController = segue.destination as? BookViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            bookViewController.book = books[index]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        cell.textLabel?.text = book.title

        if let url = URL(string: book.imageURL), let data = try? Data(contentsOf: url) {
            cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }

}

