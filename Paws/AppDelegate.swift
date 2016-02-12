//
//  AppDelegate.swift
//  Paws
//
//  Created by 蔡鈞 on 2016/2/11.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("GRucmTm8JgvlVaow3oPbX10AMVtT3LLaGnpHEiUS", clientKey: "16MZRHp94QKs6xbYDU32SpRJMuYanXKLyykrFVqm")
        
        
        var tableVC:CatsTableViewController = CatsTableViewController(className: "Cat")
        tableVC.title = "Paws"
        
        UINavigationBar.appearance().tintColor = UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.05, green: 0.47, blue: 0.91, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        var navigationVC:UINavigationController = UINavigationController(rootViewController: tableVC)
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        
        window!.rootViewController = navigationVC
        window!.makeKeyAndVisible()
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    
}

