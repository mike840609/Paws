//
//  CatsTableViewCell.swift
//  Paws
//
//  Created by 蔡鈞 on 2016/2/12.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class CatsTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var catImageView:UIImageView?
    @IBOutlet weak var catNameLabel:UILabel?
    @IBOutlet weak var catVotesLabel:UILabel?
    @IBOutlet weak var catCreditLabel:UILabel?
    @IBOutlet weak var catPawIcon:UIImageView?
    
    var parseObject:PFObject?

    override func awakeFromNib() {
        super.awakeFromNib()

        //UITapGestureRecognizer，可以讓我們跟任何視圖互動,點擊次數設定2 而後加入視圖contentView中
        let gesture = UITapGestureRecognizer(target: self, action:Selector("onDoubleTap:"))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
        
        catPawIcon?.hidden = true
    }
    
    
    func onDoubleTap(sender:AnyObject) {
        catPawIcon?.hidden = false
        catPawIcon?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options:[], animations: {

            self.catPawIcon?.alpha = 0
            
            }, completion: {
                (value:Bool) in
                
                self.catPawIcon?.hidden = true
        })
        
        //檢查parseObject是否為空值。
        //試著從parseObject取得投票數（votes），將其轉型為optional Int。
        //倘若votes不是空值，以++運算符來增加votes變數值，這跟votes = votes! + 1; 一樣。
        //然後以setObject方法將votes變數指定回去給parseObject集合。
        //然後呼叫在parseObject! 的saveInBackground()方法。這會將目前的物件儲存在背景，然後在適當時機將其寫入Parse雲中。
        //最後，更新它的文字來呈現新的投票數。
        
        if(parseObject != nil) {
            if var votes:Int? = parseObject!.objectForKey("votes") as? Int {
                votes!++
                
                parseObject!.setObject(votes!, forKey: "votes");
                parseObject!.saveInBackground();
                
                catVotesLabel?.text = "\(votes!) votes";
            }
        }
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
