% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/planning_solve_station_tsp.R
\name{planning_solve_station_tsp}
\alias{planning_solve_station_tsp}
\title{Solve a traveling Salesman problem (TSP) for a survey station allocation}
\usage{
planning_solve_station_tsp(x, hamilton = TRUE)
}
\arguments{
\item{x}{An `sf` object representing the survey stations.}

\item{hamilton}{Should a Hamiltonian path be calculated instead of a circuit?}
}
\value{
A list containing:
\item{distance_nodes}{An `sf` object of survey stations ordered based on 
the optimal TSP solution, with an added column for inter-station distances in kilometers.}
\item{tsp}{The TSP solution object.}
}
\description{
This function optimizes the sampling order of stations by solving a Traveling Salesman Problem (TSP) using the nearest insertion method to minimize the distance traveled. Option to use a circuit (starting and ending at the same station) or path (visit each station once without repeats).
}
\examples{
\dontrun{
# Load and transform survey stations
x <- system.file("extdata", "goa_station_allocation_520.shp", package = "navmaps") |> 
sf::st_read() |>
  sf::st_transform(crs = "EPSG:32606") |> # UTM zone 2
  dplyr::filter(VESSEL == 148) # Ocean Explorer

# Solve TSP for station order
tsp_out <- planning_solve_station_tsp(x = x)

# Estimate sampling days
survey_days <- planning_calc_survey_days(
  station_nodes = tsp_out$distance_nodes,
  max_daily_hr = 12,
  processing_time_hr = 1.5,
  max_daily_stn = 6,
  transit_speed_kmh = 1.852*7, # Converted from knots to km/h
  set_retrieve_hr = 0.5,
  set_on_arrival = FALSE
)

print(survey_days)
}

}
\author{
Zack Oyafuso
}
