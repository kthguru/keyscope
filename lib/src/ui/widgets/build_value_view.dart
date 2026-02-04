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

import 'dart:convert' show utf8; // Utf8Codec

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show BinaryCodec;

import 'content_analyzer.dart' show ContentAnalyzer, ContentType;
import 'viewer/hex.dart' show HexViewer;
import 'viewer/json.dart' show JsonViewer;
import 'viewer/text.dart' show TextViewer;

Widget buildValueView(List<int> rawData) {
  final type = ContentAnalyzer.analyze(rawData);

  return switch (type) {
      ContentType.binary => HexViewer(data: rawData),
      ContentType.json => 
          JsonViewer(jsonString: utf8.decode(rawData)),
      ContentType.text || _ => 
          TextViewer(text: utf8.decode(rawData)),
  };
}





