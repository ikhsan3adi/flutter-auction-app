
# Online Auction App

![GitHub forks](https://img.shields.io/github/forks/x4nn/flutter_online_auction_app?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/x4nn/flutter_online_auction_app?style=social)


## Features

- Login & Register
- Explore
- Auction Detail
- Place Bid
- My Bid
- My Auction
- Bid History
- Item
- User Profile
- Switch Dark & Light Theme
## Screenshots
- Coming Soon :soon:
## How to run the App

1. Run `flutter pub get` on main project

```shell
flutter pub get
```

2. Run `flutter pub get` on each packages, or copy & run this command for simplicity:

```shell
cd packages/auction_repository
flutter pub get
cd ../authentication_repository
flutter pub get
cd ../user_repository
flutter pub get
cd ../../
```

3. Run `build_runner` to generate `*.g.dart` file, or
run this command below for simplicity:

```shell
cd packages/auction_repository
flutter pub run build_runner build --delete-conflicting-outputs
cd ../authentication_repository
flutter pub run build_runner build --delete-conflicting-outputs
cd ../user_repository
flutter pub run build_runner build --delete-conflicting-outputs
cd ../../
```
## Authors

- [@x4nn](https://www.github.com/x4nn)

## Contributors

- [@asyncguy](https://www.github.com/asyncguy)


Don't forget to follow :ok_hand:
