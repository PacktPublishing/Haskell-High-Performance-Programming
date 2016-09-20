-- file: ioref-supply.hs

import Data.IORef

type Supply = IORef Int

createSupply :: IO Supply
createSupply = newIORef 0

newUID :: Supply -> IO Int
newUID supply = atomicModifyIORef' supply $ \uid -> (uid + 1, uid)
