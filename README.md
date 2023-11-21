## Test client-server iOS application
## Application Stack:
☑ Layout using **UIKit** + **SnapKit**

☑ API requests made on **Alamofire** networking layer

☑ **Singlton, Factory, Builder** patterns used

☑ **MVP** architecture based on delegates and protocols

☑ All libraries imported with **Package**

<img src="https://github.com/PollyVern/WeatherApp/blob/master/Screen%20Shot.png" height="400" width="180">

## You need to add an API key to work with the application!
Create an API key and put it in an Xcode environment variable. Specifically:

1. Get the key from https://yandex.ru/dev/weather/
2. Activate "Test" tariff for api weather

3. Go to `Xcode` -> `Edit Scheme...` -> ...
<img src="https://github.com/PollyVern/WeatherApp/blob/master/ReadmeResources/stepOne.png" width="200">

... -> `Run` -> `Arguments` -> `Environment Variables` -> `+`

<img src="https://github.com/PollyVern/WeatherApp/blob/master/ReadmeResources/stepSecond.png" width="700">

And create an environment variable named `weather_key_API`. Insert the API key into the value.
