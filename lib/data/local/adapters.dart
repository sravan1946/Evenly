import 'package:hive/hive.dart';
import '../../domain/models/split.dart';
import '../../domain/models/item.dart';
import '../../domain/models/participant.dart';

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      id: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as double,
      currency: fields[3] as String,
      quantity: fields[4] as int,
      assignedTo: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.assignedTo);
  }
}

class ParticipantAdapter extends TypeAdapter<Participant> {
  @override
  final int typeId = 1;

  @override
  Participant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Participant(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Participant obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }
}

class SplitMethodAdapter extends TypeAdapter<SplitMethod> {
  @override
  final int typeId = 2;

  @override
  SplitMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SplitMethod.itemized;
      case 1:
        return SplitMethod.even;
      default:
        return SplitMethod.itemized;
    }
  }

  @override
  void write(BinaryWriter writer, SplitMethod obj) {
    switch (obj) {
      case SplitMethod.itemized:
        writer.writeByte(0);
        break;
      case SplitMethod.even:
        writer.writeByte(1);
        break;
    }
  }
}

class SplitAdapter extends TypeAdapter<Split> {
  @override
  final int typeId = 3;

  @override
  Split read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Split(
      id: fields[0] as String,
      name: fields[1] as String?,
      createdAt: fields[2] as DateTime,
      participants: (fields[3] as List).cast<Participant>(),
      items: (fields[4] as List).cast<Item>(),
      method: fields[5] as SplitMethod,
    );
  }

  @override
  void write(BinaryWriter writer, Split obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.participants)
      ..writeByte(4)
      ..write(obj.items)
      ..writeByte(5)
      ..write(obj.method);
  }
}
