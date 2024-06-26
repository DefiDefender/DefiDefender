pragma solidity ^0.5.9;

pragma experimental ABIEncoderV2;



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



contract IERC20Token {



    // solhint-disable no-simple-event-func-name

    event Transfer(

        address indexed _from,

        address indexed _to,

        uint256 _value

    );



    event Approval(

        address indexed _owner,

        address indexed _spender,

        uint256 _value

    );



    /// @dev send `value` token to `to` from `msg.sender`

    /// @param _to The address of the recipient

    /// @param _value The amount of token to be transferred

    /// @return True if transfer was successful

    function transfer(address _to, uint256 _value)

        external

        returns (bool);



    /// @dev send `value` token to `to` from `from` on the condition it is approved by `from`

    /// @param _from The address of the sender

    /// @param _to The address of the recipient

    /// @param _value The amount of token to be transferred

    /// @return True if transfer was successful

    function transferFrom(

        address _from,

        address _to,

        uint256 _value

    )

        external

        returns (bool);



    /// @dev `msg.sender` approves `_spender` to spend `_value` tokens

    /// @param _spender The address of the account able to transfer the tokens

    /// @param _value The amount of wei to be approved for transfer

    /// @return Always true if the call has enough gas to complete execution

    function approve(address _spender, uint256 _value)

        external

        returns (bool);



    /// @dev Query total supply of token

    /// @return Total supply of token

    function totalSupply()

        external

        view

        returns (uint256);



    /// @param _owner The address from which the balance will be retrieved

    /// @return Balance of owner

    function balanceOf(address _owner)

        external

        view

        returns (uint256);



    /// @param _owner The address of the account owning tokens

    /// @param _spender The address of the account able to transfer the tokens

    /// @return Amount of remaining tokens allowed to spent

    function allowance(address _owner, address _spender)

        external

        view

        returns (uint256);

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



contract IEtherToken is

    IERC20Token

{

    function deposit()

        public

        payable;



    function withdraw(uint256 amount)

        public;

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



library LibRichErrors {



    // bytes4(keccak256("Error(string)"))

    bytes4 internal constant STANDARD_ERROR_SELECTOR =

        0x08c379a0;



    // solhint-disable func-name-mixedcase

    /// @dev ABI encode a standard, string revert error payload.

    ///      This is the same payload that would be included by a `revert(string)`

    ///      solidity statement. It has the function signature `Error(string)`.

    /// @param message The error string.

    /// @return The ABI encoded error.

    function StandardError(

        string memory message

    )

        internal

        pure

        returns (bytes memory)

    {

        return abi.encodeWithSelector(

            STANDARD_ERROR_SELECTOR,

            bytes(message)

        );

    }

    // solhint-enable func-name-mixedcase



    /// @dev Reverts an encoded rich revert reason `errorData`.

    /// @param errorData ABI encoded error data.

    function rrevert(bytes memory errorData)

        internal

        pure

    {

        assembly {

            revert(add(errorData, 0x20), mload(errorData))

        }

    }

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



library LibBytesRichErrors {



    enum InvalidByteOperationErrorCodes {

        FromLessThanOrEqualsToRequired,

        ToLessThanOrEqualsLengthRequired,

        LengthGreaterThanZeroRequired,

        LengthGreaterThanOrEqualsFourRequired,

        LengthGreaterThanOrEqualsTwentyRequired,

        LengthGreaterThanOrEqualsThirtyTwoRequired,

        LengthGreaterThanOrEqualsNestedBytesLengthRequired,

        DestinationLengthGreaterThanOrEqualSourceLengthRequired

    }



    // bytes4(keccak256("InvalidByteOperationError(uint8,uint256,uint256)"))

    bytes4 internal constant INVALID_BYTE_OPERATION_ERROR_SELECTOR =

        0x28006595;



    // solhint-disable func-name-mixedcase

    function InvalidByteOperationError(

        InvalidByteOperationErrorCodes errorCode,

        uint256 offset,

        uint256 required

    )

        internal

        pure

        returns (bytes memory)

    {

        return abi.encodeWithSelector(

            INVALID_BYTE_OPERATION_ERROR_SELECTOR,

            errorCode,

            offset,

            required

        );

    }

}



library LibBytes {



    using LibBytes for bytes;



    /// @dev Gets the memory address for a byte array.

    /// @param input Byte array to lookup.

    /// @return memoryAddress Memory address of byte array. This

    ///         points to the header of the byte array which contains

    ///         the length.

    function rawAddress(bytes memory input)

        internal

        pure

        returns (uint256 memoryAddress)

    {

        assembly {

            memoryAddress := input

        }

        return memoryAddress;

    }



    /// @dev Gets the memory address for the contents of a byte array.

    /// @param input Byte array to lookup.

    /// @return memoryAddress Memory address of the contents of the byte array.

    function contentAddress(bytes memory input)

        internal

        pure

        returns (uint256 memoryAddress)

    {

        assembly {

            memoryAddress := add(input, 32)

        }

        return memoryAddress;

    }



    /// @dev Copies `length` bytes from memory location `source` to `dest`.

    /// @param dest memory address to copy bytes to.

    /// @param source memory address to copy bytes from.

    /// @param length number of bytes to copy.

    function memCopy(

        uint256 dest,

        uint256 source,

        uint256 length

    )

        internal

        pure

    {

        if (length < 32) {

            // Handle a partial word by reading destination and masking

            // off the bits we are interested in.

            // This correctly handles overlap, zero lengths and source == dest

            assembly {

                let mask := sub(exp(256, sub(32, length)), 1)

                let s := and(mload(source), not(mask))

                let d := and(mload(dest), mask)

                mstore(dest, or(s, d))

            }

        } else {

            // Skip the O(length) loop when source == dest.

            if (source == dest) {

                return;

            }



            // For large copies we copy whole words at a time. The final

            // word is aligned to the end of the range (instead of after the

            // previous) to handle partial words. So a copy will look like this:

            //

            //  ####

            //      ####

            //          ####

            //            ####

            //

            // We handle overlap in the source and destination range by

            // changing the copying direction. This prevents us from

            // overwriting parts of source that we still need to copy.

            //

            // This correctly handles source == dest

            //

            if (source > dest) {

                assembly {

                    // We subtract 32 from `sEnd` and `dEnd` because it

                    // is easier to compare with in the loop, and these

                    // are also the addresses we need for copying the

                    // last bytes.

                    length := sub(length, 32)

                    let sEnd := add(source, length)

                    let dEnd := add(dest, length)



                    // Remember the last 32 bytes of source

                    // This needs to be done here and not after the loop

                    // because we may have overwritten the last bytes in

                    // source already due to overlap.

                    let last := mload(sEnd)



                    // Copy whole words front to back

                    // Note: the first check is always true,

                    // this could have been a do-while loop.

                    // solhint-disable-next-line no-empty-blocks

                    for {} lt(source, sEnd) {} {

                        mstore(dest, mload(source))

                        source := add(source, 32)

                        dest := add(dest, 32)

                    }



                    // Write the last 32 bytes

                    mstore(dEnd, last)

                }

            } else {

                assembly {

                    // We subtract 32 from `sEnd` and `dEnd` because those

                    // are the starting points when copying a word at the end.

                    length := sub(length, 32)

                    let sEnd := add(source, length)

                    let dEnd := add(dest, length)



                    // Remember the first 32 bytes of source

                    // This needs to be done here and not after the loop

                    // because we may have overwritten the first bytes in

                    // source already due to overlap.

                    let first := mload(source)



                    // Copy whole words back to front

                    // We use a signed comparisson here to allow dEnd to become

                    // negative (happens when source and dest < 32). Valid

                    // addresses in local memory will never be larger than

                    // 2**255, so they can be safely re-interpreted as signed.

                    // Note: the first check is always true,

                    // this could have been a do-while loop.

                    // solhint-disable-next-line no-empty-blocks

                    for {} slt(dest, dEnd) {} {

                        mstore(dEnd, mload(sEnd))

                        sEnd := sub(sEnd, 32)

                        dEnd := sub(dEnd, 32)

                    }



                    // Write the first 32 bytes

                    mstore(dest, first)

                }

            }

        }

    }



    /// @dev Returns a slices from a byte array.

    /// @param b The byte array to take a slice from.

    /// @param from The starting index for the slice (inclusive).

    /// @param to The final index for the slice (exclusive).

    /// @return result The slice containing bytes at indices [from, to)

    function slice(

        bytes memory b,

        uint256 from,

        uint256 to

    )

        internal

        pure

        returns (bytes memory result)

    {

        // Ensure that the from and to positions are valid positions for a slice within

        // the byte array that is being used.

        if (from > to) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.FromLessThanOrEqualsToRequired,

                from,

                to

            ));

        }

        if (to > b.length) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.ToLessThanOrEqualsLengthRequired,

                to,

                b.length

            ));

        }



        // Create a new bytes structure and copy contents

        result = new bytes(to - from);

        memCopy(

            result.contentAddress(),

            b.contentAddress() + from,

            result.length

        );

        return result;

    }



    /// @dev Returns a slice from a byte array without preserving the input.

    /// @param b The byte array to take a slice from. Will be destroyed in the process.

    /// @param from The starting index for the slice (inclusive).

    /// @param to The final index for the slice (exclusive).

    /// @return result The slice containing bytes at indices [from, to)

    /// @dev When `from == 0`, the original array will match the slice. In other cases its state will be corrupted.

    function sliceDestructive(

        bytes memory b,

        uint256 from,

        uint256 to

    )

        internal

        pure

        returns (bytes memory result)

    {

        // Ensure that the from and to positions are valid positions for a slice within

        // the byte array that is being used.

        if (from > to) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.FromLessThanOrEqualsToRequired,

                from,

                to

            ));

        }

        if (to > b.length) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.ToLessThanOrEqualsLengthRequired,

                to,

                b.length

            ));

        }



        // Create a new bytes structure around [from, to) in-place.

        assembly {

            result := add(b, from)

            mstore(result, sub(to, from))

        }

        return result;

    }



    /// @dev Pops the last byte off of a byte array by modifying its length.

    /// @param b Byte array that will be modified.

    /// @return The byte that was popped off.

    function popLastByte(bytes memory b)

        internal

        pure

        returns (bytes1 result)

    {

        if (b.length == 0) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanZeroRequired,

                b.length,

                0

            ));

        }



        // Store last byte.

        result = b[b.length - 1];



        assembly {

            // Decrement length of byte array.

            let newLen := sub(mload(b), 1)

            mstore(b, newLen)

        }

        return result;

    }



    /// @dev Tests equality of two byte arrays.

    /// @param lhs First byte array to compare.

    /// @param rhs Second byte array to compare.

    /// @return True if arrays are the same. False otherwise.

    function equals(

        bytes memory lhs,

        bytes memory rhs

    )

        internal

        pure

        returns (bool equal)

    {

        // Keccak gas cost is 30 + numWords * 6. This is a cheap way to compare.

        // We early exit on unequal lengths, but keccak would also correctly

        // handle this.

        return lhs.length == rhs.length && keccak256(lhs) == keccak256(rhs);

    }



    /// @dev Reads an address from a position in a byte array.

    /// @param b Byte array containing an address.

    /// @param index Index in byte array of address.

    /// @return address from byte array.

    function readAddress(

        bytes memory b,

        uint256 index

    )

        internal

        pure

        returns (address result)

    {

        if (b.length < index + 20) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanOrEqualsTwentyRequired,

                b.length,

                index + 20 // 20 is length of address

            ));

        }



        // Add offset to index:

        // 1. Arrays are prefixed by 32-byte length parameter (add 32 to index)

        // 2. Account for size difference between address length and 32-byte storage word (subtract 12 from index)

        index += 20;



        // Read address from array memory

        assembly {

            // 1. Add index to address of bytes array

            // 2. Load 32-byte word from memory

            // 3. Apply 20-byte mask to obtain address

            result := and(mload(add(b, index)), 0xffffffffffffffffffffffffffffffffffffffff)

        }

        return result;

    }



    /// @dev Writes an address into a specific position in a byte array.

    /// @param b Byte array to insert address into.

    /// @param index Index in byte array of address.

    /// @param input Address to put into byte array.

    function writeAddress(

        bytes memory b,

        uint256 index,

        address input

    )

        internal

        pure

    {

        if (b.length < index + 20) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanOrEqualsTwentyRequired,

                b.length,

                index + 20 // 20 is length of address

            ));

        }



        // Add offset to index:

        // 1. Arrays are prefixed by 32-byte length parameter (add 32 to index)

        // 2. Account for size difference between address length and 32-byte storage word (subtract 12 from index)

        index += 20;



        // Store address into array memory

        assembly {

            // The address occupies 20 bytes and mstore stores 32 bytes.

            // First fetch the 32-byte word where we'll be storing the address, then

            // apply a mask so we have only the bytes in the word that the address will not occupy.

            // Then combine these bytes with the address and store the 32 bytes back to memory with mstore.



            // 1. Add index to address of bytes array

            // 2. Load 32-byte word from memory

            // 3. Apply 12-byte mask to obtain extra bytes occupying word of memory where we'll store the address

            let neighbors := and(

                mload(add(b, index)),

                0xffffffffffffffffffffffff0000000000000000000000000000000000000000

            )



            // Make sure input address is clean.

            // (Solidity does not guarantee this)

            input := and(input, 0xffffffffffffffffffffffffffffffffffffffff)



            // Store the neighbors and address into memory

            mstore(add(b, index), xor(input, neighbors))

        }

    }



    /// @dev Reads a bytes32 value from a position in a byte array.

    /// @param b Byte array containing a bytes32 value.

    /// @param index Index in byte array of bytes32 value.

    /// @return bytes32 value from byte array.

    function readBytes32(

        bytes memory b,

        uint256 index

    )

        internal

        pure

        returns (bytes32 result)

    {

        if (b.length < index + 32) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanOrEqualsThirtyTwoRequired,

                b.length,

                index + 32

            ));

        }



        // Arrays are prefixed by a 256 bit length parameter

        index += 32;



        // Read the bytes32 from array memory

        assembly {

            result := mload(add(b, index))

        }

        return result;

    }



    /// @dev Writes a bytes32 into a specific position in a byte array.

    /// @param b Byte array to insert <input> into.

    /// @param index Index in byte array of <input>.

    /// @param input bytes32 to put into byte array.

    function writeBytes32(

        bytes memory b,

        uint256 index,

        bytes32 input

    )

        internal

        pure

    {

        if (b.length < index + 32) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanOrEqualsThirtyTwoRequired,

                b.length,

                index + 32

            ));

        }



        // Arrays are prefixed by a 256 bit length parameter

        index += 32;



        // Read the bytes32 from array memory

        assembly {

            mstore(add(b, index), input)

        }

    }



    /// @dev Reads a uint256 value from a position in a byte array.

    /// @param b Byte array containing a uint256 value.

    /// @param index Index in byte array of uint256 value.

    /// @return uint256 value from byte array.

    function readUint256(

        bytes memory b,

        uint256 index

    )

        internal

        pure

        returns (uint256 result)

    {

        result = uint256(readBytes32(b, index));

        return result;

    }



    /// @dev Writes a uint256 into a specific position in a byte array.

    /// @param b Byte array to insert <input> into.

    /// @param index Index in byte array of <input>.

    /// @param input uint256 to put into byte array.

    function writeUint256(

        bytes memory b,

        uint256 index,

        uint256 input

    )

        internal

        pure

    {

        writeBytes32(b, index, bytes32(input));

    }



    /// @dev Reads an unpadded bytes4 value from a position in a byte array.

    /// @param b Byte array containing a bytes4 value.

    /// @param index Index in byte array of bytes4 value.

    /// @return bytes4 value from byte array.

    function readBytes4(

        bytes memory b,

        uint256 index

    )

        internal

        pure

        returns (bytes4 result)

    {

        if (b.length < index + 4) {

            LibRichErrors.rrevert(LibBytesRichErrors.InvalidByteOperationError(

                LibBytesRichErrors.InvalidByteOperationErrorCodes.LengthGreaterThanOrEqualsFourRequired,

                b.length,

                index + 4

            ));

        }



        // Arrays are prefixed by a 32 byte length field

        index += 32;



        // Read the bytes4 from array memory

        assembly {

            result := mload(add(b, index))

            // Solidity does not require us to clean the trailing bytes.

            // We do it anyway

            result := and(result, 0xFFFFFFFF00000000000000000000000000000000000000000000000000000000)

        }

        return result;

    }



    /// @dev Writes a new length to a byte array.

    ///      Decreasing length will lead to removing the corresponding lower order bytes from the byte array.

    ///      Increasing length may lead to appending adjacent in-memory bytes to the end of the byte array.

    /// @param b Bytes array to write new length to.

    /// @param length New length of byte array.

    function writeLength(bytes memory b, uint256 length)

        internal

        pure

    {

        assembly {

            mstore(b, length)

        }

    }

}



library LibERC20Token {

    bytes constant private DECIMALS_CALL_DATA = hex"313ce567";



    /// @dev Calls `IERC20Token(token).approve()`.

    ///      Reverts if `false` is returned or if the return

    ///      data length is nonzero and not 32 bytes.

    /// @param token The address of the token contract.

    /// @param spender The address that receives an allowance.

    /// @param allowance The allowance to set.

    function approve(

        address token,

        address spender,

        uint256 allowance

    )

        internal

    {

        bytes memory callData = abi.encodeWithSelector(

            IERC20Token(0).approve.selector,

            spender,

            allowance

        );

        _callWithOptionalBooleanResult(token, callData);

    }



    /// @dev Calls `IERC20Token(token).transfer()`.

    ///      Reverts if `false` is returned or if the return

    ///      data length is nonzero and not 32 bytes.

    /// @param token The address of the token contract.

    /// @param to The address that receives the tokens

    /// @param amount Number of tokens to transfer.

    function transfer(

        address token,

        address to,

        uint256 amount

    )

        internal

    {

        bytes memory callData = abi.encodeWithSelector(

            IERC20Token(0).transfer.selector,

            to,

            amount

        );

        _callWithOptionalBooleanResult(token, callData);

    }



    /// @dev Calls `IERC20Token(token).transferFrom()`.

    ///      Reverts if `false` is returned or if the return

    ///      data length is nonzero and not 32 bytes.

    /// @param token The address of the token contract.

    /// @param from The owner of the tokens.

    /// @param to The address that receives the tokens

    /// @param amount Number of tokens to transfer.

    function transferFrom(

        address token,

        address from,

        address to,

        uint256 amount

    )

        internal

    {

        bytes memory callData = abi.encodeWithSelector(

            IERC20Token(0).transferFrom.selector,

            from,

            to,

            amount

        );

        _callWithOptionalBooleanResult(token, callData);

    }



    /// @dev Retrieves the number of decimals for a token.

    ///      Returns `18` if the call reverts.

    /// @return The number of decimals places for the token.

    function decimals(address token)

        internal

        view

        returns (uint8 tokenDecimals)

    {

        tokenDecimals = 18;

        (bool didSucceed, bytes memory resultData) = token.staticcall(DECIMALS_CALL_DATA);

        if (didSucceed && resultData.length == 32) {

            tokenDecimals = uint8(LibBytes.readUint256(resultData, 0));

        }

    }



    /// @dev Executes a call on address `target` with calldata `callData`

    ///      and asserts that either nothing was returned or a single boolean

    ///      was returned equal to `true`.

    /// @param target The call target.

    /// @param callData The abi-encoded call data.

    function _callWithOptionalBooleanResult(

        address target,

        bytes memory callData

    )

        private

    {

        (bool didSucceed, bytes memory resultData) = target.call(callData);

        if (didSucceed) {

            if (resultData.length == 0) {

                return;

            }

            if (resultData.length == 32) {

                uint256 result = LibBytes.readUint256(resultData, 0);

                if (result == 1) {

                    return;

                }

            }

        }

        LibRichErrors.rrevert(resultData);

    }

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



contract IWallet {



    bytes4 internal constant LEGACY_WALLET_MAGIC_VALUE = 0xb0671381;



    /// @dev Validates a hash with the `Wallet` signature type.

    /// @param hash Message hash that is signed.

    /// @param signature Proof of signing.

    /// @return magicValue `bytes4(0xb0671381)` if the signature check succeeds.

    function isValidSignature(

        bytes32 hash,

        bytes calldata signature

    )

        external

        view

        returns (bytes4 magicValue);

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



contract IOwnable {



    /// @dev Emitted by Ownable when ownership is transferred.

    /// @param previousOwner The previous owner of the contract.

    /// @param newOwner The new owner of the contract.

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    /// @dev Transfers ownership of the contract to a new address.

    /// @param newOwner The address that will become the owner.

    function transferOwnership(address newOwner)

        public;

}



library LibOwnableRichErrors {



    // bytes4(keccak256("OnlyOwnerError(address,address)"))

    bytes4 internal constant ONLY_OWNER_ERROR_SELECTOR =

        0x1de45ad1;



    // bytes4(keccak256("TransferOwnerToZeroError()"))

    bytes internal constant TRANSFER_OWNER_TO_ZERO_ERROR_BYTES =

        hex"e69edc3e";



    // solhint-disable func-name-mixedcase

    function OnlyOwnerError(

        address sender,

        address owner

    )

        internal

        pure

        returns (bytes memory)

    {

        return abi.encodeWithSelector(

            ONLY_OWNER_ERROR_SELECTOR,

            sender,

            owner

        );

    }



    function TransferOwnerToZeroError()

        internal

        pure

        returns (bytes memory)

    {

        return TRANSFER_OWNER_TO_ZERO_ERROR_BYTES;

    }

}



contract DeploymentConstants {

    /// @dev Mainnet address of the WETH contract.

    address constant private WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    // /// @dev Kovan address of the WETH contract.

    // address constant private WETH_ADDRESS = 0xd0A1E359811322d97991E03f863a0C30C2cF029C;

    /// @dev Mainnet address of the KyberNeworkProxy contract.

    address constant private KYBER_NETWORK_PROXY_ADDRESS = 0x818E6FECD516Ecc3849DAf6845e3EC868087B755;

    /// @dev Mainnet address of the `UniswapExchangeFactory` contract.

    address constant private UNISWAP_EXCHANGE_FACTORY_ADDRESS = 0xc0a47dFe034B400B47bDaD5FecDa2621de6c4d95;

    /// @dev Mainnet address of the Eth2Dai `MatchingMarket` contract.

    address constant private ETH2DAI_ADDRESS = 0x39755357759cE0d7f32dC8dC45414CCa409AE24e;

    /// @dev Mainnet address of the `ERC20BridgeProxy` contract

    address constant private ERC20_BRIDGE_PROXY_ADDRESS = 0x8ED95d1746bf1E4dAb58d8ED4724f1Ef95B20Db0;

    // /// @dev Kovan address of the `ERC20BridgeProxy` contract

    // address constant private ERC20_BRIDGE_PROXY_ADDRESS = 0xFb2DD2A1366dE37f7241C83d47DA58fd503E2C64;

    ///@dev Mainnet address of the `Dai` (multi-collateral) contract

    address constant private DAI_ADDRESS = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    /// @dev Mainnet address of the `Chai` contract

    address constant private CHAI_ADDRESS = 0x06AF07097C9Eeb7fD685c692751D5C66dB49c215;

    /// @dev Mainnet address of the 0x DevUtils contract.

    address constant private DEV_UTILS_ADDRESS = 0xcCc2431a7335F21d9268bA62F0B32B0f2EFC463f;

    // /// @dev Kovan address of the 0x DevUtils contract.

    // address constant private DEV_UTILS_ADDRESS = 0x56A8Da16fd8a65768c97913402212EAB60531BaE;

    /// @dev Kyber ETH pseudo-address.

    address constant internal KYBER_ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    /// @dev Mainnet address of the dYdX contract.

    address constant private DYDX_ADDRESS = 0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e;



    /// @dev Overridable way to get the `KyberNetworkProxy` address.

    /// @return kyberAddress The `IKyberNetworkProxy` address.

    function _getKyberNetworkProxyAddress()

        internal

        view

        returns (address kyberAddress)

    {

        return KYBER_NETWORK_PROXY_ADDRESS;

    }



    /// @dev Overridable way to get the WETH address.

    /// @return wethAddress The WETH address.

    function _getWethAddress()

        internal

        view

        returns (address wethAddress)

    {

        return WETH_ADDRESS;

    }



    /// @dev Overridable way to get the `UniswapExchangeFactory` address.

    /// @return uniswapAddress The `UniswapExchangeFactory` address.

    function _getUniswapExchangeFactoryAddress()

        internal

        view

        returns (address uniswapAddress)

    {

        return UNISWAP_EXCHANGE_FACTORY_ADDRESS;

    }



    /// @dev An overridable way to retrieve the Eth2Dai `MatchingMarket` contract.

    /// @return eth2daiAddress The Eth2Dai `MatchingMarket` contract.

    function _getEth2DaiAddress()

        internal

        view

        returns (address eth2daiAddress)

    {

        return ETH2DAI_ADDRESS;

    }



    /// @dev An overridable way to retrieve the `ERC20BridgeProxy` contract.

    /// @return erc20BridgeProxyAddress The `ERC20BridgeProxy` contract.

    function _getERC20BridgeProxyAddress()

        internal

        view

        returns (address erc20BridgeProxyAddress)

    {

        return ERC20_BRIDGE_PROXY_ADDRESS;

    }



    /// @dev An overridable way to retrieve the `Dai` contract.

    /// @return daiAddress The `Dai` contract.

    function _getDaiAddress()

        internal

        view

        returns (address daiAddress)

    {

        return DAI_ADDRESS;

    }



    /// @dev An overridable way to retrieve the `Chai` contract.

    /// @return chaiAddress The `Chai` contract.

    function _getChaiAddress()

        internal

        view

        returns (address chaiAddress)

    {

        return CHAI_ADDRESS;

    }



    /// @dev An overridable way to retrieve the 0x `DevUtils` contract address.

    /// @return devUtils The 0x `DevUtils` contract address.

    function _getDevUtilsAddress()

        internal

        view

        returns (address devUtils)

    {

        return DEV_UTILS_ADDRESS;

    }



    /// @dev Overridable way to get the DyDx contract.

    /// @return exchange The DyDx exchange contract.

    function _getDydxAddress()

        internal

        view

        returns (address dydxAddress)

    {

        return DYDX_ADDRESS;

    }

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



interface IUniswapExchange {



    /// @dev Buys at least `minTokensBought` tokens with ETH and transfer them

    ///      to `recipient`.

    /// @param minTokensBought The minimum number of tokens to buy.

    /// @param deadline Time when this order expires.

    /// @param recipient Who to transfer the tokens to.

    /// @return tokensBought Amount of tokens bought.

    function ethToTokenTransferInput(

        uint256 minTokensBought,

        uint256 deadline,

        address recipient

    )

        external

        payable

        returns (uint256 tokensBought);



    /// @dev Buys at least `minEthBought` ETH with tokens.

    /// @param tokensSold Amount of tokens to sell.

    /// @param minEthBought The minimum amount of ETH to buy.

    /// @param deadline Time when this order expires.

    /// @return ethBought Amount of tokens bought.

    function tokenToEthSwapInput(

        uint256 tokensSold,

        uint256 minEthBought,

        uint256 deadline

    )

        external

        returns (uint256 ethBought);



    /// @dev Buys at least `minTokensBought` tokens with the exchange token

    ///      and transfer them to `recipient`.

    /// @param minTokensBought The minimum number of tokens to buy.

    /// @param minEthBought The minimum amount of intermediate ETH to buy.

    /// @param deadline Time when this order expires.

    /// @param recipient Who to transfer the tokens to.

    /// @param toTokenAddress The token being bought.

    /// @return tokensBought Amount of tokens bought.

    function tokenToTokenTransferInput(

        uint256 tokensSold,

        uint256 minTokensBought,

        uint256 minEthBought,

        uint256 deadline,

        address recipient,

        address toTokenAddress

    )

        external

        returns (uint256 tokensBought);

}



interface IUniswapExchangeFactory {



    /// @dev Get the exchange for a token.

    /// @param tokenAddress The address of the token contract.

    function getExchange(address tokenAddress)

        external

        view

        returns (address);

}



/*



  Copyright 2019 ZeroEx Intl.



  Licensed under the Apache License, Version 2.0 (the "License");

  you may not use this file except in compliance with the License.

  You may obtain a copy of the License at



    http://www.apache.org/licenses/LICENSE-2.0



  Unless required by applicable law or agreed to in writing, software

  distributed under the License is distributed on an "AS IS" BASIS,

  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

  See the License for the specific language governing permissions and

  limitations under the License.



*/



contract IERC20Bridge {



    // @dev Result of a successful bridge call.

    bytes4 constant internal BRIDGE_SUCCESS = 0xdc1600f3;



    /// @dev Transfers `amount` of the ERC20 `tokenAddress` from `from` to `to`.

    /// @param tokenAddress The address of the ERC20 token to transfer.

    /// @param from Address to transfer asset from.

    /// @param to Address to transfer asset to.

    /// @param amount Amount of asset to transfer.

    /// @param bridgeData Arbitrary asset data needed by the bridge contract.

    /// @return success The magic bytes `0x37708e9b` if successful.

    function bridgeTransferFrom(

        address tokenAddress,

        address from,

        address to,

        uint256 amount,

        bytes calldata bridgeData

    )

        external

        returns (bytes4 success);

}



// solhint-disable space-after-comma

// solhint-disable not-rely-on-time

contract UniswapBridge is

    IERC20Bridge,

    IWallet,

    DeploymentConstants

{

    // Struct to hold `bridgeTransferFrom()` local variables in memory and to avoid

    // stack overflows.

    struct WithdrawToState {

        IUniswapExchange exchange;

        uint256 fromTokenBalance;

        IEtherToken weth;

    }



    // solhint-disable no-empty-blocks

    /// @dev Payable fallback to receive ETH from uniswap.

    function ()

        external

        payable

    {}



    /// @dev Callback for `IERC20Bridge`. Tries to buy `amount` of

    ///      `toTokenAddress` tokens by selling the entirety of the `fromTokenAddress`

    ///      token encoded in the bridge data.

    /// @param toTokenAddress The token to buy and transfer to `to`.

    /// @param to The recipient of the bought tokens.

    /// @param amount Minimum amount of `toTokenAddress` tokens to buy.

    /// @param bridgeData The abi-encoded "from" token address.

    /// @return success The magic bytes if successful.

    function bridgeTransferFrom(

        address toTokenAddress,

        address /* from */,

        address to,

        uint256 amount,

        bytes calldata bridgeData

    )

        external

        returns (bytes4 success)

    {

        // State memory object to avoid stack overflows.

        WithdrawToState memory state;

        // Decode the bridge data to get the `fromTokenAddress`.

        (address fromTokenAddress) = abi.decode(bridgeData, (address));



        // Just transfer the tokens if they're the same.

        if (fromTokenAddress == toTokenAddress) {

            LibERC20Token.transfer(fromTokenAddress, to, amount);

            return BRIDGE_SUCCESS;

        }



        // Get the exchange for the token pair.

        state.exchange = _getUniswapExchangeForTokenPair(

            fromTokenAddress,

            toTokenAddress

        );

        // Get our balance of `fromTokenAddress` token.

        state.fromTokenBalance = IERC20Token(fromTokenAddress).balanceOf(address(this));

        // Get the weth contract.

        state.weth = IEtherToken(_getWethAddress());



        // Convert from WETH to a token.

        if (fromTokenAddress == address(state.weth)) {

            // Unwrap the WETH.

            state.weth.withdraw(state.fromTokenBalance);

            // Buy as much of `toTokenAddress` token with ETH as possible and

            // transfer it to `to`.

            state.exchange.ethToTokenTransferInput.value(state.fromTokenBalance)(

                // Minimum buy amount.

                amount,

                // Expires after this block.

                block.timestamp,

                // Recipient is `to`.

                to

            );



        // Convert from a token to WETH.

        } else if (toTokenAddress == address(state.weth)) {

            // Grant the exchange an allowance.

            _grantExchangeAllowance(state.exchange, fromTokenAddress);

            // Buy as much ETH with `fromTokenAddress` token as possible.

            uint256 ethBought = state.exchange.tokenToEthSwapInput(

                // Sell all tokens we hold.

                state.fromTokenBalance,

                // Minimum buy amount.

                amount,

                // Expires after this block.

                block.timestamp

            );

            // Wrap the ETH.

            state.weth.deposit.value(ethBought)();

            // Transfer the WETH to `to`.

            IEtherToken(toTokenAddress).transfer(to, ethBought);



        // Convert from one token to another.

        } else {

            // Grant the exchange an allowance.

            _grantExchangeAllowance(state.exchange, fromTokenAddress);

            // Buy as much `toTokenAddress` token with `fromTokenAddress` token

            // and transfer it to `to`.

            state.exchange.tokenToTokenTransferInput(

                // Sell all tokens we hold.

                state.fromTokenBalance,

                // Minimum buy amount.

                amount,

                // Must buy at least 1 intermediate ETH.

                1,

                // Expires after this block.

                block.timestamp,

                // Recipient is `to`.

                to,

                // Convert to `toTokenAddress`.

                toTokenAddress

            );

        }

        return BRIDGE_SUCCESS;

    }



    /// @dev `SignatureType.Wallet` callback, so that this bridge can be the maker

    ///      and sign for itself in orders. Always succeeds.

    /// @return magicValue Success bytes, always.

    function isValidSignature(

        bytes32,

        bytes calldata

    )

        external

        view

        returns (bytes4 magicValue)

    {

        return LEGACY_WALLET_MAGIC_VALUE;

    }



    /// @dev Grants an unlimited allowance to the exchange for its token

    ///      on behalf of this contract.

    /// @param exchange The Uniswap token exchange.

    /// @param tokenAddress The token address for the exchange.

    function _grantExchangeAllowance(IUniswapExchange exchange, address tokenAddress)

        private

    {

        LibERC20Token.approve(tokenAddress, address(exchange), uint256(-1));

    }



    /// @dev Retrieves the uniswap exchange for a given token pair.

    ///      In the case of a WETH-token exchange, this will be the non-WETH token.

    ///      In th ecase of a token-token exchange, this will be the first token.

    /// @param fromTokenAddress The address of the token we are converting from.

    /// @param toTokenAddress The address of the token we are converting to.

    /// @return exchange The uniswap exchange.

    function _getUniswapExchangeForTokenPair(

        address fromTokenAddress,

        address toTokenAddress

    )

        private

        view

        returns (IUniswapExchange exchange)

    {

        address exchangeTokenAddress = fromTokenAddress;

        // Whichever isn't WETH is the exchange token.

        if (fromTokenAddress == _getWethAddress()) {

            exchangeTokenAddress = toTokenAddress;

        }

        exchange = IUniswapExchange(

            IUniswapExchangeFactory(_getUniswapExchangeFactoryAddress())

            .getExchange(exchangeTokenAddress)

        );

        require(address(exchange) != address(0), "NO_UNISWAP_EXCHANGE_FOR_TOKEN");

        return exchange;

    }

}
