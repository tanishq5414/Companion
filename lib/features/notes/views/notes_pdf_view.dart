import 'package:companion/modal/notes.modal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class NotesPdfView extends StatefulWidget {
  static Route route({required NotesModal notes}) {
    return MaterialPageRoute<void>(
      builder: (_) => NotesPdfView(notes: notes),
    );
  }
  final NotesModal notes;
  const NotesPdfView({super.key, required this.notes});

  @override
  State<NotesPdfView> createState() => _NotesPdfViewState();
}

class _NotesPdfViewState extends State<NotesPdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.notes.name!, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),),
      ),
      body: SfPdfViewer.network(
        widget.notes.reslink!,
        key: _pdfViewerKey,
      ),
    );
  }
}