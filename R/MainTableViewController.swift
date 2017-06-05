//
//  MainTableViewController.swift
//  R
//
//  Created by Juan Pablo Boero Alvarez on 4/6/17.
//  Copyright © 2017 jpba. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    // Navigation Segue.
    let descriptionViewSegue = "mainToDescriptionSegue"

    // Object to pass to the description view.
    var selectedReddit: MThing?
    
    var dataSource = [MThing](){
        didSet{
            // Handle refresh control.
            if let refreshControl = self.refreshControl {
                if refreshControl.isRefreshing {
                    refreshControl.endRefreshing()
                }
            }
            // Reload Animated.
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Data
        getData()
        
        // Auto sizing cells
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add some spacing on top.
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        // Refresh control
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(self.getData), for: .valueChanged)
        tableView.refreshControl = rc
    }
    
    //MARK: - Actions
    
    /// Get reddits, if there is cache data, will use that first.
    func getData() {
        NetworkManager.shared.getTopReddits { (reddits) in
            if let reddits = reddits {
                // Fill array
                self.dataSource = reddits
            }
        }
    }
    
    /// Fill cell with selected reddit.
    func redditCell(cell: RedditTableViewCell, reddit: MThing) -> RedditTableViewCell {
        
        // Title
        if let title = reddit.title {
            cell.redditTitle.text = title
        }
        
        // Image
        cell.redditImageView.image = #imageLiteral(resourceName: "r_icon")
        if let thumbURL = reddit.thumbnailURL, thumbURL.contains("http") {
            if !thumbURL.isEmpty {
                cell.redditImageView.kf.setImage(with: URL(string: thumbURL))
            }
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == descriptionViewSegue, let destinationVC = segue.destination as? DescriptionViewController {
            destinationVC.selectedReddit = selectedReddit
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reditCell", for: indexPath) as! RedditTableViewCell
        return redditCell(cell: cell, reddit: dataSource[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedReddit = dataSource[indexPath.row]
        performSegue(withIdentifier: descriptionViewSegue, sender: self)
    }
    
}
