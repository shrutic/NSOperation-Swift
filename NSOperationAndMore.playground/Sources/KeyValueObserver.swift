import Foundation

public class KeyValueObserver : NSObject {

    public init(of op: Operation) {
        super.init()
        op.addObserver(self, forKeyPath: #keyPath(Operation.isFinished), options: .new, context: nil)
        op.addObserver(self, forKeyPath: #keyPath(Operation.isReady), options: .new, context: nil)
        op.addObserver(self, forKeyPath: #keyPath(Operation.isCancelled), options: .new, context: nil)
        op.addObserver(self, forKeyPath: #keyPath(Operation.isExecuting), options: .new, context: nil)
    }

    // you will see the output of the print() statements in the Console, not the playground's 'results sidebar'
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let _ = object as? Operation, let keyPath = keyPath {
            switch keyPath {
            case "isFinished", "isReady", "isExecuting", "isCancelled":
                if let val = (change?[.newKey] as AnyObject?) as? Bool {
                    print("KeyValueObserver: \(keyPath) = \(val)")
                }
                else {
                    print("KeyValueObserver: couldn't get key or value")
                }
            default:
                print("KeyValueObserver: default executed")
            }
        }
    }
}
