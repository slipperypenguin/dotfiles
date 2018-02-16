if ! is-executable brew -o ! is-executable git; then
  echo "Skipped: npm (missing: brew and/or git)"
  return
fi

brew install nvm

export DOTFILES_BREW_PREFIX_NVM=`brew --prefix nvm`
set-config "DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_BREW_PREFIX_NVM" "$DOTFILES_CACHE"

. "${DOTFILES_DIR}/system/.nvm"
nvm install 8
nvm alias default 8


## Globally install with npm
packages=(
  @storybook/cli
  cost-of-modules
  create-react-app
  eslint
  #get-port-cli
  #historie
  jasmine
  jest
  nativefier
  npm
  npm-check
  npm-collect
  react-devtools
  #spot
  #superstatic
  #svgo
  swagger
  tldr
  tree-cli
  #underscore-cli
  vtop
)

npm install -g "${packages[@]}"
