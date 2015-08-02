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
			return result.stringByAppendingPathComponent(string)
		})
	}
	
	static func list(path: String) -> IO<Either<String,[String]>> {
		let fileManager = NSFileManager.defaultManager()
		return IO<Either<String,[String]>>(value: {
			do {
				let files = try fileManager.contentsOfDirectoryAtPath(path)
				return Either.Right(files)
			}
			catch {
				return Either.Left("Unknown Error")
			}
			
		})
	}
	
}