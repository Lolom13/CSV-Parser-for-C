#include "utils.h"

#define DATA_NROWS 34
#define DATA_NCOLS 7
#define MAXSIZE_FIELDSNAMES 32
#define SIZE 1024


int main()
{
	int i = 0;

	double **data;
	data = (double **)malloc(DATA_NROWS * sizeof(double *));
	for (i = 0; i < DATA_NROWS; ++i) {
		data[i] = (double *)malloc(DATA_NCOLS * sizeof(double));
	}

	char **fields_names;
	fields_names = (char**)malloc(DATA_NCOLS * sizeof(char*));
	for (i = 0; i < DATA_NCOLS; i++)
		fields_names[i] = (char*)malloc((MAXSIZE_FIELDSNAMES + 1) * sizeof(char));

	readCSV(DATA_NROWS, DATA_NCOLS, ";", "cars.csv", data, fields_names);

	return 0;
}
