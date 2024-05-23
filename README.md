# MyPokemonList
This is a pokemon App that I created to fullfill Phincon Mini Project test.

https://github.com/irsyadashari/MyPokemonList/assets/36505012/1eb6acac-73f2-47b4-ab10-635a319decc2

# Architecture Pattern

<img width="663" alt="image" src="https://github.com/irsyadashari/MyPokemonList/assets/36505012/46e59ff0-71a7-4797-9d62-7239f6f17f57">

In this project I use VIPER as the arc pattern with a few exceptions :
- I didn't use router since it will be overkill to be implemented on small app like this.
- I also put some logic bussiness in presenter instead of in interactor to save davelopment time and make the app less encapsulated.

# Design Pattern
- Singleton
  A singleton NetworkManager can manage a single instance of URLSession. This is beneficial because:

  - Efficiency: Reusing the same URLSession instance can reduce overhead and improve performance, as it can take advantage of connection pooling and other optimizations.
  - Consistency: It ensures all network requests go through the same session configuration, which can be crucial for features like caching, cookies, and custom URL protocols.

# Additional Framework
  - CoreData : I use this SQLite framework to store the captured pokemon into database.

# How To Run
You can just open the MyPokemonList.xcodeproj with xcode(I'm using xcode 15.3) and hit run to open the app. You don't need any **pod Install** or **waiting for SPM** to load the library first in order to be able to start the app.

# How to Navigate
<img width="340" alt="image" src="https://github.com/irsyadashari/MyPokemonList/assets/36505012/05c70c8b-28b1-4d60-a0f3-47acb70aa8fc">

You can use the TabBar on the bottom of the screen to navigate through Pokemon List and Pokedeck.

# Pokemon List Page

<img width="357" alt="image" src="https://github.com/irsyadashari/MyPokemonList/assets/36505012/93e758e7-233b-41c7-bd11-b44169107d0b">

This is the page where the pokemon list are being loaded from the API (https://pokeapi.co/docs/v2). From here you can go to Detail Pokemon Page to **catch them all**.

# Pokemon Detail Page

<img width="357" alt="image" src="https://github.com/irsyadashari/MyPokemonList/assets/36505012/5ac50fb9-a425-48b6-ac47-5f00e4f2e4e5">

This is where you can see more detail info about the pokemon, also to catch them

# My Pokemon List Page

<img width="349" alt="image" src="https://github.com/irsyadashari/MyPokemonList/assets/36505012/6377d51b-5cb6-4a44-a68a-a5494ddee3cf">

This is where you can see all the pokemon you have catched previously. In this page you can give it a nickname or even release it.
