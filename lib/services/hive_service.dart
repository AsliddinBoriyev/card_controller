import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/card_model.dart';

enum StorageKeys {
  cards
}

class HiveService {
  static const String dbName = "AppData";

  static Future<void> setCards(List<CardModel> cards) async {
    var box = Hive.box(dbName);
    List<Map<String, dynamic>> json = cards.map((card) => card.toJson()).toList();
    box.put(StorageKeys.cards.name, jsonEncode(json));
  }

  static List<CardModel> readCards() {
    var box = Hive.box(dbName);
    String data = box.get(StorageKeys.cards.name, defaultValue: '[]');
    List json = jsonDecode(data);
    List<CardModel> users = json.map((item) => CardModel.fromJson(item)).toList();
    // List<User> users = json.map(User.fromJson).toList();
    return users;
  }

  static Future<void> deleteAllCards() async {
    var box = Hive.box(dbName);
    await box.clear();
  }
}