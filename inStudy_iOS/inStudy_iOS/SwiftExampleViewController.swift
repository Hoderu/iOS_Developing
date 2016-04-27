//
//  ViewController.m
//  My_Chat
//
//  Created by Андрей Решетников on 29.03.16.
//  Copyright © 2016 mipt. All rights reserved.
//
import UIKit

class SwiftExampleViewController: UIViewController, LGChatControllerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var chatToolbarItem: UIBarButtonItem!
    @IBOutlet weak var checkInToolbarItem: UIBarButtonItem!
    @IBOutlet weak var feedToolbarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        feedToolbarItem.action = "feedToolbarFunction"
        feedToolbarItem.tintColor = UIColor.grayColor()
        checkInToolbarItem.tintColor = UIColor.grayColor()
        
        let tapLabel : UILabel = UILabel()
        tapLabel.bounds = CGRectMake(0, 0, 200, 100)
        tapLabel.text = "TAP TO OPEN"
        tapLabel.textAlignment = NSTextAlignment.Center
        tapLabel.center = self.view.center
        tapLabel.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
        self.view.addSubview(tapLabel)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer();
        tap.addTarget(self, action: Selector("handleTap:"))
        self.view.addGestureRecognizer(tap)
    }
    
    func feedToolbarFunction() {
        let secondStoryBoard = UIStoryboard(name: "Feed", bundle: nil)
        let next = secondStoryBoard.instantiateViewControllerWithIdentifier("feedViewController") as! FeedViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        self.launchChatController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    func stylizeChatInput() {
    //        LGChatInput.Appearance.backgroundColor = <#UIColor#>
    //        LGChatInput.Appearance.includeBlur = <#Bool#>
    //        LGChatInput.Appearance.textViewFont = <#UIFont#>
    //        LGChatInput.Appearance.textViewTextColor = <#UIColor#>
    //        LGChatInput.Appearance.tintColor = <#UIColor#>
    //        LGChatInput.Appearance.textViewBackgroundColor = <#UIColor#>
    //    }
    
    //    func stylizeMessageCell() {
    //        LGChatMessageCell.Appearance.font = <#UIFont#>
    //        LGChatMessageCell.Appearance.opponentColor = <#UIColor#>
    //        LGChatMessageCell.Appearance.userColor = <#UIColor#>
    //    }
    
    
    // MARK: Launch Chat Controller
    
    func launchChatController() {
        let chatController = LGChatController()
        chatController.opponentImage = UIImage(named: "hqdefault")
        chatController.title = "Simple Chat"
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = [helloWorld]
        chatController.delegate = self
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    // MARK: LGChatControllerDelegate
    
    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        print("Did Add Message: \(message.content)")
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        /*
        Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
        */
        message.sentByString = arc4random_uniform(2) == 0 ? LGChatMessage.SentByOpponentString() : LGChatMessage.SentByUserString()
        return true
    }
    
}
