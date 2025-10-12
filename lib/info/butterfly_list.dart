/// Mapping of numeric butterfly IDs to their corresponding species names.  This
/// allows the app to look up the appropriate [ButterflyInfo] entry in
/// `butterfly_info.dart` using only the integer ID stored in the
/// database or returned from the backend.
///
/// These IDs should match the IDs used in your backend for each butterfly
/// species.  Adjust the mapping as needed to align with your database.
const Map<int, String> idToSpeciesName = {
  1: 'Admiral',
  2: 'Aurorafalter',
  3: 'Distelfalter',
  4: 'Kleiner Fuchs',
  5: 'Tagpfauenauge',
  6: 'Schwalbenschwanz',
  7: 'Kaisermantel',
  8: 'Landkärtchen',
  9: 'Kleiner Kohlweißling',
  10: 'Waldbrettspiel',
  11: 'Großes Ochsenauge',
  12: 'Zitronenfalter',
  13: 'C‑Falter',
  14: 'Großer Kohlweißling',
  15: 'Hauhechel-Bläuling',
  16: 'Schachbrett',
  17: 'Trauermantel',
  18: 'Großer Perlmutterfalter',
  19: 'Pflaumen-Zipfelfalter',
  20: 'Kleiner Schillerfalter',
};