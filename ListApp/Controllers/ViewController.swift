//
//  ViewController.swift
//  ListApp
//
//  Created by Simge ŞİŞMAN on 22.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func didAddBarButtonItemTapped(_ sender:UIBarButtonItem){
        let alertController = UIAlertController(title: "Add new data", message: nil, preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: "ADD", style: .default) { _ in
            if alertController.textFields?.first?.text != ""{
                self.data.append((alertController.textFields?.first?.text)!)
                self.tableView.reloadData()
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField()
        alertController.addAction(defaultButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

}

