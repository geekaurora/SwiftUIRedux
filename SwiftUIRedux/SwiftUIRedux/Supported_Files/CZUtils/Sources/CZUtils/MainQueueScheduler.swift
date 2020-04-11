//
//  MainQueueScheduler.swift
//
//  Created by Cheng Zhang on 1/4/16.
//  Copyright © 2016 Cheng Zhang. All rights reserved.
//

import Foundation

/// Convenience class for scheduling sync/async execution on main queue
open class MainQueueScheduler: NSObject {
  
  /// Synchronous execution: inferring function returnType with `execution` closure returnType
  public class func sync<T>(_ execution: @escaping () -> T) -> T {
    if Thread.isMainThread {
      return execution()
    } else {
      return DispatchQueue.main.sync  {
        execution()
      }
    }
  }
  
  /// Asynchronous execution
  public class func async(execution: @escaping () -> Void ) {
    DispatchQueue.main.async {
      execution()
    }
  }
  
  /// Executes synchronously if the current thread is main thread, otherwise executes
  /// asynchronously on main thread.
  public class func safeAsync(execution: @escaping () -> Void ) {
    if Thread.isMainThread {
      execution()
    } else {
      DispatchQueue.main.async  {
        execution()
      }
    }
  }
}

