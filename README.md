# voyage

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

** weather apiV2.5
is : "https://api.openweathermap.org/data/2.5/forecast?q={sityName}&appid={APIkey}&lang={lang}"

** weather apiV3
is : "https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={APIkey}"

## Parameters

lat    (required):    Latitude, decimal (-90; 90). If you need the geocoder to automatic convert
city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API
lon    (required): Longitude, decimal (-180; 180). If you need the geocoder to automatic convert
city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API
appid    (required):    Your unique API key (you can always find it on your account page under the "
API key" tab)
exclude    (optional):    By using this parameter you can exclude some parts of the weather data
from the API response. It should be a comma-delimited list (without spaces).
Available values:

*** current ***
*** minutely ***
*** hourly ***
*** daily ***
*** alerts ***
units    (optional):    Units of measurement. standard, metric and imperial units are available. If
you do not use the units parameter, standard units will be applied by default. Learn more
lang    (optional):    You can use the lang parameter to get the output in your language. Learn more

## response

### Example of API response

"""
{
"lat":33.44,
"lon":-94.04,
"timezone":"America/Chicago",
"timezone_offset":-18000,
"current":{
"dt":1684929490,
"sunrise":1684926645,
"sunset":1684977332,
"temp":292.55,
"feels_like":292.87,
"pressure":1014,
"humidity":89,
"dew_point":290.69,
"uvi":0.16,
"clouds":53,
"visibility":10000,
"wind_speed":3.13,
"wind_deg":93,
"wind_gust":6.71,
"weather":[
{
"id":803,
"main":"Clouds",
"description":"broken clouds",
"icon":"04d"
}
]
},
"minutely":[
{
"dt":1684929540,
"precipitation":0
},
...
],
"hourly":[
{
"dt":1684926000,
"temp":292.01,
"feels_like":292.33,
"pressure":1014,
"humidity":91,
"dew_point":290.51,
"uvi":0,
"clouds":54,
"visibility":10000,
"wind_speed":2.58,
"wind_deg":86,
"wind_gust":5.88,
"weather":[
{
"id":803,
"main":"Clouds",
"description":"broken clouds",
"icon":"04n"
}
],
"pop":0.15
},
...
],
"daily":[
{
"dt":1684951200,
"sunrise":1684926645,
"sunset":1684977332,
"moonrise":1684941060,
"moonset":1684905480,
"moon_phase":0.16,
"summary":"Expect a day of partly cloudy with rain",
"temp":{
"day":299.03,
"min":290.69,
"max":300.35,
"night":291.45,
"eve":297.51,
"morn":292.55
},
"feels_like":{
"day":299.21,
"night":291.37,
"eve":297.86,
"morn":292.87
},
"pressure":1016,
"humidity":59,
"dew_point":290.48,
"wind_speed":3.98,
"wind_deg":76,
"wind_gust":8.92,
"weather":[
{
"id":500,
"main":"Rain",
"description":"light rain",
"icon":"10d"
}
],
"clouds":92,
"pop":0.47,
"rain":0.15,
"uvi":9.23
},
...
],
"alerts": [
{
"sender_name": "NWS Philadelphia - Mount Holly (New Jersey, Delaware, Southeastern Pennsylvania)",
"event": "Small Craft Advisory",
"start": 1684952747,
"end": 1684988747,
"description": "...SMALL CRAFT ADVISORY REMAINS IN EFFECT FROM 5 PM THIS\nAFTERNOON TO 3 AM EST
FRIDAY...\n* WHAT...North winds 15 to 20 kt with gusts up to 25 kt and seas\n3 to 5 ft expected.\n*
WHERE...Coastal waters from Little Egg Inlet to Great Egg\nInlet NJ out 20 nm, Coastal waters from
Great Egg Inlet to\nCape May NJ out 20 nm and Coastal waters from Manasquan Inlet\nto Little Egg
Inlet NJ out 20 nm.\n* WHEN...From 5 PM this afternoon to 3 AM EST Friday.\n* IMPACTS...Conditions
will be hazardous to small craft.",
"tags": [

      ]
    },
    ...

]
"""

### List of language supported

sq Albanian
af Afrikaans
ar Arabic
az Azerbaijani
eu Basque
be Belarusian
bg Bulgarian
ca Catalan
zh_cn Chinese Simplified
zh_tw Chinese Traditional
hr Croatian
cz Czech
da Danish
nl Dutch
en English
fi Finnish
fr French
gl Galician
de German
el Greek
he Hebrew
hi Hindi
hu Hungarian
is Icelandic
id Indonesian
it Italian
ja Japanese
kr Korean
ku Kurmanji (Kurdish)
la Latvian
lt Lithuanian
mk Macedonian
no Norwegian
fa Persian (Farsi)
pl Polish
pt Portuguese
pt_br Português Brasil
ro Romanian
ru Russian
sr Serbian
sk Slovak
sl Slovenian
sp, es Spanish
sv, se Swedish
th Thai
tr Turkish
ua, uk Ukrainian
vi Vietnamese
zu Zulu
                
              