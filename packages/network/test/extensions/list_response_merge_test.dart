import 'package:bond_network/bond_network.dart';
import 'package:test/test.dart';

class AnyModel extends Model {
  const AnyModel({required super.id});

  @override
  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

void main() {
  group('XListResponse Extension Tests', () {
    test('should return the original ListResponse when merging with an empty ListResponse', () {
      final originalList = ListResponse<AnyModel>(
        data: [AnyModel(id: 1), AnyModel(id: 2)],
      );

      final emptyList = ListResponse<AnyModel>(data: []);

      final mergedList = originalList.merge(emptyList);

      expect(mergedList.data.length, 2);
      expect(mergedList.data[0].id, 1);
      expect(mergedList.data[1].id, 2);
    });

    test('should return an empty ListResponse when merging two empty ListResponses', () {
      final emptyList1 = ListResponse<AnyModel>(data: []);
      final emptyList2 = ListResponse<AnyModel>(data: []);

      final mergedList = emptyList1.merge(emptyList2);

      expect(mergedList.data.length, 0);
    });

    test(
      'should override meta and links with those of the second ListResponse',
      () {
        final list1 = ListResponse<AnyModel>(
          data: [AnyModel(id: 1)],
          meta: Meta(from: 1, to: 2),
          links: Links(next: 'page2'),
        );

        final list2 = ListResponse<AnyModel>(
          data: [AnyModel(id: 2)],
          meta: Meta(from: 1, to: 2),
          links: Links(next: 'page3'),
        );

        final mergedList = list1.merge(list2);

        expect(mergedList.meta?.from, 1);
        expect(mergedList.meta?.to, 2);
        expect(mergedList.links?.next, 'page3');
      },
    );

    test('should merge two ListResponse instances', () {
      // Create two sample ListResponse instances
      final listResponse1 = ListResponse<AnyModel>(
        data: [AnyModel(id: 1), AnyModel(id: 2)],
      );

      final listResponse2 = ListResponse<AnyModel>(
        data: [AnyModel(id: 3), AnyModel(id: 4)],
      );

      // Merge listResponse1 and listResponse2
      final mergedListResponse = listResponse1.merge(listResponse2);

      // Verify if the data is merged correctly
      expect(mergedListResponse.data.length, 4);
      expect(mergedListResponse.data[0].id, 1);
      expect(mergedListResponse.data[1].id, 2);
      expect(mergedListResponse.data[2].id, 3);
      expect(mergedListResponse.data[3].id, 4);
    });
  });
}
