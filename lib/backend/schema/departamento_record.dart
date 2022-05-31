import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'departamento_record.g.dart';

abstract class DepartamentoRecord
    implements Built<DepartamentoRecord, DepartamentoRecordBuilder> {
  static Serializer<DepartamentoRecord> get serializer =>
      _$departamentoRecordSerializer;

  @nullable
  int get did;

  @nullable
  String get departamento;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(DepartamentoRecordBuilder builder) => builder
    ..did = 0
    ..departamento = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('departamento');

  static Stream<DepartamentoRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<DepartamentoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  DepartamentoRecord._();
  factory DepartamentoRecord(
          [void Function(DepartamentoRecordBuilder) updates]) =
      _$DepartamentoRecord;

  static DepartamentoRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createDepartamentoRecordData({
  int did,
  String departamento,
}) =>
    serializers.toFirestore(
        DepartamentoRecord.serializer,
        DepartamentoRecord((d) => d
          ..did = did
          ..departamento = departamento));
