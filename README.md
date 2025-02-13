# Jailbreak Detector

Jailbreak Detector is a lightweight Swift library that helps detect whether an iOS device is jailbroken. It also provides an additional check to determine if files can be written on a jailbroken device.

## Features
- Detect if the device is jailbroken.
- Check if files can be added on a jailbroken device.

## Installation

### Swift Package Manager (SPM)
1. Open Xcode and go to `File > Swift Packages > Add Package Dependency`.
2. Enter the repository URL: `https://github.com/Narendrapandey/JailBreakDetector.git`.
3. Choose the latest version and add it to your project.

## Usage

### Import the Library
```swift
import JailBreak
```

### Check if the Device is Jailbroken
```swift
if JailBreakDetector.shared.isJailbrokenDevice {
    print("This device is jailbroken.")
} else {
    print("This device is not jailbroken.")
}
```

### Check if Files Can Be Added on a Jailbroken Device
```swift
if JailBreakDetector.shared.canAddFileOnJailBreakDevice {
    print("Files can be written on this jailbroken device.")
} else {
    print("Files cannot be written on this jailbroken device.")
}
```

## License
You can use this code anywhere, you are free to modify 

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for suggestions and improvements.

## Author
[Narendra Pandey]

