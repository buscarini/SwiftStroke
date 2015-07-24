//
//  io.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation

struct IO<T> {
	typealias Fun = () -> T
	
	let unsafePerformIO : Fun
	init(value : Fun) {
		self.unsafePerformIO = value
	}

	static func of<T>(object: T) -> IO<T> {
		return IO<T>(value: {
			() -> T in
			return object
		})
	}
	
	func map(f : (T) -> T) -> IO<T> {
		return IO<T>(value: {
			() -> T in
			return f(self.unsafePerformIO())
		})
	}
}

struct io {
	static func docsDir() -> IO<String?> {
		return IO<String?>(value: { () -> String? in
			return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first })
	}
	
	static func cachesDir() -> IO<String?> {
		return IO<String?>(value: { () -> String? in
			return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first })
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
