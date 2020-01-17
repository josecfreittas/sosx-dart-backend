import 'package:aqueduct/aqueduct.dart';
import 'package:postgres/postgres.dart';
import 'package:sos10/sos10.dart';
import 'package:sos10/utils/custom_parsers.dart';

class DevsController extends ResourceController {
  DevsController(this.connection);
  final PostgreSQLConnection connection;

  @Operation.get()
  Future<Response> getDevs({
    @Bind.query("latitude") double latitude,
    @Bind.query("longitude") double longitude,
    @Bind.query("distance") double distance,
    @Bind.query("techs") String techs,
  }) async {
    String querySimple = '''
      SELECT
        name, github, bio, avatar, array_to_string(techs, ', ', '*'), location[0] as longitude, location[1] as lastitude
      FROM devs
      WHERE 1 = 1
    ''';

    String queryByLocation = '''
    SELECT * FROM (
        SELECT
          name, github, bio, avatar, array_to_string(techs, ', ', '*'), location[0] as longitude, location[1] as latitude, (location<@>point(@longitude, @latitude)) * 1609.344 as distance 
        FROM devs
      ) t
      WHERE distance <= @distance
    ''';

    if (techs != null) {
      print(techs);
      final String whereTechs = " AND techs && ${CustomParsers.stringToPgArray(techs)}";
      querySimple += whereTechs;
      queryByLocation += whereTechs;
    }

    final List<List<dynamic>> devs = await connection.query(
      (latitude == null || longitude == null || distance == null) ? querySimple : queryByLocation,
      substitutionValues: {
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
      },
    );

    return Response.ok(devs.map(CustomParsers.devListToMap).toList());
  }

  @Operation.post()
  Future<Response> addDev() async {
    final Map<String, dynamic> body = await request.body.decode();
    await connection.query(
      "insert into devs (name, github, bio, avatar, techs, location) values (@name, @github, @bio, @avatar, ${CustomParsers.stringToPgArray(body['techs'])}, point(@longitude, @latitude))",
      substitutionValues: {
        "name": body['name'] as String,
        "github": body['github'] as String,
        "bio": body['bio'] as String,
        "avatar": body['avatar'] as String,
        "latitude": body['latitude'] as double,
        "longitude": body['longitude'] as double,
      },
    );
    return Response.ok({"success": true});
  }
}
