# Guard::Gradle

Continuously integrate while you work. Run those tests without thinking. It's the ying to your testing yang, baby.

### WTF?

Because once on [Guard](http://guardgem.org/) you become hooked. No need to manually run your tests -- they are run _automatically_ when a file changes.

What's Guard you ask? Good question Ruby tyro. 

>Guard is a command line tool to easily handle events on file system modifications.

## Installation

It's assumed you're more familiar with Java than you are with Ruby (after all, this is a Gradle tool, right?!); consequently, it's super easy to get going with Guard::Gradle _provided you have Ruby installed_. 

Open up a terminal and type:

```bash
$ ruby -v
ruby 2.0.0p451 (2014-02-24 revision 45167) [universal.x86_64-darwin13]
```

If you see something like `ruby: command not found` then you need to [install Ruby](https://www.ruby-lang.org/en/installation/). 

#### For those who want to get going ASAP

We've made this super easy. Open up a terminal, `cd` to your desired project, and type:

```bash
curl https://raw.githubusercontent.com/bricker/guard-gradle/master/etc/installer.sh | bash -
```

It's important you do this in the root directory of a project you wish to use Gradle::Guard in. This plugin is designed to work on individual project instances, much like a `build.gradle` file is unique to a project. 

The above script will install:
  * Bundler 
  * Guard::Gradle
  * Create default Guard file
  * Create a Guard launcher script

Therefore, after you run the command above, you'll be left with a script dubbed `guard.sh` -- just execute that script to start Guard::Gradle!

#### For those familiar w/Ruby

Guard::Gradle is intended to work with project instances; accordingly, you'll need to follow these steps for each project. 

If you already haven't installed [Bundler](http://bundler.io/), go ahead and install it (`sudo gem install bundler`).

In the root of your project, create a `Gemfile` that looks like:

```ruby
source 'https://rubygems.org'
gem 'guard-gradle'
```

Save the file and then run:

```
$ bundle install --path vendor
```

Then create a `Guardfile` with the recommended configuration by running:

```
$ bundle exec guard init gradle
```

The default `Guardfile` will look like this:

```ruby
guard :gradle do
  watch(%r{^src/main/(.+)\.*$}) { |m| m[1].split('.')[0].split('/')[-1] }
end
```

For those who give a flip: `watch` watches all files in the `src/main` directory of your project and if a file happens to change, the corresponding file is parsed out -- i.e. `src/main/groovy/org/github/aglover/prattle/Prattle.groovy` becomes `Prattle`. The resultant file name is then passed into the Gradle `test` task (more or less -- see usage details below for exact behavior).

## Usage

To fire up Guard, type:

```
$ bundle exec guard
```

(I highly recommend you alias `bundle exec` to `be`)


This Guard plugin simply runs the `test` task on your Gradle project; the exact command it runs is:

```
./gradlew test
```

Note, the plugin will try and execute the exact corresponding test for a changed file. 

For example, if you change the file `DataCentuar.groovy`, if there is a corresponding `DataCentuarTest` or `DataCentuarSpec` _only_ that test is executed via the `-Dsingle.run` Gradle parameter. Otherwise, if no analogous test is found, the entire test suite is run.

### Multi-project builds

If you have a multi-project build, you can still use Guard::Gradle. You'll need to edit your `Guardfile` slightly by adding a special `multi_project` flag and passing in the project names. For instance, if you have a multi-project with two projects named "Foo" and "Bar", your `Guardfile` will need to look like so:

```ruby
guard :gradle, multi_project: true do
  watch(%r{^Foo/src/main/(.+)\.*$}) { |m|  "Foo/" +  m[1].split('.')[0].split('/')[-1]}
  watch(%r{^Bar/src/main/(.+)\.*$}) { |m|  "Bar/" +  m[1].split('.')[0].split('/')[-1] }
end
```
Be sure to have this `Guardfile` in the root of your project. 

### Configurable command/task/flags

If you want to customize how gradle runs, there are several configuration flags
available.

* `command` specifies the command line program to run.  Can be useful if your
 team wants to use globally installed gradle instead of the gradle wrapper.  Default is
 `./gradlew`
* `task` specifies the gradle task.  Default is `test`
* `flags` allows additional gradle command line flags, such as `--quiet`,
 `--stacktrace` or others.  Default is false (no flags)

## Notifications

Guard works natively with Growl. There are other options as well -- feel free to check out the [Guard wiki page](https://github.com/guard/guard/wiki/System-notifications) for more information.

For instance, as I use [Growl](http://growl.info/), I have updated my `Gemfile` to include `gem 'growl'`. After a `bundle install` I can then update my `Guardfile` with this line: `notification :growl`, which will force Guard to use Growl (instead of any default notifiers). 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
