//
//  ViewController.swift
//  ListApp
//
//  Created by Simge ŞİŞMAN on 22.10.2022.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    var data = [NSManagedObject]()
    @IBOutlet weak var tableView: UITableView!
    var alertController = UIAlertController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func didRemoveBarButtonItemTapped(_ sender:UIBarButtonItem){
        presentAlert(title: "Delete all items?", message: nil, preferredStyle: .alert, cancelButtonTitle: "CANCEL", defaultButtonTitle: "YES", isTextFieldAvailable: false) { UIAlertAction in
            self.data.removeAll()
            self.tableView.reloadData()
        }
    }
    @IBAction func didAddBarButtonItemTapped(_ sender:UIBarButtonItem){
        self.presentAddAlert()
    }
    func presentAlert(title:String?,
                      message:String?,
                      preferredStyle:UIAlertController.Style = .alert,
                      cancelButtonTitle:String?,
                      defaultButtonTitle:String? = nil,
                      isTextFieldAvailable:Bool = false,
                      defaultButtonHandler:((UIAlertAction)->Void)? = nil){
        alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel)
        if defaultButtonTitle != nil{
            let defaultButton = UIAlertAction(title: defaultButtonTitle, style: .default, handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
        if isTextFieldAvailable{
            alertController.addTextField()
        }
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    func presentWarningAlert(){
        presentAlert(title: "Warning", message: "Not Empty Data", cancelButtonTitle: "OK")
    }
    func presentAddAlert(){
        presentAlert(title: "Add new data",
                     message: nil,
                     preferredStyle: .alert,
                     cancelButtonTitle: "Cancel",
                     defaultButtonTitle: "ADD",
                     isTextFieldAvailable: true,
                     defaultButtonHandler: { UIAlertAction in
            let text = self.alertController.textFields?.first?.text
            if text != ""{
                self.data.append((text)!)
                self.tableView.reloadData()
            }else{
                self.presentWarningAlert()
            }
        })
    }
    

}
extension  ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.data.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .systemRed
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.presentAlert(title: "Edit data",
                         message: nil,
                         preferredStyle: .alert,
                         cancelButtonTitle: "Cancel",
                         defaultButtonTitle: "EDIT",
                         isTextFieldAvailable: true,
                         defaultButtonHandler: { UIAlertAction in
                let text = self.alertController.textFields?.first?.text
                if text != ""{
                    self.data[indexPath.row] = text!
                    self.tableView.reloadData()
                }else{
                    self.presentWarningAlert()
                }
            })
        }
        deleteAction.backgroundColor = .systemRed
        editAction.backgroundColor = .systemCyan
        let config = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return config
    }
}
