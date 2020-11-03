// Copyright (c) 2020 smarsufan. All Rights Reserved.

#include <stdlib.h>
#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int64_t _malloc(int64_t size) {
  return reinterpret_cast<int64_t>(malloc(size));
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void _free(int64_t ptr) {
  free(reinterpret_cast<void *>(ptr));
}
