--------------------------------------------------------------------
-- |
-- Copyright :  (c) Edward Kmett 2010-2013, Johan Kiviniemi 2013
-- License   :  BSD3
-- Maintainer:  Edward Kmett <ekmett@gmail.com>
-- Stability :  experimental
-- Portability: non-portable
--
--------------------------------------------------------------------
module Ersatz.Solver
  ( module Ersatz.Solver.Minisat
  , solveWith
  ) where

import Ersatz.Decoding
import Ersatz.Monad
import Ersatz.Solution
import Ersatz.Solver.Minisat

solveWith :: (Monad m, Decoding a) => Solver m -> SAT a -> m (Result, Maybe (Decoded a))
solveWith solver sat = case unsat sat of
  (a, qbf) -> do
    (res, litMap) <- solver qbf
    return (res, decode (solutionFrom litMap qbf) a)