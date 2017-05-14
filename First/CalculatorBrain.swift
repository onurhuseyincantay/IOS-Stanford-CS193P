//
//  CalculatorBrain.swift
//  First
//
//  Created by onur hüseyin çantay on 04/05/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
func changeSign(operand : Double)->Double{
return -operand
}
func multiply(op1: Double, op2:Double)->Double{
return op1*op2
}
struct CalculatorBrain {
    private var accumulator : Double?
    private var internalProgram = [AnyObject]()
    mutating func setOperand (operand: Double){
        if pending == nil { clear()}
        accumulator=operand
        internalProgram.append(operand as AnyObject)
    }
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double)->Double)
        case equals
        enum PrintSymbol {
            case Prefix (String)
            case Postfix (String)
        }
    }
    private var operations : Dictionary<String,Operation>=[
        "π" : Operation.constant(Double.pi),//Double.pi,
        "e" : Operation.constant(M_E),//M_E,
        "√" : Operation.unaryOperation(sqrt),//sqrt
        "cos": Operation.unaryOperation(cos),//cos
        "±" :Operation.unaryOperation(changeSign),
        "×" :Operation.BinaryOperation(multiply),
        "+" :Operation.BinaryOperation({$0+$1}),
        "-" :Operation.BinaryOperation({$0-$1}),
        "÷" :Operation.BinaryOperation({$0/$1}),
        "=" :Operation.equals,
    ]
    mutating func performOperation(_ symbol : String){
        if let operations = operations[symbol]
        {
            switch operations {
            case .constant(let Value):
                accumulator = Value
            case .unaryOperation(let function):
                if accumulator != nil{
                accumulator = function(accumulator!)
                }
            case .BinaryOperation(let function):
                if accumulator != nil { pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
  internalProgram.append(symbol as AnyObject)
}
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
        accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
        
    }
    private var pending : PendingBinaryOperationInfo?
    private struct PendingBinaryOperationInfo{
        var binaryFunction : (Double,Double)->Double
        var firstOperand : Double
    }
    private var pendingBinaryOperation:PendingBinaryOperation?
    private struct PendingBinaryOperation{
        let function : (Double,Double)->Double
        let firstOperand:Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    var isPartialResult:Bool
    {
        return pending != nil
    }
    mutating func setOperand(_ operand: Double ){
    accumulator = operand
    }
    mutating func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram = []
    }
    var result : Double? {
        get{
        return accumulator
        }
    }
}
