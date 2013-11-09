{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE EmptyDataDecls #-}

module CPLEX.Bindings ( CpxEnv'
                      , CpxLp'
                      , c_CPXopenCPLEX
                      , c_CPXcloseCPLEX
                      , c_CPXcreateprob
                      , c_CPXfreeprob
                      , c_CPXnewrows
                      , c_CPXaddrows
                      , c_CPXnewcols
                      , c_CPXaddcols
                      , c_CPXchgcoeflist
                      , c_CPXchgcoef
                      , c_CPXchgrhs
                      , c_CPXchgrngval
                      , c_CPXchgbds
                      , c_CPXchgobj
                      , c_CPXgeterrorstring
                      , c_CPXgetstatstring
                      , c_CPXsetintparam
                      , c_CPXsetdblparam
                      , c_CPXgetnumcols
                      , c_CPXgetnumrows
                      , c_CPXcopylp
--                      , c_CPXcheckcopylp
                      , c_CPXcopyquad
--                      , c_CPXcheckcopyquad
                      , c_CPXqpopt
                      , c_CPXsolution
                      ) where

import Foreign.C ( CInt(..), CDouble(..), CChar(..) )
import Foreign.Ptr ( Ptr )

data CpxEnv'
data CpxLp'

foreign import ccall unsafe "cplex.h CPXopenCPLEX" c_CPXopenCPLEX :: Ptr CInt -> IO (Ptr CpxEnv')
foreign import ccall unsafe "cplex.h CPXcloseCPLEX" c_CPXcloseCPLEX :: Ptr (Ptr CpxEnv') -> IO CInt

foreign import ccall unsafe "cplex.h CPXcreateprob" c_CPXcreateprob ::
  Ptr CpxEnv' -> Ptr CInt -> Ptr CChar -> IO (Ptr CpxLp')
foreign import ccall unsafe "cplex.h CPXfreeprob" c_CPXfreeprob ::
  Ptr CpxEnv' -> Ptr (Ptr CpxLp') -> IO CInt

foreign import ccall unsafe "cplex.h CPXnewrows" c_CPXnewrows ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CDouble -> Ptr CChar -> Ptr CDouble -> Ptr (Ptr CChar) -> IO CInt

foreign import ccall unsafe "cplex.h CPXaddrows" c_CPXaddrows ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> CInt -> CInt -> Ptr CDouble -> Ptr CChar -> Ptr CInt -> Ptr CInt -> Ptr CDouble -> Ptr (Ptr CChar) -> Ptr (Ptr CChar) -> IO CInt

foreign import ccall unsafe "cplex.h CPXnewcols" c_CPXnewcols ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CDouble -> Ptr CDouble -> Ptr CDouble -> Ptr CChar -> Ptr (Ptr CChar) -> IO CInt

foreign import ccall unsafe "cplex.h CPXaddcols" c_CPXaddcols ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> CInt -> Ptr CDouble -> Ptr CInt -> Ptr CInt -> Ptr CDouble -> Ptr CDouble -> Ptr CDouble -> Ptr (Ptr CChar) -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgcoeflist" c_CPXchgcoeflist ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CInt -> Ptr CInt -> Ptr CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgcoef" c_CPXchgcoef ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> CInt -> CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgrhs" c_CPXchgrhs ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CInt -> Ptr CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgobj" c_CPXchgobj ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CInt -> Ptr CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgbds" c_CPXchgbds ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CInt -> Ptr CChar -> Ptr CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXchgrngval" c_CPXchgrngval ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> Ptr CInt -> Ptr CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXgeterrorstring" c_CPXgeterrorstring ::
  Ptr CpxEnv' -> CInt -> Ptr CChar -> IO (Ptr CChar)

foreign import ccall unsafe "cplex.h CPXgetstatstring" c_CPXgetstatstring ::
  Ptr CpxEnv' -> CInt -> Ptr CChar -> IO (Ptr CChar)

foreign import ccall unsafe "cplex.h CPXsetintparam" c_CPXsetintparam ::
  Ptr CpxEnv' -> CInt -> CInt -> IO CInt

foreign import ccall unsafe "cplex.h CPXsetdblparam" c_CPXsetdblparam ::
  Ptr CpxEnv' -> CInt -> CDouble -> IO CInt

foreign import ccall unsafe "cplex.h CPXgetnumcols" c_CPXgetnumcols ::
  Ptr CpxEnv' -> Ptr CpxLp' -> IO CInt

foreign import ccall unsafe "cplex.h CPXgetnumrows" c_CPXgetnumrows ::
  Ptr CpxEnv' -> Ptr CpxLp' -> IO CInt

foreign import ccall unsafe "cplex.h CPXcopylp" c_CPXcopylp ::
  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> -- (CPXCENVptr env, CpxLp'ptr lp, int numcols,
  CInt -> CInt -> Ptr CDouble ->     --  int numrows, int objsense, const double *objective,
  Ptr CDouble -> Ptr CChar ->        --  const double *rhs, const char *sense,
  Ptr CInt -> Ptr CInt ->            --  const int *matbeg, const int *matcnt,
  Ptr CInt -> Ptr CDouble ->         --  const int *matind, const double *matval,
  Ptr CDouble -> Ptr CDouble ->      --  const double *lb, const double *ub,
  Ptr CDouble                        --  const double *rngval);
  -> IO CInt

--foreign import ccall unsafe "cplexcheck.h CPXcheckcopylp" c_CPXcheckcopylp ::
--                                         "CPXcheckcopylp"
--  Ptr CpxEnv' -> Ptr CpxLp' -> CInt -> -- (CPXCENVptr env, CpxLp'ptr lp, int numcols,
--  CInt -> CInt -> Ptr CDouble ->     --  int numrows, int objsense, const double *objective,
--  Ptr CDouble -> Ptr CChar ->        --  const double *rhs, const char *sense,
--  Ptr CInt -> Ptr CInt ->            --  const int *matbeg, const int *matcnt,
--  Ptr CInt -> Ptr CDouble ->         --  const int *matind, const double *matval,
--  Ptr CDouble -> Ptr CDouble ->      --  const double *lb, const double *ub,
--  Ptr CDouble                        --  const double *rngval);
--  -> IO CInt


foreign import ccall unsafe "cplex.h CPXcopyquad" c_CPXcopyquad ::
  Ptr CpxEnv' -> Ptr CpxLp' -> Ptr CInt -> -- (CPXCENVptr env, CpxLp'ptr lp, const int *qmatbeg,
  Ptr CInt -> Ptr CInt ->                --  const int *qmatcnt, const int *qmatind,
  Ptr CDouble ->                         --  const double *qmatval);
  IO CInt

--foreign import ccall unsafe "cplexcheck.h CPXcheckcopyquad" c_CPXcheckcopyquad ::
--  Ptr CpxEnv' -> Ptr CpxLp' -> Ptr CInt -> -- (CPXCENVptr env, CpxLp'ptr lp, const int *qmatbeg,
--  Ptr CInt -> Ptr CInt ->                --  const int *qmatcnt, const int *qmatind,
--  Ptr CDouble ->                         --  const double *qmatval);
--  IO CInt

foreign import ccall unsafe "cplex.h CPXqpopt" c_CPXqpopt ::
  Ptr CpxEnv' -> Ptr CpxLp' -> IO CInt

foreign import ccall unsafe "cplex.h CPXsolution" c_CPXsolution ::
  Ptr CpxEnv' -> Ptr CpxLp' -> Ptr CInt ->       -- (CPXCENVptr env, CPXCLPptr lp, int *lpstat_p,
  Ptr CDouble -> Ptr CDouble -> Ptr CDouble -> --  double *objval_p, double *x, double *pi,
  Ptr CDouble -> Ptr CDouble -> IO CInt        --  double *slack, double *dj);
