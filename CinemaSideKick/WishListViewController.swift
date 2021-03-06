//
//  WishListViewController.swift
//  CinemaSideKick
//
//  Created by Santi Angelo Pierini on 5/15/17.
//
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class WishListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var movieData : [Movie]?
    var seenMovieData : [Movie]?
    var wishMovieData : [Movie]?
    var hateMovieData : [Movie]?
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func getInstructions(_ sender: UIButton) {
        
        let details = "Swipe → to get similar suggestions.\nSwipe ← to dislike suggestion.\n Swipe ↑ to pass on rating"
            
        let alert = UIAlertController(title: "Instructions", message: details, preferredStyle: .alert)
        //define actions using callbacks (this is information going to pass you "alert:UIAlertAction" will be that type and return void)
        let defaultAction = UIAlertAction(title: "Got It!", style: .default) {
            //closure is third argument that is between brackets
            (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button OK")
        }
            
        //associate alert with the controller action
        alert.addAction(defaultAction)
            
        // PRESENT it to the view controller storyboard
        present(alert, animated: true, completion:nil) //nil param stands for i want to do something once view has become visible
            
        
    }
    
    @IBAction func listChoice(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            movieData = wishMovieData
            tableView.reloadData()
        }
        else if(sender.selectedSegmentIndex == 1) {
            movieData = seenMovieData
            tableView.reloadData()
        }
        else if(sender.selectedSegmentIndex == 2) {
            movieData = hateMovieData
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create an 'edit' barbuttonitem with an action to allow for editing
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editObjects(_:)))
        //set the button to be on the left side
        self.navigationItem.rightBarButtonItem = editButton
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        tableView.rowHeight = 80
        tableView.layer.cornerRadius = 5
        
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = 2
        containerView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        movieData = wishMovieData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // support editing the table view. called when "delete" is clicked
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            movieData!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //***Delete data from correct array here depending on segment index ****
            //wishlist
            if(segmentControl.selectedSegmentIndex == 0) {
                wishMovieData!.remove(at: indexPath.row)
                removeFromQueue(valInQueue: (wishMovieData?[indexPath.row].key)!)
            }//likedList
            else if(segmentControl.selectedSegmentIndex == 1) {
                seenMovieData!.remove(at: indexPath.row)
                removeFromQueue(valInQueue: (seenMovieData?[indexPath.row].key)!)

            }
            else if(segmentControl.selectedSegmentIndex == 2) {
                hateMovieData!.remove(at: indexPath.row)
                removeFromQueue(valInQueue: (hateMovieData?[indexPath.row].key)!)
                
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: - Table view data source (top 2 are required)
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData!.count
    }
    
    //set each attribute of the table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //this method uses recycled cells but will create a new one if nothing available (used to be "standardCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishlistCell", for: indexPath) as! WishlistTVCell
        
        let movie = movieData?[indexPath.row]
        
        
        cell.poster.image = movie?.poster
        cell.titleLabel.text = movie?.title
        cell.genreLabel.text = movie?.genres
        cell.directorLabel.text = movie?.director
        cell.runtimeLabel.text = movie?.runtime
        
        return cell
    }
    
    
    // called when 'done' button was pressed
    func doneEditing(_ sender: AnyObject) {
        
        //create 'edit' button again with same action
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editObjects(_:)))
        self.navigationItem.rightBarButtonItem = editButton
        //make editing impossible again
        self.tableView.setEditing(false, animated: true)
        
    }
    
    // called when 'edit' button was pressed
    func editObjects(_ sender: AnyObject) {
        
        //make editing possible
        self.tableView.setEditing(true, animated: true)
        //create a temporary 'done' button with an action to end editing
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing(_:)))
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
    
    //remove movie from selected list given it's key
    func removeFromQueue(valInQueue : String) {
        
        let auth = FIRAuth.auth()
        let userId = auth?.currentUser?.uid
        
        var ref : FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        //wishlist
        if(segmentControl.selectedSegmentIndex == 0) {
            ref.child("users").child(userId!).child("wishList").child(valInQueue).removeValue()
            
        }//likedList
        else if(segmentControl.selectedSegmentIndex == 1) {
            ref.child("users").child(userId!).child("likeList").child(valInQueue).removeValue()

        }
        else if(segmentControl.selectedSegmentIndex == 2) {
            ref.child("users").child(userId!).child("hateList").child(valInQueue).removeValue()
            
        }
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //**** SEND BACK ARRAYS on unwind ****
    }
    

}
