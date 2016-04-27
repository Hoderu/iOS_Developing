//
//  FeedViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 06.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit
import AFNetworking

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, FeedModelProtocol {
    @IBOutlet var feedPlusButton: UIBarButtonItem!
    @IBOutlet weak var feedSegmentedControl: UISegmentedControl!
    @IBOutlet weak var feedTableView: UITableView!
    
    @IBOutlet weak var checkInToolbarItem: UIBarButtonItem!
    @IBOutlet weak var chatToolbarItem: UIBarButtonItem!
    @IBOutlet weak var feedToolbarItem: UIBarButtonItem!
    
    @IBAction func publicInformationSegment(sender: AnyObject) {
        if (isTeacher() || feedSegmentedControl.selectedSegmentIndex == 1) {
            self.navigationItem.rightBarButtonItem = self.feedPlusButton
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        feedTableView.reloadData()
    }
    @IBOutlet var menuButton: UIBarButtonItem!
    
    var feedModel: FeedModel!
    var rowToAnswerDictionary = [Int: Int]()
    var answerTextArray = [String]()
    var textArray = [String]()
    var themeArray = [String]()
    var typeArray = [Int]()
    var textArrayPrivate = [String]()
    var themeArrayPrivate = [String]()
    var wallId: String!
    func isTeacher() -> Bool { // Get information from the server
        return true
    }
    
    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        chatToolbarItem.action = #selector(FeedViewController.chatToolbarFunction)
        chatToolbarItem.tintColor = UIColor.grayColor()
        checkInToolbarItem.tintColor = UIColor.grayColor()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: Selector("onContentSizeChange:"),
                                                         name: UIContentSizeCategoryDidChangeNotification,
                                                         object: nil)
        feedTableView.rowHeight = UITableViewAutomaticDimension
        
        super.viewDidLoad()
        if isTeacher()
        {
            self.navigationItem.rightBarButtonItem = self.feedPlusButton
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil
        }
        textArray = ["Текст1", "Текст2", "Текст3", "Текст4"]
        themeArray = ["Тема1", "Тема2", "Тема3", "Тема4"]
        textArrayPrivate = ["Личный текст1", "Личный текст2", "Личный текст3", "Личный текст4"]
        themeArrayPrivate = ["Личная тема1", "Личная тема2", "Личная тема3", "Личная тема4"]
        answerTextArray = ["Личный текст1", "Личный текст2", "Личный текст3", "Личный текст4", "Личный текст1", "Личный текст2", "Личный текст3", "Личный текст4"]
        typeArray = [2, 1, 2, 1]
        if wallId == nil {
            feedModel = FeedModel.init()
        } else {
            feedModel = FeedModel.init(wallId: wallId!)
        }
        feedModel.delegate = self
        feedModel.alertShowDelegate = self
        self.navigationItem.title = "Новости"
        updateFeedModel()
    }
    
    func chatToolbarFunction() {
        let secondStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let next = secondStoryBoard.instantiateViewControllerWithIdentifier("swiftExampleViewController") as! SwiftExampleViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowsNumber = 0
        switch (feedSegmentedControl.selectedSegmentIndex) {
        case 0:
            rowsNumber = (feedModel.idCourseNewsPublic as Array<Dictionary<String, AnyObject>>).count
            //rowsNumber = textArray.count
            break
        case 1:
            rowsNumber = (feedModel.idCourseNewsPrivate as Array<Dictionary<String, AnyObject>>).count
            break
        default: break
        }
        return rowsNumber
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (feedSegmentedControl.selectedSegmentIndex) {
        case 0:
            let newsRow = (feedModel.idCourseNewsPublic as Array<Dictionary<String, AnyObject>>) [indexPath.row]
            let author = (newsRow["author"] as! Dictionary<String, AnyObject>)
            let title = (newsRow["title"] as! String)
            let text = (newsRow["text"] as! String)
            let imageUrl = (author["avatar"] as! String)
            let imageRequest = NSURLRequest(URL: NSURL(string: imageUrl)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
            //let wallId = (newsRow["wall_id"] as! String)
            switch (newsRow["post_type"] as! String) {
            case "Q":
                let fullTitleString:String = "Опубликовано! " + title
                let mutableTitleString = NSMutableAttributedString(string: fullTitleString)
                
                mutableTitleString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location:0,length:13))
                
                let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! FeedTableViewCell
                cell.avatarImage?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil)
                //cell.wallId = wallId
                cell.adTextLabel?.text = text
                cell.adTitleLabel?.attributedText = mutableTitleString
                cell.answerTextLabel?.text = self.answerTextArray[indexPath.row] //temporary
                
                cell.answerAuthorAvatarImage?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil) //temporary
                return cell
            case "C":
                let cell = tableView.dequeueReusableCellWithIdentifier("feedType2Cell", forIndexPath: indexPath) as! FeedType2TableViewCell
                //cell.wallId = wallId
                cell.avatarType2ImageView?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil)
                cell.adTextType2Label?.text = text
                cell.adTitleType2Label?.text = title
                return cell
            case "I":
                let cell = tableView.dequeueReusableCellWithIdentifier("feedType3Cell", forIndexPath: indexPath) as! FeedType3TableViewCell
                //cell.wallId = wallId
                cell.avatarType3ImageView?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil)
                cell.adTextType3Label?.text = text
                cell.adTitleType3Label?.text = "Важно! " + title
                cell.adTitleType3Label?.textColor = UIColor.redColor()
                return cell
            default: break
            }
            
            break;
        case 1:
            let newsRow = (feedModel.idCourseNewsPrivate as Array<Dictionary<String, AnyObject>>) [indexPath.row]
            let author = (newsRow["author"] as! Dictionary<String, AnyObject>)
            let title = (newsRow["title"] as! String)
            let text = (newsRow["text"] as! String)
            let cell = tableView.dequeueReusableCellWithIdentifier("feedType2Cell", forIndexPath: indexPath) as! FeedType2TableViewCell
            let imageUrl = (author["avatar"] as! String)
            let imageRequest = NSURLRequest(URL: NSURL(string: imageUrl)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
            //cell.wallId = wallId
            cell.avatarType2ImageView?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil)
            cell.adTextType2Label?.text = text
            cell.adTitleType2Label?.text = title
            return cell
        default: break
        }
        return tableView.dequeueReusableCellWithIdentifier("feedType2Cell", forIndexPath: indexPath) as! FeedTableViewCell // Unreachable
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (feedSegmentedControl.selectedSegmentIndex) {
        case 0:
            let newsRow = (feedModel.idCourseNewsPublic as Array<Dictionary<String, AnyObject>>) [indexPath.row]
            if ((newsRow["post_type"] as! String) == "Q") {
                self.performSegueWithIdentifier("showPostedFullAdSegue", sender: self)
            } else {
                self.performSegueWithIdentifier("showFullAdSegue", sender: self)
            }
            break
        case 1:
            self.performSegueWithIdentifier("showFullAdSegue", sender: self)
            break
        default: break
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isLandscapeOrientation() {
            return 120.0
        } else {
            return 155.0
        }
    }
    
    func isLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if feedTableView!.indexPathsForSelectedRows != nil {
            let indexPaths = feedTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            
            if segue.identifier == "showFullAdSegue"
            {
                let vc = segue.destinationViewController as! FeedFullAdViewController
                
                switch (feedSegmentedControl.selectedSegmentIndex) {
                case 0:
                    let newsRow = (feedModel.idCourseNewsPublic as Array<Dictionary<String, AnyObject>>) [indexPath.row]
                    switch (newsRow["post_type"] as! String) {
                    case "C":
                        let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! FeedType2TableViewCell
                        vc.adAvatar = cell.avatarType2ImageView?.image
                    case "I":
                        let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! FeedType3TableViewCell
                        vc.adAvatar = cell.avatarType3ImageView?.image
                    default:
                        break
                    }
                    vc.labelText = newsRow["text"] as! String
                    vc.labelTitle = newsRow["title"] as! String
                    if self.wallId != nil {
                        vc.wallId = self.wallId
                    } else {
                        vc.wallId = String(newsRow["wall_id"] as! Int)
                    }
                    vc.postId = String(newsRow["id"] as! Int)
                    break;
                case 1:
                    let newsRow = (feedModel.idCourseNewsPrivate as Array<Dictionary<String, AnyObject>>) [indexPath.row]
                    vc.labelText = newsRow["text"] as! String
                    vc.labelTitle = newsRow["title"] as! String
                    if self.wallId != nil {
                        vc.wallId = self.wallId
                    } else {
                        vc.wallId = String(newsRow["wall_id"] as! Int)
                    }
                    vc.postId = String(newsRow["id"] as! Int)
                    let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! FeedType2TableViewCell
                    vc.adAvatar = cell.avatarType2ImageView?.image
                    break;
                default: break;
                }
            } else
                if segue.identifier == "showPostedFullAdSegue"
                {
                    let newsRow = (feedModel.idCourseNewsPublic as Array<Dictionary<String, AnyObject>>) [indexPath.row]
                    let cell = feedTableView.cellForRowAtIndexPath(indexPath) as! FeedTableViewCell
                    
                    let vc = segue.destinationViewController as! FeedFullPostViewController
                    vc.labelText = newsRow["text"] as! String
                    vc.labelTitle = newsRow["title"] as! String
                    if self.wallId != nil {
                        vc.wallId = self.wallId
                    } else {
                        vc.wallId = String(newsRow["wall_id"] as! Int)
                    }
                    vc.postId = String(newsRow["id"] as! Int)
                    vc.adAvatar = cell.avatarImage?.image
                    vc.answerAuthorAvatar = cell.answerAuthorAvatarImage?.image
                    vc.answerTextLabel = self.answerTextArray[indexPath.row]
            }
        }
    }
    var newAdTitle: String = ""
    var newAdText: String = ""
    var newAdAnswerText: String = ""
    var postType: String = ""
    var newAdAuthorAvatar: UIImage!
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
        let adVC = segue.sourceViewController as! FeedAddAdViewController
        newAdText = adVC.textString
        newAdTitle = adVC.titleString
        textArrayPrivate.append(newAdText)
        themeArrayPrivate.append(newAdTitle)
        feedModel.postNews(newAdTitle, text: newAdText, type: "C")
        feedTableView.reloadData()
    }
    
    @IBAction func teacherCancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func teacherDone(segue: UIStoryboardSegue) {
        let adVC = segue.sourceViewController as! FeedTeacherAddAdViewController
        newAdText = adVC.textString
        newAdTitle = adVC.titleString
        
        textArray.append(newAdText)
        themeArray.append(newAdTitle)
        if (adVC.importance ?? false) {
            typeArray.append(2)
            postType = "C"
        } else {
            typeArray.append(1)
            postType = "I"
        }
        feedModel.postNews(newAdTitle, text: newAdText, type: postType)
        feedTableView.reloadData()
    }
    
    @IBAction func answerPost(segue: UIStoryboardSegue) {
        let adVC = segue.sourceViewController as! FeedFullAdViewController
        newAdText = adVC.labelText
        newAdTitle = adVC.labelTitle
        newAdAnswerText = adVC.answerText
        newAdAuthorAvatar = adVC.adAvatar
        textArray.append(newAdText)
        themeArray.append(newAdTitle)
        typeArray.append(0)
        answerTextArray.append(newAdAnswerText)
        rowToAnswerDictionary[textArray.count-1] = rowToAnswerDictionary.count
        feedTableView.reloadData()
    }
    
    @IBAction func didTapPlus(sender: UIBarButtonItem) {
        switch (feedSegmentedControl.selectedSegmentIndex) {
        case 0:
            performSegueWithIdentifier("teacherPublishSegue", sender: self)
            break
        case 1:
            performSegueWithIdentifier("studentPublishSegue", sender: self)
            break
        default:
            break
        }
    }
    
    // Temporary
    @IBAction func goToNews() {
        self.wallId = "1"
        feedModel.setCurrentWallId(wallId)
        self.navigationItem.title = "Python"
        updateFeedModel()
    }
    
    func updateFeedModel() {
        feedModel.updateFeed();
    }
    
    func feedDidLoaded() {
        feedTableView.reloadData()
    }
}
