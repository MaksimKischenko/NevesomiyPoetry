enum SvgRepo {
  bookClosed('assets/icons/book-closed.svg'), 
  bookOpen('assets/icons/book-open.svg'),  
  email('assets/icons/envelope.svg'),
  heart('assets/icons/heart.svg'),  
  map('assets/icons/map.svg'),
  globeMain('assets/icons/globe-main.svg'),
  man('assets/icons/man.svg'), 
  comment('assets/icons/comment.svg'),
  sun('assets/icons/sun.svg'), 
  presentation('assets/icons/presentation.svg'),
  lock('assets/icons/lock.svg'),
  unLock('assets/icons/eye.svg'),      
  key('assets/icons/key.svg'),
  settings('assets/icons/cog.svg'),     
  pen('assets/icons/pen.svg'),
  pencil('assets/icons/pencil.svg'),   
  star('assets/icons/star.svg'),     
  like('assets/icons/thumb-up.svg'),
  medal('assets/icons/medal.svg'),
  plain('assets/icons/plane.svg'),
  photo('assets/icons/photo.svg'),    
  modem('assets/icons/modem.svg'),  
  rocket('assets/icons/rocket.svg'),
  wrench('assets/icons/wrench.svg'),            
  unLike('assets/icons/thumb-down.svg');    



  const SvgRepo(this.location);
  final String location;
}

