import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'cargos_record.g.dart';

abstract class CargosRecord
    implements Built<CargosRecord, CargosRecordBuilder> {
  static Serializer<CargosRecord> get serializer => _$cargosRecordSerializer;

  @nullable
  String get cargos;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CargosRecordBuilder builder) =>
      builder..cargos = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cargos');

  static Stream<CargosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CargosRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CargosRecord._();
  factory CargosRecord([void Function(CargosRecordBuilder) updates]) =
      _$CargosRecord;

  static CargosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCargosRecordData({
  String cargos,
}) =>
    serializers.toFirestore(
        CargosRecord.serializer, CargosRecord((c) => c..cargos = cargos));
