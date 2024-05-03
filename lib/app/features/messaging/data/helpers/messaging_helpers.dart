///
/// This function take both user uids and then sort alphabetically
///
/// return string example
/// ```dart
///  "uidExample0_uidExample1"
/// ```
///
///
String getMessageCollection(String firstUid, String secondUid) {
  final uids = [firstUid, secondUid];
  uids.sort();
  return uids.join('_');
}
