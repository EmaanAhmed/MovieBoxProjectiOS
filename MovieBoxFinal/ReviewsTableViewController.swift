//
//  ReviewsTableViewController.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/14/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit

class ReviewsTableViewController: UITableViewController,ReloadReviewsDeleget{
    
    var id: Int?
    var reviewList: [Review]?
    private var myReview : Reviews!
    
    
    func reloadReviews(reviews: [Review]) {
        reviewList = reviews
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        myReview = Reviews(id: id!, deleget: self)
        reviewList =  myReview.execute()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (reviewList?.count == 0)
        {
            let alert = UIAlertController(title: "No Reviews to show", message: "sorry", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Back to movie", style: .default, handler: {action in
                self.dismiss(animated: true, completion: nil)
            } ))
            self.present(alert, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviewList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewTableViewCell

        cell.myAuthor.text = reviewList![indexPath.row].author
        cell.myContent.text = reviewList![indexPath.row].content

        return cell
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
