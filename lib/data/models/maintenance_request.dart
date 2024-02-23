class MaintenanceRequest {
  final String carMake;
  final String carModel;
  final String licensePlate;
  final String workshop;
  final String serviceType;
  final String description;
  final DateTime appointmentDate;
  final String email;
  final String status;

  MaintenanceRequest({
    required this.workshop,
    required this.carMake,
    required this.carModel,
    required this.licensePlate,
    required this.serviceType,
    required this.description,
    required this.appointmentDate,
    required this.email,
    required this.status,
  });
}
