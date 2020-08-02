const _tag = 'Cross-Solutions/Smart-Notes';

void debugInfo(String message) => print(_getFormattedMessage('INFO', message));

void debugError(String message) =>
    print(_getFormattedMessage('ERROR', message));

void debugWrite(String tag, String message) =>
    print(_getFormattedMessage(tag, message));

String _getFormattedMessage(String level, String message) =>
    '$_tag ($level): $message';
