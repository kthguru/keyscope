/*
 * Copyright 2025-2026 Infradise Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';
import 'package:args/args.dart';
import 'package:keyscope/keyscope.dart';
// import 'package:valkey_client/valkey_client.dart';

void main(List<String> arguments) async {
  // e.g., keyscope --ping
  final parser = ArgParser()
    ..addOption('host', abbr: 'h', defaultsTo: 'localhost', help: 'Target host')
    ..addOption('port', abbr: 'p', defaultsTo: '6379', help: 'Target port')
    ..addFlag('ping', help: 'Check connectivity (PING/PONG)', negatable: false)
    ..addFlag('help',
        abbr: '?', help: 'Show usage information', negatable: false);

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      print('Keyscope CLI - Diagnostic Tool\n');
      print(parser.usage);
      exit(0);
    }

    final host = results['host'] as String;
    final port = int.parse(results['port'] as String);

    if (results['ping'] as bool) {
      await _runPingTest(host, port);
    } else {
      print('No command specified. Use --help for usage.');
    }
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

Future<void> _runPingTest(String host, int port) async {
  print('Running PING test on $host:$port...');

  // Here we use the Repository logic defined in lib/
  // Since we are in CLI (no Riverpod), we instantiate the repository directly.
  final repo = BasicConnectionRepository();

  try {
    // In the future, this will return real connection status
    await repo.connect(host: host, port: port);
    print('✅ Connection Status: OK');
    // TODO: Implement actual PING command via valkey_client
  } catch (e) {
    print('❌ Connection Failed: $e');
    exit(1);
  }
}
