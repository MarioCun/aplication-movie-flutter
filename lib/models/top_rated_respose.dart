// To parse this JSON data, do
//
//     final topRatedRepose = topRatedReposeFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class TopRatedRepose {
    TopRatedRepose({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory TopRatedRepose.fromJson(String str) => TopRatedRepose.fromMap(json.decode(str));


    factory TopRatedRepose.fromMap(Map<String, dynamic> json) => TopRatedRepose(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    
}

