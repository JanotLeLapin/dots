#define MUSIC_CMD "mpc current"
#define BAT_CMD "echo $(acpi -b | grep -P -o '[0-9]+(?=%)')%"
#define DATE_CMD "date +'%d/%m/%Y %H:%M'"

static const Block blocks[] = {
	/* Icon */ /* Command */ /*Update Interval*/ /*Update Signal*/
	{"󰝚 ",       MUSIC_CMD,    0,                  10},
	{"󰁹 ",       BAT_CMD,      120,                0},
	{"󰅐 ",       DATE_CMD,     60,                 0},
};

/* sets delimiter between status commands. NULL character ('\0') means no delimiter. */
static char delim[] = " | ";
static unsigned int delimLen = 5;
