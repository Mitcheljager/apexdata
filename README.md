## ApexData.GG

This is the repository for [ApexData.gg](https://www.apexdata.gg/). Anyone is feel to contribute by forking this project.

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
