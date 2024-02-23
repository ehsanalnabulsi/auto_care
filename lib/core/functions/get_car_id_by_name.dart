int? getCarIdByModel(List cars, String modelName) {
  print(cars);
  var car = cars.firstWhere((car) => car['modelName'] == modelName);
  print(car);
  return car['carId'];
}

int? getWorkshopIdByWorkshopName(List workshops, String workshopNameToSearch) {
  var workshop = workshops.firstWhere(
      (workshop) => workshop['workshopName'] == workshopNameToSearch);

  return workshop['id'];
}
