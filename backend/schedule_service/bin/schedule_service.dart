import 'package:schedule_service/schedule_service.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
  } catch (e) {
    print(e);
    print('Error connecting to database');
    Future.delayed(Duration(seconds: 10), () => exit(1));
  }
  final subjectDataSource = PostgreSubjectDataSource(dbConection);
  final teacherDataSource = PostgreTeacherDataSource(dbConection);
  final cabinetDataSource = PostgreCabinetDataSource(dbConection);
  final subgroupDataSource = PostgreSubgroupDataSource(dbConection);
  final spetialityDataSource = PostgreSpecialityDataSource(dbConection);
  final groupDataSource = PostgreGroupDataSource(dbConection);
  final studentDataSource = PostgreStudentDataSource(dbConection);
  final lessonDataSource = PostgresLessonDataSource(dbConection);

  final app = Router();

  app.mount(
      '/subjects',
      SubjectsRoute(
        repository: subjectDataSource,
      ).router);
  app.mount(
      '/teachers',
      TeachersRoute(
              teacherRepository: teacherDataSource,
              subjectRepository: subjectDataSource)
          .router);
  app.mount(
      '/cabinets',
      CabinetsRoute(
        cabinetRepository: cabinetDataSource,
        subjectRepository: subjectDataSource,
      ).router);
  app.mount(
      '/subgroups',
      SubgroupsRoute(
        subgroupRepository: subgroupDataSource,
        subjectRepository: subjectDataSource,
      ).router);
  app.mount(
      '/spetialties',
      SpecialitysRoute(
        repository: spetialityDataSource,
      ).router);
  app.mount(
      '/groups',
      GroupsRoute(
        groupRepository: groupDataSource,
        specialityRepository: spetialityDataSource,
        subjectRepository: subjectDataSource,
      ).router);
  app.mount(
      '/students',
      StudentRoute(
        studentRepository: studentDataSource,
        groupRepository: groupDataSource,
        subgroupRepository: subgroupDataSource,
      ).router);
  app.mount(
      '/lessons',
      LessonsRoute(
        subgroupRepository: subgroupDataSource,
        subjectRepository: subjectDataSource,
        teacherRepository: teacherDataSource,
        cabinetRepository: cabinetDataSource,
        groupRepository: groupDataSource,
        lessonRepository: lessonDataSource,
        studentRepository: studentDataSource,
      ).router);

  final handler = Pipeline()
      .addMiddleware((logRequests()))
      .addMiddleware(handlerAuth())
      .addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Schedule service started on ${serviceHost()}:${servicePort()}');
}
