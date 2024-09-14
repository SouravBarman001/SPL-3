// ai_service.dart
import 'package:brain_fusion/brain_fusion.dart';
import 'dart:typed_data';

class AIService {
  final AI _ai = AI();

  Future<Uint8List> generateImage(String query, AIStyle style) async {
    return await _ai.runAI(query, style);
  }
}
