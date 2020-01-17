class CustomParsers {
  static Map<String, dynamic> devListToMap(List<dynamic> devList) {
    final Map<String, dynamic> result = {
      "name": devList[0],
      "github": devList[1],
      "bio": devList[2],
      "avatar_url": devList[3],
      "techs": devList[4],
      "latitude": devList[5],
      "longitude": devList[6],
    };

    if (devList.length > 7) {
      result["distance"] = devList[7];
    }

    return result;
  }

  static String stringToPgArray(dynamic value) {
    final String result = (value as String).split(",").map((item) => "'${item.trim()}'").join(", ");
    return "ARRAY[${result}]::text[]";
  }
}
