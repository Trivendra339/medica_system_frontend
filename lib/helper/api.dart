
class ApiUrls{
  ApiUrls._();
  static const baseUrl = "http://127.0.0.1:8000";


static const login =  "/doctor/login";
static const register = "/doctor/register";
static const uploadFile = "/doctor/upload-file";

static const getDoctors = "/admin/get_doctors";
// String getDoctor(int id)=> "admin/Doctor/$id";
static String approve(int id)=> "/admin/approve/$id";
static String reject(int id)=> "/admin/reject/$id";

}