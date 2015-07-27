//
//  base.swift
//  iOSExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/7/15.
//  Copyright © 2015 jms. All rights reserved.
//

import Foundation


//// This operator can be used to chain Optional types like so:
//// optionalVal >>= f1 >>= f2
//// where f1 and f2 have type `Any -> Any?`
////
//// If a value is ever nil, the chain short-circuits and will result in nil.
//// This is a much neater way to do this than using the if syntax specified in
//// the Swift iBook.
//operator infix >>= { associativity left }
//func >>=<TypeA, TypeB> (lhs: TypeA?, rhs: (TypeA -> TypeB?)) -> TypeB? {
//	if let x = lhs {
//		return rhs(x)
//	}
//	return nil;
//}

public let blah = "blah"


public enum Either<T1, T2> {
	case Left(T1)
	case Right(T2)
}

public struct Task<Data,Error> {
	public let run : (reject:(Error)-> Void, success: (Data) -> Void) -> Void
	public init(f : (reject: (Error) -> Void, success: (Data) -> Void) -> ()) {
		self.run = f
	}
	public static func of<T>(object : T) -> Task<T,String> {
		return Task<T,String>(f: {
			(reject, success) in
			success(object)
		})
	}
	
	public func map<Data2>(f: (Data) -> Data2) -> Task<Data2,Error> {
		return Task<Data2,Error>(f: {
			(reject, success) in
			self.run(reject: reject,
				success: {
					(data) in
					success(f(data))
				}
			)
		})
	}
}


