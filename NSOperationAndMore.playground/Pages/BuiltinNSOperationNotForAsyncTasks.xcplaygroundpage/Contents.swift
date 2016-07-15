//: [Previous](@previous)

/*:
 
 # Default NSOperation and asynchronous tasks don't mix
 
 This section will explain why the utilize the built-in NSOperation API  will not work for asynchronous tasks. 
 
 By definition, the caller of asynchronous task immediately returns after firing the task.
 With the NSOperation API, this return can be incorrectly assumed to be completion of the task execution. 
 
 ### Playground code details
  
 This code demonstrates that if we need to execute an asynchronous operation inside the NSOperation, the built in 
 NSoperation API will not help.
 
 Run this playgound and you will notice that the isFinished KVO is set to true before the "Completion of operation" message is printed out on console
 
 */

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


var operationQueue = NSOperationQueue()
operationQueue.qualityOfService = .Background
var op = NSBlockOperation()
weak var weakOpRef = op
op.addExecutionBlock {
    if weakOpRef?.cancelled == false {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print("From Inside NSOperation: Start of operation")
            
            sleep(5)
            
            print("From Inside NSOperation: Completion of operation")
            XCPlaygroundPage.currentPage.finishExecution()
        }
    }
}

// Add observer for NSOperation state KVO to keep track of the operation status
var observer = KeyValueObserver()
op.addObserver(observer, forKeyPath: "isFinished", options: .New, context: nil)
op.addObserver(observer, forKeyPath: "isReady", options: .New, context: nil)
op.addObserver(observer, forKeyPath: "isCancelled", options: .New, context: nil)
op.addObserver(observer, forKeyPath: "isExecuting", options: .New, context: nil)

// Operation is immediately checked for ready state as soon as it is added to the operation queue unless the queue is suspended
operationQueue.addOperation(op)


//: [Next](@next)
