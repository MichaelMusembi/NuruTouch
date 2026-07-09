// Backend Preparation - Priority 7
// Do not implement logic, just the contract.

abstract class ApiInterface {
  Future<void> syncData();
  Future<void> uploadProgress(Map<String, dynamic> data);
  Future<void> downloadModel();
  Future<void> updateCurriculum();
  Future<void> sendAnalytics(List<Map<String, dynamic>> events);
}
