
import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'dart:io'; // For Platform.isX

final DynamicLibrary cPtrLib = Platform.isAndroid
    ? DynamicLibrary.open("libc_ptr.so")
    : DynamicLibrary.process();

final int Function(int size) _malloc =
  cPtrLib
    .lookup<NativeFunction<Int64 Function(Int64)>>("_malloc")
    .asFunction();

final void Function(int ptr) _free =
  cPtrLib
    .lookup<NativeFunction<Void Function(Int64)>>("_free")
    .asFunction();

class P<T extends NativeType> {
  P();

  void init(int size) {
    resize(size);

    // if (size <= 0) {
    //   return;
    // }

    // if (_address != 0) {
    //   _free(address);
    // }

    // _length = size;
    // _address = _malloc(sizeOf<T>() * size);
  }

  void resize(int size) {
    if (size < 0) {
      print('ERROR: FLUTTER_C_PTR size ... $size');
      return;
    }

    _length = size;
    if (_length > _capacity) {
      if (_address != 0) {
        _free(_address);
      }

      _capacity = _length;
      _address = _malloc(sizeOf<T>() * size);
    }
  }

  void dispose() {
    if (_address != 0) {
      _free(_address);
    }
  }

  void copy(P other) {
    _address = other.address;
    _length = other.length;
  }

  void copyList(List list) {
    resize(list.length);
    this.list.setAll(0, list);
  }

  operator [](int index) {
    return list[index];
  }

  int get address => _address;

  Pointer<T> get pointer => Pointer<T>.fromAddress(_address ?? 0);

  get list => null;
  
  int get length => _length;

  /// The raw c address.
  int _address = 0;

  int _length = 0;

  int _capacity = 0;
}

class Int8P extends P<Int8> {
  @override
  get list => pointer.asTypedList(length);

  static Int8P fromString(String s) {
    List<int> code = s.codeUnits;
    code += [0];
    return Int8P.fromList(code);
  }
  
  static Int8P fromList(List<int> list) {
    Int8P p = Int8P();
    p.init(list.length);
    // Pointer<Int8> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Int8List int8List = p.pointer.asTypedList(list.length);
    int8List.setAll(0, list);
    return p;
  }
}

class Int16P extends P<Int16> {
  @override
  get list => pointer.asTypedList(length);
  
  static Int16P fromList(List<int> list) {
    Int16P p = Int16P();
    p.init(list.length);
    // Pointer<Int16> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Int16List int16List = p.pointer.asTypedList(list.length);
    int16List.setAll(0, list);
    return p;
  }
}

class Int32P extends P<Int32> {
  @override
  get list => pointer.asTypedList(length);
  
  static Int32P fromList(List<int> list) {
    Int32P p = Int32P();
    p.init(list.length);
    // Pointer<Int32> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Int32List int32List = p.pointer.asTypedList(list.length);
    int32List.setAll(0, list);
    return p;
  }
}

class Int64P extends P<Int64> {
  @override
  get list => pointer.asTypedList(length);
  
  static Int64P fromList(List<int> list) {
    Int64P p = Int64P();
    p.init(list.length);
    // Pointer<Int64> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Int64List int64List = p.pointer.asTypedList(list.length);
    int64List.setAll(0, list);
    return p;
  }
}

class Uint8P extends P<Uint8> {
  @override
  get list => pointer.asTypedList(length);
  
  static Uint8P fromString(String s) {
    List<int> code = s.codeUnits;
    code += [0];
    return Uint8P.fromList(code);
  }

  static Uint8P fromList(List<int> list) {
    Uint8P p = Uint8P();
    p.init(list.length);
    // Pointer<Uint8> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Uint8List uint8List = p.pointer.asTypedList(list.length);
    uint8List.setAll(0, list);
    return p;
  }
}

class Uint16P extends P<Uint16> {
  @override
  get list => pointer.asTypedList(length);
  
  static Uint16P fromList(List<int> list) {
    Uint16P p = Uint16P();
    p.init(list.length);
    // Pointer<Uint16> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Uint16List uint16List = p.pointer.asTypedList(list.length);
    uint16List.setAll(0, list);
    return p;
  }
}

class Uint32P extends P<Uint32> {
  @override
  get list => pointer.asTypedList(length);
  
  static Uint32P fromList(List<int> list) {
    Uint32P p = Uint32P();
    p.init(list.length);
    // Pointer<Uint32> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Uint32List uint32List = p.pointer.asTypedList(list.length);
    uint32List.setAll(0, list);
    return p;
  }
}

class Uint64P extends P<Uint64> {
  @override
  get list => pointer.asTypedList(length);
  
  static Uint64P fromList(List<int> list) {
    Uint64P p = Uint64P();
    p.init(list.length);
    // Pointer<Uint64> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Uint64List uint64List = p.pointer.asTypedList(list.length);
    uint64List.setAll(0, list);
    return p;
  }
}

class FloatP extends P<Float> {
  @override
  get list => pointer.asTypedList(length);
  
  static FloatP fromList(List<double> list) {
    FloatP p = FloatP();
    p.init(list.length);
    // Pointer<Float> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Float32List float32List = p.pointer.asTypedList(list.length);
    float32List.setAll(0, list);
    return p;
  }
}

class DoubleP extends P<Double> {
  @override
  get list => pointer.asTypedList(length);
  
  static DoubleP fromList(List<double> list) {
    DoubleP p = DoubleP();
    p.init(list.length);
    // Pointer<Double> pointer = p.pointer;
    // for (int idx = 0; idx < list.length; ++idx) {
    //   pointer[idx] = list[idx];
    // }
    Float64List float64List = p.pointer.asTypedList(list.length);
    float64List.setAll(0, list);
    return p;
  }
}

class FlutterCPtr {
  static const MethodChannel _channel =
      const MethodChannel('flutter_c_ptr');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
