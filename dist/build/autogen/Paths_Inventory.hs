module Paths_Inventory (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/hawk/.cabal/bin"
libdir     = "/home/hawk/.cabal/lib/Inventory-0.1.0.0/ghc-7.4.1"
datadir    = "/home/hawk/.cabal/share/Inventory-0.1.0.0"
libexecdir = "/home/hawk/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "Inventory_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Inventory_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Inventory_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Inventory_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
