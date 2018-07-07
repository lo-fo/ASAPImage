# ASAPImage

A library providing asynchronous image downloading utilities.

## ASAPImageView

**ASAPImageView** is a subclass of **UIImageView**.

It handles fetching an image from an URL then asynchronously setting it as its `image` property.

### Basic usage

```swift
import ASAPImage

let url: URL!

let asapImageView = ASAPImageView()
asapImageView.load(imageAt: url)
```

While a request is ongoing, any subsequent modification of the image, wether through a new call to `load(imageAt:)` or by setting the `image` property directly, will result in the cancellation of the 'old' request.

### Request cancellation

The `cancel()` method allows you to cancel the ongoing request.

```swift
asapImageView.load(imageAt: url)
asapImageView.cancel()
```

### Request completion

`load(imageAt:)` accepts as an optional argument a callback to notify your code of the request's completion.
The callback takes as an argument a `Result<Void>` type, which is an `enum` with `.success` and `.failure(Error)` cases.

```swift
asapImageView.load(imageAt: url) { result in
	switch result {
	case .success:
	     /* your logic */
	case .failure(let error):
	     /* your logic */
	}
}
```
Cancelling a request will result with a `.failure(Error)` completion.

## ASAPImageLoader

For pure image downloading you can use the **ASAPImageLoader** singleton.

In the same fashion as **ASAPImageView**, it provides a `load(imageAt:completion:)` method. This time the completion handler is obligatory and its argument is of type `Result<Image>`.

```swift
ASAPImageLoader.shared.load(imageAt: url) { result in
	switch result {
	case .success(let image):
	     /* your logic */
	case .failure(let error):
	     /* your logic */
	}
}
```

### Request cancellation

If you want to cancel a request you can use the `CancellationToken` returned by the `load(imageAt:completion:)` method.

```swift
let token = ASAPImageLoader.shared.load(imageAt: url) { /* your logic */ }
token.cancel()
```

## Installation with Cocoapods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
pod 'ASAPImage'
```

If you are using Swift, be sure to add `use_frameworks!`
```
use_frameworks!
```