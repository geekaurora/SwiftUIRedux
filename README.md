# SwiftUIRedux

[![Version](https://img.shields.io/cocoapods/v/ReactiveListViewKit.svg?style=flat)](http://cocoapods.org/pods/ReactiveListViewKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg)
[![License](https://img.shields.io/cocoapods/l/ReactiveListViewKit.svg?style=flat)](http://cocoapods.org/pods/ReactiveListViewKit)
[![Platform](https://img.shields.io/cocoapods/p/ReactiveListViewKit.svg?style=flat)](http://cocoapods.org/pods/ReactiveListViewKit)

### Comprehensive Redux library for SwiftUI.

 * Keep `State` consistent across features by `pub/sub` pattern with `reducers` of `RootStore`. 
 * Waterfall `Action` propagation flow from root to `State` subtree.
  
### Unidirectional Data Flow
 * **Dispatcher:** Propagates domained actions

 * **Store:** Maintains `State` tree

 * **Subscriber:** Subscribes to `Store` and updates Components with new `State`

 * **Action:** Action driven - more loosely coupled pattern than `Delegation` pattern
    
 * **State:**
   * Waterfall reacting flow
   * Composition: `RootState` is composed of `Substates`
   * Reacts to `Action` and outputs new `State`, propagates `Action` to children nodes via `State` tree

### Declarative/Stateful/Immutable/Predictable
  * Efficient ViewModel tree diff algorithm, no more imperative manual cells update code

  <img src="./Docs/FLUX.jpeg">


### [Instagram Demo](https://github.com/showt1me/CZInstagram)
Implemented on top of **ReactiveListViewKit**

<img src="./Docs/CZInstagram.gif">
