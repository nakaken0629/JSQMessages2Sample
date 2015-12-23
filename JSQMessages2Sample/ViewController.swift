//
//  ViewController.swift
//  JSQMessages2Sample
//
//  Created by 中垣 健志 on 2015/12/22.
//  Copyright © 2015年 itvirtuoso. All rights reserved.
//

import UIKit

class ViewController: JSQMessagesViewController {
    
    private var messages = [JSQMessage]()
    private var incomingBubble: JSQMessagesBubbleImage!
    private var outgoingBubble: JSQMessagesBubbleImage!
    private var incomingAvatar: JSQMessagesAvatarImage!
    private var outgoingAvatar: JSQMessagesAvatarImage!
    
    override func viewDidLoad() {
        print("execute viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.senderId = "1"
        self.senderDisplayName = "user1"
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        self.outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man1"), diameter: 64)
        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man2"), diameter: 64)
        
        // images from wikipedia
        let mounts = [
            "https://upload.wikimedia.org/wikipedia/commons/2/2a/01_Fujisan_from_Yamanakako_2004-2-7.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/e/e6/02_Kitadake_and_Fujisan_from_Senjyogatake_1995-7-25.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/b/bf/03_Okuhotakadake_from_Kitahotakadake_2000-9-3.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/e/e1/04_Ainodake_from_Happonbanokashira_2001-10-3.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/2/2c/05_Yarigatake_from_Higashikamaone_2000-8-16.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/0/05/06_Warusawadake_from_Kogochidake_1999-11-5.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/d/d0/07_Akaishidake_from_Hijiridake_2001-9-25.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/6/63/08_Okuhotaka_Karasawa_Kitahotakadake_from_Cyogatake_2001-11-23.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/7/7a/09_Kitahotaka_and_Okuhotakadake_from_Nishidake_2000-8-16.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/f/f2/10_Oobamidake_from_Yarigatake_2003-10-5.jpg"
        ]
        
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[0], isOutgoing: true)))
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "メロスは激怒した。"))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", media: createPhotoItem(mounts[1], isOutgoing: false)))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "必ず、かの邪智暴虐（じゃちぼうぎゃく）の王を除かなければならぬと決意した。"))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "メロスには政治がわからぬ。"))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "メロスは、村の牧人である。"))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[2], isOutgoing: true)))
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "笛を吹き、羊と遊んで暮して来た。"))
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "けれども邪悪に対しては、人一倍に敏感であった。"))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", media: createPhotoItem(mounts[3], isOutgoing: false)))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[4], isOutgoing: true)))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[5], isOutgoing: true)))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[6], isOutgoing: true)))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", media: createPhotoItem(mounts[7], isOutgoing: false)))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", media: createPhotoItem(mounts[8], isOutgoing: false)))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", media: createPhotoItem(mounts[9], isOutgoing: true)))
    }
    
    private func createPhotoItem(url: String, isOutgoing: Bool) -> JSQPhotoMediaItem {
        print("creating photo image url = " + url)
        guard let nsurl = NSURL(string: url) else {
            print("invalid url")
            return JSQPhotoMediaItem()
        }
        guard let data = NSData(contentsOfURL: nsurl) else {
            print("invalid data")
            return JSQPhotoMediaItem()
        }
        guard let image = UIImage(data: data) else {
            print("invalid image")
            return JSQPhotoMediaItem()
        }
        let photoItem = JSQPhotoMediaItem(image: image)
        photoItem.appliesMediaViewMaskAsOutgoing = isOutgoing
        return photoItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingBubble : self.incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingAvatar : self.incomingAvatar
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return NSAttributedString(string: self.messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return CGFloat(30)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
}

