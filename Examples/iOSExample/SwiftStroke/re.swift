//
//  re.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation

public struct re {
	
	public struct result {
		let text : String
		let groups : [result]
		init(text:String, groups : [result]  = []) {
			self.text = text
			self.groups = groups
		}
		
		init?(textResult: NSTextCheckingResult, string: String) {
			guard let range = string.rangeFromNSRange(textResult.range) else { return nil }

			var groups : [result] = []
			for i in 0..<textResult.numberOfRanges  {
				let groupRange = textResult.rangeAtIndex(i)
				guard let subRange = string.rangeFromNSRange(groupRange) else { return nil }
				if subRange==range {
					continue
				}
				groups.append(result(text:string.substringWithRange(subRange), groups: []))
			}
			
			self.init(text: string.substringWithRange(range), groups: groups)
		}
	}
	
	static func match(pattern: String,string : String, _ options : NSRegularExpressionOptions = .CaseInsensitive) -> [result]? {
		do {
			let re = try NSRegularExpression(pattern: pattern, options: options)
			var matches : [result] = []
			re.enumerateMatchesInString(string, options: .WithoutAnchoringBounds, range: NSMakeRange(0, string.characters.count), usingBlock: { (textResult, flags, stop) -> Void in
				guard let textResult = textResult else { return }
				
				if let match = result(textResult: textResult, string: string) {
					matches.append(match)
				}
			})
			
			return matches
			
//			let matches = re.matchesInString(string,options:.WithoutAnchoringBounds,range: NSMakeRange(0, string.characters.count))
//			return matches.map {
//				return result(result: $0, string: string)
//				}.flatMap {
//					return $0
//				}
		}
		catch {
			return nil
		}
	}
	
}