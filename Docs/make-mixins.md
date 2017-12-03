# Make Mixins

For exmaple, you have written this mixin

```swift
import UIKit

public protocol KeyboardMixin {
    var keyboardHeight: CGFloat? { set get }
}

public extension KeyboardMixin {
    private func registerKeyboard() {
        // Register keyboard...
    }
    private func deregisterKeyboard() {
        // Deregister keyboard...
    }
}
```

And you want to make the custom UIViewController subclass that conform this protocol/mixin call `registerKeyboard` in `viewWillAppear` and call `deregisterKeyboard` in `viewWillDisappear`

How to do that?

First, make this protocol conform `ViewControllerMixinable`.
```swift
protocol KeyboardMixin: ViewControllerMixinable
```
Then add private `viewWillAppear` and `viewWillDisappear` methods, and call methods you want.
```swift
    private func viewWillAppear(_ animated: Bool) {
        registerKeyboard()
    }
    private func viewWillDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
```
Finally, register those methods to `UIViewControllerLifeCycle` property
```swift
public var viewControllerLifeCycle: UIViewControllerLifeCycle {
        return BlockViewControllerLifeCycle(
            viewWillAppear: viewWillAppear,
            viewWillDisappear: viewWillDisappear
        )
    }
```

And don't forgot add this mixin to ViewControllerMixinable extension when you use it
```swift
import UIKit
import Mixin

extension ViewControllerMixinable {
    var viewControllerLifeCycles: [LifeCycle?] {
        return [
            (self as? KeyboardMixin)?.viewControllerLifeCycle,
        ]
    }
}
```

And we use it like [this](https://github.com/oney/Mixin/tree/master/Docs/use-mixins.md)

Whole mixin code is [here](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/KeyboardMixin.swift)