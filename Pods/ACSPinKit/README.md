# ACSPinKit

<p align="center" >
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACSPinKit.png">
</p>

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- min. Target iOS 7

## Installation

ACSPinKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ACSPinKit"
    
## Features
- Create a pin code
- Verify pin code
- Change pin code
- Customize titles, colors and images
- Fullscreen verification controller
- Very modular code design
- iPhone and iPad Support

## Screenshots

<br>
<br>
<p align="center" >
	<img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS1.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS2.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
  <img src="https://github.com/arconsis/ACSPinKit/raw/master/Resources/ACS3.PNG" width="30%" height="30%" alt="ACS" title="ACS" border="1">
</p>
<br>
<br>

## Usage

For getting started just initialize the pin controller with a given user, service and access group. All pin controller instances with these same values share the same pin handling.

```objective-c
	self.pinController = [[ACSPinController alloc] initWithPinServiceName:@"testservice" pinUserName:@"testuser" accessGroup:@"accesstest" delegate:self];
    self.pinController.retriesMax = 5;
    // Validation block for pin controller to check if entered pin is valid.
    self.pinController.validationBlock = ^(NSString *pin) {
        // Check if 'pin' unlocks a vault or something similar...
    };
```

After you did setup the pin controller just present it from the current view controller:

```objective-c
	[self.pinController presentVerifyControllerFromViewController:self];
```


## Author

arconsis IT-Solutions GmbH <contact@arconsis.com>

## License

The MIT License (MIT)

Copyright (c) 2015 arconsis IT-Solutions GmbH <contact@arconsis.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

