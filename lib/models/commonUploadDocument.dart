class CommonUploadDocument {
  int? organizationId;
  String? parentDocumentType;
  int? id;
  int? enqId;
  int? documentId;
  String? documentParentCategory;
  String? documentName;
  String? uploadedDocumentName;
  int? uploadedBy;
  String? viewlink;
  String? folderName;

  CommonUploadDocument(
      {this.organizationId,
      this.parentDocumentType,
      this.id,
      this.enqId,
      this.documentId,
      this.documentParentCategory,
      this.documentName,
      this.uploadedDocumentName,
      this.uploadedBy,
      this.viewlink,
      this.folderName});

  CommonUploadDocument.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    parentDocumentType = json['parent_document_type'];
    id = json['id'];
    enqId = json['enq_id'];
    documentId = json['document_id'];
    documentParentCategory = json['document_parent_category'];
    documentName = json['document_name'];
    uploadedDocumentName = json['uploaded_document_name'];

    viewlink = json['viewlink'];
    folderName = json['folder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['organization_id'] = organizationId;
    data['parent_document_type'] = parentDocumentType;
    data['id'] = id;
    data['enq_id'] = enqId;
    data['document_id'] = documentId;
    data['document_parent_category'] = documentParentCategory;
    data['document_name'] = documentName;
    data['uploaded_document_name'] = uploadedDocumentName;

    data['uploaded_by'] = uploadedBy;
    data['viewlink'] = viewlink;
    data['folder_name'] = folderName;
    return data;
  }
}
