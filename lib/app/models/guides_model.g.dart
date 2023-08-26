// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guides_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuidesAdapter extends TypeAdapter<Guides> {
  @override
  final int typeId = 0;

  @override
  Guides read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Guides(
      id: fields[0] as String,
      name: fields[1] as String,
      elements: (fields[2] as List).cast<GuideStep>(),
    );
  }

  @override
  void write(BinaryWriter writer, Guides obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.elements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuidesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GuideStepAdapter extends TypeAdapter<GuideStep> {
  @override
  final int typeId = 1;

  @override
  GuideStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuideStep(
      step: fields[0] as int,
      imageUrl: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GuideStep obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.step)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuideStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guides _$GuidesFromJson(Map<String, dynamic> json) => Guides(
      id: json['id'] as String,
      name: json['name'] as String,
      elements: (json['elements'] as List<dynamic>)
          .map((e) => GuideStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuidesToJson(Guides instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'elements': instance.elements,
    };

GuideStep _$GuideStepFromJson(Map<String, dynamic> json) => GuideStep(
      step: json['step'] as int,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$GuideStepToJson(GuideStep instance) => <String, dynamic>{
      'step': instance.step,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
