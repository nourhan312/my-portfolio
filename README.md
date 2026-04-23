# nourhan_portfolio

Flutter portfolio project ready for GitHub Pages deployment.

## Live site

When published to GitHub Pages, the site will be available at:

`https://nourhan312.github.io/my-portfolio/`

## Deploy to GitHub Pages

1. Push this project to the GitHub repository:

```powershell
git remote add origin https://github.com/nourhan312/my-portfolio.git
git branch -M main
git push -u origin main
```

2. In GitHub repository settings:
   - Go to **Settings -> Pages**
   - Set **Source** to **GitHub Actions**

3. If GitHub shows environment protection for `github-pages`:
   - Go to **Settings -> Environments -> github-pages**
   - Allow deployment from `main` or temporarily remove branch restrictions

4. Re-run the workflow in the **Actions** tab if needed.

## Local development

```powershell
flutter pub get
flutter run -d chrome
```

