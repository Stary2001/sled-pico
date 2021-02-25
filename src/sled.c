#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pio.h"
//#include "ws2812.pio.h"

#include "../sled/src/types.h"
#include "../sled/src/oscore.h"
#include "../sled/src/main.h"
#include "../sled/src/timers.h"

int fake_argc = 1;
char * fake_argv[] = {"sled", NULL};

// Main entry point.
int main(int argc, char** argv) {
	stdio_init_all();

	int n_attempts = 20;
	while(!tud_cdc_n_connected(0) && n_attempts > 0) {
		sleep_ms(100);
		n_attempts--;
	}

	printf("Hello!!\n");
	int ret = sled_main(fake_argc, fake_argv);
	printf("sled exited!\n");
	while(true) {
		sleep_ms(1000);
	}
}