//
//  ViewController.swift
//  JKWeChatUserHeadImageDownload
//
//  Created by 宋旭 on 16/6/11.
//  Copyright © 2016年 sky. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var headImageOfUserOne: UIImageView!
    
    @IBOutlet weak var headImageOfUserTwo: UIImageView!
    
    @IBOutlet weak var headImageOfUserThree: UIImageView!
    
    @IBOutlet weak var downloadHeadImageButton: UIButton!
    
    lazy var arrayContainsURL: Array<String> = {
        return Array()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /** 下载头像URL */
    @IBAction func startDownloadHeadImageURL(sender: UIButton) {
        //清空之前下载的图片
        self.headImageOfUserOne.image = UIImage(named: "placeholder.jpg")
        self.headImageOfUserTwo.image = UIImage(named: "placeholder.jpg")
        self.headImageOfUserThree.image = UIImage(named: "placeholder.jpg")
        
        if self.arrayContainsURL.isEmpty {
            //获取URL
            let url = NSURL(string: "http://1.jkwechatdevelop.applinzi.com/getuserslist.php")
            //异步发送请求
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                if ((error) != nil) {
                    print("请求失败")
                } else {
                    let res = String.init(data: data!, encoding: NSUTF8StringEncoding)
                    
                    //过滤掉JS代码并获取到包含全部URL的字符串
                    if (res!.spit("%").isEmpty) {
                        print("字符串提取码错误")
                        return
                    }
                    self.arrayContainsURL = res!.spit("%")
                    //当URL下载完成,下载头像按钮将被激活
                    self.downloadHeadImageButton.alpha = 1
                }
            }
            task.resume()
        } else {
            print("正在下载URL,可能网速较慢,请稍等!")
        }
    }
    
    /** 下载头像图片并显示 */
    @IBAction func startDownloadHeadImage(sender: UIButton) {
        
        if self.arrayContainsURL.isEmpty {
            return
        }
        var imageArray = [UIImage]()
        //下载图片
        for item in self.arrayContainsURL {
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: item)!)!)
            imageArray += [image!]
        }
        //更新UI
        if imageArray.isEmpty {
            print("公众号当前关注总用户数为0")
        } else {
            dispatch_async(dispatch_get_main_queue()) {
                //获取最新关注的3人的头像予以展示
                self.headImageOfUserOne.image = imageArray[0]
                self.headImageOfUserTwo.image = imageArray[1]
                self.headImageOfUserThree.image = imageArray[2]
                
                //清空URL缓存,为下次下载最新图片做准备
                self.arrayContainsURL.removeAll()
                sender.alpha = 0;
            }
        }
        
    }
}

