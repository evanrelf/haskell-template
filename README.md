# Haskell Template

[![CI](https://github.com/evanrelf/haskell-template/actions/workflows/ci.yml/badge.svg)](https://github.com/evanrelf/haskell-template/actions/workflows/ci.yml)

Template for my Haskell + Nix projects

I use this repo to as a starting point for new projects to avoid rewriting
common boilerplate. It's written in a very "batteries included" style - with all
the bells and whistles I might want included - but I usually strip out a lot of
that for smaller projects, or just steal bits and pieces as I go.

It's also nice to capture best practices and opinions (same thing amirite /s) on
project layout, which I can refer other people to easily.

## Checklist

- Replace occurances of `template` (`{rg,fd} --ignore-case --hidden 'template'`)
  with your project name
- Add `CACHIX_AUTH_TOKEN` secret to GitHub repo for CI
