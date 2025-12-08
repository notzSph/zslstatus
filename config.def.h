/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

static const struct arg args[] = {
	/* function    format    argument */
	
	/* Network */
	{ netspeed_rx, "  %s  · ",	"wlp14s0" },
	{ netspeed_tx, " %s ", 		"wlp14s0" },

	/* CPU Load + Frequency */
	{ cpu_perc, "   %s%% · ", NULL },
	{ cpu_freq, " %s · ", 	   NULL },
	
	/* CPU Temps */
	{ run_command, " %s \u00B0C · ",
		"sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/+//; s/.0//'" },
	{ run_command, " %s \u00B0C",
		"sensors | grep 'Tccd1:' | awk '{ print $2 }' | sed 's/+//; s/.0//'" },

	/* RAM + Temp */
	{ ram_perc, "  %s%% · ", NULL },
	{ run_command, " %s \u00B0C",
		"sensors | grep 'Thermistor 1:' | awk '{ print $3 }' | sed 's/+//; s/.0//'"	},
		
	/* GPU Temp */
	{ run_command, "   %s \u00B0C",
		"sensors | awk '/edge:/ { print $2 }' | head -n 1 | sed 's/+//; s/.0//'" },
		
	/* Audio */
	{ run_command, "  %s",
		"amixer -D pulse sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'"	},
		
	/* Date & Time */
	{ datetime, "  %s", "%a %b %d %r" 								},
};
