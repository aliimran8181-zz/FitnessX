//
//  dashboardController.swift
//  FitnessX
//
//  Created by Ali on 17/11/2021.
//

import UIKit

class dashboardController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
     var Users : [Employee]? = nil
    private let CoreDataHandler: EmployeeManager = EmployeeManager()

     override func viewWillAppear(_ animated: Bool) {
         // Do any additional setup after loading the view.
         Users = CoreDataHandler.fetchEmployee()
         if(Users != nil && Users?.count != 0)
         {
             self.tableView.reloadData()
         }
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
       if(segue.identifier == SegueIdentifier.SegwayUpdateDelete)
       {
           let detailsView = segue.destination as? UpdateDeleteVC
           guard detailsView != nil else { return }
           detailsView?.selectedEmployee = self.Users![self.tableView.indexPathForSelectedRow!.row]
       }
    }
 }

 extension dashboardController : UITableViewDelegate, UITableViewDataSource
 {


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.Users!.count
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 250
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
         let employee = self.Users![indexPath.row]
         cell.fname.text = employee.fname
         cell.lname.text = employee.lname
         cell.email.text = employee.email
         cell.dob.text = employee.dob
         return cell
     }
     
 }
