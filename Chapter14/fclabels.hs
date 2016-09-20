-- file: fclabels.hs
{-# LANGUAGE TemplateHaskell #-}

import Prelude hiding (id, (.))
import Control.Category
import Data.Label

data Member = Member
          { _name :: String
          , _task :: String
          } deriving Show

data Team = Team
          { _leader :: Member
          , _memebrs :: [Member]
          } deriving Show

mkLabels [''Member, ''Team]
