class Planet {
  final String? name;
  final int? orbitalDistanceKm;
  final int? equatorialRadiusKm;
  final dynamic volumeKm3;
  final String? massKg;
  final double? densityGcm3;
  final double? surfaceGravityMs2;
  final int? escapeVelocityKmh;
  final double? dayLengthEarthDays;
  final double? yearLengthEarthDays;
  final int? orbitalSpeedKmh;
  final String? atmosphereComposition;
  final int? moons;
  final String? image;
  final String? description;

  Planet({
    this.name,
    this.orbitalDistanceKm,
    this.equatorialRadiusKm,
    this.volumeKm3,
    this.massKg,
    this.densityGcm3,
    this.surfaceGravityMs2,
    this.escapeVelocityKmh,
    this.dayLengthEarthDays,
    this.yearLengthEarthDays,
    this.orbitalSpeedKmh,
    this.atmosphereComposition,
    this.moons,
    this.image,
    this.description,
  });

  /// Deserialización desde JSON
  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      orbitalDistanceKm: json['orbital_distance_km'] ,
      equatorialRadiusKm: json['equatorial_radius_km'] ,
      volumeKm3: json['volume_km3'], 
      massKg: json['mass_kg'],
      densityGcm3: (json['density_g_cm3'] != null) ? json['density_g_cm3'].toDouble() : null,
      surfaceGravityMs2: (json['surface_gravity_m_s2'] != null) ? json['surface_gravity_m_s2'].toDouble() : null,
      escapeVelocityKmh: json['escape_velocity_kmh'],
      dayLengthEarthDays: (json['day_length_earth_days'] != null) ? json['day_length_earth_days'].toDouble() : null,
      yearLengthEarthDays: (json['year_length_earth_days'] != null) ? json['year_length_earth_days'].toDouble() : null,
      orbitalSpeedKmh: json['orbital_speed_kmh'],
      atmosphereComposition: json['atmosphere_composition'],
      moons: json['moons'],
      image: json['image'],
      description: json['description'],
    );
  }

  /// Serialización a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'orbital_distance_km': orbitalDistanceKm,
      'equatorial_radius_km': equatorialRadiusKm,
      'volume_km3': volumeKm3,
      'mass_kg': massKg,
      'density_g_cm3': densityGcm3,
      'surface_gravity_m_s2': surfaceGravityMs2,
      'escape_velocity_kmh': escapeVelocityKmh,
      'day_length_earth_days': dayLengthEarthDays,
      'year_length_earth_days': yearLengthEarthDays,
      'orbital_speed_kmh': orbitalSpeedKmh,
      'atmosphere_composition': atmosphereComposition,
      'moons': moons,
      'image': image,
      'description': description,
    };
  }
}
