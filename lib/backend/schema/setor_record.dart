import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'setor_record.g.dart';

abstract class SetorRecord implements Built<SetorRecord, SetorRecordBuilder> {
  static Serializer<SetorRecord> get serializer => _$setorRecordSerializer;

  @nullable
  int get sid;

  @nullable
  String get setor;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SetorRecordBuilder builder) => builder
    ..sid = 0
    ..setor = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('setor');

  static Stream<SetorRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SetorRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SetorRecord._();
  factory SetorRecord([void Function(SetorRecordBuilder) updates]) =
      _$SetorRecord;

  static SetorRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSetorRecordData({
  int sid,
  String setor,
}) =>
    serializers.toFirestore(
        SetorRecord.serializer,
        SetorRecord((s) => s
          ..sid = sid
          ..setor = setor));
