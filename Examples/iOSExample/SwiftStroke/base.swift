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

enum Either<T1, T2> {
	case Left(T1)
	case Right(T2)
}

//typealias Result<T2> = Either<String,T2>

