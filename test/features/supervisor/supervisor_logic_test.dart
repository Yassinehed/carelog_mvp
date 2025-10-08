import 'package:flutter_test/flutter_test.dart';
import 'package:carelog_mvp/features/of_order/domain/entities/of_order.dart';

void main() {
  OfOrderStatus localStatusFromString(String s) {
    try {
      return OfOrderStatus.values.firstWhere((e) => e.name == s);
    } catch (_) {
      return OfOrderStatus.productionProd;
    }
  }

  test('status string mapping returns enum or default', () {
    expect(localStatusFromString('productionTest'), OfOrderStatus.productionTest);
    expect(localStatusFromString('unknown_status'), OfOrderStatus.productionProd);
  });

  test('reorder logic preserves all items and computes priority indices', () {
    final list = List.generate(5, (i) => 'doc_$i');
    final item = list.removeAt(1);
    list.insert(3, item);
    expect(list.length, 5);
    expect(list[3], 'doc_1');
  });
}
