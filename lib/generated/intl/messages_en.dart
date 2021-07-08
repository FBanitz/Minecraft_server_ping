// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(responseHostname) => "Hostname : ${responseHostname}";

  static m1(responsePlayerCount, responseMaxPlayers) => "Players : ${responsePlayerCount} / ${responseMaxPlayers}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "hostname" : m0,
    "hostname_imput" : MessageLookupByLibrary.simpleMessage("Hostname or IP"),
    "no_internet" : MessageLookupByLibrary.simpleMessage("You are not connected to the internet, check your connection"),
    "players" : m1,
    "welcome_message" : MessageLookupByLibrary.simpleMessage("Enter the IP or the hostname of the server"),
    "wrong_ip" : MessageLookupByLibrary.simpleMessage("Can\'t resolve hostname / IP")
  };
}