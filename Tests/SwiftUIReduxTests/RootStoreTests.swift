import XCTest
@testable import SwiftUIRedux

final class RootStoreTests: XCTestCase {
  static let total = 300
  static let queueLable = "com.swiftui.redux"
  private var rootStore: ReduxRootStore!
  
  override func setUp() {
    rootStore = ReduxRootStore()
  }
  
  func testSubscribe() {
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
  }
  
  func testUnsubscribe() {
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    rootStore.unsubscribe(reducer)
    XCTAssert(!rootStore.reducers.contains(reducer))
  }
  
  func testDispatchToSingleReducer() {
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.reducers.contains(reducer))
    
    let action = TestAction()
    rootStore.dispatch(action: action)
    XCTAssert(reducer.receivedAction as AnyObject? === action)
  }
  
  func testDispatchToMultipleReducers() {
    let reducers = (0..<100).map { _ in TestReducer() }
    reducers.forEach { rootStore.subscribe($0) }
    reducers.forEach {
      XCTAssert(rootStore.reducers.contains($0), "rootStore doesn't contains reducer - \($0).")
    }
    
    let action = TestAction()
    rootStore.dispatch(action: action)
    reducers.forEach { reducer in
      XCTAssert(reducer.receivedAction as AnyObject? === action)
    }
  }
  
  func testDispatchOnMultiThreads() {
    let queue = DispatchQueue(label: Self.queueLable, attributes: .concurrent)
    // Subscriber `reducers` to `rootStore`.
    let reducers = (0..<100).map { _ in TestReducer() }
    reducers.forEach { rootStore.subscribe($0) }
    reducers.forEach {
      XCTAssert(rootStore.reducers.contains($0), "rootStore doesn't contains reducer - \($0).")
    }
    
    let action = TestAction()
    // Dispatch `action` on background thread.
    queue.async {
      self.rootStore.dispatch(action: action)
    }
    
    // Verify actions were received by `reducers`.
    let expectation = XCTestExpectation(description: "waitForAsync")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      reducers.forEach { reducer in
        // Verify received `action`.
        XCTAssert(reducer.receivedAction as AnyObject? === action)
        // Verify received on the main thread.
        XCTAssert(reducer.receivedActionOnMainThread, "Should receive action on the main thread.")
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 3)
  }
  
  func testWeakReference() {
    // Subscribe `reducer` to `rootStore`.
    var reducer: TestReducer? = TestReducer()
    rootStore.subscribe(reducer!)
    XCTAssert(rootStore.reducers.contains(reducer!))
    
    // After release `reducer`, it should be unsubscribed automatically from `rootStore`.
    reducer = nil
    XCTAssert(rootStore.reducers.count == 0)
  }
  
  func testMultiThread() {
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: Self.queueLable, attributes: .concurrent)
    
    // Test adding objects on multiple threads.
    let reducers = (0..<Self.total).map { _ in TestReducer() }
    reducers.forEach { item in
      dispatchGroup.enter()
      queue.async {
        self.rootStore.subscribe(item)
        dispatchGroup.leave()
      }
    }
    // Wait till group multi thread tasks complete.
    dispatchGroup.wait()
    // Verify `count` of reducers with the expected value.
    XCTAssertEqual(rootStore.reducers.count, Self.total)
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

