//
//  io.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation


struct io {
	
	static func docsDir() -> String? {
		return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
		
		return nil
	}
	
	static func cachesDir() -> String? {
		return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
		
		return nil
	}
	
	static func writeFile(path : String, contents: String, encoding : NSStringEncoding = NSUTF8StringEncoding) -> Bool {
		do {
			try contents.writeToFile(path, atomically: true, encoding: encoding)
			return true
		}
		catch {
			return false
		}
	}
	
	static func readFile(path : String) -> String? {
		do {
			let contents = try String(contentsOfFile: path)
			return contents
		}
		catch {
			return nil
		}
	}
	
	
}
