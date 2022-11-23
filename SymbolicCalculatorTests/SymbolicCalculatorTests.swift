//
//  SymbolicCalculatorTests.swift
//  SymbolicCalculatorTests
//
//  Created by Joseph Cestone on 9/1/22.
//

import XCTest
@testable import SymbolicCalculus
@testable import SymbolicCalculator

final class SymbolicCalculatorTests: XCTestCase {
    
    func testParse(input: String, expected: any Expression) {
        let parsed = AnyExpression(
            ExpressionParser(
                exact: !input.contains(".")
            ).parse(input: input)
        )
        
        XCTAssertEqual(parsed, AnyExpression(expected))
    }
    
    func testConstants() {
        XCTAssertEqual("1.0 agag".leadingNumber, "1.0")
        XCTAssertEqual("658.57e2453".leadingNumber, "658.57")
        XCTAssertEqual("ewy3".leadingNumber, "")
        XCTAssertEqual(".1.0hrt5".leadingNumber, ".1")
        XCTAssertEqual("..0hrt5".leadingNumber, "")
        XCTAssertEqual("1/7 agag".leadingNumber, "1/7")
        XCTAssertEqual("1/e2453".leadingNumber, "1/")
        XCTAssertEqual("1ewy3".leadingNumber, "1")
        XCTAssertEqual("1/0hrt5".leadingNumber, "1/0")
    }
    
    func testContainerString() {
        XCTAssertEqual("".leadingContainer, "")
        XCTAssertEqual("(".leadingContainer, "")
        XCTAssertEqual(",".leadingContainer, "")
        XCTAssertEqual("(,".leadingContainer, "")
        XCTAssertEqual(",,".leadingContainer, "")
        XCTAssertEqual(",)".leadingContainer, "")
        XCTAssertEqual("2 + 2".leadingContainer, "")
        XCTAssertEqual("(2 + 2".leadingContainer, "")
        XCTAssertEqual(",2 + 2".leadingContainer, "")
        XCTAssertEqual("(2 + 2,".leadingContainer, "2 + 2")
        XCTAssertEqual(",2 + 2,".leadingContainer, "2 + 2")
        XCTAssertEqual(",2 + 2)".leadingContainer, "2 + 2")
        XCTAssertEqual("(1 - 2 ^ 3, 13 mod 8)".leadingContainer, "1 - 2 ^ 3")
        XCTAssertEqual("((1 - 2) ^ 3, 13 mod 8)".leadingContainer, "(1 - 2) ^ 3")
        XCTAssertEqual("(Logx(1 - 2, 8) ^ 3, 13 mod 8)".leadingContainer, "Logx(1 - 2, 8) ^ 3")
    }
    
    func testDropContainerString() {
        var input1 = "Logx(1 - 2, 8) ^ 3, 13 mod 8"
        XCTAssertEqual(input1.dropLeadingContainer(), "")
        XCTAssertEqual(input1, "Logx(1 - 2, 8) ^ 3, 13 mod 8")
        var input2 = "(1 - 2, 8) ^ 3, 13 mod 8"
        XCTAssertEqual(input2.dropLeadingContainer(), "1 - 2")
        XCTAssertEqual(input2, ", 8) ^ 3, 13 mod 8")
        XCTAssertEqual(input2.dropLeadingContainer(), " 8")
        XCTAssertEqual(input2, " ^ 3, 13 mod 8")
        
        var input3 = "Logx(1 - 2, 8) ^ 3, 13 mod 8)".lowercased()
        XCTAssertEqual(input3.dropLeadingExpression(), .expression(eType: .binaryOperation(bType: .logx, sType: .any)))
        XCTAssertEqual(input3.dropLeadingExpression(), .expression(eType: .container(contents: "1 - 2")))
        XCTAssertEqual(input3.dropLeadingExpression(), .expression(eType: .container(contents: " 8")))
        XCTAssertEqual(input3.dropLeadingExpression(), .space)
        XCTAssertEqual(input3.dropLeadingExpression(), .expression(eType: .binaryOperation(bType: .exponential, sType: .any)) )
        XCTAssertEqual(input3.dropLeadingExpression(), .space)
        XCTAssertEqual(input3.dropLeadingExpression(), .constant(string: "3"))
        XCTAssertEqual(input3.dropLeadingExpression(), .expression(eType: .container(contents: " 13 mod 8")))
    }
    
    func testParse() throws {
        testParse(
            input: "(1 - 2)",
            expected: Difference(arg1: Constant(Fraction(1)), arg2: Constant(Fraction(2)))
        )
        testParse(
            input: "(( 1 - 2 ) ^ 3)",
            expected:
                Exponential(
                    arg1: Difference(arg1: Constant(Fraction(1)), arg2: Constant(Fraction(2))),
                    arg2: Constant(Fraction(3))
                )
        )
        testParse(
            input: "(13  mod 8)",
            expected:
                Mod(arg1: Constant(Fraction(13)), arg2: Constant(Fraction(8)))
        )
        testParse(
            input: "Logx(( 1 - 2 ) ^ (3), (13  mod 8))",
            expected:
                Logx(
                    arg1:
                        Exponential(
                            arg1: Difference(arg1: Constant(Fraction(1)), arg2: Constant(Fraction(2))),
                            arg2: Constant(Fraction(3))
                        ),
                    arg2: Mod(arg1: Constant(Fraction(13)), arg2: Constant(Fraction(8)))
                )
        )
    }
    
    func testGiantParse() throws {
        let input = "Logx(( 1.0 - 2 ) ^ (3), (13  mod 8)) * (3 / 2) + Abs(4)! + -ln(log2(32)) - sqrt(4)"
        let exp =
        Difference( // last operator must be outermost
            arg1:
                Sum(
                    arg1:
                        Sum(
                            arg1:
                                Product(
                                    arg1:
                                        Logx(
                                            arg1:
                                                Exponential(arg1: Difference(arg1: Constant(1.0), arg2: Constant(2.0)), arg2: Constant(3.0)),
                                            arg2: Mod(arg1: Constant(13.0), arg2: Constant(8.0))
                                        ),
                                    arg2: Quotient(arg1: Constant(3.0), arg2: Constant(2.0))
                                ),
                            arg2:
                                Factorial(arg1: Abs(arg1: Constant(4.0)))
                        ),
                    arg2:
                        Negative(arg1: Ln(arg1: Log2(arg1: Constant(32.0))))
                ),
            arg2: Sqrt(arg1: Constant(4.0))
        )
        testParse(input: input, expected: exp)
    }
    
    func testExpressionsEqual() {
        let expressions:[any Expression] = [
            Difference(),
            Exponential(),
            Logx(),
            Mod(),
            NthDerivative(),
            NthIntegral(),
            Product(),
            Quotient(),
            Sum(),
            
            Abs(),
            Factorial(),
            Ln(),
            Log2(),
            Log10(),
            Negative(),
            Sqrt(),
            
            AnyExpression(EmptyArg()),
            EmptyArg()
        ]
        for expr in expressions {
            XCTAssertFalse(expr.equals(expr), "Expression \(expr) of type \(expr.eType) = itself with EmptyArg arguments.")
        }
        XCTAssertEqual(Container("test"), Container("test"))
        let testArg1 = Constant(69.0)
        var expressionsMutable = expressions
        expressionsMutable.removeLast(2)
        expressionsMutable = expressionsMutable.map { expr in
            switch expr {
            case is any BinaryOperation:
                var binOp = expr as! (any BinaryOperation)
                binOp.arg1 = testArg1
                binOp.arg2 = testArg1
                return binOp as (any Expression)
            case is any UnaryOperation:
                var unaOp = expr as! (any UnaryOperation)
                unaOp.arg1 = testArg1
                return unaOp as (any Expression)
            default: fatalError("All expressions for this test should be unary or binary operations.")
            }
        }
        for expr in expressionsMutable {
            XCTAssertTrue(expr.equals(expr), "Expression \(expr) of type \(expr.eType) ≠ itself.")
        }
    }
    
    func testEmptyExpressionsEqual() {
        let expressions:[any Expression] = [
            Difference(),
            Exponential(),
            Logx(),
            Mod(),
            NthDerivative(),
            NthIntegral(),
            Product(),
            Quotient(),
            Sum(),
            
            Abs(),
            Factorial(),
            Ln(),
            Log2(),
            Log10(),
            Negative(),
            Sqrt(),
            
            AnyExpression(EmptyArg()),
            EmptyArg()
        ]
        
        for expr in expressions {
            XCTAssertFalse(expr.equals(expr))
        }
        
        XCTAssertEqual(Container("test"), Container("test"))
        
    }
    
    func testCalculatorRow() {
        let row = ComputationRow(index: 0, input: "7.0")
        XCTAssertEqual(AnyExpression(row.expression), AnyExpression(Constant(7.0)))
    }
}
