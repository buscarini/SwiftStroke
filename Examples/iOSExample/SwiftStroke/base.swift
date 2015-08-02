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


public enum Either<ErrorType, ResultType> {
	case Left(ErrorType)
	case Right(ResultType)
	
	public func map<T>(f : (ResultType) -> T) -> Either<ErrorType, T> {
		switch self {
			case .Left(let error):
				return Either<ErrorType,T>.Left(error)
			case .Right(let value):
				return Either<ErrorType,T>.Right(f(value))
		}
	}
	
	public static func flatten(value : Either<ErrorType,Either<ErrorType,ResultType>>) -> Either<ErrorType,ResultType> {
		switch value {
		case .Left(let error):
			return Either<ErrorType,ResultType>.Left(error)
		case .Right(let nested):
			switch nested {
				case .Left(let error):
					return Either<ErrorType,ResultType>.Left(error)
				case .Right(let inner):
					return Either<ErrorType,ResultType>.Right(inner)
			}
		}
	}
}

public extension Either {
	public func flatMap<T>(f : (ResultType) -> Either<ErrorType,T>) -> Either<ErrorType, T> {
		return Either<ErrorType,T>.flatten(map(f))
	}
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


