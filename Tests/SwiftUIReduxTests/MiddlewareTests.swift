import CZUtils
import XCTest
@testable import SwiftUIRedux

final class MiddlewareTests: XCTestCase {
  private var rootStore: ReduxRootStore!
  
  override func setUp() {
    rootStore = ReduxRootStore()
  }
  
  func testApplyOneMiddlware() {
    rootStore.applyMiddleware(TestMiddlewareAllowNext)
    XCTAssert(rootStore.middlewares.allObjects.count == 1, "First Middleware should have been applied!")
  }

  func testApplyTwoMiddlwares() {
    rootStore.applyMiddleware(TestMiddlewareAllowNext)
    XCTAssert(rootStore.middlewares.allObjects.count == 1, "First Middleware should have been applied!")

    rootStore.applyMiddleware(TestMiddlewareDisallowNext)
    XCTAssert(rootStore.middlewares.allObjects.count == 2, "Second Middleware should have been applied!")
  }
  
  func testMiddlewareWithTranformer() {
    rootStore.applyMiddleware(TestMiddlewareAllowNextWithTransformer1)
    XCTAssert(rootStore.middlewares.allObjects.count == 1, "First Middleware should have been applied!")
    
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    let action = TestAction()
    rootStore.dispatch(action: action)
    XCTAssert(reducer.receivedAction is TestAction1)
  }
  
  func testMiddlewareOrder() {
    rootStore.applyMiddleware(TestMiddlewareAllowNextWithTransformer1)
    rootStore.applyMiddleware(TestMiddlewareAllowNextWithTransformer2)
    XCTAssert(rootStore.middlewares.allObjects.count == 2, "Two Middlewares should have been applied!")
    
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    // Middlewares should be applied according to `applyMiddleware(_:)` order,
    // thereby `TestMiddlewareAllowNextWithTransformer2` should execute at last,
    // the finally output action should be `TestAction2`.
    let action = TestAction()
    rootStore.dispatch(action: action)
    XCTAssert(reducer.receivedAction is TestAction2)
  }
  
  func testMiddlewareAllowNext() {
    rootStore.applyMiddleware(TestMiddlewareAllowNext)
    XCTAssert(rootStore.middlewares.allObjects.count == 1, "First Middleware should have been applied!")
    
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    let action = TestAction()
    rootStore.dispatch(action: action)
    XCTAssert(reducer.receivedAction as AnyObject? === action)
  }
  
  func testMiddlewareDisallowNext() {
    rootStore.applyMiddleware(TestMiddlewareDisallowNext)
    XCTAssert(rootStore.middlewares.allObjects.count == 1, "First Middleware should have been applied!")
    
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    let action = TestAction()
    rootStore.dispatch(action: action)
    XCTAssert(reducer.receivedAction as AnyObject? == nil)
  }
}

/// Middleware that calls the next middleware on the middleware chain.
public func TestMiddlewareAllowNext(_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    dispatchFunction(action)
  }
}

public func TestMiddlewareAllowNextWithTransformer1(_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    let newAction = TestAction1()
    dispatchFunction(newAction)
  }
}

public func TestMiddlewareAllowNextWithTransformer2(_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    let newAction = TestAction2()
    dispatchFunction(newAction)
  }
}

/// Middleware that doesn't call the next middleware on the middleware chain.
public func TestMiddlewareDisallowNext(_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    // No-op.
  }
}

private class TestReducer: ReduxReducerProtocol {
  private(set) var receivedAction: ReduxActionProtocol?
  private(set) var receivedActionOnMainThread = false
  
  func reduce(action: ReduxActionProtocol) {
    receivedAction = action
    receivedActionOnMainThread = Thread.isMainThread
  }
}

private class TestAction: ReduxActionProtocol {}

private class TestAction1: ReduxActionProtocol {}

private class TestAction2: ReduxActionProtocol {}
