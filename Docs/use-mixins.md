# Use Mixins

There is some written Mixins in this package. They are
* [`KeyboardMixin`](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/KeyboardMixin.swift)
* [`ScrollCloseBottomMixin`](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/ScrollCloseBottomMixin.swift)
* [`ScrollFinishMixin`](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/ScrollFinishMixin.swift)
* [`StandardTableMixin`](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/StandardTableMixin.swift)
* [`TextFieldReturnMixin`](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixins/TextFieldReturnMixin.swift)

For example, `ScrollFinishMixin` is used for detecting when users finish scrolling scroll views.

## Setup

Create new Xcode project, install pod by adding `pod Mixin` to `Podfile`, then `pod install`.  
So for example, you want to use `ScrollFinishMixin` to your `ViewController` class

Add the following codes to `ViewController.swift`
```swift
import UIKit
import Mixin

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView! // here assume you setup delegate from storyboard
}
extension ViewController: ScrollFinishMixin {
    func scrollFinish(_ scrollView: UIScrollView) {
        print("scrollFinish")
    }
}
```

But you still have to do Mixin configuration.

Create new file called `SetupMixin.swift` and put these codes
```swift
import UIKit
import Mixin

extension ScrollViewMixinable {
    var scrollViewDelegates: [UIScrollViewDelegate?] {
        return [
            (self as? ScrollFinishMixin)?.scrollViewDelegate_ScrollFinishMixin,
        ]
    }
}
```

Remember you should add all Mixin you use here.

That's all!