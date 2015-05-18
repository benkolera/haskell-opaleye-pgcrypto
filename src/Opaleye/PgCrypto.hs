{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Opaleye.PgCrypto where

import           Opaleye                              (Column)
import qualified Opaleye.Internal.Column              as C
import qualified Opaleye.Internal.HaskellDB.PrimQuery as HPQ
import           Opaleye.PGTypes                      (PGInt4, PGText,
                                                       pgStrictText)

genSalt :: Column PGText -> Column PGInt4 -> Column PGText
genSalt m l = C.Column (HPQ.FunExpr "gen_salt" [C.unColumn m,C.unColumn l])

genSaltBf8 :: Column PGText
genSaltBf8 = genSalt (pgStrictText "bf") 8

crypt :: Column PGText -> Column PGText -> Column PGText
crypt p s = C.Column (HPQ.FunExpr "crypt" [C.unColumn p,C.unColumn s])
