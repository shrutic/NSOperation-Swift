//: [Previous](@previous)    [Next](@next)
/*:
 # Default NSOperation and asynchronous tasks don't mix
 
 This section will explain why the utilize the built-in NSOperation API  will not work for asynchronous tasks. 
 
 By definition, the caller of asynchronous task immediately returns after firing the task.
 With the NSOperation API, this return can be incorrectly assumed to be completion of the task execution. 
 
 ### Playground code details
  
 This code demonstrates that if we need to execute an asynchronous operation inside the NSOperation, the built in 
 NSOperation API will not help.
 
 Run this playgound and you will notice that the isFinished KVO is set to true before the "Completion of operation" message is printed in the playground's 'results sidebar'
 
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var operationQueue = OperationQueue()
operationQueue.qualityOfService = .background
var op = BlockOperation()
weak var weakOpRef = op
op.addExecutionBlock {
    if weakOpRef?.isCancelled == false {
        DispatchQueue.global().async {
            print("\nInside Block: Start of operation")
            
            sleep(5)
            
            print("\nInside Block: Completion of operation")
            PlaygroundPage.current.finishExecution()
        }
    }
}

// Add observer for NSOperation state KVO to keep track of the operation status
var observer = KeyValueObserver(of: op)

// Operation is immediately checked for ready state as soon as it is added to the operation queue unless the queue is suspended
operationQueue.addOperation(op)

//: [Previous](@previous)    [Next](@next)
