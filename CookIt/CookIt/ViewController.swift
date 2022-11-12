//
//  ViewController.swift
//  CookIt
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let recipes: [Recipe]  = [
        Recipe(title: "Best Brownies", steps: ["step 1", "step 2", "step 3"], imageURL: "https://images.pexels.com/photos/45202/brownie-dessert-cake-sweet-45202.jpeg"),
        Recipe(title: "Banana Bread", steps: ["step 1", "step 2", "step 3"], imageURL: "https://images.pexels.com/photos/830894/pexels-photo-830894.jpeg"),
        Recipe(title: "Chocolate Chip Cookies", steps: ["step 1", "step 2", "step 3"], imageURL: "https://images.pexels.com/photos/230325/pexels-photo-230325.jpeg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipeDetailViewController = segue.destination as? RecipeDetailViewController,
           let index = tableView.indexPathForSelectedRow?.row {
            recipeDetailViewController.recipe = recipes[index]
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        
        if let url = URL(string: recipe.imageURL), let data = try? Data(contentsOf: url) {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.textLabel?.text = recipes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    


}

