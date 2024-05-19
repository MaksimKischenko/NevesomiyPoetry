enum Topics {
  all(('Все', 'assets/icons/bookshelf.svg')),
  love(('О любви', 'assets/icons/love_heart.svg')),
  urban(('О городах', 'assets/icons/architecture_building.svg')), 
  philosophy(('Философия', 'assets/icons/yin_yang.svg')), 
  civil(('Гражданская лирика', 'assets/icons/megaphone.svg')),
  landscape(('О природе', 'assets/icons/mountain_nature.svg')),
  favorite(('Избранные', 'assets/icons/medal.svg'));

  const Topics(this.nameAndLocation);
  final (String, String) nameAndLocation;
}


//https://ik.imagekit.io/hbtrxkiew/sun_AJMBGl_R7.svg?updatedAt=1715868100946