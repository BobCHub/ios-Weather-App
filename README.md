
![App](App.png)

# iOS Weather App

## My Goal

Develop a iOS Weather App ![alt text](https://raw.githubusercontent.com/BobCHub/ios-Weather-App/tree/master/weather_app_icon/Icon-Small@3x.png)

Weather is a location-aware weather app. It will find out where you are in the world and query an open source weather service to retrieve the temperature and weather conditions. Also, you can change the city at the tap of a button. Want to know what it’s like in Victoria? Weather is here to help. 

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

## What I will create

I purpose a weather app using the [Openweathermap weather API](https://openweathermap.org/api). The main page uses geo location to bring up the users local weather. The user can use switch button to migrate to screen and select new city. The intended Audience is anyone that is interested in the current
weather. By bringing up the app you get the current weather instantly.

## Screens

1. On Launch - location based weather screen
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get Geolocation and send to Openweathermap weather API to acquire local weather data using my API Key
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Displays Current Temperature and Weather Condition (Image)
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Possible background from Unsplash Picture API
2. Search Screen - Search different City
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Allow User to get weather in different City.
3. Weather Screen for selected City
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Displays Current Temperature and Weather Condition (Image)


## What I have learned

- [x] The Use CocoaPods to manage and use open source code libraries. 
- [x] The use Networking calls.
- [x] The use public web-based APIs to fetch data.
- [x] Parse data organised in JSON format.
- [x] Core Location and utilising the iPhone’s inbuilt GPS. 
- [x] Navigation between View Controllers using Segues.
- [x] The use Delegates and Protocols.
- [x] How to pass data between View Controllers.
- [x] The use Switch statements

### Want to add

- [ ] Intragration of pList for City search auto-complete using openweathermap json response
- [ ] Add Three day Weather Forcast
- [ ] Add More API Information

## Libraries I used -  [CocoaPods is a dependency manager for Swift](https://cocoapods.org/)

* [CoreLocation - Apple](https://developer.apple.com/documentation/corelocation) - Core Location provides services for determining a device's geographic location
* [Alamofire -  CocoaPods](https://cocoapods.org/pods/Alamofire) - Alamofire is an HTTP networking library written in Swift [Alamofire GitHub](https://github.com/Alamofire/Alamofire)
* [SwiftyJSON -  CocoaPods](https://cocoapods.org/pods/SwiftyJSON) -  SwiftyJSON makes it easy to deal with JSON data in Swift. [SwiftyJSON GitHub](https://github.com/SwiftyJSON/SwiftyJSON)



