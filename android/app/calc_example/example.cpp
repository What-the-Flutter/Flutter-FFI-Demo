#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include "example.h"

double calc_pi(int32_t precision) {
    double pi = 0;
    int8_t sign = 1;

    for (int32_t i = 1; i < precision * 2; i+=2) {
        pi = pi + sign * 4.0/i;
        sign *= -1;
    }

    return pi;
}

double calc_area_under_sin(int32_t precision, int32_t pi_precision)
{
    double sum = 0;
    double pi = calc_pi(pi_precision);
    double rectArea = pi * 1.0;

    srand(time(NULL));
    for (int i = 0; i < precision; ++i) {
        double x = ((float)rand())/RAND_MAX * pi;
        double y = ((float)rand())/RAND_MAX * 1.0;

        if (y < sin(x)) {
            sum++;
        }
    }
    return sum / precision * rectArea;
}