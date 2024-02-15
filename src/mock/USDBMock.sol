// // SPDX-License-Identifier: BSL 1.1 - Copyright 2024 MetaLayer Labs Ltd.
// pragma solidity ^0.8.15;

// import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";
// import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
// import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";
// import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import { Address } from "@openzeppelin/contracts/utils/Address.sol";
// import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import { ERC165Checker } from "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
// import { Math } from "@openzeppelin/contracts/utils/math/Math.sol";
// import { SignedMath } from "@openzeppelin/contracts/utils/math/SignedMath.sol";
// import { FixedPointMathLib } from "solmate/utils/FixedPointMathLib.sol";
// import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
// import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
// import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// enum YieldMode {
//     AUTOMATIC,
//     VOID,
//     CLAIMABLE
// }

// library SafeMath {
//     /**
//      * @dev Returns the addition of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `+` operator.
//      *
//      * Requirements:
//      *
//      * - Addition cannot overflow.
//      */
//     function add(uint256 a, uint256 b) internal pure returns (uint256) {
//         uint256 c = a + b;
//         require(c >= a, "SafeMath: addition overflow");

//         return c;
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting on
//      * overflow (when the result is negative).
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//         return sub(a, b, "SafeMath: subtraction overflow");
//     }

//     /**
//      * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
//      * overflow (when the result is negative).
//      *
//      * Counterpart to Solidity's `-` operator.
//      *
//      * Requirements:
//      *
//      * - Subtraction cannot overflow.
//      */
//     function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b <= a, errorMessage);
//         uint256 c = a - b;

//         return c;
//     }

//     /**
//      * @dev Returns the multiplication of two unsigned integers, reverting on
//      * overflow.
//      *
//      * Counterpart to Solidity's `*` operator.
//      *
//      * Requirements:
//      *
//      * - Multiplication cannot overflow.
//      */
//     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
//         // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
//         // benefit is lost if 'b' is also tested.
//         // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
//         if (a == 0) {
//             return 0;
//         }

//         uint256 c = a * b;
//         require(c / a == b, "SafeMath: multiplication overflow");

//         return c;
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers. Reverts on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator. Note: this function uses a
//      * `revert` opcode (which leaves remaining gas untouched) while Solidity
//      * uses an invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(uint256 a, uint256 b) internal pure returns (uint256) {
//         return div(a, b, "SafeMath: division by zero");
//     }

//     /**
//      * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
//      * division by zero. The result is rounded towards zero.
//      *
//      * Counterpart to Solidity's `/` operator. Note: this function uses a
//      * `revert` opcode (which leaves remaining gas untouched) while Solidity
//      * uses an invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b > 0, errorMessage);
//         uint256 c = a / b;
//         // assert(a == b * c + a % b); // There is no case in which this doesn't hold

//         return c;
//     }

//     /**
//      * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
//      * Reverts when dividing by zero.
//      *
//      * Counterpart to Solidity's `%` operator. This function uses a `revert`
//      * opcode (which leaves remaining gas untouched) while Solidity uses an
//      * invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function mod(uint256 a, uint256 b) internal pure returns (uint256) {
//         return mod(a, b, "SafeMath: modulo by zero");
//     }

//     /**
//      * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
//      * Reverts with custom message when dividing by zero.
//      *
//      * Counterpart to Solidity's `%` operator. This function uses a `revert`
//      * opcode (which leaves remaining gas untouched) while Solidity uses an
//      * invalid opcode to revert (consuming all remaining gas).
//      *
//      * Requirements:
//      *
//      * - The divisor cannot be zero.
//      */
//     function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
//         require(b != 0, errorMessage);
//         return a % b;
//     }
// }

// library Counters {
//     using SafeMath for uint256;

//     struct Counter {
//         // This variable should never be directly accessed by users of the library: interactions must be restricted to
//         // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
//         // this feature: see https://github.com/ethereum/solidity/issues/4637
//         uint256 _value; // default: 0
//     }

//     function current(Counter storage counter) internal view returns (uint256) {
//         return counter._value;
//     }

//     function increment(Counter storage counter) internal {
//         // The {SafeMath} overflow check can be skipped here, see the comment at the top
//         counter._value += 1;
//     }

//     function decrement(Counter storage counter) internal {
//         counter._value = counter._value.sub(1);
//     }
// }

// /**
//  * @dev Implementation of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
//  * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
//  *
//  * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
//  * presenting a message signed by the account. By not relying on `{IERC20-approve}`, the token holder account doesn't
//  * need to send a transaction, and thus is not required to hold Ether at all.
//  *
//  * _Available since v3.4._
//  */
// abstract contract ERC20Permit is IERC20Permit, EIP712 {
//     using Counters for Counters.Counter;

//     mapping(address => Counters.Counter) private _nonces;

//     bytes32 public constant PERMIT_TYPEHASH =
//         keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
//     /**
//      * @dev In previous versions `_PERMIT_TYPEHASH` was declared as `immutable`.
//      * However, to ensure consistency with the upgradeable transpiler, we will continue
//      * to reserve a slot.
//      * @custom:oz-renamed-from _PERMIT_TYPEHASH
//      */
//     // solhint-disable-next-line var-name-mixedcase
//     bytes32 private _PERMIT_TYPEHASH_DEPRECATED_SLOT;

//     /**
//      * @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
//      *
//      * It's a good idea to use the same `name` that is defined as the ERC20 token name.
//      */
//     constructor(string memory name) EIP712(name, "1") {}

//     /**
//      * @dev See {IERC20Permit-permit}.
//      */
//     function permit(
//         address owner,
//         address spender,
//         uint256 value,
//         uint256 deadline,
//         uint8 v,
//         bytes32 r,
//         bytes32 s
//     ) public virtual override {
//         require(block.timestamp <= deadline, "ERC20Permit: expired deadline");

//         bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));

//         bytes32 hash = _hashTypedDataV4(structHash);

//         address signer = ECDSA.recover(hash, v, r, s);
//         require(signer == owner, "ERC20Permit: invalid signature");

//         _approve(owner, spender, value);
//     }

//     /**
//      * @dev See {IERC20Permit-nonces}.
//      */
//     function nonces(address owner) public view virtual override returns (uint256) {
//         return _nonces[owner].current();
//     }

//     /**
//      * @dev See {IERC20Permit-DOMAIN_SEPARATOR}.
//      */
//     // solhint-disable-next-line func-name-mixedcase
//     function DOMAIN_SEPARATOR() external view override returns (bytes32) {
//         return _domainSeparatorV4();
//     }

//     /**
//      * @dev "Consume a nonce": return the current value and increment.
//      *
//      * _Available since v4.1._
//      */
//     function _useNonce(address owner) internal virtual returns (uint256 current) {
//         Counters.Counter storage nonce = _nonces[owner];
//         current = nonce.current();
//         nonce.increment();
//     }

//     /**
//      * @dev See {ERC20-_approve}.
//      */
//     function _approve(
//         address owner,
//         address spender,
//         uint256 amount
//     ) internal virtual;
// }


// /// @title Arithmetic
// /// @notice Even more math than before.
// library Arithmetic {
//     /// @notice Clamps a value between a minimum and maximum.
//     /// @param _value The value to clamp.
//     /// @param _min   The minimum value.
//     /// @param _max   The maximum value.
//     /// @return The clamped value.
//     function clamp(int256 _value, int256 _min, int256 _max) internal pure returns (int256) {
//         return SignedMath.min(SignedMath.max(_value, _min), _max);
//     }

//     /// @notice (c)oefficient (d)enominator (exp)onentiation function.
//     ///         Returns the result of: c * (1 - 1/d)^exp.
//     /// @param _coefficient Coefficient of the function.
//     /// @param _denominator Fractional denominator.
//     /// @param _exponent    Power function exponent.
//     /// @return Result of c * (1 - 1/d)^exp.
//     function cdexp(int256 _coefficient, int256 _denominator, int256 _exponent) internal pure returns (int256) {
//         return (_coefficient * (FixedPointMathLib.powWad(1e18 - (1e18 / _denominator), _exponent * 1e18))) / 1e18;
//     }
// }

// /// @title Burn
// /// @notice Utilities for burning stuff.
// library Burn {
//     /// @notice Burns a given amount of ETH.
//     /// @param _amount Amount of ETH to burn.
//     function eth(uint256 _amount) internal {
//         new Burner{ value: _amount }();
//     }

//     /// @notice Burns a given amount of gas.
//     /// @param _amount Amount of gas to burn.
//     function gas(uint256 _amount) internal view {
//         uint256 i = 0;
//         uint256 initialGas = gasleft();
//         while (initialGas - gasleft() < _amount) {
//             ++i;
//         }
//     }
// }

// /// @title Burner
// /// @notice Burner self-destructs on creation and sends all ETH to itself, removing all ETH given to
// ///         the contract from the circulating supply. Self-destructing is the only way to remove ETH
// ///         from the circulating supply.
// contract Burner {
//     constructor() payable {
//         selfdestruct(payable(address(this)));
//     }
// }


// /// @custom:upgradeable
// /// @title ResourceMetering
// /// @notice ResourceMetering implements an EIP-1559 style resource metering system where pricing
// ///         updates automatically based on current demand.
// abstract contract ResourceMetering is Initializable {
//     /// @notice Represents the various parameters that control the way in which resources are
//     ///         metered. Corresponds to the EIP-1559 resource metering system.
//     /// @custom:field prevBaseFee   Base fee from the previous block(s).
//     /// @custom:field prevBoughtGas Amount of gas bought so far in the current block.
//     /// @custom:field prevBlockNum  Last block number that the base fee was updated.
//     struct ResourceParams {
//         uint128 prevBaseFee;
//         uint64 prevBoughtGas;
//         uint64 prevBlockNum;
//     }

//     /// @notice Represents the configuration for the EIP-1559 based curve for the deposit gas
//     ///         market. These values should be set with care as it is possible to set them in
//     ///         a way that breaks the deposit gas market. The target resource limit is defined as
//     ///         maxResourceLimit / elasticityMultiplier. This struct was designed to fit within a
//     ///         single word. There is additional space for additions in the future.
//     /// @custom:field maxResourceLimit             Represents the maximum amount of deposit gas that
//     ///                                            can be purchased per block.
//     /// @custom:field elasticityMultiplier         Determines the target resource limit along with
//     ///                                            the resource limit.
//     /// @custom:field baseFeeMaxChangeDenominator  Determines max change on fee per block.
//     /// @custom:field minimumBaseFee               The min deposit base fee, it is clamped to this
//     ///                                            value.
//     /// @custom:field systemTxMaxGas               The amount of gas supplied to the system
//     ///                                            transaction. This should be set to the same
//     ///                                            number that the op-node sets as the gas limit
//     ///                                            for the system transaction.
//     /// @custom:field maximumBaseFee               The max deposit base fee, it is clamped to this
//     ///                                            value.
//     struct ResourceConfig {
//         uint32 maxResourceLimit;
//         uint8 elasticityMultiplier;
//         uint8 baseFeeMaxChangeDenominator;
//         uint32 minimumBaseFee;
//         uint32 systemTxMaxGas;
//         uint128 maximumBaseFee;
//     }

//     /// @notice EIP-1559 style gas parameters.
//     ResourceParams public params;

//     /// @notice Reserve extra slots (to a total of 50) in the storage layout for future upgrades.
//     uint256[48] private __gap;

//     /// @notice Meters access to a function based an amount of a requested resource.
//     /// @param _amount Amount of the resource requested.
//     modifier metered(uint64 _amount) {
//         // Record initial gas amount so we can refund for it later.
//         uint256 initialGas = gasleft();

//         // Run the underlying function.
//         _;

//         // Run the metering function.
//         _metered(_amount, initialGas);
//     }

//     /// @notice An internal function that holds all of the logic for metering a resource.
//     /// @param _amount     Amount of the resource requested.
//     /// @param _initialGas The amount of gas before any modifier execution.
//     function _metered(uint64 _amount, uint256 _initialGas) internal {
//         // Update block number and base fee if necessary.
//         uint256 blockDiff = block.number - params.prevBlockNum;

//         ResourceConfig memory config = _resourceConfig();
//         int256 targetResourceLimit =
//             int256(uint256(config.maxResourceLimit)) / int256(uint256(config.elasticityMultiplier));

//         if (blockDiff > 0) {
//             // Handle updating EIP-1559 style gas parameters. We use EIP-1559 to restrict the rate
//             // at which deposits can be created and therefore limit the potential for deposits to
//             // spam the L2 system. Fee scheme is very similar to EIP-1559 with minor changes.
//             int256 gasUsedDelta = int256(uint256(params.prevBoughtGas)) - targetResourceLimit;
//             int256 baseFeeDelta = (int256(uint256(params.prevBaseFee)) * gasUsedDelta)
//                 / (targetResourceLimit * int256(uint256(config.baseFeeMaxChangeDenominator)));

//             // Update base fee by adding the base fee delta and clamp the resulting value between
//             // min and max.
//             int256 newBaseFee = Arithmetic.clamp({
//                 _value: int256(uint256(params.prevBaseFee)) + baseFeeDelta,
//                 _min: int256(uint256(config.minimumBaseFee)),
//                 _max: int256(uint256(config.maximumBaseFee))
//             });

//             // If we skipped more than one block, we also need to account for every empty block.
//             // Empty block means there was no demand for deposits in that block, so we should
//             // reflect this lack of demand in the fee.
//             if (blockDiff > 1) {
//                 // Update the base fee by repeatedly applying the exponent 1-(1/change_denominator)
//                 // blockDiff - 1 times. Simulates multiple empty blocks. Clamp the resulting value
//                 // between min and max.
//                 newBaseFee = Arithmetic.clamp({
//                     _value: Arithmetic.cdexp({
//                         _coefficient: newBaseFee,
//                         _denominator: int256(uint256(config.baseFeeMaxChangeDenominator)),
//                         _exponent: int256(blockDiff - 1)
//                     }),
//                     _min: int256(uint256(config.minimumBaseFee)),
//                     _max: int256(uint256(config.maximumBaseFee))
//                 });
//             }

//             // Update new base fee, reset bought gas, and update block number.
//             params.prevBaseFee = uint128(uint256(newBaseFee));
//             params.prevBoughtGas = 0;
//             params.prevBlockNum = uint64(block.number);
//         }

//         // Make sure we can actually buy the resource amount requested by the user.
//         params.prevBoughtGas += _amount;
//         require(
//             int256(uint256(params.prevBoughtGas)) <= int256(uint256(config.maxResourceLimit)),
//             "ResourceMetering: cannot buy more gas than available gas limit"
//         );

//         // Determine the amount of ETH to be paid.
//         uint256 resourceCost = uint256(_amount) * uint256(params.prevBaseFee);

//         // We currently charge for this ETH amount as an L1 gas burn, so we convert the ETH amount
//         // into gas by dividing by the L1 base fee. We assume a minimum base fee of 1 gwei to avoid
//         // division by zero for L1s that don't support 1559 or to avoid excessive gas burns during
//         // periods of extremely low L1 demand. One-day average gas fee hasn't dipped below 1 gwei
//         // during any 1 day period in the last 5 years, so should be fine.
//         uint256 gasCost = resourceCost / Math.max(block.basefee, 1 gwei);

//         // Give the user a refund based on the amount of gas they used to do all of the work up to
//         // this point. Since we're at the end of the modifier, this should be pretty accurate. Acts
//         // effectively like a dynamic stipend (with a minimum value).
//         uint256 usedGas = _initialGas - gasleft();
//         if (gasCost > usedGas) {
//             Burn.gas(gasCost - usedGas);
//         }
//     }

//     /// @notice Virtual function that returns the resource config.
//     ///         Contracts that inherit this contract must implement this function.
//     /// @return ResourceConfig
//     function _resourceConfig() internal virtual returns (ResourceConfig memory);

//     /// @notice Sets initial resource parameter values.
//     ///         This function must either be called by the initializer function of an upgradeable
//     ///         child contract.
//     // solhint-disable-next-line func-name-mixedcase
//     function __ResourceMetering_init() internal onlyInitializing {
//         params = ResourceParams({ prevBaseFee: 1 gwei, prevBoughtGas: 0, prevBlockNum: uint64(block.number) });
//     }
// }


// /// @title Constants
// /// @notice Constants is a library for storing constants. Simple! Don't put everything in here, just
// ///         the stuff used in multiple contracts. Constants that only apply to a single contract
// ///         should be defined in that contract instead.
// library Constants {
//     /// @notice Special address to be used as the tx origin for gas estimation calls in the
//     ///         OptimismPortal and CrossDomainMessenger calls. You only need to use this address if
//     ///         the minimum gas limit specified by the user is not actually enough to execute the
//     ///         given message and you're attempting to estimate the actual necessary gas limit. We
//     ///         use address(1) because it's the ecrecover precompile and therefore guaranteed to
//     ///         never have any code on any EVM chain.
//     address internal constant ESTIMATION_ADDRESS = address(1);

//     /// @notice Value used for the L2 sender storage slot in both the OptimismPortal and the
//     ///         CrossDomainMessenger contracts before an actual sender is set. This value is
//     ///         non-zero to reduce the gas cost of message passing transactions.
//     address internal constant DEFAULT_L2_SENDER = 0x000000000000000000000000000000000000dEaD;

//     /// @notice The storage slot that holds the address of a proxy implementation.
//     /// @dev `bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)`
//     bytes32 internal constant PROXY_IMPLEMENTATION_ADDRESS =
//         0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

//     /// @notice The storage slot that holds the address of the owner.
//     /// @dev `bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1)`
//     bytes32 internal constant PROXY_OWNER_ADDRESS = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;

//     /// @notice Returns the default values for the ResourceConfig. These are the recommended values
//     ///         for a production network.
//     function DEFAULT_RESOURCE_CONFIG() internal pure returns (ResourceMetering.ResourceConfig memory) {
//         ResourceMetering.ResourceConfig memory config = ResourceMetering.ResourceConfig({
//             maxResourceLimit: 20_000_000,
//             elasticityMultiplier: 10,
//             baseFeeMaxChangeDenominator: 8,
//             minimumBaseFee: 1 gwei,
//             systemTxMaxGas: 1_000_000,
//             maximumBaseFee: type(uint128).max
//         });
//         return config;
//     }

//     /// @notice The `reinitailizer` input for upgradable contracts. This value must be updated
//     ///         each time that the contracts are deployed.
//     uint8 internal constant INITIALIZER = 3;
// }


// library RLPWriter {
//     /// @notice RLP encodes a byte string.
//     /// @param _in The byte string to encode.
//     /// @return out_ The RLP encoded string in bytes.
//     function writeBytes(bytes memory _in) internal pure returns (bytes memory out_) {
//         if (_in.length == 1 && uint8(_in[0]) < 128) {
//             out_ = _in;
//         } else {
//             out_ = abi.encodePacked(_writeLength(_in.length, 128), _in);
//         }
//     }

//     /// @notice RLP encodes a list of RLP encoded byte byte strings.
//     /// @param _in The list of RLP encoded byte strings.
//     /// @return list_ The RLP encoded list of items in bytes.
//     function writeList(bytes[] memory _in) internal pure returns (bytes memory list_) {
//         list_ = _flatten(_in);
//         list_ = abi.encodePacked(_writeLength(list_.length, 192), list_);
//     }

//     /// @notice RLP encodes a string.
//     /// @param _in The string to encode.
//     /// @return out_ The RLP encoded string in bytes.
//     function writeString(string memory _in) internal pure returns (bytes memory out_) {
//         out_ = writeBytes(bytes(_in));
//     }

//     /// @notice RLP encodes an address.
//     /// @param _in The address to encode.
//     /// @return out_ The RLP encoded address in bytes.
//     function writeAddress(address _in) internal pure returns (bytes memory out_) {
//         out_ = writeBytes(abi.encodePacked(_in));
//     }

//     /// @notice RLP encodes a uint.
//     /// @param _in The uint256 to encode.
//     /// @return out_ The RLP encoded uint256 in bytes.
//     function writeUint(uint256 _in) internal pure returns (bytes memory out_) {
//         out_ = writeBytes(_toBinary(_in));
//     }

//     /// @notice RLP encodes a bool.
//     /// @param _in The bool to encode.
//     /// @return out_ The RLP encoded bool in bytes.
//     function writeBool(bool _in) internal pure returns (bytes memory out_) {
//         out_ = new bytes(1);
//         out_[0] = (_in ? bytes1(0x01) : bytes1(0x80));
//     }

//     /// @notice Encode the first byte and then the `len` in binary form if `length` is more than 55.
//     /// @param _len    The length of the string or the payload.
//     /// @param _offset 128 if item is string, 192 if item is list.
//     /// @return out_ RLP encoded bytes.
//     function _writeLength(uint256 _len, uint256 _offset) private pure returns (bytes memory out_) {
//         if (_len < 56) {
//             out_ = new bytes(1);
//             out_[0] = bytes1(uint8(_len) + uint8(_offset));
//         } else {
//             uint256 lenLen;
//             uint256 i = 1;
//             while (_len / i != 0) {
//                 lenLen++;
//                 i *= 256;
//             }

//             out_ = new bytes(lenLen + 1);
//             out_[0] = bytes1(uint8(lenLen) + uint8(_offset) + 55);
//             for (i = 1; i <= lenLen; i++) {
//                 out_[i] = bytes1(uint8((_len / (256 ** (lenLen - i))) % 256));
//             }
//         }
//     }

//     /// @notice Encode integer in big endian binary form with no leading zeroes.
//     /// @param _x The integer to encode.
//     /// @return out_ RLP encoded bytes.
//     function _toBinary(uint256 _x) private pure returns (bytes memory out_) {
//         bytes memory b = abi.encodePacked(_x);

//         uint256 i = 0;
//         for (; i < 32; i++) {
//             if (b[i] != 0) {
//                 break;
//             }
//         }

//         out_ = new bytes(32 - i);
//         for (uint256 j = 0; j < out_.length; j++) {
//             out_[j] = b[i++];
//         }
//     }

//     /// @custom:attribution https://github.com/Arachnid/solidity-stringutils
//     /// @notice Copies a piece of memory to another location.
//     /// @param _dest Destination location.
//     /// @param _src  Source location.
//     /// @param _len  Length of memory to copy.
//     function _memcpy(uint256 _dest, uint256 _src, uint256 _len) private pure {
//         uint256 dest = _dest;
//         uint256 src = _src;
//         uint256 len = _len;

//         for (; len >= 32; len -= 32) {
//             assembly {
//                 mstore(dest, mload(src))
//             }
//             dest += 32;
//             src += 32;
//         }

//         uint256 mask;
//         unchecked {
//             mask = 256 ** (32 - len) - 1;
//         }
//         assembly {
//             let srcpart := and(mload(src), not(mask))
//             let destpart := and(mload(dest), mask)
//             mstore(dest, or(destpart, srcpart))
//         }
//     }

//     /// @custom:attribution https://github.com/sammayo/solidity-rlp-encoder
//     /// @notice Flattens a list of byte strings into one byte string.
//     /// @param _list List of byte strings to flatten.
//     /// @return out_ The flattened byte string.
//     function _flatten(bytes[] memory _list) private pure returns (bytes memory out_) {
//         if (_list.length == 0) {
//             return new bytes(0);
//         }

//         uint256 len;
//         uint256 i = 0;
//         for (; i < _list.length; i++) {
//             len += _list[i].length;
//         }

//         out_ = new bytes(len);
//         uint256 flattenedPtr;
//         assembly {
//             flattenedPtr := add(out_, 0x20)
//         }

//         for (i = 0; i < _list.length; i++) {
//             bytes memory item = _list[i];

//             uint256 listPtr;
//             assembly {
//                 listPtr := add(item, 0x20)
//             }

//             _memcpy(flattenedPtr, listPtr, item.length);
//             flattenedPtr += _list[i].length;
//         }
//     }
// }


// /// @title Hashing
// /// @notice Hashing handles Optimism's various different hashing schemes.
// library Hashing {
//     /// @notice Computes the hash of the RLP encoded L2 transaction that would be generated when a
//     ///         given deposit is sent to the L2 system. Useful for searching for a deposit in the L2
//     ///         system.
//     /// @param _tx User deposit transaction to hash.
//     /// @return Hash of the RLP encoded L2 deposit transaction.
//     function hashDepositTransaction(Types.UserDepositTransaction memory _tx) internal pure returns (bytes32) {
//         return keccak256(Encoding.encodeDepositTransaction(_tx));
//     }

//     /// @notice Computes the deposit transaction's "source hash", a value that guarantees the hash
//     ///         of the L2 transaction that corresponds to a deposit is unique and is
//     ///         deterministically generated from L1 transaction data.
//     /// @param _l1BlockHash Hash of the L1 block where the deposit was included.
//     /// @param _logIndex    The index of the log that created the deposit transaction.
//     /// @return Hash of the deposit transaction's "source hash".
//     function hashDepositSource(bytes32 _l1BlockHash, uint256 _logIndex) internal pure returns (bytes32) {
//         bytes32 depositId = keccak256(abi.encode(_l1BlockHash, _logIndex));
//         return keccak256(abi.encode(bytes32(0), depositId));
//     }

//     /// @notice Hashes the cross domain message based on the version that is encoded into the
//     ///         message nonce.
//     /// @param _nonce    Message nonce with version encoded into the first two bytes.
//     /// @param _sender   Address of the sender of the message.
//     /// @param _target   Address of the target of the message.
//     /// @param _value    ETH value to send to the target.
//     /// @param _gasLimit Gas limit to use for the message.
//     /// @param _data     Data to send with the message.
//     /// @return Hashed cross domain message.
//     function hashCrossDomainMessage(
//         uint256 _nonce,
//         address _sender,
//         address _target,
//         uint256 _value,
//         uint256 _gasLimit,
//         bytes memory _data
//     )
//         internal
//         pure
//         returns (bytes32)
//     {
//         (, uint16 version) = Encoding.decodeVersionedNonce(_nonce);
//         if (version == 0) {
//             return hashCrossDomainMessageV0(_target, _sender, _data, _nonce);
//         } else if (version == 1) {
//             return hashCrossDomainMessageV1(_nonce, _sender, _target, _value, _gasLimit, _data);
//         } else {
//             revert("Hashing: unknown cross domain message version");
//         }
//     }

//     /// @notice Hashes a cross domain message based on the V0 (legacy) encoding.
//     /// @param _target Address of the target of the message.
//     /// @param _sender Address of the sender of the message.
//     /// @param _data   Data to send with the message.
//     /// @param _nonce  Message nonce.
//     /// @return Hashed cross domain message.
//     function hashCrossDomainMessageV0(
//         address _target,
//         address _sender,
//         bytes memory _data,
//         uint256 _nonce
//     )
//         internal
//         pure
//         returns (bytes32)
//     {
//         return keccak256(Encoding.encodeCrossDomainMessageV0(_target, _sender, _data, _nonce));
//     }

//     /// @notice Hashes a cross domain message based on the V1 (current) encoding.
//     /// @param _nonce    Message nonce.
//     /// @param _sender   Address of the sender of the message.
//     /// @param _target   Address of the target of the message.
//     /// @param _value    ETH value to send to the target.
//     /// @param _gasLimit Gas limit to use for the message.
//     /// @param _data     Data to send with the message.
//     /// @return Hashed cross domain message.
//     function hashCrossDomainMessageV1(
//         uint256 _nonce,
//         address _sender,
//         address _target,
//         uint256 _value,
//         uint256 _gasLimit,
//         bytes memory _data
//     )
//         internal
//         pure
//         returns (bytes32)
//     {
//         return keccak256(Encoding.encodeCrossDomainMessageV1(_nonce, _sender, _target, _value, _gasLimit, _data));
//     }

//     /// @notice Derives the withdrawal hash according to the encoding in the L2 Withdrawer contract
//     /// @param _tx Withdrawal transaction to hash.
//     /// @return Hashed withdrawal transaction.
//     function hashWithdrawal(Types.WithdrawalTransaction memory _tx) internal pure returns (bytes32) {
//         return keccak256(abi.encode(_tx.nonce, _tx.sender, _tx.target, _tx.value, _tx.gasLimit, _tx.data));
//     }

//     /// @notice Hashes the various elements of an output root proof into an output root hash which
//     ///         can be used to check if the proof is valid.
//     /// @param _outputRootProof Output root proof which should hash to an output root.
//     /// @return Hashed output root proof.
//     function hashOutputRootProof(Types.OutputRootProof memory _outputRootProof) internal pure returns (bytes32) {
//         return keccak256(
//             abi.encode(
//                 _outputRootProof.version,
//                 _outputRootProof.stateRoot,
//                 _outputRootProof.messagePasserStorageRoot,
//                 _outputRootProof.latestBlockhash
//             )
//         );
//     }
// }


// /// @title Types
// /// @notice Contains various types used throughout the Optimism contract system.
// library Types {
//     /// @notice OutputProposal represents a commitment to the L2 state. The timestamp is the L1
//     ///         timestamp that the output root is posted. This timestamp is used to verify that the
//     ///         finalization period has passed since the output root was submitted.
//     /// @custom:field outputRoot    Hash of the L2 output.
//     /// @custom:field timestamp     Timestamp of the L1 block that the output root was submitted in.
//     /// @custom:field l2BlockNumber L2 block number that the output corresponds to.
//     struct OutputProposal {
//         bytes32 outputRoot;
//         uint128 timestamp;
//         uint128 l2BlockNumber;
//     }

//     /// @notice Struct representing the elements that are hashed together to generate an output root
//     ///         which itself represents a snapshot of the L2 state.
//     /// @custom:field version                  Version of the output root.
//     /// @custom:field stateRoot                Root of the state trie at the block of this output.
//     /// @custom:field messagePasserStorageRoot Root of the message passer storage trie.
//     /// @custom:field latestBlockhash          Hash of the block this output was generated from.
//     struct OutputRootProof {
//         bytes32 version;
//         bytes32 stateRoot;
//         bytes32 messagePasserStorageRoot;
//         bytes32 latestBlockhash;
//     }

//     /// @notice Struct representing a deposit transaction (L1 => L2 transaction) created by an end
//     ///         user (as opposed to a system deposit transaction generated by the system).
//     /// @custom:field from        Address of the sender of the transaction.
//     /// @custom:field to          Address of the recipient of the transaction.
//     /// @custom:field isCreation  True if the transaction is a contract creation.
//     /// @custom:field value       Value to send to the recipient.
//     /// @custom:field mint        Amount of ETH to mint.
//     /// @custom:field gasLimit    Gas limit of the transaction.
//     /// @custom:field data        Data of the transaction.
//     /// @custom:field l1BlockHash Hash of the block the transaction was submitted in.
//     /// @custom:field logIndex    Index of the log in the block the transaction was submitted in.
//     struct UserDepositTransaction {
//         address from;
//         address to;
//         bool isCreation;
//         uint256 value;
//         uint256 mint;
//         uint64 gasLimit;
//         bytes data;
//         bytes32 l1BlockHash;
//         uint256 logIndex;
//     }

//     /// @notice Struct representing a withdrawal transaction.
//     /// @custom:field nonce    Nonce of the withdrawal transaction
//     /// @custom:field sender   Address of the sender of the transaction.
//     /// @custom:field target   Address of the recipient of the transaction.
//     /// @custom:field value    Value to send to the recipient.
//     /// @custom:field gasLimit Gas limit of the transaction.
//     /// @custom:field data     Data of the transaction.
//     struct WithdrawalTransaction {
//         uint256 nonce;
//         address sender;
//         address target;
//         uint256 value;
//         uint256 gasLimit;
//         bytes data;
//     }
// }


// /// @title Encoding
// /// @notice Encoding handles Optimism's various different encoding schemes.
// library Encoding {
//     /// @notice RLP encodes the L2 transaction that would be generated when a given deposit is sent
//     ///         to the L2 system. Useful for searching for a deposit in the L2 system. The
//     ///         transaction is prefixed with 0x7e to identify its EIP-2718 type.
//     /// @param _tx User deposit transaction to encode.
//     /// @return RLP encoded L2 deposit transaction.
//     function encodeDepositTransaction(Types.UserDepositTransaction memory _tx) internal pure returns (bytes memory) {
//         bytes32 source = Hashing.hashDepositSource(_tx.l1BlockHash, _tx.logIndex);
//         bytes[] memory raw = new bytes[](8);
//         raw[0] = RLPWriter.writeBytes(abi.encodePacked(source));
//         raw[1] = RLPWriter.writeAddress(_tx.from);
//         raw[2] = _tx.isCreation ? RLPWriter.writeBytes("") : RLPWriter.writeAddress(_tx.to);
//         raw[3] = RLPWriter.writeUint(_tx.mint);
//         raw[4] = RLPWriter.writeUint(_tx.value);
//         raw[5] = RLPWriter.writeUint(uint256(_tx.gasLimit));
//         raw[6] = RLPWriter.writeBool(false);
//         raw[7] = RLPWriter.writeBytes(_tx.data);
//         return abi.encodePacked(uint8(0x7e), RLPWriter.writeList(raw));
//     }

//     /// @notice Encodes the cross domain message based on the version that is encoded into the
//     ///         message nonce.
//     /// @param _nonce    Message nonce with version encoded into the first two bytes.
//     /// @param _sender   Address of the sender of the message.
//     /// @param _target   Address of the target of the message.
//     /// @param _value    ETH value to send to the target.
//     /// @param _gasLimit Gas limit to use for the message.
//     /// @param _data     Data to send with the message.
//     /// @return Encoded cross domain message.
//     function encodeCrossDomainMessage(
//         uint256 _nonce,
//         address _sender,
//         address _target,
//         uint256 _value,
//         uint256 _gasLimit,
//         bytes memory _data
//     )
//         internal
//         pure
//         returns (bytes memory)
//     {
//         (, uint16 version) = decodeVersionedNonce(_nonce);
//         if (version == 0) {
//             return encodeCrossDomainMessageV0(_target, _sender, _data, _nonce);
//         } else if (version == 1) {
//             return encodeCrossDomainMessageV1(_nonce, _sender, _target, _value, _gasLimit, _data);
//         } else {
//             revert("Encoding: unknown cross domain message version");
//         }
//     }

//     /// @notice Encodes a cross domain message based on the V0 (legacy) encoding.
//     /// @param _target Address of the target of the message.
//     /// @param _sender Address of the sender of the message.
//     /// @param _data   Data to send with the message.
//     /// @param _nonce  Message nonce.
//     /// @return Encoded cross domain message.
//     function encodeCrossDomainMessageV0(
//         address _target,
//         address _sender,
//         bytes memory _data,
//         uint256 _nonce
//     )
//         internal
//         pure
//         returns (bytes memory)
//     {
//         return abi.encodeWithSignature("relayMessage(address,address,bytes,uint256)", _target, _sender, _data, _nonce);
//     }

//     /// @notice Encodes a cross domain message based on the V1 (current) encoding.
//     /// @param _nonce    Message nonce.
//     /// @param _sender   Address of the sender of the message.
//     /// @param _target   Address of the target of the message.
//     /// @param _value    ETH value to send to the target.
//     /// @param _gasLimit Gas limit to use for the message.
//     /// @param _data     Data to send with the message.
//     /// @return Encoded cross domain message.
//     function encodeCrossDomainMessageV1(
//         uint256 _nonce,
//         address _sender,
//         address _target,
//         uint256 _value,
//         uint256 _gasLimit,
//         bytes memory _data
//     )
//         internal
//         pure
//         returns (bytes memory)
//     {
//         return abi.encodeWithSignature(
//             "relayMessage(uint256,address,address,uint256,uint256,bytes)",
//             _nonce,
//             _sender,
//             _target,
//             _value,
//             _gasLimit,
//             _data
//         );
//     }

//     /// @notice Adds a version number into the first two bytes of a message nonce.
//     /// @param _nonce   Message nonce to encode into.
//     /// @param _version Version number to encode into the message nonce.
//     /// @return Message nonce with version encoded into the first two bytes.
//     function encodeVersionedNonce(uint240 _nonce, uint16 _version) internal pure returns (uint256) {
//         uint256 nonce;
//         assembly {
//             nonce := or(shl(240, _version), _nonce)
//         }
//         return nonce;
//     }

//     /// @notice Pulls the version out of a version-encoded nonce.
//     /// @param _nonce Message nonce with version encoded into the first two bytes.
//     /// @return Nonce without encoded version.
//     /// @return Version of the message.
//     function decodeVersionedNonce(uint256 _nonce) internal pure returns (uint240, uint16) {
//         uint240 nonce;
//         uint16 version;
//         assembly {
//             nonce := and(_nonce, 0x0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
//             version := shr(240, _nonce)
//         }
//         return (nonce, version);
//     }
// }


// library SafeCall {
//     /// @notice Performs a low level call without copying any returndata.
//     /// @dev Passes no calldata to the call context.
//     /// @param _target   Address to call
//     /// @param _gas      Amount of gas to pass to the call
//     /// @param _value    Amount of value to pass to the call
//     function send(address _target, uint256 _gas, uint256 _value) internal returns (bool) {
//         bool _success;
//         assembly {
//             _success :=
//                 call(
//                     _gas, // gas
//                     _target, // recipient
//                     _value, // ether value
//                     0, // inloc
//                     0, // inlen
//                     0, // outloc
//                     0 // outlen
//                 )
//         }
//         return _success;
//     }

//     /// @notice Perform a low level call without copying any returndata
//     /// @param _target   Address to call
//     /// @param _gas      Amount of gas to pass to the call
//     /// @param _value    Amount of value to pass to the call
//     /// @param _calldata Calldata to pass to the call
//     function call(address _target, uint256 _gas, uint256 _value, bytes memory _calldata) internal returns (bool) {
//         bool _success;
//         assembly {
//             _success :=
//                 call(
//                     _gas, // gas
//                     _target, // recipient
//                     _value, // ether value
//                     add(_calldata, 32), // inloc
//                     mload(_calldata), // inlen
//                     0, // outloc
//                     0 // outlen
//                 )
//         }
//         return _success;
//     }

//     /// @notice Helper function to determine if there is sufficient gas remaining within the context
//     ///         to guarantee that the minimum gas requirement for a call will be met as well as
//     ///         optionally reserving a specified amount of gas for after the call has concluded.
//     /// @param _minGas      The minimum amount of gas that may be passed to the target context.
//     /// @param _reservedGas Optional amount of gas to reserve for the caller after the execution
//     ///                     of the target context.
//     /// @return `true` if there is enough gas remaining to safely supply `_minGas` to the target
//     ///         context as well as reserve `_reservedGas` for the caller after the execution of
//     ///         the target context.
//     /// @dev !!!!! FOOTGUN ALERT !!!!!
//     ///      1.) The 40_000 base buffer is to account for the worst case of the dynamic cost of the
//     ///          `CALL` opcode's `address_access_cost`, `positive_value_cost`, and
//     ///          `value_to_empty_account_cost` factors with an added buffer of 5,700 gas. It is
//     ///          still possible to self-rekt by initiating a withdrawal with a minimum gas limit
//     ///          that does not account for the `memory_expansion_cost` & `code_execution_cost`
//     ///          factors of the dynamic cost of the `CALL` opcode.
//     ///      2.) This function should *directly* precede the external call if possible. There is an
//     ///          added buffer to account for gas consumed between this check and the call, but it
//     ///          is only 5,700 gas.
//     ///      3.) Because EIP-150 ensures that a maximum of 63/64ths of the remaining gas in the call
//     ///          frame may be passed to a subcontext, we need to ensure that the gas will not be
//     ///          truncated.
//     ///      4.) Use wisely. This function is not a silver bullet.
//     function hasMinGas(uint256 _minGas, uint256 _reservedGas) internal view returns (bool) {
//         bool _hasMinGas;
//         assembly {
//             // Equation: gas × 63 ≥ minGas × 64 + 63(40_000 + reservedGas)
//             _hasMinGas := iszero(lt(mul(gas(), 63), add(mul(_minGas, 64), mul(add(40000, _reservedGas), 63))))
//         }
//         return _hasMinGas;
//     }

//     /// @notice Perform a low level call without copying any returndata. This function
//     ///         will revert if the call cannot be performed with the specified minimum
//     ///         gas.
//     /// @param _target   Address to call
//     /// @param _minGas   The minimum amount of gas that may be passed to the call
//     /// @param _value    Amount of value to pass to the call
//     /// @param _calldata Calldata to pass to the call
//     function callWithMinGas(
//         address _target,
//         uint256 _minGas,
//         uint256 _value,
//         bytes memory _calldata
//     )
//         internal
//         returns (bool)
//     {
//         bool _success;
//         bool _hasMinGas = hasMinGas(_minGas, 0);
//         assembly {
//             // Assertion: gasleft() >= (_minGas * 64) / 63 + 40_000
//             if iszero(_hasMinGas) {
//                 // Store the "Error(string)" selector in scratch space.
//                 mstore(0, 0x08c379a0)
//                 // Store the pointer to the string length in scratch space.
//                 mstore(32, 32)
//                 // Store the string.
//                 //
//                 // SAFETY:
//                 // - We pad the beginning of the string with two zero bytes as well as the
//                 // length (24) to ensure that we override the free memory pointer at offset
//                 // 0x40. This is necessary because the free memory pointer is likely to
//                 // be greater than 1 byte when this function is called, but it is incredibly
//                 // unlikely that it will be greater than 3 bytes. As for the data within
//                 // 0x60, it is ensured that it is 0 due to 0x60 being the zero offset.
//                 // - It's fine to clobber the free memory pointer, we're reverting.
//                 mstore(88, 0x0000185361666543616c6c3a204e6f7420656e6f75676820676173)

//                 // Revert with 'Error("SafeCall: Not enough gas")'
//                 revert(28, 100)
//             }

//             // The call will be supplied at least ((_minGas * 64) / 63) gas due to the
//             // above assertion. This ensures that, in all circumstances (except for when the
//             // `_minGas` does not account for the `memory_expansion_cost` and `code_execution_cost`
//             // factors of the dynamic cost of the `CALL` opcode), the call will receive at least
//             // the minimum amount of gas specified.
//             _success :=
//                 call(
//                     gas(), // gas
//                     _target, // recipient
//                     _value, // ether value
//                     add(_calldata, 32), // inloc
//                     mload(_calldata), // inlen
//                     0x00, // outloc
//                     0x00 // outlen
//                 )
//         }
//         return _success;
//     }
// }


// library AddressAliasHelper {
//     uint160 constant offset = uint160(0x1111000000000000000000000000000000001111);

//     /// @notice Utility function that converts the address in the L1 that submitted a tx to
//     /// the inbox to the msg.sender viewed in the L2
//     /// @param l1Address the address in the L1 that triggered the tx to L2
//     /// @return l2Address L2 address as viewed in msg.sender
//     function applyL1ToL2Alias(address l1Address) internal pure returns (address l2Address) {
//         unchecked {
//             l2Address = address(uint160(l1Address) + offset);
//         }
//     }

//     /// @notice Utility function that converts the msg.sender viewed in the L2 to the
//     /// address in the L1 that submitted a tx to the inbox
//     /// @param l2Address L2 address as viewed in msg.sender
//     /// @return l1Address the address in the L1 that triggered the tx to L2
//     function undoL1ToL2Alias(address l2Address) internal pure returns (address l1Address) {
//         unchecked {
//             l1Address = address(uint160(l2Address) - offset);
//         }
//     }
// }


// /// @title Semver
// /// @notice Semver is a simple contract for managing contract versions.
// contract Semver {
//     /// @notice Contract version number (major).
//     uint256 private immutable MAJOR_VERSION;

//     /// @notice Contract version number (minor).
//     uint256 private immutable MINOR_VERSION;

//     /// @notice Contract version number (patch).
//     uint256 private immutable PATCH_VERSION;

//     /// @param _major Version number (major).
//     /// @param _minor Version number (minor).
//     /// @param _patch Version number (patch).
//     constructor(uint256 _major, uint256 _minor, uint256 _patch) {
//         MAJOR_VERSION = _major;
//         MINOR_VERSION = _minor;
//         PATCH_VERSION = _patch;
//     }

//     /// @notice Returns the full semver contract version.
//     /// @return Semver contract version as a string.
//     function version() public view returns (string memory) {
//         return string(
//             abi.encodePacked(
//                 Strings.toString(MAJOR_VERSION),
//                 ".",
//                 Strings.toString(MINOR_VERSION),
//                 ".",
//                 Strings.toString(PATCH_VERSION)
//             )
//         );
//     }
// }

// /// @title IOptimismMintableERC20
// /// @notice This interface is available on the OptimismMintableERC20 contract.
// ///         We declare it as a separate interface so that it can be used in
// ///         custom implementations of OptimismMintableERC20.
// interface IOptimismMintableERC20 is IERC165 {
//     function remoteToken() external view returns (address);

//     function bridge() external returns (address);

//     function mint(address _to, uint256 _amount) external;

//     function burn(address _from, uint256 _amount) external;
// }

// /// @custom:legacy
// /// @title ILegacyMintableERC20
// /// @notice This interface was available on the legacy L2StandardERC20 contract.
// ///         It remains available on the OptimismMintableERC20 contract for
// ///         backwards compatibility.
// interface ILegacyMintableERC20 is IERC165 {
//     function l1Token() external view returns (address);

//     function mint(address _to, uint256 _amount) external;

//     function burn(address _from, uint256 _amount) external;
// }

// /// @custom:upgradeable
// /// @title StandardBridge
// /// @notice StandardBridge is a base contract for the L1 and L2 standard ERC20 bridges. It handles
// ///         the core bridging logic, including escrowing tokens that are native to the local chain
// ///         and minting/burning tokens that are native to the remote chain.
// abstract contract StandardBridge is Initializable {
//     using SafeERC20 for IERC20;

//     /// @notice The L2 gas limit set when eth is depoisited using the receive() function.
//     uint32 internal constant RECEIVE_DEFAULT_GAS_LIMIT = 200_000;

//     /// @notice Corresponding bridge on the other domain. This public getter is deprecated
//     ///         and will be removed in the future. Please use `otherBridge` instead.
//     ///         This can safely be an immutable because for the L1StandardBridge, it will
//     ///         be set to the L2StandardBridge address, which is the same for all OP Stack
//     ///         chains. For the L2StandardBridge, there are not multiple proxies using the
//     ///         same implementation.
//     /// @custom:legacy
//     /// @custom:network-specific
//     StandardBridge public immutable OTHER_BRIDGE;

//     /// @custom:legacy
//     /// @custom:spacer messenger
//     /// @notice Spacer for backwards compatibility.
//     address private spacer_0_2_20;

//     /// @custom:legacy
//     /// @custom:spacer l2TokenBridge
//     /// @notice Spacer for backwards compatibility.
//     address private spacer_1_0_20;

//     /// @notice Mapping that stores deposits for a given pair of local and remote tokens.
//     mapping(address => mapping(address => uint256)) public deposits;

//     /// @notice Messenger contract on this domain. This public getter is deprecated
//     ///         and will be removed in the future. Please use `messenger` instead.
//     /// @custom:network-specific
//     CrossDomainMessenger public messenger;

//     /// @notice Reserve extra slots (to a total of 50) in the storage layout for future upgrades.
//     ///         A gap size of 46 was chosen here, so that the first slot used in a child contract
//     ///         would be a multiple of 50.
//     uint256[46] private __gap;

//     /// @notice Emitted when an ETH bridge is initiated to the other chain.
//     /// @param from      Address of the sender.
//     /// @param to        Address of the receiver.
//     /// @param amount    Amount of ETH sent.
//     /// @param extraData Extra data sent with the transaction.
//     event ETHBridgeInitiated(address indexed from, address indexed to, uint256 amount, bytes extraData);

//     /// @notice Emitted when an ETH bridge is finalized on this chain.
//     /// @param from      Address of the sender.
//     /// @param to        Address of the receiver.
//     /// @param amount    Amount of ETH sent.
//     /// @param extraData Extra data sent with the transaction.
//     event ETHBridgeFinalized(address indexed from, address indexed to, uint256 amount, bytes extraData);

//     /// @notice Emitted when an ERC20 bridge is initiated to the other chain.
//     /// @param localToken  Address of the ERC20 on this chain.
//     /// @param remoteToken Address of the ERC20 on the remote chain.
//     /// @param from        Address of the sender.
//     /// @param to          Address of the receiver.
//     /// @param amount      Amount of the ERC20 sent.
//     /// @param extraData   Extra data sent with the transaction.
//     event ERC20BridgeInitiated(
//         address indexed localToken,
//         address indexed remoteToken,
//         address indexed from,
//         address to,
//         uint256 amount,
//         bytes extraData
//     );

//     /// @notice Emitted when an ERC20 bridge is finalized on this chain.
//     /// @param localToken  Address of the ERC20 on this chain.
//     /// @param remoteToken Address of the ERC20 on the remote chain.
//     /// @param from        Address of the sender.
//     /// @param to          Address of the receiver.
//     /// @param amount      Amount of the ERC20 sent.
//     /// @param extraData   Extra data sent with the transaction.
//     event ERC20BridgeFinalized(
//         address indexed localToken,
//         address indexed remoteToken,
//         address indexed from,
//         address to,
//         uint256 amount,
//         bytes extraData
//     );

//     /// @notice Only allow EOAs to call the functions. Note that this is not safe against contracts
//     ///         calling code within their constructors, but also doesn't really matter since we're
//     ///         just trying to prevent users accidentally depositing with smart contract wallets.
//     modifier onlyEOA() {
//         require(!Address.isContract(msg.sender), "StandardBridge: function can only be called from an EOA");
//         _;
//     }

//     /// @notice Ensures that the caller is a cross-chain message from the other bridge.
//     modifier onlyOtherBridge() {
//         require(
//             msg.sender == address(messenger) && messenger.xDomainMessageSender() == address(OTHER_BRIDGE),
//             "StandardBridge: function can only be called from the other bridge"
//         );
//         _;
//     }

//     /// @param _otherBridge Address of the other StandardBridge contract.
//     constructor(StandardBridge _otherBridge) {
//         OTHER_BRIDGE = _otherBridge;
//     }

//     /// @notice Initializer.
//     /// @param _messenger   Address of CrossDomainMessenger on this network.
//     // solhint-disable-next-line func-name-mixedcase
//     function __StandardBridge_init(CrossDomainMessenger _messenger) internal onlyInitializing {
//         messenger = _messenger;
//     }

//     /// @notice Allows EOAs to bridge ETH by sending directly to the bridge.
//     ///         Must be implemented by contracts that inherit.
//     receive() external payable virtual;

//     /// @notice Getter for messenger contract.
//     /// @custom:legacy
//     /// @return Messenger contract on this domain.
//     function MESSENGER() external view returns (CrossDomainMessenger) {
//         return messenger;
//     }

//     /// @notice Getter for the remote domain bridge contract.
//     function otherBridge() external view returns (StandardBridge) {
//         return OTHER_BRIDGE;
//     }

//     /// @notice Sends ETH to the sender's address on the other chain.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function bridgeETH(uint32 _minGasLimit, bytes calldata _extraData) public payable onlyEOA {
//         _initiateBridgeETH(msg.sender, msg.sender, msg.value, _minGasLimit, _extraData);
//     }

//     /// @notice Sends ETH to a receiver's address on the other chain. Note that if ETH is sent to a
//     ///         smart contract and the call fails, the ETH will be temporarily locked in the
//     ///         StandardBridge on the other chain until the call is replayed. If the call cannot be
//     ///         replayed with any amount of gas (call always reverts), then the ETH will be
//     ///         permanently locked in the StandardBridge on the other chain. ETH will also
//     ///         be locked if the receiver is the other bridge, because finalizeBridgeETH will revert
//     ///         in that case.
//     /// @param _to          Address of the receiver.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function bridgeETHTo(address _to, uint32 _minGasLimit, bytes calldata _extraData) public payable {
//         _initiateBridgeETH(msg.sender, _to, msg.value, _minGasLimit, _extraData);
//     }

//     /// @notice Sends ERC20 tokens to the sender's address on the other chain. Note that if the
//     ///         ERC20 token on the other chain does not recognize the local token as the correct
//     ///         pair token, the ERC20 bridge will fail and the tokens will be returned to sender on
//     ///         this chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the corresponding token on the remote chain.
//     /// @param _amount      Amount of local tokens to deposit.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function bridgeERC20(
//         address _localToken,
//         address _remoteToken,
//         uint256 _amount,
//         uint32 _minGasLimit,
//         bytes calldata _extraData
//     )
//         public
//         virtual
//         onlyEOA
//     {
//         _initiateBridgeERC20(_localToken, _remoteToken, msg.sender, msg.sender, _amount, _minGasLimit, _extraData);
//     }

//     /// @notice Sends ERC20 tokens to a receiver's address on the other chain. Note that if the
//     ///         ERC20 token on the other chain does not recognize the local token as the correct
//     ///         pair token, the ERC20 bridge will fail and the tokens will be returned to sender on
//     ///         this chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the corresponding token on the remote chain.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of local tokens to deposit.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function bridgeERC20To(
//         address _localToken,
//         address _remoteToken,
//         address _to,
//         uint256 _amount,
//         uint32 _minGasLimit,
//         bytes calldata _extraData
//     )
//         public
//         virtual
//     {
//         _initiateBridgeERC20(_localToken, _remoteToken, msg.sender, _to, _amount, _minGasLimit, _extraData);
//     }

//     /// @notice Finalizes an ETH bridge on this chain. Can only be triggered by the other
//     ///         StandardBridge contract on the remote chain.
//     /// @param _from      Address of the sender.
//     /// @param _to        Address of the receiver.
//     /// @param _amount    Amount of ETH being bridged.
//     /// @param _extraData Extra data to be sent with the transaction. Note that the recipient will
//     ///                   not be triggered with this data, but it will be emitted and can be used
//     ///                   to identify the transaction.
//     function finalizeBridgeETH(
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes calldata _extraData
//     )
//         public
//         payable
//         onlyOtherBridge
//     {
//         require(msg.value == _amount, "StandardBridge: amount sent does not match amount required");
//         require(_to != address(this), "StandardBridge: cannot send to self");
//         require(_to != address(messenger), "StandardBridge: cannot send to messenger");

//         // Emit the correct events. By default this will be _amount, but child
//         // contracts may override this function in order to emit legacy events as well.
//         _emitETHBridgeFinalized(_from, _to, _amount, _extraData);

//         bool success = SafeCall.call(_to, gasleft(), _amount, hex"");
//         require(success, "StandardBridge: ETH transfer failed");
//     }

//     /// @notice Finalizes an ERC20 bridge on this chain. Can only be triggered by the other
//     ///         StandardBridge contract on the remote chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the corresponding token on the remote chain.
//     /// @param _from        Address of the sender.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of the ERC20 being bridged.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function finalizeBridgeERC20(
//         address _localToken,
//         address _remoteToken,
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes calldata _extraData
//     )
//         public
//         virtual
//         onlyOtherBridge
//     {
//         if (_isOptimismMintableERC20(_localToken)) {
//             require(
//                 _isCorrectTokenPair(_localToken, _remoteToken),
//                 "StandardBridge: wrong remote token for Optimism Mintable ERC20 local token"
//             );

//             OptimismMintableERC20(_localToken).mint(_to, _amount);
//         } else {
//             deposits[_localToken][_remoteToken] = deposits[_localToken][_remoteToken] - _amount;
//             IERC20(_localToken).safeTransfer(_to, _amount);
//         }

//         // Emit the correct events. By default this will be ERC20BridgeFinalized, but child
//         // contracts may override this function in order to emit legacy events as well.
//         _emitERC20BridgeFinalized(_localToken, _remoteToken, _from, _to, _amount, _extraData);
//     }

//     /// @notice Initiates a bridge of ETH through the CrossDomainMessenger.
//     /// @param _from        Address of the sender.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of ETH being bridged.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function _initiateBridgeETH(
//         address _from,
//         address _to,
//         uint256 _amount,
//         uint32 _minGasLimit,
//         bytes memory _extraData
//     )
//         internal
//     {
//         require(msg.value == _amount, "StandardBridge: bridging ETH must include sufficient ETH value");

//         // Emit the correct events. By default this will be _amount, but child
//         // contracts may override this function in order to emit legacy events as well.
//         _emitETHBridgeInitiated(_from, _to, _amount, _extraData);

//         messenger.sendMessage{ value: _amount }(
//             address(OTHER_BRIDGE),
//             abi.encodeWithSelector(this.finalizeBridgeETH.selector, _from, _to, _amount, _extraData),
//             _minGasLimit
//         );
//     }

//     /// @notice Sends ERC20 tokens to a receiver's address on the other chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the corresponding token on the remote chain.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of local tokens to deposit.
//     /// @param _minGasLimit Minimum amount of gas that the bridge can be relayed with.
//     /// @param _extraData   Extra data to be sent with the transaction. Note that the recipient will
//     ///                     not be triggered with this data, but it will be emitted and can be used
//     ///                     to identify the transaction.
//     function _initiateBridgeERC20(
//         address _localToken,
//         address _remoteToken,
//         address _from,
//         address _to,
//         uint256 _amount,
//         uint32 _minGasLimit,
//         bytes memory _extraData
//     )
//         internal
//         virtual
//     {
//         if (_isOptimismMintableERC20(_localToken)) {
//             require(
//                 _isCorrectTokenPair(_localToken, _remoteToken),
//                 "StandardBridge: wrong remote token for Optimism Mintable ERC20 local token"
//             );

//             OptimismMintableERC20(_localToken).burn(_from, _amount);
//         } else {
//             IERC20(_localToken).safeTransferFrom(_from, address(this), _amount);
//             deposits[_localToken][_remoteToken] = deposits[_localToken][_remoteToken] + _amount;
//         }

//         // Emit the correct events. By default this will be ERC20BridgeInitiated, but child
//         // contracts may override this function in order to emit legacy events as well.
//         _emitERC20BridgeInitiated(_localToken, _remoteToken, _from, _to, _amount, _extraData);

//         messenger.sendMessage(
//             address(OTHER_BRIDGE),
//             abi.encodeWithSelector(
//                 this.finalizeBridgeERC20.selector,
//                 // Because this call will be executed on the remote chain, we reverse the order of
//                 // the remote and local token addresses relative to their order in the
//                 // finalizeBridgeERC20 function.
//                 _remoteToken,
//                 _localToken,
//                 _from,
//                 _to,
//                 _amount,
//                 _extraData
//             ),
//             _minGasLimit
//         );
//     }

//     /// @notice Checks if a given address is an OptimismMintableERC20. Not perfect, but good enough.
//     ///         Just the way we like it.
//     /// @param _token Address of the token to check.
//     /// @return True if the token is an OptimismMintableERC20.
//     function _isOptimismMintableERC20(address _token) internal view returns (bool) {
//         return ERC165Checker.supportsInterface(_token, type(ILegacyMintableERC20).interfaceId)
//             || ERC165Checker.supportsInterface(_token, type(IOptimismMintableERC20).interfaceId);
//     }

//     /// @notice Checks if the "other token" is the correct pair token for the OptimismMintableERC20.
//     ///         Calls can be saved in the future by combining this logic with
//     ///         `_isOptimismMintableERC20`.
//     /// @param _mintableToken OptimismMintableERC20 to check against.
//     /// @param _otherToken    Pair token to check.
//     /// @return True if the other token is the correct pair token for the OptimismMintableERC20.
//     function _isCorrectTokenPair(address _mintableToken, address _otherToken) internal view returns (bool) {
//         if (ERC165Checker.supportsInterface(_mintableToken, type(ILegacyMintableERC20).interfaceId)) {
//             return _otherToken == ILegacyMintableERC20(_mintableToken).l1Token();
//         } else {
//             return _otherToken == IOptimismMintableERC20(_mintableToken).remoteToken();
//         }
//     }

//     /// @notice Emits the ETHBridgeInitiated event and if necessary the appropriate legacy event
//     ///         when an ETH bridge is finalized on this chain.
//     /// @param _from      Address of the sender.
//     /// @param _to        Address of the receiver.
//     /// @param _amount    Amount of ETH sent.
//     /// @param _extraData Extra data sent with the transaction.
//     function _emitETHBridgeInitiated(
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes memory _extraData
//     )
//         internal
//         virtual
//     {
//         emit ETHBridgeInitiated(_from, _to, _amount, _extraData);
//     }

//     /// @notice Emits the ETHBridgeFinalized and if necessary the appropriate legacy event when an
//     ///         ETH bridge is finalized on this chain.
//     /// @param _from      Address of the sender.
//     /// @param _to        Address of the receiver.
//     /// @param _amount    Amount of ETH sent.
//     /// @param _extraData Extra data sent with the transaction.
//     function _emitETHBridgeFinalized(
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes memory _extraData
//     )
//         internal
//         virtual
//     {
//         emit ETHBridgeFinalized(_from, _to, _amount, _extraData);
//     }

//     /// @notice Emits the ERC20BridgeInitiated event and if necessary the appropriate legacy
//     ///         event when an ERC20 bridge is initiated to the other chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the ERC20 on the remote chain.
//     /// @param _from        Address of the sender.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of the ERC20 sent.
//     /// @param _extraData   Extra data sent with the transaction.
//     function _emitERC20BridgeInitiated(
//         address _localToken,
//         address _remoteToken,
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes memory _extraData
//     )
//         internal
//         virtual
//     {
//         emit ERC20BridgeInitiated(_localToken, _remoteToken, _from, _to, _amount, _extraData);
//     }

//     /// @notice Emits the ERC20BridgeFinalized event and if necessary the appropriate legacy
//     ///         event when an ERC20 bridge is initiated to the other chain.
//     /// @param _localToken  Address of the ERC20 on this chain.
//     /// @param _remoteToken Address of the ERC20 on the remote chain.
//     /// @param _from        Address of the sender.
//     /// @param _to          Address of the receiver.
//     /// @param _amount      Amount of the ERC20 sent.
//     /// @param _extraData   Extra data sent with the transaction.
//     function _emitERC20BridgeFinalized(
//         address _localToken,
//         address _remoteToken,
//         address _from,
//         address _to,
//         uint256 _amount,
//         bytes memory _extraData
//     )
//         internal
//         virtual
//     {
//         emit ERC20BridgeFinalized(_localToken, _remoteToken, _from, _to, _amount, _extraData);
//     }
// }


// contract OptimismMintableERC20 is IOptimismMintableERC20, ILegacyMintableERC20, ERC20, Semver {
//     /// @notice Address of the corresponding version of this token on the remote chain.
//     address public immutable REMOTE_TOKEN;

//     /// @notice Address of the StandardBridge on this network.
//     address public immutable BRIDGE;

//     /// @notice Decimals of the token
//     uint8 private immutable DECIMALS;

//     /// @notice Emitted whenever tokens are minted for an account.
//     /// @param account Address of the account tokens are being minted for.
//     /// @param amount  Amount of tokens minted.
//     event Mint(address indexed account, uint256 amount);

//     /// @notice Emitted whenever tokens are burned from an account.
//     /// @param account Address of the account tokens are being burned from.
//     /// @param amount  Amount of tokens burned.
//     event Burn(address indexed account, uint256 amount);

//     /// @notice A modifier that only allows the bridge to call
//     modifier onlyBridge() {
//         require(msg.sender == BRIDGE, "OptimismMintableERC20: only bridge can mint and burn");
//         _;
//     }

//     /// @custom:semver 1.2.1
//     /// @param _bridge      Address of the L2 standard bridge.
//     /// @param _remoteToken Address of the corresponding L1 token.
//     /// @param _name        ERC20 name.
//     /// @param _symbol      ERC20 symbol.
//     constructor(
//         address _bridge,
//         address _remoteToken,
//         string memory _name,
//         string memory _symbol,
//         uint8 _decimals
//     )
//         ERC20(_name, _symbol)
//         Semver(1, 2, 1)
//     {
//         REMOTE_TOKEN = _remoteToken;
//         BRIDGE = _bridge;
//         DECIMALS = _decimals;
//     }

//     /// @notice Allows the StandardBridge on this network to mint tokens.
//     /// @param _to     Address to mint tokens to.
//     /// @param _amount Amount of tokens to mint.
//     function mint(
//         address _to,
//         uint256 _amount
//     )
//         external
//         virtual
//         override(IOptimismMintableERC20, ILegacyMintableERC20)
//         onlyBridge
//     {
//         _mint(_to, _amount);
//         emit Mint(_to, _amount);
//     }

//     /// @notice Allows the StandardBridge on this network to burn tokens.
//     /// @param _from   Address to burn tokens from.
//     /// @param _amount Amount of tokens to burn.
//     function burn(
//         address _from,
//         uint256 _amount
//     )
//         external
//         virtual
//         override(IOptimismMintableERC20, ILegacyMintableERC20)
//         onlyBridge
//     {
//         _burn(_from, _amount);
//         emit Burn(_from, _amount);
//     }

//     /// @notice ERC165 interface check function.
//     /// @param _interfaceId Interface ID to check.
//     /// @return Whether or not the interface is supported by this contract.
//     function supportsInterface(bytes4 _interfaceId) external pure virtual returns (bool) {
//         bytes4 iface1 = type(IERC165).interfaceId;
//         // Interface corresponding to the legacy L2StandardERC20.
//         bytes4 iface2 = type(ILegacyMintableERC20).interfaceId;
//         // Interface corresponding to the updated OptimismMintableERC20 (this contract).
//         bytes4 iface3 = type(IOptimismMintableERC20).interfaceId;
//         return _interfaceId == iface1 || _interfaceId == iface2 || _interfaceId == iface3;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for the remote token. Use REMOTE_TOKEN going forward.
//     function l1Token() public view returns (address) {
//         return REMOTE_TOKEN;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for the bridge. Use BRIDGE going forward.
//     function l2Bridge() public view returns (address) {
//         return BRIDGE;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for REMOTE_TOKEN.
//     function remoteToken() public view returns (address) {
//         return REMOTE_TOKEN;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for BRIDGE.
//     function bridge() public view returns (address) {
//         return BRIDGE;
//     }

//     /// @dev Returns the number of decimals used to get its user representation.
//     /// For example, if `decimals` equals `2`, a balance of `505` tokens should
//     /// be displayed to a user as `5.05` (`505 / 10 ** 2`).
//     /// NOTE: This information is only used for _display_ purposes: it in
//     /// no way affects any of the arithmetic of the contract, including
//     /// {IERC20-balanceOf} and {IERC20-transfer}.
//     function decimals() public view override returns (uint8) {
//         return DECIMALS;
//     }
// }

// /// @custom:legacy
// /// @title CrossDomainMessengerLegacySpacer0
// /// @notice Contract only exists to add a spacer to the CrossDomainMessenger where the
// ///         libAddressManager variable used to exist. Must be the first contract in the inheritance
// ///         tree of the CrossDomainMessenger.
// contract CrossDomainMessengerLegacySpacer0 {
//     /// @custom:legacy
//     /// @custom:spacer libAddressManager
//     /// @notice Spacer for backwards compatibility.
//     address private spacer_0_0_20;
// }

// /// @custom:legacy
// /// @title CrossDomainMessengerLegacySpacer1
// /// @notice Contract only exists to add a spacer to the CrossDomainMessenger where the
// ///         PausableUpgradable and OwnableUpgradeable variables used to exist. Must be
// ///         the third contract in the inheritance tree of the CrossDomainMessenger.
// contract CrossDomainMessengerLegacySpacer1 {
//     /// @custom:legacy
//     /// @custom:spacer ContextUpgradable's __gap
//     /// @notice Spacer for backwards compatibility. Comes from OpenZeppelin
//     ///         ContextUpgradable.
//     uint256[50] private spacer_1_0_1600;

//     /// @custom:legacy
//     /// @custom:spacer OwnableUpgradeable's _owner
//     /// @notice Spacer for backwards compatibility.
//     ///         Come from OpenZeppelin OwnableUpgradeable.
//     address private spacer_51_0_20;

//     /// @custom:legacy
//     /// @custom:spacer OwnableUpgradeable's __gap
//     /// @notice Spacer for backwards compatibility. Comes from OpenZeppelin
//     ///         OwnableUpgradeable.
//     uint256[49] private spacer_52_0_1568;

//     /// @custom:legacy
//     /// @custom:spacer PausableUpgradable's _paused
//     /// @notice Spacer for backwards compatibility. Comes from OpenZeppelin
//     ///         PausableUpgradable.
//     bool private spacer_101_0_1;

//     /// @custom:legacy
//     /// @custom:spacer PausableUpgradable's __gap
//     /// @notice Spacer for backwards compatibility. Comes from OpenZeppelin
//     ///         PausableUpgradable.
//     uint256[49] private spacer_102_0_1568;

//     /// @custom:legacy
//     /// @custom:spacer ReentrancyGuardUpgradeable's `_status` field.
//     /// @notice Spacer for backwards compatibility.
//     uint256 private spacer_151_0_32;

//     /// @custom:legacy
//     /// @custom:spacer ReentrancyGuardUpgradeable's __gap
//     /// @notice Spacer for backwards compatibility.
//     uint256[49] private spacer_152_0_1568;

//     /// @custom:legacy
//     /// @custom:spacer blockedMessages
//     /// @notice Spacer for backwards compatibility.
//     mapping(bytes32 => bool) private spacer_201_0_32;

//     /// @custom:legacy
//     /// @custom:spacer relayedMessages
//     /// @notice Spacer for backwards compatibility.
//     mapping(bytes32 => bool) private spacer_202_0_32;
// }

// /// @custom:upgradeable
// /// @title CrossDomainMessenger
// /// @notice CrossDomainMessenger is a base contract that provides the core logic for the L1 and L2
// ///         cross-chain messenger contracts. It's designed to be a universal interface that only
// ///         needs to be extended slightly to provide low-level message passing functionality on each
// ///         chain it's deployed on. Currently only designed for message passing between two paired
// ///         chains and does not support one-to-many interactions.
// ///         Any changes to this contract MUST result in a semver bump for contracts that inherit it.
// abstract contract CrossDomainMessenger is
//     CrossDomainMessengerLegacySpacer0,
//     Initializable,
//     CrossDomainMessengerLegacySpacer1
// {
//     /// @notice Current message version identifier.
//     uint16 public constant MESSAGE_VERSION = 1;

//     /// @notice Constant overhead added to the base gas for a message.
//     uint64 public constant RELAY_CONSTANT_OVERHEAD = 200_000;

//     /// @notice Numerator for dynamic overhead added to the base gas for a message.
//     uint64 public constant MIN_GAS_DYNAMIC_OVERHEAD_NUMERATOR = 64;

//     /// @notice Denominator for dynamic overhead added to the base gas for a message.
//     uint64 public constant MIN_GAS_DYNAMIC_OVERHEAD_DENOMINATOR = 63;

//     /// @notice Extra gas added to base gas for each byte of calldata in a message.
//     uint64 public constant MIN_GAS_CALLDATA_OVERHEAD = 16;

//     /// @notice Gas reserved for performing the external call in `relayMessage`.
//     uint64 public constant RELAY_CALL_OVERHEAD = 40_000;

//     /// @notice Gas reserved for finalizing the execution of `relayMessage` after the safe call.
//     uint64 public constant RELAY_RESERVED_GAS = 40_000;

//     /// @notice Gas reserved for the execution between the `hasMinGas` check and the external
//     ///         call in `relayMessage`.
//     uint64 public constant RELAY_GAS_CHECK_BUFFER = 5_000;

//     /// @notice Address of the paired CrossDomainMessenger contract on the other chain.
//     address public immutable OTHER_MESSENGER;

//     /// @notice Mapping of message hashes to boolean receipt values. Note that a message will only
//     ///         be present in this mapping if it has successfully been relayed on this chain, and
//     ///         can therefore not be relayed again.
//     mapping(bytes32 => bool) public successfulMessages;

//     /// @notice Address of the sender of the currently executing message on the other chain. If the
//     ///         value of this variable is the default value (0x00000000...dead) then no message is
//     ///         currently being executed. Use the xDomainMessageSender getter which will throw an
//     ///         error if this is the case.
//     address internal xDomainMsgSender;

//     /// @notice Nonce for the next message to be sent, without the message version applied. Use the
//     ///         messageNonce getter which will insert the message version into the nonce to give you
//     ///         the actual nonce to be used for the message.
//     uint240 internal msgNonce;

//     /// @notice Mapping of message hashes to a boolean if and only if the message has failed to be
//     ///         executed at least once. A message will not be present in this mapping if it
//     ///         successfully executed on the first attempt.
//     mapping(bytes32 => bool) public failedMessages;

//     /// @notice Reserve extra slots in the storage layout for future upgrades.
//     ///         A gap size of 41 was chosen here, so that the first slot used in a child contract
//     ///         would be a multiple of 50.
//     uint256[42] private __gap;

//     /// @notice Emitted whenever a message is sent to the other chain.
//     /// @param target       Address of the recipient of the message.
//     /// @param sender       Address of the sender of the message.
//     /// @param message      Message to trigger the recipient address with.
//     /// @param messageNonce Unique nonce attached to the message.
//     /// @param gasLimit     Minimum gas limit that the message can be executed with.
//     event SentMessage(address indexed target, address sender, bytes message, uint256 messageNonce, uint256 gasLimit);

//     /// @notice Additional event data to emit, required as of Bedrock. Cannot be merged with the
//     ///         SentMessage event without breaking the ABI of this contract, this is good enough.
//     /// @param sender Address of the sender of the message.
//     /// @param value  ETH value sent along with the message to the recipient.
//     event SentMessageExtension1(address indexed sender, uint256 value);

//     /// @notice Emitted whenever a message is successfully relayed on this chain.
//     /// @param msgHash Hash of the message that was relayed.
//     event RelayedMessage(bytes32 indexed msgHash);

//     /// @notice Emitted whenever a message fails to be relayed on this chain.
//     /// @param msgHash Hash of the message that failed to be relayed.
//     event FailedRelayedMessage(bytes32 indexed msgHash);

//     /// @param _otherMessenger Address of the messenger on the paired chain.
//     constructor(address _otherMessenger) {
//         OTHER_MESSENGER = _otherMessenger;
//     }

//     /// @notice Sends a message to some target address on the other chain. Note that if the call
//     ///         always reverts, then the message will be unrelayable, and any ETH sent will be
//     ///         permanently locked. The same will occur if the target on the other chain is
//     ///         considered unsafe (see the _isUnsafeTarget() function).
//     /// @param _target      Target contract or wallet address.
//     /// @param _message     Message to trigger the target address with.
//     /// @param _minGasLimit Minimum gas limit that the message can be executed with.
//     function sendMessage(address _target, bytes calldata _message, uint32 _minGasLimit) external payable {
//         // Triggers a message to the other messenger. Note that the amount of gas provided to the
//         // message is the amount of gas requested by the user PLUS the base gas value. We want to
//         // guarantee the property that the call to the target contract will always have at least
//         // the minimum gas limit specified by the user.
//         _sendMessage(
//             OTHER_MESSENGER,
//             baseGas(_message, _minGasLimit),
//             msg.value,
//             abi.encodeWithSelector(
//                 this.relayMessage.selector, messageNonce(), msg.sender, _target, msg.value, _minGasLimit, _message
//             )
//         );

//         emit SentMessage(_target, msg.sender, _message, messageNonce(), _minGasLimit);
//         emit SentMessageExtension1(msg.sender, msg.value);

//         unchecked {
//             ++msgNonce;
//         }
//     }

//     /// @notice Relays a message that was sent by the other CrossDomainMessenger contract. Can only
//     ///         be executed via cross-chain call from the other messenger OR if the message was
//     ///         already received once and is currently being replayed.
//     /// @param _nonce       Nonce of the message being relayed.
//     /// @param _sender      Address of the user who sent the message.
//     /// @param _target      Address that the message is targeted at.
//     /// @param _value       ETH value to send with the message.
//     /// @param _minGasLimit Minimum amount of gas that the message can be executed with.
//     /// @param _message     Message to send to the target.
//     function relayMessage(
//         uint256 _nonce,
//         address _sender,
//         address _target,
//         uint256 _value,
//         uint256 _minGasLimit,
//         bytes calldata _message
//     )
//         external
//         payable
//     {
//         (, uint16 version) = Encoding.decodeVersionedNonce(_nonce);
//         require(version < 2, "CrossDomainMessenger: only version 0 or 1 messages are supported at this time");

//         // If the message is version 0, then it's a migrated legacy withdrawal. We therefore need
//         // to check that the legacy version of the message has not already been relayed.
//         if (version == 0) {
//             bytes32 oldHash = Hashing.hashCrossDomainMessageV0(_target, _sender, _message, _nonce);
//             require(successfulMessages[oldHash] == false, "CrossDomainMessenger: legacy withdrawal already relayed");
//         }

//         // We use the v1 message hash as the unique identifier for the message because it commits
//         // to the value and minimum gas limit of the message.
//         bytes32 versionedHash =
//             Hashing.hashCrossDomainMessageV1(_nonce, _sender, _target, _value, _minGasLimit, _message);

//         if (_isOtherMessenger()) {
//             // These properties should always hold when the message is first submitted (as
//             // opposed to being replayed).
//             assert(msg.value == _value);
//             assert(!failedMessages[versionedHash]);
//         } else {
//             require(msg.value == 0, "CrossDomainMessenger: value must be zero unless message is from a system address");

//             require(failedMessages[versionedHash], "CrossDomainMessenger: message cannot be replayed");
//         }

//         require(
//             _isUnsafeTarget(_target) == false, "CrossDomainMessenger: cannot send message to blocked system address"
//         );

//         require(successfulMessages[versionedHash] == false, "CrossDomainMessenger: message has already been relayed");

//         // If there is not enough gas left to perform the external call and finish the execution,
//         // return early and assign the message to the failedMessages mapping.
//         // We are asserting that we have enough gas to:
//         // 1. Call the target contract (_minGasLimit + RELAY_CALL_OVERHEAD + RELAY_GAS_CHECK_BUFFER)
//         //   1.a. The RELAY_CALL_OVERHEAD is included in `hasMinGas`.
//         // 2. Finish the execution after the external call (RELAY_RESERVED_GAS).
//         //
//         // If `xDomainMsgSender` is not the default L2 sender, this function
//         // is being re-entered. This marks the message as failed to allow it to be replayed.
//         if (
//             !SafeCall.hasMinGas(_minGasLimit, RELAY_RESERVED_GAS + RELAY_GAS_CHECK_BUFFER)
//                 || xDomainMsgSender != Constants.DEFAULT_L2_SENDER
//         ) {
//             failedMessages[versionedHash] = true;
//             emit FailedRelayedMessage(versionedHash);

//             // Revert in this case if the transaction was triggered by the estimation address. This
//             // should only be possible during gas estimation or we have bigger problems. Reverting
//             // here will make the behavior of gas estimation change such that the gas limit
//             // computed will be the amount required to relay the message, even if that amount is
//             // greater than the minimum gas limit specified by the user.
//             if (tx.origin == Constants.ESTIMATION_ADDRESS) {
//                 revert("CrossDomainMessenger: failed to relay message");
//             }

//             return;
//         }

//         xDomainMsgSender = _sender;
//         bool success = SafeCall.call(_target, gasleft() - RELAY_RESERVED_GAS, _value, _message);
//         xDomainMsgSender = Constants.DEFAULT_L2_SENDER;

//         if (success) {
//             successfulMessages[versionedHash] = true;
//             emit RelayedMessage(versionedHash);
//         } else {
//             failedMessages[versionedHash] = true;
//             emit FailedRelayedMessage(versionedHash);

//             // Revert in this case if the transaction was triggered by the estimation address. This
//             // should only be possible during gas estimation or we have bigger problems. Reverting
//             // here will make the behavior of gas estimation change such that the gas limit
//             // computed will be the amount required to relay the message, even if that amount is
//             // greater than the minimum gas limit specified by the user.
//             if (tx.origin == Constants.ESTIMATION_ADDRESS) {
//                 revert("CrossDomainMessenger: failed to relay message");
//             }
//         }
//     }

//     /// @notice Retrieves the address of the contract or wallet that initiated the currently
//     ///         executing message on the other chain. Will throw an error if there is no message
//     ///         currently being executed. Allows the recipient of a call to see who triggered it.
//     /// @return Address of the sender of the currently executing message on the other chain.
//     function xDomainMessageSender() external view returns (address) {
//         require(
//             xDomainMsgSender != Constants.DEFAULT_L2_SENDER, "CrossDomainMessenger: xDomainMessageSender is not set"
//         );

//         return xDomainMsgSender;
//     }

//     /// @notice Retrieves the next message nonce. Message version will be added to the upper two
//     ///         bytes of the message nonce. Message version allows us to treat messages as having
//     ///         different structures.
//     /// @return Nonce of the next message to be sent, with added message version.
//     function messageNonce() public view returns (uint256) {
//         return Encoding.encodeVersionedNonce(msgNonce, MESSAGE_VERSION);
//     }

//     /// @notice Computes the amount of gas required to guarantee that a given message will be
//     ///         received on the other chain without running out of gas. Guaranteeing that a message
//     ///         will not run out of gas is important because this ensures that a message can always
//     ///         be replayed on the other chain if it fails to execute completely.
//     /// @param _message     Message to compute the amount of required gas for.
//     /// @param _minGasLimit Minimum desired gas limit when message goes to target.
//     /// @return Amount of gas required to guarantee message receipt.
//     function baseGas(bytes calldata _message, uint32 _minGasLimit) public pure returns (uint64) {
//         return
//         // Constant overhead
//         RELAY_CONSTANT_OVERHEAD
//         // Calldata overhead
//         + (uint64(_message.length) * MIN_GAS_CALLDATA_OVERHEAD)
//         // Dynamic overhead (EIP-150)
//         + ((_minGasLimit * MIN_GAS_DYNAMIC_OVERHEAD_NUMERATOR) / MIN_GAS_DYNAMIC_OVERHEAD_DENOMINATOR)
//         // Gas reserved for the worst-case cost of 3/5 of the `CALL` opcode's dynamic gas
//         // factors. (Conservative)
//         + RELAY_CALL_OVERHEAD
//         // Relay reserved gas (to ensure execution of `relayMessage` completes after the
//         // subcontext finishes executing) (Conservative)
//         + RELAY_RESERVED_GAS
//         // Gas reserved for the execution between the `hasMinGas` check and the `CALL`
//         // opcode. (Conservative)
//         + RELAY_GAS_CHECK_BUFFER;
//     }

//     /// @notice Initializer.
//     // solhint-disable-next-line func-name-mixedcase
//     function __CrossDomainMessenger_init() internal onlyInitializing {
//         xDomainMsgSender = Constants.DEFAULT_L2_SENDER;
//     }

//     /// @notice Sends a low-level message to the other messenger. Needs to be implemented by child
//     ///         contracts because the logic for this depends on the network where the messenger is
//     ///         being deployed.
//     /// @param _to       Recipient of the message on the other chain.
//     /// @param _gasLimit Minimum gas limit the message can be executed with.
//     /// @param _value    Amount of ETH to send with the message.
//     /// @param _data     Message data.
//     function _sendMessage(address _to, uint64 _gasLimit, uint256 _value, bytes memory _data) internal virtual;

//     /// @notice Checks whether the message is coming from the other messenger. Implemented by child
//     ///         contracts because the logic for this depends on the network where the messenger is
//     ///         being deployed.
//     /// @return Whether the message is coming from the other messenger.
//     function _isOtherMessenger() internal view virtual returns (bool);

//     /// @notice Checks whether a given call target is a system address that could cause the
//     ///         messenger to peform an unsafe action. This is NOT a mechanism for blocking user
//     ///         addresses. This is ONLY used to prevent the execution of messages to specific
//     ///         system addresses that could cause security issues, e.g., having the
//     ///         CrossDomainMessenger send messages to itself.
//     /// @param _target Address of the contract to check.
//     /// @return Whether or not the address is an unsafe system address.
//     function _isUnsafeTarget(address _target) internal view virtual returns (bool);
// }


// /// @custom:predeploy 0x4300000000000000000000000000000000000000
// /// @title SharesBase
// /// @notice Base contract to track share rebasing and yield reporting.
// abstract contract SharesBase is Initializable {
//     /// @notice Approved yield reporter.
//     address public immutable REPORTER;

//     /// @notice Share price. This value can only increase.
//     uint256 public price;

//     /// @notice Accumulated yield that has not been distributed
//     ///         to the share price.
//     uint256 public pending;

//     /// @notice Reserve extra slots (to a total of 50) in the storage layout for future upgrades.
//     ///         A gap size of 48 was chosen here, so that the first slot used in a child contract
//     ///         would be a multiple of 50.
//     uint256[48] private __gap;

//     /// @notice Emitted when a new share price is set after a yield event.
//     event NewPrice(uint256 price);

//     error InvalidReporter();
//     error DistributeFailed(uint256 count, uint256 pending);
//     error PriceIsInitialized();

//     /// @param _reporter Address of the approved yield reporter.
//     constructor(address _reporter) {
//         REPORTER = _reporter;
//     }

//     /// @notice Initializer.
//     /// @param _price Initial share price.
//     // solhint-disable-next-line func-name-mixedcase
//     function __SharesBase_init(uint256 _price) internal onlyInitializing {
//         if (price != 0) {
//             revert PriceIsInitialized();
//         }
//         price = _price;
//     }

//     /// @notice Get the total number of shares. Needs to be
//     ///         overridden by the child contract.
//     /// @return Total number of shares.
//     function count() public view virtual returns (uint256);

//     /// @notice Report a yield event and update the share price.
//     /// @param value Amount of new yield
//     function addValue(uint256 value) external {
//         if (AddressAliasHelper.undoL1ToL2Alias(msg.sender) != REPORTER) {
//             revert InvalidReporter();
//         }

//         if (value > 0) {
//             pending += value;
//         }

//         _tryDistributePending();
//     }

//     /// @notice Distribute pending yields.
//     function distributePending() external {
//         if (!_tryDistributePending()) {
//             revert DistributeFailed(count(), pending);
//         }
//     }

//     /// @notice Attempt to distribute pending yields if there
//     ///         are sufficient pending yields to increase the
//     ///         share price.
//     /// @return True if there were sufficient pending yields to
//     ///         increase the share price.
//     function _tryDistributePending() internal returns (bool) {
//         if (pending < count() || count() == 0) {
//             return false;
//         }

//         price += pending / count();
//         pending = pending % count();

//         emit NewPrice(price);

//         return true;
//     }
// }

// /// @custom:predeploy 0x4300000000000000000000000000000000000000
// /// @title Shares
// /// @notice Integrated EVM contract to manage native ether share
// ///         rebasing from yield reports.
// contract Shares is SharesBase, Semver {
//     /// @notice Total number of shares. This value is modified directly
//     ///         by the sequencer EVM.
//     uint256 private _count;

//     /// @notice _reporter Address of approved yield reporter.
//     constructor(uint256 _price, address _reporter) SharesBase(_reporter) Semver(1, 0, 0) {
//         initialize({ _price: _price });
//     }

//     /// @notice Initializer.
//     function initialize(uint256 _price) public initializer {
//         __SharesBase_init({ _price: _price });
//     }

//     /// @inheritdoc SharesBase
//     function count() public view override returns (uint256) {
//         return _count;
//     }
// }




// /// @custom:upgradeable
// /// @title ERC20Rebasing
// /// @notice ERC20 implementation with rebasing token balances. There are 3 yield
// /// modes with different rebasing behaviors.
// ///
// /// AUTOMATIC dynamically updates the balance as the share price increases.
// ///
// /// VOID fixes the balance and exempts the account from receiving yields.
// ///
// /// CLAIMABLE fixes the balance and allows the account to claim yields to
// /// another account.
// ///
// /// The child implementation is responsible for deciding how the share price is set.
// abstract contract ERC20Rebasing is Initializable, ERC20Permit, IERC20 {
//     /// @notice Number of decimals.
//     uint8 public immutable decimals;

//     /// @notice Name of the token.
//     string public name;
//     /// @notice Symbol of the token.
//     string public symbol;

//     /// @notice Mapping that stores the number of shares for each account.
//     mapping(address => uint256) private _shares;

//     /// @notice Total number of shares distributed.
//     uint256 internal _totalShares;

//     /// @notice Mapping that stores the number of remainder tokens for each account.
//     mapping(address => uint256) private _remainders;

//     /// @notice Mapping that stores the number of fixed tokens for each account.
//     mapping(address => uint256) private _fixed;

//     /// @notice Total number of non-rebasing tokens.
//     uint256 internal _totalVoidAndRemainders;

//     /// @notice Mapping that stores the configured yield mode for each account.
//     mapping(address => YieldMode) private _yieldMode;

//     /// @notice Mapping that stores the allowance for a given spender and operator pair.
//     mapping(address => mapping(address => uint256)) private _allowances;

//     /// @notice Reserve extra slots (to a total of 50) in the storage layout for future upgrades.
//     ///         A gap size of 41 was chosen here, so that the first slot used in a child contract
//     ///         would be a multiple of 50.
//     uint256[41] private __gap;

//     /// @notice Emitted when an account configures their yield mode.
//     /// @param account   Address of the account.
//     /// @param yieldMode Yield mode that was configured.
//     event Configure(address indexed account, YieldMode yieldMode);

//     /// @notice Emitted when a CLAIMABLE account claims their yield.
//     /// @param account   Address of the account.
//     /// @param recipient Address of the recipient.
//     /// @param amount    Amount of yield claimed.
//     event Claim(address indexed account, address indexed recipient, uint256 amount);

//     error InsufficientBalance();
//     error InsufficientAllowance();
//     error CannotClaimToSameAccount();
//     error TransferFromZeroAddress();
//     error TransferToZeroAddress();
//     error ApproveFromZeroAddress();
//     error ApproveToZeroAddress();
//     error NotClaimableAccount();

//     /// @param _name     Token name.
//     /// @param _symbol   Token symbol.
//     /// @param _decimals Number of decimals.
//     constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20Permit(_name) {
//         decimals = _decimals;
//     }

//     /// @param _name     Token name.
//     /// @param _symbol   Token symbol.
//     function __ERC20Rebasing_init(string memory _name, string memory _symbol) internal onlyInitializing {
//         name = _name;
//         symbol = _symbol;
//     }

//     /// @notice --- ERC20 Interface ---

//     /// @inheritdoc IERC20
//     function totalSupply() external view returns (uint256) {
//         return sharePrice() * _totalShares + _totalVoidAndRemainders;
//     }

//     /// @inheritdoc IERC20
//     function balanceOf(address account)
//         public
//         view
//         virtual
//         returns (uint256 value)
//     {
//         YieldMode yieldMode = _yieldMode[account];
//         if (yieldMode == YieldMode.AUTOMATIC) {
//             value = _computeShareValue(sharePrice(), _shares[account], _remainders[account]);
//         } else {
//             value = _fixed[account];
//         }
//     }

//     /// @inheritdoc IERC20
//     function allowance(address owner, address spender)
//         public
//         view
//         virtual
//         returns (uint256)
//     {
//         return _allowances[owner][spender];
//     }

//     /// @inheritdoc IERC20
//     function transfer(address to, uint256 amount)
//         public
//         virtual
//         returns (bool)
//     {
//         _transfer(msg.sender, to, amount);
//         return true;
//     }

//     /// @inheritdoc IERC20
//     function approve(address spender, uint256 amount)
//         public
//         virtual
//         returns (bool)
//     {
//         address owner = msg.sender;
//         _approve(owner, spender, amount);
//         return true;
//     }

//     /// @inheritdoc IERC20
//     function transferFrom(
//         address from,
//         address to,
//         uint256 amount
//     ) public virtual returns (bool) {
//         _spendAllowance(from, msg.sender, amount);
//         _transfer(from, to, amount);
//         return true;
//     }

//     /// @notice --- Blast Interface ---

//     /// @notice Query an account's configured yield mode.
//     /// @param account Address to query the configuration.
//     /// @return Configured yield mode.
//     function getConfiguration(address account) public view returns (YieldMode) {
//         return _yieldMode[account];
//     }

//     /// @notice Get current share price. To be overridden by
//     ///         child contract.
//     /// @return sharePrice Current share price.
//     function sharePrice() public view virtual returns (uint256);

//     /// @notice Query an CLAIMABLE account's claimable yield.
//     /// @param account Address to query the claimable amount.
//     /// @return amount Claimable amount.
//     function getClaimableAmount(address account) public view returns (uint256) {
//         if (getConfiguration(account) != YieldMode.CLAIMABLE) {
//             revert NotClaimableAccount();
//         }

//         uint256 shareValue = _computeShareValue(sharePrice(), _shares[account], _remainders[account]);
//         return shareValue - _fixed[account];
//     }

//     /// @notice Claim yield from a CLAIMABLE account and send to
//     ///         a recipient.
//     /// @param recipient Address to receive the claimed balance.
//     /// @param amount    Amount to claim.
//     /// @return amount Amount claimed.
//     function claim(address recipient, uint256 amount) external returns (uint256) {
//         address account = msg.sender;

//         if (account == recipient) {
//             revert CannotClaimToSameAccount();
//         }

//         if (getConfiguration(account) != YieldMode.CLAIMABLE) {
//             revert NotClaimableAccount();
//         }

//         uint256 currentSharePrice = sharePrice();
//         uint256 shareValue = _computeShareValue(currentSharePrice, _shares[account], _remainders[account]);

//         uint256 claimableAmount = shareValue - _fixed[account];
//         if (amount > claimableAmount) {
//             revert InsufficientBalance();
//         }

//         (uint256 newShares, uint256 newRemainder) = _computeSharesAndRemainder(currentSharePrice, shareValue - amount);

//         _deposit(recipient, amount);
//         _updateBalance(account, newShares, newRemainder, _fixed[account]);

//         emit Claim(msg.sender, recipient, amount);

//         return amount;
//     }

//     /// @notice Change the yield mode of the caller and update the
//     ///         balance to reflect the configuration.
//     /// @param yieldMode Yield mode to configure
//     /// @return Current user balance
//     function configure(YieldMode yieldMode) external returns (uint256) {
//         _configure(msg.sender, yieldMode);

//         emit Configure(msg.sender, yieldMode);

//         return balanceOf(msg.sender);
//     }

//     /// @notice Moves `amount` of tokens from `from` to `to`.
//     /// @param from   Address of the sender.
//     /// @param to     Address of the recipient.
//     /// @param amount Amount of tokens to send.
//     function _transfer(
//         address from,
//         address to,
//         uint256 amount
//     ) internal virtual {
//         if (from == address(0)) revert TransferFromZeroAddress();
//         if (to == address(0)) revert TransferToZeroAddress();

//         uint256 currentSharePrice = sharePrice();
//         uint256 fromBalance = balanceOf(from);
//         if (amount > fromBalance) {
//             revert InsufficientBalance();
//         }
//         uint256 toBalance = balanceOf(to);
//         _setBalance(from, fromBalance - amount, currentSharePrice, false);
//         _setBalance(to, toBalance + amount, currentSharePrice, false);

//         /// If the sender is configured as VOID, then the amount
//         /// is deducted from the total voided funds.
//         YieldMode fromYieldMode = getConfiguration(from);
//         if (fromYieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders -= amount;
//         }

//         /// If the receiver is configured as VOID, then the amount
//         /// is added to the total voided funds.
//         YieldMode toYieldMode = getConfiguration(to);
//         if (toYieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders += amount;
//         }

//         emit Transfer(from, to, amount);
//     }

//     /// @notice Sets `amount` as the allowance of `spender` over the `owner` s tokens.
//     /// @param owner   Address of the owner.
//     /// @param spender Address of the spender.
//     /// @param amount  Amount of tokens to approve.
//     function _approve(
//         address owner,
//         address spender,
//         uint256 amount
//     ) internal override {
//         if (owner == address(0)) revert ApproveFromZeroAddress();
//         if (spender == address(0)) revert ApproveToZeroAddress();

//         _allowances[owner][spender] = amount;
//         emit Approval(owner, spender, amount);
//     }

//     /// @notice Updates `owner` s allowance for `spender` based on spent `amount`.
//     /// @param owner   Address of the owner.
//     /// @param spender Address of the spender.
//     /// @param amount  Amount of tokens to spender.
//     function _spendAllowance(
//         address owner,
//         address spender,
//         uint256 amount
//     ) internal virtual {
//         uint256 currentAllowance = allowance(owner, spender);
//         if (currentAllowance != type(uint256).max) {
//             if (amount > currentAllowance) revert InsufficientAllowance();
//             unchecked {
//                 _approve(owner, spender, currentAllowance - amount);
//             }
//         }
//     }

//     /// @notice Deposit to an account.
//     /// @param account Address of the account to deposit to.
//     /// @param amount  Amount to deposit to the account.
//     function _deposit(address account, uint256 amount) internal {
//         uint256 balanceAfter = balanceOf(account) + amount;
//         _setBalance(account, balanceAfter, sharePrice(), false);

//         /// If the user is configured as VOID, then the amount
//         /// is added to the total voided funds.
//         YieldMode yieldMode = getConfiguration(account);
//         if (yieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders += amount;
//         }
//     }

//     /// @notice Withdraw from an account.
//     /// @param account Address of the account to withdraw from.
//     /// @param amount  Amount to withdraw to the account.
//     function _withdraw(address account, uint256 amount) internal {
//         uint256 balance = balanceOf(account);
//         if (amount > balance) {
//             revert InsufficientBalance();
//         }

//         unchecked {
//             _setBalance(account, balance - amount, sharePrice(), false);
//         }

//         /// If the user is configured as VOID, then the amount
//         /// is deducted from the total voided funds.
//         YieldMode yieldMode = getConfiguration(account);
//         if (yieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders -= amount;
//         }
//     }

//     /// @notice Configures a new yield mode for an account and updates
//     ///         the balance storage to reflect the change.
//     /// @param account      Address of the account to configure.
//     /// @param newYieldMode New yield mode to configure.
//     function _configure(address account, YieldMode newYieldMode) internal {
//         uint256 balance = balanceOf(account);

//         YieldMode prevYieldMode = getConfiguration(account);
//         _yieldMode[account] = newYieldMode;

//         uint256 prevFixed = _fixed[account];

//         _setBalance(account, balance, sharePrice(), true);

//         /// If the previous yield mode was VOID, then the amount
//         /// is deducted from the total voided funds.
//         if (prevYieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders -= prevFixed;
//         }

//         /// If the new yield mode is VOID, then the amount
//         /// is added to the total voided funds.
//         if (newYieldMode == YieldMode.VOID) {
//             _totalVoidAndRemainders += balance;
//         }
//     }

//     /// @notice Sets the balance of an account according to it's yield mode
//     ///         configuration.
//     /// @param account           Address of the account to set the balance of.
//     /// @param amount            Balance to set for the account.
//     /// @param currentSharePrice Current share price.
//     /// @param resetClaimable    If the account is CLAIMABLE, true if the share
//     ///                          balance should be set to the amount. Should only be true when
//     ///                          configuring the account.
//     function _setBalance(address account, uint256 amount, uint256 currentSharePrice, bool resetClaimable) internal {
//         uint256 newShares; uint256 newRemainder; uint256 newFixed;
//         YieldMode yieldMode = getConfiguration(account);
//         if (yieldMode == YieldMode.AUTOMATIC) {
//             (newShares, newRemainder) = _computeSharesAndRemainder(currentSharePrice, amount);
//         } else if (yieldMode == YieldMode.VOID) {
//             newFixed = amount;
//         } else if (yieldMode == YieldMode.CLAIMABLE) {
//             newFixed = amount;
//             uint256 shareValue = amount;
//             if (!resetClaimable) {
//                 /// In order to not reset the claimable balance, we have to compute
//                 /// the user's current share balance and add or subtract the change in
//                 /// fixed balance before computing the new shares balance parameters.
//                 shareValue = _computeShareValue(currentSharePrice, _shares[account], _remainders[account]);
//                 shareValue = shareValue + amount - _fixed[account];
//             }
//             (newShares, newRemainder) = _computeSharesAndRemainder(currentSharePrice, shareValue);
//         }

//         _updateBalance(account, newShares, newRemainder, newFixed);
//     }

//     /// @notice Update the balance paramters of an account and appropriately refresh the global sums
//     ///         to reflect the change of allocation.
//     /// @param account      Address of account to update.
//     /// @param newShares    New shares value for account.
//     /// @param newRemainder New remainder value for account.
//     /// @param newFixed     New fixed value for account.
//     function _updateBalance(address account, uint256 newShares, uint256 newRemainder, uint256 newFixed) internal {
//         _totalShares = _totalShares + newShares - _shares[account];
//         _totalVoidAndRemainders = _totalVoidAndRemainders + newRemainder - _remainders[account];

//         _shares[account] = newShares;
//         _remainders[account] = newRemainder;
//         _fixed[account] = newFixed;
//     }

//     /// @notice Convert nominal value to number of shares with remainder.
//     /// @param currentSharePrice Current share price (wad).
//     /// @param value             Amount to convert to shares (wad).
//     /// @return shares Number of shares (wad), remainder Remainder (wad).
//     function _computeSharesAndRemainder(uint256 currentSharePrice, uint256 value) internal pure returns (uint256 shares, uint256 remainder) {
//         if (currentSharePrice == 0) {
//             remainder = value;
//         } else {
//             shares = value / currentSharePrice;
//             remainder = value % currentSharePrice;
//         }
//     }

//     /// @notice Compute nominal value from number of shares.
//     /// @param currentSharePrice Current share price (wad).
//     /// @param shares            Number of shares (wad).
//     /// @param remainders        (wad).
//     /// @return value (wad).
//     function _computeShareValue(uint256 currentSharePrice, uint256 shares, uint256 remainders) internal pure returns (uint256) {
//         return currentSharePrice * shares + remainders;
//     }
// }


// /// @custom:proxied
// /// @custom:predeploy 0x4200000000000000000000000000000000000022
// /// @title USDB
// /// @notice Rebasing ERC20 token with the share price determined by an L1
// ///         REPORTER. Conforms to OptimismMintableERC20 interface to allow mint/burn
// ///         interfactions from the L1BlastBridge.
// contract USDB is SharesBase, ERC20Rebasing, Semver, IOptimismMintableERC20 {
//     /// @notice Address of the corresponding version of this token on the remote chain.
//     address public immutable REMOTE_TOKEN;

//     /// @notice Address of the BlastBridge on this network.
//     address public immutable BRIDGE;

//     /// @notice Emitted whenever tokens are minted for an account.
//     /// @param account Address of the account tokens are being minted for.
//     /// @param amount  Amount of tokens minted.
//     event Mint(address indexed account, uint256 amount);

//     /// @notice Emitted whenever tokens are burned from an account.
//     /// @param account Address of the account tokens are being burned from.
//     /// @param amount  Amount of tokens burned.
//     event Burn(address indexed account, uint256 amount);

//     error CallerIsNotBridge();

//     /// @notice A modifier that only allows the bridge to call
//     modifier onlyBridge() {
//         // UNDO alias required because _bridge is a L1 address
//         if (AddressAliasHelper.undoL1ToL2Alias(msg.sender) != BRIDGE) {
//             revert CallerIsNotBridge();
//         }
//         _;
//     }

//     /// @custom:semver 1.0.0
//     /// @param _bridge      Address of the L1 USD bridge.
//     /// @param _remoteToken Address of the corresponding L1 token.
//     constructor(address _bridge, address _remoteToken)
//         SharesBase(_bridge)
//         ERC20Rebasing("Rebasing USD", "USDB", 18)
//         Semver(1, 0, 0)
//     {
//         BRIDGE = _bridge;
//         REMOTE_TOKEN = _remoteToken;
//         initialize();
//     }

//     /// @notice Initializer
//     function initialize() public initializer {
//         __ERC20Rebasing_init("Rebasing USD", "USDB");
//         __SharesBase_init({ _price: 1e8 });
//     }

//     /// @inheritdoc ERC20Rebasing
//     function sharePrice() public view override returns (uint256) {
//         return price;
//     }

//     /// @inheritdoc SharesBase
//     function count() public view override returns (uint256) {
//         return _totalShares;
//     }

//     /// @notice ERC165 interface check function.
//     /// @param _interfaceId Interface ID to check.
//     /// @return Whether or not the interface is supported by this contract.
//     function supportsInterface(bytes4 _interfaceId) external pure returns (bool) {
//         bytes4 iface1 = type(IERC165).interfaceId;
//         // Interface corresponding to the updated OptimismMintableERC20 (this contract).
//         bytes4 iface2 = type(IOptimismMintableERC20).interfaceId;
//         return _interfaceId == iface1 || _interfaceId == iface2;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for REMOTE_TOKEN.
//     function remoteToken() public view returns (address) {
//         return REMOTE_TOKEN;
//     }

//     /// @custom:legacy
//     /// @notice Legacy getter for BRIDGE.
//     function bridge() public view returns (address) {
//         return BRIDGE;
//     }

//     /// @notice Allows the StandardBridge on this network to mint tokens.
//     /// @param _to     Address to mint tokens to.
//     /// @param _amount Amount of tokens to mint.
//     function mint(address _to, uint256 _amount)
//         external
//         virtual
//         onlyBridge
//     {
//         if (_to == address(0)) {
//             revert TransferToZeroAddress();
//         }

//         _deposit(_to, _amount);
//         emit Mint(_to, _amount);
//     }

//     /// @notice Allows the StandardBridge on this network to burn tokens.
//     /// @param _from   Address to burn tokens from.
//     /// @param _amount Amount of tokens to burn.
//     function burn(address _from, uint256 _amount)
//         external
//         virtual
//         onlyBridge
//     {
//         if (_from == address(0)) {
//             revert TransferFromZeroAddress();
//         }

//         uint256 accountBalance = balanceOf(_from);
//         if (_amount > accountBalance) {
//             revert InsufficientBalance();
//         }
//         _withdraw(_from, _amount);

//         emit Burn(_from, _amount);
//     }
// }
