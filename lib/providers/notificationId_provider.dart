import 'package:flutter_riverpod/flutter_riverpod.dart';

final uniqueIDProvider = StateNotifierProvider<UniqueIdNotifier, int>((ref) {
  return UniqueIdNotifier();
});

class UniqueIdNotifier extends StateNotifier<int> {
  UniqueIdNotifier() : super(0);

  int getNextId() {
    state = state + 1;
    return state;
  }
}
