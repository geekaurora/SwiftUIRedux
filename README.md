# SwiftUIRedux

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg)
[![License](https://img.shields.io/cocoapods/l/ReactiveListViewKit.svg?style=flat)](http://cocoapods.org/pods/ReactiveListViewKit)

### Comprehensive Redux library for SwiftUI.

 * Keep `State` consistent across `Stores` by `pub/sub` pattern with `Reducers` of `RootStore`.
 * Waterfall `Action` propagation flow from root to `State` subtree.
  
### Unidirectional Data Flow
 * **RootStore/Dispatcher:** Propagates domained actions 

 * **Subscriber:** Subscribes to `RootStore` and updates Components with new `State`

 * **Action:** Action driven - more loosely coupled pattern than `Delegation` pattern
    
 * **State:**
   * Reduces `Action` and outputs new `State`
   * Waterfall reduce flow: propagates `Action` to children nodes via `State` tree
 
### Declarative/Stateful/Immutable/Predictable
  * Efficient tree diff algorithm, no more imperative manual update code. 


  <img src="./Docs/Redux.jpeg" width="600">

