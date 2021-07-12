# template

[![CI](https://github.com/evanrelf/template/actions/workflows/ci.yml/badge.svg)](https://github.com/evanrelf/template/actions/workflows/ci.yml)

Template for my Haskell + Nix projects

I use this repo to as a starting point for new projects to avoid rewriting
common boilerplate, and to capture best practices. It's written in a very
"batteries included" style - with all the bells and whistles I might want
included - but I usually strip out a lot of that for smaller projects, or just
steal bits and pieces as I go.

## Checklist

- Replace occurances of `template` (`rg --ignore-case --hidden 'template'`) with
  your project name
- Add `CACHIX_AUTH_TOKEN` secret to GitHub repo for CI
