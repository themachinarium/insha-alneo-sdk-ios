Introduction
============

This documentation provides a step-by-step guide on how to integrate your iOS application with InshaAlneo SDK.

Integration Steps
-----------------

Follow the steps below to integrate YourApp with InshaAlneo:

### Step 1: Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate InshaAlneo into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/themachinarium/insha-alneo-sdk-ios", .upToNextMajor(from: "1.0.0"))
]
```
        

Conclusion
----------

Congratulations! You have successfully integrated YourApp with InshaAlneo. Your application is now ready to track various events and interactions, providing valuable analytics data to help you make informed decisions and enhance the user experience.

If you encounter any issues during the integration process or have questions about using InshaAlneo, please refer to their official documentation or contact their support team for assistance.
