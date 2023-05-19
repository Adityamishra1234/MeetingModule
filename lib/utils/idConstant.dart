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
    default:
      return -1; // Return -1 if noteType is not recognized
  }
}
