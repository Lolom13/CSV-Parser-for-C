#pragma once
#include "stdafx.cuh"

int readCSV(int Nrow, int Ncol, char *sep, char *filename, double **data, char **fields_names);
int closest_centroid(float **centroids, double *element, int nb_centroids, int nb_features);
float EQ_distance_to_centroid(float *centroid, double *element, int nb_features);

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
		}
		else
		{
			while (field)
			{
				data[row_count - 1][field_count] = atof(field);
				field = strtok(NULL, sep);
				field_count++;
			}

			row_count++;
		}
	}

	fclose(file);

	return 0;
}

int closest_centroid(float **centroids, double *element, int nb_centroids, int nb_features)
{
	int closest_centroid_id = 0;
	float closest_distance = 0; 
	
	closest_distance = EQ_distance_to_centroid(centroids[0], element, nb_features);

	if (nb_centroids > 1)
	{
		int i = 0;
		float current_distance = 0;
		for (i = 1; i < nb_centroids; i++)
		{
			current_distance = EQ_distance_to_centroid(centroids[i], element, nb_features);

			if (current_distance < closest_distance)
			{
				closest_centroid_id = i;
				closest_distance = current_distance;
			}
		}
	}

	return closest_centroid_id;
}

float EQ_distance_to_centroid(float *centroid, double *element, int nb_features)
{
	int i = 0;
	float dist = 0;

	for (i = 0; i < nb_features; i++)
	{
		dist += (centroid[i] - (float)element[i]) * (centroid[i] - (float)element[i]);
	}

	return sqrt(dist);
}