import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';

class Person extends Struct {
  @Int32()
  external int age;

  external Pointer<Utf8> name;
}

typedef CreatePersonC = Person Function(Int32 age, Pointer<Utf8> name);
typedef CreatePersonDart = Person Function(int age, Pointer<Utf8> name);

typedef CreatePersonPointerC = Person Function(Pointer<Int32> age, Pointer<Utf8> name);
typedef CreatePersonPointerDart = Person Function(Pointer<Int32> age, Pointer<Utf8> name);

abstract class StructsExample {
  static late CreatePersonDart createPerson;
  static late CreatePersonPointerDart createPersonPointer;

  static void init() {
    final DynamicLibrary nativeLib =
    Platform.isAndroid ? DynamicLibrary.open('libstruct_example_lib.so') : DynamicLibrary.process();

    createPerson = nativeLib.lookupFunction<CreatePersonC, CreatePersonDart>('create_person');
    createPersonPointer = nativeLib.lookupFunction<CreatePersonPointerC, CreatePersonPointerDart>('create_person_pointer');
  }

  static void main() {
    Person p1 = createPerson(18, 'John'.toNativeUtf8());
    print(p1.name.toDartString() + ' ' + p1.age.toString());

    final agePtr = calloc<Int32>()..value = 22;
    Person p2 = createPersonPointer(agePtr, 'Mike'.toNativeUtf8());
    calloc.free(agePtr);
    print(p2.name.toDartString() + ' ' + p2.age.toString());
  }
}