//
//  StringExtension.swift
//  NSStringExtension
//
//  Created by 宋旭 on 16/3/14.
//  Copyright © 2016年 sky. All rights reserved.
//

import Foundation

extension String{
    
    func spit(target: String) -> Array<String> {
        
        var str =  ""
        let original = self.characters
        let reference = target.characters
        var array = [String]()
        
        if !original.isEmpty {
            for i in 0..<original.count {
                if !reference.contains(original[original.startIndex.advancedBy(i)]){
                    str.append(original[original.startIndex.advancedBy(i)])
                } else {
                    array += [str]
                    str = ""
                }
            }
        }
        return array
    }
}

