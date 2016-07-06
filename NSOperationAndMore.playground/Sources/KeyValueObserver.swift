import Foundation

public class KeyValueObserver : NSObject {
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String: AnyObject]?, context: UnsafeMutablePointer<()>) {
        if let _ = object as? NSOperation, keyPath = keyPath {
            switch keyPath {
            case "isFinished":
                if let val: AnyObject = change?[NSKeyValueChangeNewKey] {
                    if let val = val as? Bool {
                        print("From inside KeyValueObserver: isFinished result \(val)")
                    }
                }
            case "isReady":
                if let val: AnyObject = change?[NSKeyValueChangeNewKey] {
                    if let val = val as? Bool {
                        print("From inside KeyValueObserver: isReady result \(val)")
                    }
                }
            case "isExecuting":
                if let val: AnyObject = change?[NSKeyValueChangeNewKey] {
                    if let val = val as? Bool {
                        print("From inside KeyValueObserver: isExecuting result \(val)")
                    }
                }
            case "isCancelled":
                if let val: AnyObject = change?[NSKeyValueChangeNewKey] {
                    if let val = val as? Bool {
                        print("From inside KeyValueObserver: isCancelled result \(val)")
                    }
                }
            default:
                print("default executed")
            }
            
           
        }
    }
}