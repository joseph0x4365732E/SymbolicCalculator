//
//  ComputationRow.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import Foundation
import SymbolicCalculus

public struct CachedExpression {
    var expression: any Expression
    var result: String
}

struct ComputationRow<S: Scalar> {
    var index: Int
    var input: String
    var expression: AnyExpression<S>
    var result: AnyExpression<S>
    var output: String
    
    init(index: Int, input: String, expression: AnyExpression<S>, result: AnyExpression<S>, output: String) {
        self.index = index
        self.input = input
        self.expression = expression
        self.result = result
        self.output = output
    }
    
    init(index: Int, input: String) {
        self.index = index
        self.input = input
        let exact = !input.contains(".")
        do {
            self.expression = try ExpressionParser<S>(exact: true).parse(input: input)
            self.result = expression.simplified()
            self.output = result.description
        } catch { error
            #warning("Probably not a good use of EmptyArg(). Might cause fatal errors elsewhere")
            self.expression = AnyExpression(EmptyArg())
            self.result = AnyExpression(EmptyArg())
            self.output = (error as! ParseError).message
        }
        
    }
}
