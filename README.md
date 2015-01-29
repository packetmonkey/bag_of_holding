# Bag of Holding

[![Build Status](https://travis-ci.org/packetmonkey/bag_of_holding.svg?branch=travis)](https://travis-ci.org/packetmonkey/bag_of_holding)
[![Code Climate](https://codeclimate.com/github/packetmonkey/bag_of_holding/badges/gpa.svg)](https://codeclimate.com/github/packetmonkey/bag_of_holding)
[![Gem Version](https://badge.fury.io/rb/bag_of_holding.svg)](http://badge.fury.io/rb/bag_of_holding)

A tabletop gaming utility library and CLI

## Install

```shell
gem install bag_of_holding
```

or add the following line to Gemfile:

```ruby
gem 'bag_of_holding'
```

## Usage
All of these examples assume usage of the command line utility. All functions
should be easily executable via the ruby API as the cli mostly just executes
high level API call and prints the results.

### Rolling Dice
#### Example
```sh
boh roll 1d20+5
8 = 3 (1d20) + 5
```

## Found a bug?
Open a [github issue](https://github.com/packetmonkey/bag_of_holding/issues)

## Contributing & Development
1. Fork the project.
2. Make your feature addition or bug fix. All specs should pass.
3. Add specs for your changes.
4. Commit
5. Send a pull request. Bonus points for topic branches.

## Licence
Bag of Holding is released under the [MIT Licence](http://choosealicense.com/licenses/mit/)

## Authors
Bag of Holding is written and maintained by Evan Sharp.
