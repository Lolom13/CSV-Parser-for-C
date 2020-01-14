#include <stdio.h>
#include <stdlib.h>

int readCSV(int Nrow, int Ncol, char *sep, char *filename, double **data, char **fields_names);

int readCSV(int Nrow, int Ncol, char *sep, char *filename, double **data, char **fields_names)
{
	FILE *file;
	file = fopen(filename, "r");

	if (!file)
		return 1;

	char buff[2048];
	int row_count = 0;
	int field_count = 0;

	while (fgets(buff, 2048, file))
	{
		field_count = 0;
		
		char *field = strtok(buff, sep);

		if (row_count == 0)
		{
			while (field)
			{
				fields_names[field_count] = field;
				field = strtok(NULL, sep);
				field_count++;
			}
			
			row_count++;
			continue;
		}

		while (field)
		{
			data[row_count - 1][field_count] = atof(field);
			printf("%f\t", data[row_count - 1][field_count]);
			field = strtok(NULL, sep);
			field_count++;
		}

		row_count++;
	}

	fclose(file);

	return 0;
}