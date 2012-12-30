#!/usr/bin/env dart

import 'dart:io';
import 'package:buildtool/buildtool.dart';
import 'package:buildtool/dart2js_task.dart';
void main() {
  var config = () {
    var dart2jstask = new Dart2JSTask.withOutDir("dart2js", new Path("."));
    addTask(["app.dart"], dart2jstask);
  };

  configure(config);
}
