#ifndef FFI_STRUCT_EXAMPLE_H
#define FFI_STRUCT_EXAMPLE_H

extern "C"
struct __attribute__((visibility("default"))) Person
{
    int age;
    char *name;
};

extern "C" __attribute__((visibility("default"))) __attribute__((used))
struct Person create_person(int age, char* name);

extern "C" __attribute__((visibility("default"))) __attribute__((used))
struct Person create_person_pointer(int* age, char* name);

#endif //FFI_STRUCT_EXAMPLE_H