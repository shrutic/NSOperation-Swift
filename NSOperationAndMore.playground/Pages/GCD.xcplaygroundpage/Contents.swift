/*:
 
 # GCD basics
 
To ensure that developers focus more on business logic than the intricacies of threads(priorities, memory usage), Apple introduced GCD in iOS 4 ( along with on OSX). GCD, an ObjC API, manages a thread pool that all of its callers can reuse.
 
 # Technical information
 
 GCD provides ability to create queues ( aka dispatch_queues) where developers can schedule blocks of logic synchronously or async wrt caller
 
GCD provides 5 queues by default ( one queue that runs on main thread and 4 other queues with different priorities of execution)

 Any custom queues created by developer, will eventually be executed in one of these 4 default queues. It is not recommended to create a custom queue for running on main thread
 
 The priorities of the 4 defaults queues ( Queue running on main thread always has the highest priority)
 * Background
 * Low
 * Default
 * High
 
 
 ![GCD queues](Objcio.png)
 Image Courtesy of Objc.io article [here](https://www.objc.io/issues/2-concurrency/concurrency-apis-and-pitfalls/)
 
 ## Playground example description
 
 This playground example runs on one of the 5 dispatch_queues provided by the GCD ( with .Default priority). 
 
 
 */

//: [Next](@next)

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

// Start dispatch_async  
print("Task scheduled")

dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    
    print("Task started")
    
    sleep(5) // Representative of long running task
    
    print("Task completed")
    
    XCPlaygroundPage.currentPage.finishExecution()
}

// Dispatch_async schedules operation and returns immediately even if the operation execution isnt complete
print("Task may or may not have completed")

/*:
  ### Additional GCD facts:
 
  * Provides the ability to group multiple tasks and wait on them
  
  * Provide dispatch semaphores to regulate use of finite resources
 
  * Dispatch_queues are thread safe
 
 */
