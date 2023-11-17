getNoteTypeId(String noteType) {
  switch (noteType) {
    case 'Meeting Notes':
      return 1;
    case 'Marketing Notes':
      return 2;
    case 'Observation':
      return 3;
    case 'Propose Changes':
      return 4;
    case 'Process':
      return 5;
    case 'Training Notes':
      return 6;
    case 'Requirements':
      return 7;
    case 'University Notes':
      return 8;
    case 'Offline Marketing Notes':
      return 9;
    case 'Confidential Notes':
      return 10;
    default:
      return -1; // Return -1 if noteType is not recognized
  }
}

getNoteTypefromId(int noteType) {
  switch (noteType) {
    case 1:
      return 'Meeting Notes';
    case 2:
      return 'Marketing Notes';
    case 3:
      return 'Observation';
    case 4:
      return 'Propose Changes';
    case 5:
      return 'Process';
    case 6:
      return 'Training Notes';
    case 7:
      return 'Requirements';
    case 8:
      return 'University Notes';
    case 9:
      return 'Offline Marketing Notes';
    case 10:
      return 'Confidential Notes';
    default:
      return '-1'; // Return -1 if noteType is not recognized
  }
}
