//
//  path.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation


public struct path {
	
	static func join(strings: String...) -> String {
		return strings.reduce("", combine: { (result, string) in
//			let aResult = result as NSString
//			let aString = string as NSString
			
			return result.stringByAppendingPathComponent(string)
		})
	}
	
}