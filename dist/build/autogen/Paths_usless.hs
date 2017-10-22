module Paths_usless (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/eliethewoody/.cabal/bin"
libdir     = "/home/eliethewoody/.cabal/lib/x86_64-linux-ghc-7.10.3/usless-0.1.0.0-KEPffKAhr4dLsxt4Fxa5wA"
datadir    = "/home/eliethewoody/.cabal/share/x86_64-linux-ghc-7.10.3/usless-0.1.0.0"
libexecdir = "/home/eliethewoody/.cabal/libexec"
sysconfdir = "/home/eliethewoody/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "usless_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "usless_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "usless_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "usless_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "usless_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
