# Trumpster

## Description
This is the API of the full stack application that we have created for the soul purpose of making fun of the former president of the United States, Mr Donald J. Trump. During his presidency he have made life hard for comedians whom makes political commentary. How do you make a joke about a living joke? The answer that we find to be the best is to show the original joke without context or commentary, let the man speak for himself.
The website is made by using an external API called [Tronald Dump](https://www.tronalddump.io/). this API is a collection of all the dumbest things that Donald Trump has ever said. We use our API to modify the data from the Tronald Dump API and then use Axios to to request in order to get relevant data.
The functionality is based on different leaves of authentication. When you are lust a visitor you will get one random quote that will update every time you refresh the page.
When you are a registered member you have the ability to search for a quote from the Tronald Dump API. You become a registered member by providing the webpage with you’re Email and a password
But when you are a subscriber you will be able to customize your own insult insider by Trump. You become a subscriber by adding you card information and paying us 3kr.

## User stories
```
As an API
In order to be able to show a random quote on our website
We would like to be able to get a random quote from an external API
```
```
As an API
In order for users to search through quotes
We would like to authenticate the visitor
```
```
As an API
In order to provide the user with a search function
We would like to get data from our external API
```

## Dependencies
- RSpec for acceptance testing
- Devise for authenticating users
- Stripe as a payment provider

## Acknowledgements
- Learning materials from Craft Academy
- Our teammates

## License
MIT License

## Authors
- Sanne Lindholm
- Kyungin Na
- Viktor Karlsson
- Paulo Swärdblad
- Paulina Sobczak
