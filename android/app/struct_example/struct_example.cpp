#include "struct_example.h"

struct Person create_person(int age, char* name)
{
    struct Person person;
    person.age = age;
    person.name = name;
    return person;
}

struct Person create_person_pointer(int* age, char* name)
{
    struct Person person;
    person.age = *age;
    person.name = name;
    return person;
}
