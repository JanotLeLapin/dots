#define DATE_CMD "date +'%d/%m/%Y %H:%M'"

static const Block blocks[] = {
	/* Icon */ /* Command */ /*Update Interval*/ /*Update Signal*/
	{"",       DATE_CMD,     60,                 0},
};

/* sets delimiter between status commands. NULL character ('\0') means no delimiter. */
static char delim[] = " | ";
static unsigned int delimLen = 5;
