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

    let kImageHeihgtConstraint: CGFloat    = 250.0
    let kImageVisibleHeihgt: CGFloat       = 200.0
    let kMaxZoomFactor: CGFloat            = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.backgroundColor = UIColor.clearColor()
    }


    //MARK: - table delegate -
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kImageVisibleHeihgt
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, kImageVisibleHeihgt));
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }


    //MARK: - scroll view delegate -

    func scrollViewDidScroll(scrollView: UIScrollView) {
        //dim image and move up 0.5 times slowlier when scrolled up
        let scrollOffset = -scrollView.contentOffset.y * 0.5
        let alpha = 1.0 + scrollOffset / topImage.frame.size.height * 2

        if scrollOffset < 0 {
            topImageTopConstraint.constant = scrollOffset
            topImage.alpha = alpha
        }

        //else on scroll down zoom in the image
        let zoomScale = 1 + (abs (min (scrollView.contentOffset.y, 0)) / kImageHeihgtConstraint)
        let zoom = min(zoomScale, kMaxZoomFactor)
        topImageHeightConstraint.constant = kImageHeihgtConstraint * zoom
    }
    
}

