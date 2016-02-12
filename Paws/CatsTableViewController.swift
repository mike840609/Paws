//
//  CatsTableViewController.swift
//  Paws
//
//  Created by 蔡鈞 on 2016/2/11.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class CatsTableViewController: PFQueryTableViewController {
    
    let cellIdentifier:String = "CatCell"
    
    override func viewDidLoad() {
        
        tableView.registerNib(UINib(nibName: "CatsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        super.viewDidLoad()
        
    }
    
    
    //一個指定的初始化設定
    //兩個參數,一個是表格視圖的樣式，一個是我們從Parse上取得會用到的className
    //儲存className參數在parseClassName這一個實體屬性中
    override init(style: UITableViewStyle, className: String!)
    {
        //呼叫父類別進行初始化
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        self.parseClassName = className
        
        //第一行設定列為合適高度，而第二行不允許做cell的選取
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
        
        
    }
    
    
    //一個必要的初始化設定
    //一個NSCoder的實體。它的內容跟現在無關，我們只要把它固定作為必要實做的方法，但結構上不是重要的方法。
    required init(coder aDecoder:NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    
    //在它要連上表格視圖控制器至Parse 的datastore時會呼叫它,它幫表格查詢文字資料，因此這個方法稱作queryForTable
    override func queryForTable() -> PFQuery {
        
        //以self.parseClassName 來取得其值的建構方法（constructor method）來實體化它
        var query:PFQuery = PFQuery(className:self.parseClassName!)
        
        //倘若查詢結果是空的話，我們在query設定cachePolicy屬性。它的值是PFCachePolicy.CacheThenNetwork 常數，表示查詢會先針對物件做離線快取（cache）查詢，如果不存在的話，它會從線上的Parse datastore下載物件
        if(objects?.count == 0)
        {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending("name")
        
        return query
    }
    
    
    //將資料放到表格視圖上,回傳一個很明確地，解開（unwarp）的PFTableViewCell 實體
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        
        //方法的回傳型態是optional，而我們將它以「?」陳述轉型  UITableViewCell為PFTableViewCell 而後轉為 CatsTableViewCell
        var cell:CatsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CatsTableViewCell
        
        
        //當cell實際上是空值，我們從PFTableViewCell建立一個新的cell。我們以識別碼來指出cell的型態，並給予一個UITableViewCellStyle.Default的樣式
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("CatsTableViewCell", owner: self, options: nil)[0] as? CatsTableViewCell
        }
        
        //建立了一個機制，將物件從cellForRowAtIndexPath 複製到表格視圖cell，讓物件實體可以在CatsTableViewCell 類別取得。
         cell?.parseObject = object
        
        //使用optional binding（if let）來確認optional是否為非空值。倘若它有包含一個值，我們將這個值指定給一個暫時的常數（pfObject）
        if let pfObject = object {
            cell?.catNameLabel?.text = pfObject["name"] as? String
            
            
            var votes:Int? = pfObject["votes"] as? Int
            if votes == nil {
                votes = 0
            }
            cell?.catVotesLabel?.text = "\(votes!) votes"
            
            var credit:String? = pfObject["cc_by"] as? String
            if credit != nil {
                cell?.catCreditLabel?.text = "\(credit!) / CC 2.0"
            }
            
            cell?.catImageView?.image = nil
            
            if var urlString:String? = pfObject["url"] as? String {
                
                var url:NSURL? = NSURL(string: urlString!)
                
                if var url:NSURL? = NSURL(string: urlString!) {
                    
                    var error:NSError?
                    
                    var request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
                    
                    NSOperationQueue.mainQueue().cancelAllOperations()
                    
                    //NSURLConnection處理網路資料來源 但無法處理外部URLs相片,貓咪圖片是儲存在flickr
                    //開始另一個非同步的連結，我們先清除所有主佇列的操作
                    //從主佇列移除pending或沒有完成的下載
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                        
                        (response:NSURLResponse?, imageData:NSData?, error:NSError? ) -> Void in
                        
                        (cell?.catImageView?.image = UIImage(data: imageData!))!
                        
                    })
                    
                }
                
            }
            
        }
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
