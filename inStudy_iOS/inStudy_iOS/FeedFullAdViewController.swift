//
//  FeedFullAdViewController.swift
//  inStudy_iOS
//
//  Created by Булат Галиев on 06.03.16.
//  Copyright © 2016 Булат Галиев. All rights reserved.
//

import UIKit

class FeedFullAdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, CommentModelProtocol {
    var commentModel: CommentModel!
    
    var labelText:String!
    var labelTitle:String!
    var answerText:String!
    var adAvatar:UIImage!
    var wallId: String!
    var postId: String!
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBAction func sendCommentAction(sender: UIButton) {
        /*commentTextArray.append(commentTypeTextView.text)
        commentTitleArray.append(getUserName())
        commentAvatarsArray.append(getUserAvatar())
        commentTypeTextView.text = nil
        commentTableView.reloadData()*/
        
        commentModel.postComment(wallId, postId: postId, text: commentTypeTextView.text)
        commentTypeTextView.text = nil
    }
    @IBOutlet weak var commentTypeTextView: UITextView!
    
    var commentTextArray = [String]()
    var commentTitleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "onContentSizeChange:",
                                                         name: UIContentSizeCategoryDidChangeNotification,
                                                         object: nil)
        commentTypeTextView.delegate = self
        commentTypeTextView.text = "Введите ваш комментарий"
        commentTypeTextView.textColor = UIColor.lightGrayColor();
        commentTableView.rowHeight = UITableViewAutomaticDimension
        commentModel = CommentModel.init()
        commentModel.delegate = self
        commentModel.alertShowDelegate = self
        commentModel.updateComments(wallId, postId: postId)
        // Do any additional setup after loading the view.
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if commentTypeTextView.textColor == UIColor.lightGrayColor() {
            commentTypeTextView.text = nil
            commentTypeTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if commentTypeTextView.text.isEmpty {
            commentTypeTextView.text = "Введите ваш текст"
            commentTypeTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if commentModel.idCommentDictionary == nil {
            return 0
        } else {
            return (commentModel.idCommentDictionary! as Array<Dictionary<String, AnyObject>>).count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row != 0) {
            let commentsRow = (commentModel.idCommentDictionary! as Array<Dictionary<String, AnyObject>>) [indexPath.row - 1]
            let text = (commentsRow["text"] as! String)
            let author = (commentsRow["author"] as! Dictionary<String, AnyObject>)
            let imageUrl = (author["avatar"] as! String)
            let imageRequest = NSURLRequest(URL: NSURL(string: imageUrl)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
            let authorFirstName = (author["first_name"] as! String)
            let authorLastName = (author["last_name"] as! String)
            let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell
            cell.commentTextLabel?.text = text
            cell.commentTitleLabel?.text = authorFirstName + " " + authorLastName
            cell.commentAuthorAvatarImageView?.setImageWithURLRequest(imageRequest, placeholderImage: UIImage(named: "ic_user")!, success: nil, failure: nil)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("fullAdCell", forIndexPath: indexPath) as! FullAdTableViewCell
            cell.fullAdTextLabel?.text = labelText
            cell.fullAdTitleLabel?.text = labelTitle
            cell.fullAdAvatarImageView?.image = adAvatar
            return cell
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "postAnswerSegue" {
            let button = sender as! UIButton
            let view = button.superview!
            let currentCell = view.superview as! CommentTableViewCell
            answerText = currentCell.commentTextLabel?.text
        }
    }
    
    func commentDidLoaded() {
        commentTableView.reloadData()
    }
    /*@IBAction func postAnswerAction(sender: AnyObject) {
     let button = sender as! UIButton
     let view = button.superview!
     let currentCell = view.superview as! CommentTableViewCell
     answerText = currentCell.commentTextLabel?.text
     }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     if (indexPath.row != 0) {
     let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CommentTableViewCell;
     answerText = currentCell.commentTextLabel?.text
     performSegueWithIdentifier("showActionMenu", sender: self)
     }
     //performSegueWithIdentifier("studentPublishSegue", sender: self)
     }*/
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
