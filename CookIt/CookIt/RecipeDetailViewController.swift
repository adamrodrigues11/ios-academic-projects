//
//  RecipeDetailViewController.swift
//  CookIt
//
//  Created by Adam Rodrigues on 2022-11-01.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = recipe?.title
        tableView.delegate = self
        tableView.dataSource = self
        if let url = URL(string: recipe!.imageURL), let data = try? Data(contentsOf: url) {
            recipeImageView.image = UIImage(data: data)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.steps.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        cell.textLabel?.text = recipe?.steps[indexPath.row]
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
