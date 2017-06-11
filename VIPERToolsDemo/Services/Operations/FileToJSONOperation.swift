//
//  FileToJSONOperation.swift
//  BeautyCam
//
//  Created by ANDREY KLADOV on 16/03/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation
import ConcurrentOperation
import APIClient

public class FileToJSONOperation: Operation, OperationResultProvider {
    
    public typealias FileInfo = (filename: String, extension: String)
    
    enum SystemBundlesError: Error {
        case noSuchFile
    }
    
    public let fileInfo: FileInfo
    
    private(set) public var result: OperationResult<JSONObject>
    
    public init(fileInfo: FileInfo) {
        self.fileInfo = fileInfo
        self.result = .pending
        super.init()
    }
    
    public override func main() {
        
        guard !isCancelled else {
            result = .cancelled
            return
        }
        
        guard let path = Bundle(for: type(of: self)).path(forResource: fileInfo.filename, ofType: fileInfo.extension),
            let json = NSDictionary(contentsOfFile: path) as? JSONObject else {
                result = .fail(SystemBundlesError.noSuchFile)
                return
        }
        
        result = .success(json)
    }
}
