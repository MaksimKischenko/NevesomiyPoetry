enum CollectionData {
  poems('Poems', 'fBgfMNpbEXoZaNvtoZMv'),
  poemsTest('Poems', 'clbmVKboLK3lOiN55lPW'),
  urlLinks('UrlLinks', 'gowYPJ7QbO9DoUu2mmOl');

  const CollectionData(this.name, this.docId);
  final String name;
  final String docId;
}