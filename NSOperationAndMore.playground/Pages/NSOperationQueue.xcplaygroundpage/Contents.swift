//: [Previous](@previous)
/*: 
 # NSOperationQueue and NSOperation
 
 **NSOperationQueue** is an object oriented wrapper to GCD functionality. It provides wealth of features on top of GCD and allow developers to be further agnostic of the GCD inner-workings.
 
 Any operation that is to be scheduled on NSOperationQueue should be of the **NSOperation** type.
 
 NSOperation is an abstract class, but is a feature-rich wrapper. It provides the ability to keep track of the operation's state ( Ready, Executing, Cancelled and Finished) via KVO ( Key-Value Observing)
 
 **NSBlockOperation** and **NSInvocationOperation** are the system-defined sub classes of the NSOperation class.
 
 Developers are also encouraged to create custom subclasses NSOperation class. Developers can override 
 
 ### Reference links
 [Apple developer documentation](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/NSOperation_class/)
 
 [NSHipster](http://nshipster.com/nsoperation/)
 
 [Ray wenderlich Video tutorials](https://www.raywenderlich.com/123840/video-tutorial-introducing-concurrency-series-introduction)
 
 [Objc.io article](https://www.objc.io/issues/2-concurrency/concurrency-apis-and-pitfalls/)
 
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
        print("From Inside NSOperation: Start of operation")
        
        sleep(5)
        
        print("From Inside NSOperation: Completion of operation")
        XCPlaygroundPage.currentPage.finishExecution()
        
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

// Uncomment the below line to see the isCancelled KVO notifications and prevent the operation from executing
 op.cancel()
//: [Next](@next)
