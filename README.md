# Introduction

This documentation provides a comprehensive guide for integrating your iOS application with the **InshaAlneo SDK**. By following these steps, you can seamlessly incorporate InshaAlneo's functionality into your project to track and manage various events.

---

## Integration Steps

### Step 1: Install the SDK Using Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) (SPM) is a tool for automating the integration of Swift libraries. To integrate **InshaAlneo SDK** into your project:

1. Open your Xcode project.

2. Navigate to **File > Add Packages**.

3. Enter the package repository URL:

   ```
   https://github.com/themachinarium/insha-alneo-sdk-ios
   ```

4. Set the version rule to **Up to Next Major** from `1.0.0`.

5. Add the package to your target.

Alternatively, if you're managing dependencies using a `Package.swift` file, add the following to the `dependencies` section:

```swift
dependencies: [
    .package(url: "https://github.com/themachinarium/insha-alneo-sdk-ios", .upToNextMajor(from: "1.0.0"))
]
```

### Step 2: Import the SDK

After installing the SDK, import it into the files where you need its functionality:

```swift
import InshaAlneo
```

### Step 3: Initialize the API Client

Create an instance of the API client and configure it with your credentials:

```swift
let client = AlneoAPIClient()
client.setKeys(
    apiKey: "YOUR_API_KEY",
    apiSecret: "YOUR_API_SECRET",
    userCode: "YOUR_USER_CODE"
)
```

Replace `YOUR_API_KEY`, `YOUR_API_SECRET`, and `YOUR_USER_CODE` with your credentials provided by InshaAlneo.

### Step 4: Use the SDK

Now, you can use the `sessionCreateDirect` method to initiate a session:

```swift
client.sessionCreateDirect(price: 1256, data: "544078") { response in
    switch response {
    case .success(let data):
        print("Session Created: ", data)
    case .failure(let error):
        print("Error: ", error.localizedDescription)
    }
}
```

---

## Conclusion

Congratulations! You have successfully integrated your iOS application with **InshaAlneo SDK**. Your app is now ready to utilize the powerful features offered by InshaAlneo to enhance user experience and provide valuable analytics data.

If you encounter any issues during the integration or need further assistance:

- Refer to the [official InshaAlneo documentation](https://github.com/themachinarium/insha-alneo-sdk-ios).
- Contact the **InshaAlneo Support Team**.

Happy coding!
