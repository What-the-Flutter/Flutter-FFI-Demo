#ifndef FFI_TEST_EXAMPLE_H
#define FFI_TEST_EXAMPLE_H

extern "C" __attribute__((visibility("default"))) __attribute__((used))
double calc_pi(int32_t precision);

extern "C" __attribute__((visibility("default"))) __attribute__((used))
double calc_area_under_sin(int32_t precision, int32_t pi_precision);

#endif //FFI_TEST_EXAMPLE_H