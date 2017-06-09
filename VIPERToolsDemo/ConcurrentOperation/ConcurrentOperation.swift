//
//  ConcurrentOperation.swift
//  VimeoUpload
//
//  Created by Hanssen, Alfie on 10/12/15.
//  Copyright © 2015 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// This class is a minimally modified version of this gist: https://gist.github.com/calebd/93fa347397cec5f88233

open class ConcurrentOperation: Operation {
    
    public static var loggingEnabled: Bool = false
    
    public var loggingEnabled: Bool {
        return ConcurrentOperation.loggingEnabled
    }
    private var dateStarted: Date!
    
    // MARK: Types
    
    public enum State {
        case ready, executing, finished
        
        var keyPath: String {
            switch self {
                case .ready:
                    return "isReady"
                case .executing:
                    return "isExecuting"
                case .finished:
                    return "isFinished"
            }
        }
    }
    
    // MARK: Properties
    
    public var state: State = .ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    // MARK: NSOperation Property Overrides
    
    override open var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override open var isExecuting: Bool {
        return state == .executing
    }
    
    override open var isFinished: Bool {
        return state == .finished
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    // MARK: NSOperation Method Overrides
    
    override open func start() {
        guard !isCancelled else {
            return
        }
        
        dateStarted = Date()
        state = .executing
        main()
    }
    
    override open func main() {
        fatalError("Subclasses must override main()")
    }
    
    override open func cancel() {
        super.cancel()
        if isExecuting {
            finish()
        }
    }
    
    public func finish() {
        if let date = dateStarted, loggingEnabled {
            print("\(self) finished in \(Date().timeIntervalSince(date)) seconds")
        }
        state = .finished
    }
}
