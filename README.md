### Currencies Mobile Application
<img width="1200" alt="cover" src="https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/e3ea72bc-9b00-494c-8fa2-b1fb2d000d54">


### About Application
Currencies is an iOS mobile app developed with Swift and SwiftUI in Xcode. Simply enter an amount, choose your currencies and get real-time conversion rates at your fingertips. Ideal for travelers and finance enthusiasts alike, this app ensures you have the latest currency information quickly and easily.

<img width="1200" alt="browse" src="https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/51614355-a50f-4821-bf1e-2c9316374d5c">

### Convert Your Amount
<img width="1200" alt="convert" src="https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/465c7656-abae-4ad4-84f9-ef157c0ad770">

### Choose Your Currency Base
<img width="1200" alt="base" src="https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/71fef8d9-8fec-4e08-b384-bca31e388f9e">

### Display Preferences
<img width="1200" alt="mode" src="https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/0ecb5539-614e-44f0-87fa-4d71cd632a3f">

### Run Application
https://github.com/nicktheodoridisiOS/Currencies/assets/122683142/6c938010-ca93-4c3d-a5aa-8c260086e62c


### API Reference
For the implementation of the Currencies application, I utilized the [ExchangeRate-API](https://www.exchangerate-api.com/), which allows you to retrieve current currency exchange rates, perform currency conversions and fetch historical exchange rate data.

| Parameter | Type     | Value |Description                |
| :-------- | :------- | :-------|:------------------------- |
| `api_key` | `string` |b1b71f168dab8cfbff14f4d3 |**Required** |
| `currency_base` | `string` |EUR |**Required**|

```https
  GET https://v6.exchangerate-api.com/v6/b1b71f168dab8cfbff14f4d3/latest/EUR
```

This will return (with JSON format) the exchange rates from your base code to all the other currencies which supported:

```json
{
   "result":"success",
   "documentation":"https://www.exchangerate-api.com/docs",
   "terms_of_use":"https://www.exchangerate-api.com/terms",
   "time_last_update_unix":1715558401,
   "time_last_update_utc":"Mon, 13 May 2024 00:00:01 +0000",
   "time_next_update_unix":1715644801,
   "time_next_update_utc":"Tue, 14 May 2024 00:00:01 +0000",
   "base_code":"EUR",
   "conversion_rates":{
      "EUR":1,
      "AED":3.9561,
      "AFN":77.7023,
      "ALL":100.5079,
      "AMD":418.0317,
      "ANG":1.9283,
      "AOA":907.8752,
      "ARS":931.5387,
      "AUD":1.6318,
      "...":1.9283,
      "...":1.8379,
      "...":28.8929,
      "ZWL":14.5678
   }
}
```
### Project Tools
|Xcode|GitHub|Figma|Postman|
|:---:|:---:|:---:|:---:|
|<img width="60" alt="mode" src="https://cdn.jim-nielsen.com/macos/512/xcode-2020-11-11.png?rf=1024">|<img width="60" alt="mode" src="https://cdn.jim-nielsen.com/macos/512/github-desktop-2021-05-20.png?rf=1024">|<img width="60" alt="mode" src="https://cdn.jim-nielsen.com/macos/512/figma-2021-05-05.png?rf=1024">|<img width="60" alt="mode" src="https://www.dockhunt.com/_next/image?url=https%3A%2F%2Fdockhunt-images.nyc3.cdn.digitaloceanspaces.com%2F04e04350-1ef9-40d5-893f-aa743ad3435c&w=256&q=75">|

### Programming Stack
|Swift|SwiftUI
|:---:|:---:|
|<img width="60" alt="mode" src="https://developer.apple.com/assets/elements/icons/swift/swift-96x96_2x.png">|<img width="60" alt="mode" src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-128x128_2x.png">

### Contact
I'm always open to questions, suggestions and comments. If you have any questions or need assistance, feel free to contact me at [nicktheodoridiscontact@gmail.com](mailto:nicktheodoridiscontact@gmail.com) or through my GitHub account.

### Socials

Follow me on social media for the latest news and updates:

- Twitter: [nickiOSDev](https://twitter.com/nickiOSDev)
- Instagram: [nickmadethisone](https://www.instagram.com/nickmadethisone/)
- LinkedIn: [Nikolaos Theodoridis](https://www.linkedin.com/in/nikolaostheodoridis/)

### License
This project is distributed under the [Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/).

This means you can use, modify and share this work under the following conditions:
- You must attribute the original creator (attribution).
- You may not use this work for commercial purposes (non-commercial use).

