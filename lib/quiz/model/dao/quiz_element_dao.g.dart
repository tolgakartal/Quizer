// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_element_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizElementDaoAdapter extends TypeAdapter<QuizElementDao> {
  @override
  final int typeId = 0;

  @override
  QuizElementDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizElementDao(
      question: fields[0] as String,
      answer: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuizElementDao obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizElementDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
