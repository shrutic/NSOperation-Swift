import Foundation

public class AsynchronousOperation: NSOperation {
    
    public enum State: String {
        case Ready, Executing, Finished
        
        private var keyPath: String {
            return "is" +  self.rawValue
        }
    }
    
    public var state = State.Ready {
        willSet {
            willChangeValueForKey(newValue.keyPath)
            willChangeValueForKey(state.keyPath)
        }
        
        didSet {
            didChangeValueForKey(oldValue.keyPath)
            didChangeValueForKey(state.keyPath)
        }
    }
    
    override public var ready: Bool {
        return super.ready && self.state == .Ready
    }
    
    override public var executing: Bool {
        return self.state == .Executing
    }
    
    override public var finished: Bool {
        return self.state == .Finished
    }
    
    override public var asynchronous: Bool {
        return true
    }
    
    private var block: ((operation: AsynchronousOperation) -> ())?
    
    override public func main() {
        self.block?(operation: self)
    }
    
    convenience init(block: ((operation: AsynchronousOperation) -> ())?) {
        self.init()
        self.block = block
    }
    
    override public func start() {
        if self.cancelled {
            state = .Finished
        } else {
            self.main() // This should set self.state = .Finished when done with execution
            state = .Executing
        }
    }
}

