# nourhan_portfolio

Portfolio website built with Flutter.

## Why the deployed site can fail on GitHub Pages

This project is hosted under a subpath:

- `https://nourhan312.github.io/Portfolio/`

For GitHub Pages subpath hosting, Flutter web **must** be built with:

- `--base-href /Portfolio/`

If you build without this flag, generated files point to `/` and the app fails to load correctly.

## Build for GitHub Pages

```powershell
flutter clean
flutter pub get
flutter build web --release --base-href /Portfolio/
```

Then deploy the contents of `build/web` to GitHub Pages.

## Local run

```powershell
flutter pub get
flutter run -d chrome
```
