//
//  url.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation


struct url {
	func load(urlString: String) -> String? {
		guard let url = NSURL(string: urlString) else { return nil }
		do {
			return try String(contentsOfURL: url)
		}
		catch {
			return nil
		}
	}
}