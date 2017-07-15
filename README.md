# YAlert

[![CI Status](http://img.shields.io/travis/wleofeng@gmail.com/YAlert.svg?style=flat)](https://travis-ci.org/wleofeng@gmail.com/YAlert)
[![Version](https://img.shields.io/cocoapods/v/YAlert.svg?style=flat)](http://cocoapods.org/pods/YAlert)
[![License](https://img.shields.io/cocoapods/l/YAlert.svg?style=flat)](http://cocoapods.org/pods/YAlert)
[![Platform](https://img.shields.io/cocoapods/p/YAlert.svg?style=flat)](http://cocoapods.org/pods/YAlert)


<image src="https://github.com/wleofeng/YAlert/blob/master/screenshot/screenshot1.png" width=200px>
## How to use
In your view controller, you can initialize and present an AlertViewController instance using the following code:
```
let alertVC = AlertViewController(bannerImageName: "banner",
                                            title: "Alert #1",
                                          message: "This is a message",
                                          primaryButtonTitle: "Ok",
                                          secondaryButtonTitle: "Cancel")
alertVC.tag = 1000
alertVC.delegate = self
alertVC.present()
```

There are two properties responsible for handling user events when AlertViewController is present.

`delegate` allows your view controller to receive and handle primary button, secondary button, and background tap events.

`tag` allows you to differentiate different AlertViewController instance when handling tap events. You may have different event handling logic based on the AlertViewController's tag number.

```
extension ViewController: AlertViewControllerDelegate {
    func didTapPrimaryButton(_ sender: AlertViewController) {
        switch sender.tag {
        case 1000:
            print("1000")
        case 2000:
            print("2000")
        default:
            print("no tag")
        }

        print("primary button tapped")
    }

    func didTapSecondaryButton(_ sender: AlertViewController) {
        print("secondary button tapped")
    }

    func didTapBackground(_ sender: AlertViewController) {
        print("background tapped")
    }
}
```

## Installation

YAlert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YAlert"
```

## Author

Leo Feng, wleofeng@gmail.com

## License

YAlert is available under the MIT license. See the LICENSE file for more info.
