# Quote Me

### Table of Contents
1. [Overview](#overview)
2. [Add to your server](#adding)
3. [Installing your own](#self)
4. [Commands](#commands)
5. [Migrating from Nadeko](#migrating)

## Overview
Quote Me is a simple quote bot for discord.

## Adding Quote Me to your server <a name="adding" />
If you would like to add Quote Me to your discord server just click this link: [Add Quote Me to your server](https://discordapp.com/oauth2/authorize?&client_id=403268142312456204&scope=bot&permissions=52224)

## Installing your own Instance <a name="self" />
#### Requirements
* Ruby 2.3 or higher (2.5 recommended)
* Bundler
* SQLite

#### Installation Steps
1. Clone the repo using `git clone https://github.com/flutterflies/QuoteMe.git`
2. `cd` into the repo's directory
3. Run `bundle install`
4. Run `cp lib/data/sample.config.yml lib/data/config.yml`
5. Open `config.yml` in a text editor and add your bot credentials
6. Run `rake run` and enjoy your bot!

## Commands <a name="commands" />
Check out this page to see a full list of Quote Me commands:
[Quote Me Commands](https://github.com/flutterflies/QuoteMe/wiki/Commands)

## Migrating From Nadeko <a name="migrating" />
Quote Me offers some support for migrating from Nadeko by reading a quote message output from Nadeko and importing it into QuoteMe's database.

To import quotes follow the steps below:
1. Run the Quote Me command `$toggleimportnadeko`.
   * This will tell Quote Me to start listening to messages from Nadeko.
2. Use Nadeko's quote by ID command (`.qid`) to export a quote from Nadeko.
   * Quote Me will automatically read the resulting message from Nadeko and import the quote.
   * **Note: Exporting quotes from Nadeko using the `...` command will cause quotes to not be imported into Quote Me correctly**
3. Run the `$toggleimportnadeko` command again to make Quote Me stop listening to Nadeko.
   * **NOTE: Failing to run this when you are done import quotes may result in unwanted quotes being created in Quote Me**
