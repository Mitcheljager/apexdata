## ApexData.GG

This is the repository for [ApexData.gg](https://www.apexdata.gg/). Anyone is feel to contribute by forking this project.

### API

_We provide an API with most of the Data you will find on ApexData.gg. This API is free of charge and has unlimited calls. We do ask for a respectful use of our API, excessive spam requests will be blocked._

#### Aquiring an API Key

To aquire an API key please login or create an account. You will find your API key on your account page. This key is associated with your account and is required for all of your requests. To get multiple API keys you will need to create multiple accounts.

#### How to retrieve data

Calls are contructed as follows:
```
https://www.apexdata.gg/api/[your_api_key]/[type]/[optional_values].json
```

**Weapons**
To retrieve all weapon data you would call:
```
https://www.apexdata.gg/api/[your_api_key]/weapons.json
```
You can also retrieve weapons by their category:
```
https://www.apexdata.gg/api/[your_api_key]/weapons/[category].json
```
Categories include: `assault-rifles`, `pistols`, `shotguns`, `sniper-rifles`, `light-machine-guns`, `sub-machine-guns`.

Weapons can optionally be sorted by whichever numerical value you want. You would retrieve this as:
```
https://www.apexdata.gg/api/[your_api_key]/weapons/sort/[weapon_category]/[data_type].json
```
For example: `.../weapons/sort/pistols/damage-per-second.json`. The values are separated with dashes `-`, even though the values might have underscores `_`.

You can also retrieve weapons by any of it's values.
```
https://www.apexdata.gg/api/[your_api_key]/weapons/[data_type]/[_value].json
```

For example: `.../weapons/ammo-type/light.json` will return all weapons that use "Light" ammo.
This can also be used to get a specific weapon by it's name. `/weapons/name/eva-8-auto.json`. All names are downcase, and spaces are replaced with a dash `-`.

**Legends**
To retrieve all legends data you would call:
```
https://www.apexdata.gg/api/[your_api_key]/legends.json
```

Similar to weapons, you can also find legends by their name using `/legends/name/bangalore.json`. All names are downcase, and spaces are replaced with a dash `-`.

**Items**
Items come in several categories; `equipment`, `consumables`, `grenades`, `attachments`.

To retrieve items you would call:
```
https://www.apexdata.gg/api/[your_api_key]/[category].json
```

For example: `.../grenades.json` will retrieve all Grenades.

Similar to weapons and legends, you can also find items by their name using `/[category]/name/1x-holo.json`. All names are downcase, and spaces are replaced with a dash `-`.

#### Player Data

We do not supply Player or Account data. Check out [https://github.com/HugoDerave/ApexLegendsAPI](https://github.com/HugoDerave/ApexLegendsAPI) if you are looking for Player data.

#### Questions, Requests and issues

For any problems you encounter, requests, or questions, please create an issue and we will see what we can do!

---

### The project

### Getting it running

This is a basic Rails (5.2) project without anything added that needs additional steps to get started. There is no database and as a result no rake tasks are required to be ran.

The project can be installed simply with:

`bundle install`

Followed by running it with:

`rails s`

This will start a localhost at `localhost:3000`, just like any other Rails project.

### Where to find what

#### Content
We do not use a database for anything. All content can be found in `config/content`. Everything is categorised in different `.yml` files. These files are loaded in at `app/helpers/content_helper.rb`.

#### Views
View can be found in `app/views`. We are using [High Voltage](https://github.com/thoughtbot/high_voltage) to run static pages. We use this for most of our pages. These pages are located in `app/views/pages`. Most of the content logic is handled in these files.
Some more complex pages have their own controllers. An example is the `where_controller.rb` in `app/controllers`. This is a super simple filter system that takes 2 parameters `/where/[key]/[value]` such as `/where/ammo-type/heavy`. The views can be found `app/views/where`.

#### Images
Images are found in `app/assets/images`. Images are categorised by what they are intended to be used for. All images are ran through [TinyPNG](https://tinypng.com/) to make sure they are properly compressed.

#### SCSS and JS
SCSS can be found in `app/assets/stylesheets` and `app/assets/javascripts` respectively.

### SCSS

All SCSS is written according to [BEM](https://github.com/Mitcheljager/SCSS-Styleguide/blob/master/bem.md). Simply said: `.parent__child--modifier`. Each file is named and categorised according to the `parent` classed. The CSS properties should be roughly categorised by `Box -> Position -> Style -> Font -> Expensive modifier (box-shadow, transform, etc.)`.

### JS
All JS is written in ES6, with no regards to older browsers. We do not use Babel or anything similar to convert our ES6 back to ES5. No frameworks are used, we write in plain JS. No plugins should be used, with exceptions.
