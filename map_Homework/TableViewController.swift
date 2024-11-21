//
//  TableViewController.swift
//  map_Homework
//
//  Created by Bekzat on 17/11/24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayMalls = [Mall(name: "Vincom Times City", address: "458 Minh Khai Street, Vinh Tuy Ward, Hai Bà Trưng District", imagename: "vincome times city", lat: 20.993884, long: 105.86860),
                      Mall(name: "Vincom Center Bà Triệu", address: "191 P. Bà Triệu, Lê Đại Hành, Hai Bà Trưng, Hà Nội", imagename: "ba trieu", lat: 21.01137, long: 105.84975),
                      Mall(name: "Aeon Mall", address: "27 Đ. Cổ Linh, Long Biên, Hà Nộii", imagename: "aeon mall", lat: 21.02652, long: 105.90051)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMalls.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        let labelName = cell.viewWithTag(1) as! UILabel
        labelName.text = arrayMalls[indexPath.row].name
        
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = UIImage(named: arrayMalls[indexPath.row].imagename)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Detailed View Controller") as! ViewController
        
        vc.mall = arrayMalls[indexPath.row]
        
        navigationController?.show(vc, sender: self)
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
