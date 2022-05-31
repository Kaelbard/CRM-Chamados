import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'top_antend_record.g.dart';

abstract class TopAntendRecord
    implements Built<TopAntendRecord, TopAntendRecordBuilder> {
  static Serializer<TopAntendRecord> get serializer =>
      _$topAntendRecordSerializer;

  @nullable
  String get titulo;

  @nullable
  int get cid;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TopAntendRecordBuilder builder) => builder
    ..titulo = ''
    ..cid = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('top_antend');

  static Stream<TopAntendRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TopAntendRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TopAntendRecord._();
  factory TopAntendRecord([void Function(TopAntendRecordBuilder) updates]) =
      _$TopAntendRecord;

  static TopAntendRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTopAntendRecordData({
  String titulo,
  int cid,
}) =>
    serializers.toFirestore(
        TopAntendRecord.serializer,
        TopAntendRecord((t) => t
          ..titulo = titulo
          ..cid = cid));
