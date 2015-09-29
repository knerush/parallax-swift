//
//  ViewController.swift
//  ParallaxEffect
//
//  Created by Katya Nerush on 28/09/2015.
//  Copyright © 2015 KN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - table delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200));
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollOffset = -scrollView.contentOffset.y * 0.5
        let alpha = 1.0 + scrollOffset/topImage.frame.size.height*2
//        let yPos = scrollOffset;
//        
//        topImage.frame = CGRectMake(0, yPos, topImage.frame.size.width, topImage.frame.size.height);
        topImageTopConstraint.constant = scrollOffset
        topImage.alpha = alpha
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(scrollView.contentOffset.y)
        let scrollOffset = -scrollView.contentOffset.y
        if scrollOffset < 0 {
            let zoomFactor = -scrollOffset/topImage.frame.size.height
            topImageHeightConstraint.constant += zoomFactor
        }
    }
    

}

