import 'dart:io';

String fixture(final String fileName) => File('test/fixtures/$fileName').readAsStringSync();
