-- file: bracket.hs

import Control.Exception
import System.IO hiding (withFile)

withFile file mode go = bracket (openFile file mode) hClose go
