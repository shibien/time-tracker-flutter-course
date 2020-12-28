import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/job_entries_page.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/job_list_tile.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_items_builder.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {
  // HomePage({@required this.auth});
  // // HomePage({@required this.auth, @required this.onSignOut});
  // // final VoidCallback onSignOut;
  // final AuthBase auth;



  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on Exception catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
    }
  }

  // Future<void> _createJob(BuildContext context) async {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.createJob(Job(name: 'Blogging', ratePerHour: 10));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(
              context,
              database: Provider.of<Database>(context, listen: false),
            ),
          ),
          // FlatButton(
          //   child: Text(
          //     'Logout',
          //     style: TextStyle(
          //       fontSize: 18.0,
          //       color: Colors.white,
          //     ),
          //   ),
          //   onPressed: () => _confirmSignOut(context),
          // ),
        ],
      ),
      body: _buildContents(context),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => EditJobPage.show(
      //     context,
      //     database: Provider.of<Database>(context, listen: false),
      //   ),
      //   // onPressed: () => _createJob(context),
      // ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
              // onTap: () => EditJobPage.show(context, job: job),
            ),
          ),
        );
        // if (snapshot.hasData) {
        //   final jobs = snapshot.data;
        //   if (jobs.isNotEmpty) {
        //     final children = jobs
        //         .map((job) => JobListTile(
        //               job: job,
        //               onTap: () => EditJobPage.show(context, job: job),
        //             ))
        //         .toList();
        //     return ListView(children: children);
        //   }
        //   return EmptyContent();
        // }
        // if (snapshot.hasError) {
        //   return Center(child: Text('Some error occurred'));
        // }
        // return Center(child: CircularProgressIndicator());
      },
    );
  }
}
