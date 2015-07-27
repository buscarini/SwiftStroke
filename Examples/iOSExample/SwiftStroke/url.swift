//
//  url.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation

public struct url {
	public static func load(urlString: String) -> Task<String?,String> {
		return Task<String?,String>(f: {
			(reject, success) in
			
			guard let url = NSURL(string: urlString) else {
				reject("Url is not valid")
				return
			}
			
			let config = NSURLSessionConfiguration.defaultSessionConfiguration()
			let session = NSURLSession(configuration: config)
			let request = NSURLRequest(URL: url)
			let task = session.dataTaskWithRequest(request, completionHandler: {
				(data, urlResponse, error) in
				guard let data = data else {
					reject(error?.localizedDescription ?? "Unknown error loading url")
					return
				}
				
				let encoding : NSStringEncoding
				if let encodingName = urlResponse?.textEncodingName {
					encoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingName))
				}
				else {
					encoding = NSUTF8StringEncoding
				}
				
				if let response = NSString(data: data, encoding: encoding) as? String {
					success(response)
				}
				else {
					reject("Invalid")
				}
			})
			
			if let task = task {
				task.resume()
			}
			else {
				reject("Error creating data task")
			}
		})
	}
}