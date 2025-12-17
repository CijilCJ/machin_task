import 'package:flutter/material.dart';
import 'package:machin_task/view/admin/controller/course_controller.dart';
import 'package:machin_task/view/admin/model/course_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoController = TextEditingController();
  final pdfController = TextEditingController();
  final pptController = TextEditingController();

  bool isFree = true;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    videoController.dispose();
    pdfController.dispose();
    pptController.dispose();
    super.dispose();
  }

  void addCourse() {
    if (!_formKey.currentState!.validate()) return;

    final course = CourseModel(
      id: '',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      thumbnail: '', // can be added later
      videoUrl: videoController.text.trim(),
      pdfUrl: pdfController.text.trim(),
      pptUrl: pptController.text.trim(),
      mcqs: [],
      isFree: isFree,
      createdAt: Timestamp.now(),
    );

    context.read<CourseController>().addCourse(course);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Course"),
        backgroundColor: const Color.fromARGB(255, 47, 59, 65),
        foregroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              _inputField(
                controller: titleController,
                label: "Course Title",
                icon: Icons.book,
              ),

              const SizedBox(height: 16),

              _inputField(
                controller: descriptionController,
                label: "Description",
                icon: Icons.description,
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              _inputField(
                controller: videoController,
                label: "Video URL (YouTube)",
                icon: Icons.play_circle,
              ),

              const SizedBox(height: 16),

              _inputField(
                controller: pdfController,
                label: "PDF URL",
                icon: Icons.picture_as_pdf,
              ),

              const SizedBox(height: 16),

              _inputField(
                controller: pptController,
                label: "PPT URL",
                icon: Icons.slideshow,
              ),

              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text("Free Course"),
                activeColor: Colors.amber,
                value: isFree,
                onChanged: (value) {
                  setState(() => isFree = value);
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: addCourse,
                  child: const Text(
                    "Add Course",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) =>
          value == null || value.isEmpty ? "$label required" : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.amber),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.amber,
            width: 2,
          ),
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:machin_task/view/admin/controller/course_controller.dart';
// import 'package:machin_task/view/admin/service/course_service.dart';
// import 'package:machin_task/widget/common.dart';

// class AddCourseScreen extends StatelessWidget {
//   final CourseController courseController=CourseController();
//   AddCourseScreen({super.key});

//   final _formKey = GlobalKey<FormState>();
  

//   final titleCntrl= TextEditingController();
//   final descriptionCntrl= TextEditingController();
//   final thumbCtrl = TextEditingController();

//   final CourseService courseService =CourseService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Course"),
//         actions: [
//           IconButton(onPressed: (){}, icon: Icon(Icons.edit))
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             textFormField(titleCntrl, "Title", Icons.margin, (v){}),
//             textFormField(descriptionCntrl, "description", Icons.description, (v){}),
//             textFormField(thumbCtrl, "Thumbnail", Icons.image, (v){}),
//             ElevatedButton(onPressed: (){}, child: Text("Save")),
//           ],
//         ),
//       ),
//     );
//   }
// }