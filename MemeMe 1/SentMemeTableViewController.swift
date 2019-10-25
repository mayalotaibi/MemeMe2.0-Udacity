//
//  SentMemeTableViewController.swift
//  MemeMe 1
//
//  Created by مي الدغيلبي on 18/02/1441 AH.
//  Copyright © 1441 مي الدغيلبي. All rights reserved.
//

import UIKit

class SentMemeTableViewController:UITableViewController{
    
   
    
    var memes :[Meme]!
    {
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.textLabel?.text = meme.bottomText
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! MemeDetailViewController
        
      
       
        detailController.image = memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

}
