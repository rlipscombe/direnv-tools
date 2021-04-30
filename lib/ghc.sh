use_ghc() {
    GHC_VERSION="$1"
    GHC_PREFIX="/opt/ghc/$GHC_VERSION"
    load_prefix "$GHC_PREFIX"
}

use_cabal() {
    CABAL_VERSION="$1"
    CABAL_PREFIX="/opt/cabal/$CABAL_VERSION"
    load_prefix "$CABAL_PREFIX"
}
