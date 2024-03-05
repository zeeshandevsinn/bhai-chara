
class MaterialDialogContent {
  final String title;
  final String content;
  final String positiveText;
  final String negativeText;

  MaterialDialogContent(
      {required this.title,
      required this.content,
      this.positiveText = "Try Again",
      this.negativeText = "Cancel"});

  MaterialDialogContent.networkError()
      : this(
            title: 'Limited Network Connection',
            content: "Uh..oh… We\\'re unable proceed, its seems like your internet connection is broke or maybe limited. Please check it and try again.",
            positiveText: "Try Again",
            negativeText: "Cancel");

  @override
  String toString() {
    return 'MaterialDialogContent{title: $title, content: $content, positiveText: $positiveText, negativeText: $negativeText}';
  }
}
