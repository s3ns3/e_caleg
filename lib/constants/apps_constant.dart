const  kJumlahPartai = 17;
const  kSelectionItemLoginType = 1;
const  kSelectionItemPartai = 2;
const  kListCaleg = 3;

const kPagePreparation = 0;
const kPageDataPersonal = 1;
const kPageDataCreatePass = 2;
const kPageDataLoginFinger = 3;

const kPageUploadFull= 1;

// const kEngineUrlDebug = 'https://saksi.punyasurya.com/api/';
const kEngineUrlDebug = 'http://192.168.1.22:8080/';
const kEngineUrlRelease = 'https://saksi.punyasurya.com/api/';
const kAllowAllSsl = true;
const rcPictureNotTaken = 'X501';
const kHttpTimeoutConnect = 60 * 1000; // seems bugs in DIO, where connectTimeout is used as receiveTimeout
const kHttpTimeoutForImage = 30 * 1000; // Duration(seconds: 10); 10s
const kHttpTimeoutForPost = 30 * 1000; // Duration(seconds: 10);
const kHttpTimeoutForUploadFile = 60 * 1000;
const kLogoutDelay = Duration(seconds: 500);

const kAppsMsgErrSystem = 'Terjadi masalah pada sistem';

const kEndponitLoginPass = 'auth';
const kEndponitDocumentInit = 'document-init';
const kEndponitDocumentUpload = 'document-upload';