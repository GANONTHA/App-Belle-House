String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} jour(s)';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} heure(e)';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute(s)';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} seconde(s)';
  } else {
    return 'just now';
  }
}
