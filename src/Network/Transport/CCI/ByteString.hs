-- |ByteString.hs
--
-- Copyright (C) 2012 Parallel Scientific, Inc
-- Please see the accompanying LICENSE file or contact Parallel Scientific, Inc for licensing details.
--
-- A temporary module containing unsafePackMallocCStringLen until such a time as that function
-- becomes available in Data.ByteString.Unsafe
-- This code shamelessly ripped off from Lauri Alanko's message proposing this addition.
module Network.Transport.CCI.ByteString 
  (unsafePackMallocCStringLen) where

import Data.ByteString.Internal
import Foreign.C.String (CStringLen)
import Foreign.ForeignPtr (newForeignPtr)
import Foreign.Ptr (castPtr)

unsafePackMallocCStringLen :: CStringLen -> IO ByteString
unsafePackMallocCStringLen (cstr, len) = do
    fp <- newForeignPtr c_free_finalizer (castPtr cstr)
    return $! PS fp 0 len

	