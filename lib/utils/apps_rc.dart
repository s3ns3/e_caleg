
const rcSuccess = '0';
const rcInProgress = '';

// rc from engine
const rcAppsNeedUpgrade = '7010'; // if apps need to upgrade
const rcAppsRegistrationPending = '7091'; // registration pending
const rcAppsCustomerExists = '7092'; // registration approved, customer exists
const rcAppsAccNoInvalid = '7093'; // account no is invalid
const rcAppsCustomerNotFound = '7103'; // when login, customer not found
const rcAppsInvalidFirebaseBioToken = '7104'; // login biometric but invalid firease / biotoken
const rcAppsInvalidMaxPass = '7107'; // otomatis logout kalau dapat rc ini
const rcAppsDuplicateCustDiffAcc = '7100';  // when register with diff accNo
const rcAppsInvalidPin = '7111';
const rcAppsInvalidMaxPin = '7108';

// rc mobile apps, use X as prefix
const rcJailbroken = 'X100'; // device is jailbroken
//const rcUnavailableDeviceId = 'X102'; // deviceId cannot be retrieved, maybe no permission ?
const rcErrorFcmInit = 'X103';
const rcSystemError = 'X104'; // system error, e.g database is not valid

const rcServerFailed = 'X201'; // server failed response 404, 500, etc
const rcConnectionError = 'X202';  // connect timeout, receive timeout, user can check connection and retry
const rcNetworkGeneralError = 'X203';  // general error when connecting to server

const rcValidationError = 'X301'; // validation error, include missing input, confirmPassDiff, etc
const rcUnActivated = 'X304'; //user not yet doing activation
const rcAleradyReset = 'X305'; //user already reset password, plese check email
//const rcTransactionFailed = 'X302'; // transaction failed
//const rcInsufficientSpace = 'X303'; // insufficient space, used in kyc

const rcLoginNeedOtp = 'X401'; // special rc indicate that login need otp
const rcLoginNeedCreatePin = 'X402'; // special rc indicate that login create pin
