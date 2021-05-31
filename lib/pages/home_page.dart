import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:memstuff_final/controllers/home_controller.dart';
import 'package:memstuff_final/core/app_const.dart';
import 'package:memstuff_final/helpers/snackbar_helper.dart';
import 'package:memstuff_final/models/stuff_model.dart';
import 'package:memstuff_final/pages/detail_page.dart';
import 'package:memstuff_final/repositories/stuff_repository_impl.dart';
import 'package:memstuff_final/widgets/stuff_card.dart';
import 'package:memstuff_final/widgets/stuff_listview.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(StuffRepositoryImpl());

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future _initialize() async {
    await _controller.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kTitleHome)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onCreate,
      ),
      body: RefreshIndicator(
        onRefresh: _initialize,
        child: StuffListView(
          loading: _controller.loading,
          itemCount: _controller.length,
          itemBuilder: _buildStuffCard,
        ),
      ),
    );
  }

  Widget _buildStuffCard(BuildContext context, int index) {
    final stuff = _controller.stuffs[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 1000),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: StuffCard(
            stuff: stuff,
            onUpdate: () => _onUpdate(stuff),
            onDelete: () => _onDelete(stuff),
          ),
        ),
      ),
    );
  }

  _onCreate() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DetailPage()),
    );
    _initialize();
  }

  _onUpdate(StuffModel stuff) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DetailPage(stuff: stuff)),
    );
    _initialize();
  }

  _onDelete(StuffModel stuff) async {
    await _controller.delete(stuff);
    _initialize();
    SnackbarHelper.showDeleteMessage(
      context: context,
      message: '${stuff.description} excluído!',
    );
  }

  _onCall(StuffModel stuff) async {
    var url = 'tel:0' + '${stuff.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Erro';
    }
  }

  _onDeleteUndo(StuffModel stuff) async {
    await _controller.undo(stuff);
    _initialize();
  }
}
