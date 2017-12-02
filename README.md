# Mixin 🍹

[![Version](https://img.shields.io/cocoapods/v/Mixin.svg?style=flat)](http://cocoapods.org/pods/Mixin)
[![License](https://img.shields.io/cocoapods/l/Mixin.svg?style=flat)](http://cocoapods.org/pods/Mixin)
[![Platform](https://img.shields.io/cocoapods/p/Mixin.svg?style=flat)](http://cocoapods.org/pods/Mixin)

# Why?

Swift is Protocol-Oriented Programming, and it's more powerful by default implementations of extensions of protocols. You can mixin methods to classes like Ruby's Mixin.

However, iOS as an UI framework, objects like UIViewController have their own life cyle, if you can't listen life cyle methods, extensions as mixin don't really help.

For example, I write a protocol with extension to listen keyboard events
```swift
protocol KeyboardMixin {
    var keyboardHeight: CGFloat? { set get }
    func registerKeyboard()
    func deregisterKeyboard()
}

extension KeyboardMixin {
    func registerKeyboard() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardHeight = nil
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { [weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.keyboardHeight = keyboardSize.height
            }
        }
    }
    func deregisterKeyboard() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}
```
But I still need to register and deregister by myself
```swift
class ViewController: UIViewController, KeyboardMixin {
    var keyboardHeight: CGFloat? {
        didSet { }
    }
    override func viewWillAppear(_ animated: Bool) {
        registerKeyboard()
    }
    override func viewWillDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
}
```
The problem is why can't I mixin something to existing methods e.g. UIViewController life cyle?

If you have programmed React.js, you'll find its Mixin mechanism is very useful. So I just copy it to iOS. After using this package, you can write a mixin like this.

```swift
public protocol KeyboardMixin: ViewControllerMixinable {
    var keyboardHeight: CGFloat? { set get }
}

public extension KeyboardMixin {
    private func registerKeyboard() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardHeight = nil
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { [weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.keyboardHeight = keyboardSize.height
            }
        }
    }
    private func deregisterKeyboard() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    fileprivate func viewWillAppear(_ animated: Bool) {
        registerKeyboard()
    }
    fileprivate func viewWillDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
}
```
And use it like below

```swift
class ViewController: UIViewController, KeyboardMixin {
    var keyboardHeight: CGFloat? {
        didSet { }
    }
    override func viewWillAppear(_ animated: Bool) {
        // Don't worry, you can still do things here...
    }
}
```
It can't be simpler!

## How it works

This package uses iOS runtime to swizzle methods, so all override methods and mixins' methods will be called simultaneously.

## Support

This package support mixin to
* [UIViewControllerLifeCycle](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixinables/ViewControllerMixinable.swift#L11)
* [ExtendTableViewDelegate](https://github.com/oney/Mixin/blob/master/Mixin/Classes/Mixinables/TableViewMixinable.swift#L11)
* UIScrollViewDelegate
* UITextFieldDelegate

## Example

Check out [Example ViewController](https://github.com/oney/Mixin/blob/master/Example/Mixin/ViewController.swift), it shows how amazing to use Mixin

## Requirements

Only tested in Swift 4

## Installation

Mixin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Mixin'
```

## Author

Howard Yang, appdevoney@gmail.com

## License

Mixin is available under the MIT license. See the LICENSE file for more info.
