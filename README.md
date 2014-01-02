# Guard::Gradle

Build your Java projects with Gradle as you work.


## Installation

Create a Gemfile that looks like:

```ruby
source "https://rubygems.org"
gem 'guard-gradle'
```

Then run:

```
bundle install
```

To create a Guardfile with the recommended configuration, run:

```
bundle exec guard init gradle
```


## Usage

This Guard plugin simply builds your gradle project using the gradle wrapper. The exact command it runs is:

```
./gradlew build
```

Therefore, you'll need to start guard from wherever your `gradlew` script lives:

```
bundle exec guard
```

The default Guardfile assumes that your project will follow the standard Gradle project structure (everything under the `src` directory), but you can customize this in your Guardfile.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
