import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/element_model.dart';

class ElementApiService {
  Future<List<ElementModel>> getElements() async {
    // Load local JSON file for now
    final String response = await rootBundle.loadString('assets/elements.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => ElementModel.fromJson(json)).toList();
  }
}