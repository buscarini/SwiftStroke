//
//  io.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation

public struct IO<T> {
	public typealias Fun = () -> T
	
	public let unsafePerformIO : Fun
	public init(value : Fun) {
		self.unsafePerformIO = value
	}

	public static func of<T>(object: T) -> IO<T> {
		return IO<T>(value: {
			() -> T in
			return object
		})
	}
	
	public func map<T2>(f : (T) -> T2) -> IO<T2> {
		return IO<T2>(value: {
			() -> T2 in
			return f(self.unsafePerformIO())
		})
	}
}

public struct io {
	public static func docsDir() -> IO<String?> {
		return IO<String?>(value: { () -> String? in
			return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first })
	}
	
	public static func cachesDir() -> IO<String?> {
		return IO<String?>(value: { () -> String? in
			return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first })
	}
	
	public static func writeFile(path : String, contents: String, encoding : NSStringEncoding = NSUTF8StringEncoding) -> IO<String?> {
		return IO(value : {
			() -> String? in
			do {
				try contents.writeToFile(path, atomically: true, encoding: encoding)
				return contents
			}
			catch {
				return nil
			}
		})
	}
	
	public static func readFile(path : String) -> IO<String?> {
		return IO(value: { () -> String? in
			do {
				let contents = try String(contentsOfFile: path)
				return contents
			}
			catch {
				return nil
			}
		})
	}
	
	public static func print(string : String) -> IO<String> {
		return IO(value: { () -> String in
			print(string)
			return string
		})
	}
	
	
}
