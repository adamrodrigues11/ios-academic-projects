//
//  BookViewController.swift
//  BookTracker
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import UIKit

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var book: Book?
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = book!.title
        tableView.delegate = self
        tableView.dataSource = self
        if let url = URL(string: book!.imageURL), let data = try? Data(contentsOf: url) {
            bookImageView.image = UIImage(data: data)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book!.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookDetailsCell", for: indexPath)
        cell.textLabel?.text = book!.details[indexPath.row]
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
