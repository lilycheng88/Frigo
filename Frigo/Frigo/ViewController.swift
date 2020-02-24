//
//  ViewController.swift
//  Frigo
//
//  Created by Lily Cheng on 2/15/20.
//  Copyright © 2020 Lily Cheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
//    , UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    //var itemName : [NSManagedObject] = []
    
 
    
    @IBAction func onSubmitClick(_ sender: Any) {
        viewTapped()
        
        itemTextField.text = ""
        weightTextField.text = ""
        dateTextField.text = ""
        categoryTextField.text = ""
    }
        
    var foodNameArr = ["Spinach", "Apples", "Blueberries", "Broccoli", "Bananas", "Chicken", "Turkey Slices", "Ground Beef", "Tofu", "Eggs", "Cheddar Cheese", "Butter", "Yogurt", "Sour Cream", "Whipped Cream", "Milk", "Orange Juice", "Coca Cola", "Lemonade", "Pizza", "Fried Rice", "Pasta"]
    var foodAmountArr = ["1 g", "2 g", "3 g", "4 g", "5 g", "6 g", "7 g", "8 g", "9 g", "10 g", "11 g", "12 g", "13 g", "14 g", "15 g", "16 g", "17 g", "18 g", "19 g", "20 g", "21 g", "22 g"]
      var foodDateArr = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "7 days", "8 days", "9 days", "10 days", "11 days", "12 days", "13 days", "14 days", "15 days", "16 days", "17 days", "18 days", "19 days", "20 days", "21 days", "22 days"]

    var searchFood = [String]()
    var searching = false
    
    override func viewDidLoad(){
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        
        if !(itemTextField == nil) {
            itemTextField.delegate = self
            weightTextField.delegate = self
            dateTextField.delegate = self
            
        }
        
        let tapRecogniser = UITapGestureRecognizer()
        tapRecogniser.addTarget(self, action:#selector(self.viewTapped))
        self.view.addGestureRecognizer(tapRecogniser)
        
        // #1.1 - Create "the notification's category value--its type."
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
        // #1.2 - Register the notification type.
        UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
    }
     
        @objc func viewTapped(){
            self.view.endEditing(true)
        }
     
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodNameArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        cell.foodTitle.text = foodNameArr[indexPath.row]
        cell.foodAmount.text = foodAmountArr[indexPath.row]
        cell.foodDate.text = foodDateArr[indexPath.row]
        
        return cell
    }
    
//    tableView.delegate = self
 //   tableView.dataSource = self
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool{
            if textField == itemTextField{
                textField.resignFirstResponder()
                weightTextField.becomeFirstResponder()
            }
            else{
                weightTextField.resignFirstResponder()
            }
            if textField == weightTextField{
                textField.resignFirstResponder()
                dateTextField.becomeFirstResponder()
            }
            else{
                dateTextField.resignFirstResponder()
            }
            if textField == dateTextField {
                textField.resignFirstResponder()
                categoryTextField.becomeFirstResponder()
            }
            else {
                categoryTextField.resignFirstResponder()
            }
            
            return true
            }
    
    
    @IBAction func sendNotificationButtonTapped(_ sender: Any) {
            
            // find out what are the user's notification preferences
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
     
                // we're only going to create and schedule a notification
                // if the user has kept notifications authorized for this app
                guard settings.authorizationStatus == .authorized else { return }
                
                // create the content and style for the local notification
                let content = UNMutableNotificationContent()
                
                // #2.1 - "Assign a value to this property that matches the identifier
                // property of one of the UNNotificationCategory objects you
                // previously registered with your app."
                content.categoryIdentifier = "debitOverdraftNotification"
                
                // create the notification's content to be presented
                // to the user
                content.title = "DEBIT OVERDRAFT NOTICE!"
                content.subtitle = "Exceeded balance by $300.00."
                content.body = "One-time overdraft fee is $25. Should we cover transaction?"
                content.sound = UNNotificationSound.default
                
                // #2.2 - create a "trigger condition that causes a notification
                // to be delivered after the specified amount of time elapses";
                // deliver after 10 seconds
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                // create a "request to schedule a local notification, which
                // includes the content of the notification and the trigger conditions for delivery"
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
                
                // "Upon calling this method, the system begins tracking the
                // trigger conditions associated with your request. When the
                // trigger condition is met, the system delivers your notification."
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            } // end getNotificationSettings
            
        } // end func sendNotificationButtonTapped


    
    
    func tableView0( _ tableView0: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchFood.count
        } else {
            return foodNameArr.count
        }
    }

    func tableView0( _ tableView0: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView0.dequeueReusableCell(withIdentifier: "Cell")
        if searching {
            Cell?.textLabel?.text = searchFood[indexPath.row]
        } else {
            Cell?.textLabel?.text = foodNameArr[indexPath.row]
        }
        return Cell!
    }
    
    //attempt to add swipe delete function
    func tableView0(_ tableView0: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            foodNameArr.remove(at: indexPath.row)
            tableView0.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

    extension ViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchFood = foodNameArr.filter({$0.prefix(searchText.count) == searchText})
            searching = true
            tableView.reloadData()

        }
    }

//}
