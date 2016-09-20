
import Data.Array.Accelerate as A

stFun ( (x1, x2, x3)
      , (y1, y2, y3)
      , (z1, z2, z3) ) = y1 >* 0.5 &&*
                         y2 >* 0.5 &&*
                         y3 >* 0.5 ? (1, 0)
