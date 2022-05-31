import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'chamado_record.g.dart';

abstract class ChamadoRecord
    implements Built<ChamadoRecord, ChamadoRecordBuilder> {
  static Serializer<ChamadoRecord> get serializer => _$chamadoRecordSerializer;

  @nullable
  String get titular;

  @nullable
  String get descricao;

  @nullable
  String get impacto;

  @nullable
  @BuiltValueField(wireName: 'hora_criacao')
  DateTime get horaCriacao;

  @nullable
  @BuiltValueField(wireName: 'topic_antend')
  String get topicAntend;

  @nullable
  String get setor;

  @nullable
  String get departamento;

  @nullable
  String get anexo;

  @nullable
  String get chid;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ChamadoRecordBuilder builder) => builder
    ..titular = ''
    ..descricao = ''
    ..impacto = ''
    ..topicAntend = ''
    ..setor = ''
    ..departamento = ''
    ..anexo = ''
    ..chid = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chamado');

  static Stream<ChamadoRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ChamadoRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ChamadoRecord._();
  factory ChamadoRecord([void Function(ChamadoRecordBuilder) updates]) =
      _$ChamadoRecord;

  static ChamadoRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createChamadoRecordData({
  String titular,
  String descricao,
  String impacto,
  DateTime horaCriacao,
  String topicAntend,
  String setor,
  String departamento,
  String anexo,
  String chid,
}) =>
    serializers.toFirestore(
        ChamadoRecord.serializer,
        ChamadoRecord((c) => c
          ..titular = titular
          ..descricao = descricao
          ..impacto = impacto
          ..horaCriacao = horaCriacao
          ..topicAntend = topicAntend
          ..setor = setor
          ..departamento = departamento
          ..anexo = anexo
          ..chid = chid));
