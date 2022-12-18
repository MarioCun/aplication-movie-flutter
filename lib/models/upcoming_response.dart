// To parse this JSON data, do
//
//     final upcomingRepose = upcomingReposeFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class UpcomingRespose {
    UpcomingRespose({
       required this.dates,
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory UpcomingRespose.fromJson(String str) => UpcomingRespose.fromMap(json.decode(str));


    factory UpcomingRespose.fromMap(Map<String, dynamic> json) => UpcomingRespose(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
