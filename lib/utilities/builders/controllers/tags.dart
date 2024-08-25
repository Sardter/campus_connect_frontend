class EditableTagsController {
  EditableTagsController({List<String>? intialTags}) {
    tags = intialTags ?? [];
  }

  late final List<String> tags;
}