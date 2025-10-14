import 'package:flutter/material.dart';

/// A small data class used to describe a single informational chip.  Each chip
/// appears as a pill‑shaped label with an icon and a short label.  These
/// chips summarise key traits of a butterfly such as its habitat, flight
/// period, wingspan or typical food source.
class InfoChipData {
  final IconData icon;
  final String label;

  const InfoChipData({required this.icon, required this.label});
}

/// A data class used to represent one information card.  An information
/// card groups together a number of bullet points under a title with an
/// accompanying icon.  This is used on the details page to show a more
/// structured list of facts such as reproduction stages or observation
/// hints.
class InfoCardData {
  final String title;
  final IconData leading;
  final List<String> bullets;

  const InfoCardData({
    required this.title,
    required this.leading,
    required this.bullets,
  });
}

/// Contains the full description for a butterfly species along with lists of
/// chips and cards that will be rendered on the detail screen.  The
/// description and reproduction fields provide a short summary and the
/// metamorphosis sequence respectively, while `chips` and `cards` allow for
/// arbitrary numbers of additional details to be displayed.
class ButterflyInfo {
  final String description;
  final String reproduction;
  final List<InfoChipData> chips;
  final List<InfoCardData> cards;

  const ButterflyInfo({
    required this.description,
    required this.reproduction,
    required this.chips,
    required this.cards,
  });
}

/// A lookup map for common German butterfly species.  Each entry associates
/// the species' German common name with a [ButterflyInfo] object.  When
/// adding new species please ensure the key matches the displayed name in
/// your UI (for example the `commonName` returned from the API or stored in
/// the database).  This allows the details page to find the correct data
/// when a user selects a butterfly from the collection.
final Map<String, ButterflyInfo> butterflyInfoMap = {
  // 1. Adonis (Adonis Blue, Lysandra/Polyommatus bellargus)
  // Habitat: warm chalk/limestone grasslands; host: horseshoe vetch; 2 broods (May–Jun, Aug–Sep);
  // wingspan ~30–38 mm. Sources: Butterfly Conservation; The Wildlife Trusts; Wikipedia. :contentReference[oaicite:0]{index=0}
  'Adonis': const ButterflyInfo(
    description:
        'The Adonis Blue (Lysandra bellargus) male is a vivid sky-blue; females are brown with orange spots. It flies low over warm, south-facing chalk or limestone grasslands.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs are laid on horseshoe vetch (Hippocrepis comosa). Two broods per year; overwinters as a small larva.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Chalk grassland'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Horseshoe vetch'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~30–38 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Breeding',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eggs placed on horseshoe vetch',
          'Overwinters as a small larva',
          'Usually 2 broods/year in warm sites',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Search sunny, south-facing slopes',
          'Often nectaring on short-grazed turf flowers',
        ],
      ),
    ],
  ),

  // 2. African Giant Swallowtail (Papilio antimachus)
  // Largest African butterfly (wingspan ~18–23 cm); West & Central African rainforests; males mud-puddle; canopy species. Sources: Wikipedia; SBBT; iNaturalist. :contentReference[oaicite:1]{index=1}
  'African Giant Swallowtail': const ButterflyInfo(
    description:
        'Papilio antimachus is Africa’s largest butterfly. Orange-brown with black markings, it lives mainly in the rainforest canopy; males sometimes descend to rivers to mud-puddle.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Likely breeds high in the canopy; adults frequent sunny gaps and river edges.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Rainforest canopy'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Tropical year-round',
      ),
      InfoChipData(icon: Icons.eco, label: 'Adults: nectar & mud-puddling (♂)'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 18–23 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Ranges across W & Central Africa',
          'Males may gather along rivers',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Scan river corridors at forest edges',
          'Most activity near sunny stream sections',
        ],
      ),
    ],
  ),

  // 3. American Snoot (Libytheana carinenta)
  // Hosts: hackberries (Celtis spp.); migrations noted in TX/MX; widespread in the Americas. Sources: Wikipedia; UF/IFAS; Texas A&M. :contentReference[oaicite:2]{index=2}
  'American Snoot': const ButterflyInfo(
    description:
        'The American Snout (Libytheana carinenta) has an elongated “snout” formed by palps. Common in the Americas, sometimes migrating in large numbers.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid singly on hackberry leaves (Celtis spp.). Multiple broods in warm regions.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Woodlands, edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Most of year (warm areas)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Hackberries (Celtis)',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~35–50 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Breeding',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eggs placed singly on host',
          'Caterpillars feed on Celtis leaves',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Check hackberry trees',
          'Watch for mass flights after rains',
        ],
      ),
    ],
  ),

  // 4. An 88 (Anna’s Eighty-eight, Diaethria anna)
  // Wet tropical forests Mexico→Costa Rica; adults take rotting fruit; hosts in elm & soapberry families; wingspan ~35–45 mm. Sources: BAMONA; Wikipedia; other refs. :contentReference[oaicite:3]{index=3}
  'An 88': const ButterflyInfo(
    description:
        'Diaethria anna shows the iconic “88” pattern on the hindwing underside. Found in wet tropical forests from Mexico to Costa Rica; rare stray to South Texas.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on plants in the elm (Ulmaceae) and soapberry (Sapindaceae) families. Adults often feed at rotting fruit.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Wet tropical forest'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Tropical year-round',
      ),
      InfoChipData(icon: Icons.eco, label: 'Adult food: Rotting fruit'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~35–45 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look for fruit-bait stations',
          'Often along forest edges & streams',
        ],
      ),
      InfoCardData(
        title: 'Range notes',
        leading: Icons.public,
        bullets: ['Common Mesoamerica', 'Occasional stray to S Texas'],
      ),
    ],
  ),

  // 5. Apollo (Parnassius apollo)
  // Large alpine species; single brood; hosts Sedum/Sempervivum; wingspan ~62–95 mm. Sources: Wikipedia; Animalia; NatureGate. :contentReference[oaicite:4]{index=4}
  'Apollo': const ButterflyInfo(
    description:
        'The Apollo (Parnassius apollo) is a large white mountain butterfly with black spots and red eye-spots, found on sunny alpine meadows and rocky slopes.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Single brood. Larvae feed mainly on stonecrops (Sedum spp.) and houseleeks (Sempervivum spp.).',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Alpine meadows, slopes'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: May–Sep (1 brood)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Sedum, Sempervivum',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 62–95 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Active on warm, sunny days',
          'Visits nectar-rich alpine flowers',
        ],
      ),
      InfoCardData(
        title: 'Conservation note',
        leading: Icons.warning_amber_outlined,
        bullets: [
          'Sensitive to habitat changes',
          'Local protection in parts of Europe',
        ],
      ),
    ],
  ),

  // 6. Arcigera Flower Moth (Schinia arcigera)
  // N. America; wingspan 22–25 mm; adults mid/late summer; larvae feed on several Symphyotrichum asters. Sources: Wikipedia; BugGuide; NatureServe. :contentReference[oaicite:5]{index=5}
  'Arcigera Flower Moth': const ButterflyInfo(
    description:
        'Schinia arcigera is a small noctuid moth of fields and open areas across much of North America. Adults fly in late summer to fall.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on asters, including Symphyotrichum laeve, S. ericoides and related species.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Fields, open areas'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jul–Oct'),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Symphyotrichum spp.',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 22–25 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to lights at night',
          'Check late-season asters for larvae',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Widespread across N. America', 'Several named subspecies'],
      ),
    ],
  ),

  // 7. Atala (Eumaeus atala)
  // SE Florida & Caribbean; wingspan ~38–51 mm; host is coontie (Zamia integrifolia & other cycads); toxic/aposematic; eggs often laid in clusters. Sources: UF/IFAS EDIS; Florida Wildflowers; Wikipedia. :contentReference[oaicite:6]{index=6}
  'Atala': const ButterflyInfo(
    description:
        'The Atala is a small, velvet-black hairstreak with turquoise iridescence and bright red abdominal patches. It is aposematic due to toxins from its cycad host.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs are often laid in clusters on coontie (Zamia) leaves. Larvae feed gregariously on cycads.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Pine rocklands, hammocks',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Most of the year',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Coontie (Zamia)'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~38–51 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Check ornamental cycads in suburbs',
          'Adults often roost in small groups',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Recovered after host plant replanting',
          'Warning colors deter predators',
        ],
      ),
    ],
  ),

  // 8. Atlas Moth (Attacus atlas)
  // One of the world’s largest moths; adults do not feed (vestigial mouthparts); hosts include Citrus, Cinnamomum, Annona, etc.; wingspan up to ~24–26 cm. Sources: Wikipedia; AnimalDiversity; NHM; Reiman Butterfly; Britannica. :contentReference[oaicite:7]{index=7}
  'Atlas Moth': const ButterflyInfo(
    description:
        'The Atlas Moth is a huge silk moth with broad reddish-brown wings and “snake-head” forewing tips. Adults are nocturnal and short-lived.',
    reproduction:
        'Egg → caterpillar → pupa (cocoon) → adult. Adults have vestigial mouthparts and do not feed; energy comes from larval fat reserves.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Tropical forests & gardens',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Mostly nocturnal',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Citrus, Cinnamomum, Annona…',
      ),
      InfoChipData(
        icon: Icons.info_outline,
        label: 'Wingspan: up to ~24–26 cm',
      ),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to lights at night',
          'Females often remain near cocoons',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Adults do not feed (vestigial proboscis)',
          'Among the largest lepidopterans',
        ],
      ),
    ],
  ),

  // 9. Banded Orange Heliconian (Dryadula phaetusa)
  // Lowland tropical fields/valleys; unpalatable (Müllerian mimicry); hosts Passiflora; adults take nectar & bird droppings; wingspan ~2.5–3.5 in (≈65–90 mm). Sources: Wikipedia; BAMONA; South Coast Botanic Garden. :contentReference[oaicite:8]{index=8}
  'Banded Orange Heliconian': const ButterflyInfo(
    description:
        'Dryadula phaetusa is a bright orange heliconian with dark bands, common in lowland tropical fields and open areas; it is unpalatable to predators.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid singly on passion-vines (Passiflora). Adults nectar and also visit bird droppings.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Lowland open areas'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round tropics',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Passiflora spp.'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~65–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Perches in sunny clearings',
          'Group roosting at night is common',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Part of an orange Müllerian mimicry ring',
          'Range: Brazil → Mexico; vagrant to U.S.',
        ],
      ),
    ],
  ),

  // 10. Banded Peacock (Anartia fatima)
  // Subtropical open/disturbed habitats; South TX→Mexico→Central America; hosts Acanthaceae (e.g., Ruellia); wingspan ~6–7 cm. Sources: Wikipedia; BAMONA; BugGuide. :contentReference[oaicite:9]{index=9}
  'Banded Peacock': const ButterflyInfo(
    description:
        'Anartia fatima is a brown nymphalid with bold pale bands. Common from Mexico through Central America; regularly reaches South Texas.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid on low leaves/bracts of host plants in the Acanthaceae; larvae often use Ruellia.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Open & second-growth areas',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (S. TX)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Acanthaceae (Ruellia)',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~60–70 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Patrolling males in late morning',
          'Often along riparian edges',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Common and non-toxic', 'Readily visits garden flowers'],
      ),
    ],
  ),

  // 11. Banded Tiger Moth (Apantesis vittata)
  'Banded Tiger Moth': const ButterflyInfo(
    description:
        'The Banded Tiger Moth (Apantesis vittata) shows dark wings crossed by pale bands. It is a medium-sized moth found in North America. :contentReference[oaicite:0]{index=0}',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on various herbs (e.g. dandelions). Adults fly from spring through fall. :contentReference[oaicite:1]{index=1}',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: fields, lawns, meadows'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval food: herbaceous plants'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~32–42 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Life cycle & behavior',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Larvae feed on low herbs such as dandelions',
          'Overwinter as larvae or pupae in debris',
          'Adults often active at night or drawn to lights',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Use light traps at night',
          'Search open areas near meadows or lawns',
        ],
      ),
    ],
  ),

  // 12. Becker’s White (likely Pieris beckerii or related)
  'Beckers White': const ButterflyInfo(
    description:
        'Becker’s White is a white butterfly in the Pieridae family, similar in appearance to other whites. (Exact species info may vary regionally.)',
    reproduction:
        'Egg → larva → pupa → adult. Larvae likely feed on plants in the mustard (Brassicaceae) family, similar to related “white” butterflies.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: open areas, fields'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: spring to summer',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval food: Brassicaceae plants',
      ),
      InfoChipData(
        icon: Icons.info_outline,
        label: 'Wingspan: ~35–45 mm (typical white range)',
      ),
    ],
    cards: [
      InfoCardData(
        title: 'Behavior & notes',
        leading: Icons.info_outline,
        bullets: [
          'Likely multiple broods in warm climates',
          'Often found near host plants in open terrain',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Check mustard and cabbage family plants',
          'Watch warm, sunny margins and fields',
        ],
      ),
    ],
  ),

  // 13. Bird Cherry Ermine Moth (Yponomeuta evonymella)
  'Bird Cherry Ermine Moth': const ButterflyInfo(
    description:
        'The Bird-cherry Ermine (Yponomeuta evonymella) is a small white moth with many black spots, often seen in clusters on its larval host plant, bird cherry (Prunus padus).',
    reproduction:
        'Egg → larva → pupa → adult. Larvae feed in webs on bird cherry leaves; multiple larvae build communal webs.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: hedgerows, wood edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: late spring to summer',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: bird cherry (Prunus padus)',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~18–25 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Behavior & notes',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Larvae live communally in silk webs',
          'Pupation occurs within the web',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look for webbing on bird cherry trees',
          'Adult moths rest on foliage nearby',
        ],
      ),
    ],
  ),

  // 14. Black Hairstreak (Satyrium pruni)
  'Black Hairstreak': const ButterflyInfo(
    description:
        'The Black Hairstreak (Satyrium pruni) is an elusive butterfly found in blackthorn scrub on heavy clay soils in parts of England and Europe. :contentReference[oaicite:2]{index=2}',
    reproduction:
        'Egg → larva → pupa → adult. Larvae feed mostly on blackthorn (Prunus spinosa), occasionally other Prunus species. :contentReference[oaicite:3]{index=3}',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: blackthorn scrub in woodland edges',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: mid-summer (often July)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval food: blackthorn (Prunus spinosa)',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~37 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Behavior & notes',
        leading: Icons.info_outline,
        bullets: [
          'Adults spend much time in treetops feeding on honeydew',
          'They make short flights to sunlit canopy edges',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Walk woodland rides with blackthorn thickets',
          'Look for them midday in sunshine near tops of scrub',
        ],
      ),
    ],
  ),

  // 15. Blue Morpho (Morpho peleides or similar)
  'Blue Morpho': const ButterflyInfo(
    description:
        'The Blue Morpho (e.g. Morpho peleides) is known for its brilliant iridescent blue wings, seen in tropical forests of Central and South America. :contentReference[oaicite:4]{index=4}',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on plants like legumes (Fabaceae). Adults feed on rotting fruit, tree sap or wet leaf litter. :contentReference[oaicite:5]{index=5}',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: tropical forest understory & edges',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: year-round in tropics',
      ),
      InfoChipData(
        icon: Icons.eco,
        label: 'Adult food: rotting fruit, sap, mud',
      ),
      InfoChipData(
        icon: Icons.info_outline,
        label: 'Wingspan: ~12–20 cm (5–8 in)',
      ),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Watch along forest trails and clearings',
          'Look for the flash of blue in flight between leaves',
        ],
      ),
      InfoCardData(
        title: 'Notes & defense',
        leading: Icons.warning_amber_outlined,
        bullets: [
          'Brown underside with eyespots helps camouflage',
          'Blue flash in flight confuses predators',
        ],
      ),
    ],
  ),

  // 16. Blue Spotted Crow (Euploea midamus or Euploea spp.)
  'Blue Spotted Crow': const ButterflyInfo(
    description:
        'The Blue-spotted Crow is a danaid butterfly of the genus Euploea, marked by blue spots on otherwise dark wings. It is found in Asia and Australasia.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on plants in the Apocynaceae family (e.g. milkweed relatives). Adults often fly in groups, sometimes engaging in mud-puddling.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: tropical forests & edges',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: year-round in tropics',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Apocynaceae species',
      ),
      InfoChipData(
        icon: Icons.info_outline,
        label: 'Expected wingspan: ~70–90 mm (typical for Euploea “crow”)',
      ),
    ],
    cards: [
      InfoCardData(
        title: 'Behavior & notes',
        leading: Icons.info_outline,
        bullets: [
          'Often participates in mud-puddling groups',
          'Part of the large “crow/queen” group of milkweed butterflies',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look along sunny forest edges or paths',
          'Observe low vegetation or puddles for congregations',
        ],
      ),
    ],
  ),

  // 17. Brookes Birdwing (Trogonoptera brookiana or Ornithoptera brookiana)
  'Brookes Birdwing': const ButterflyInfo(
    description:
        'Brookes Birdwing (Ornithoptera / Trogonoptera brookiana) is a large, spectacular butterfly of the rainforests in Southeast Asia, bearing iridescent green or blue on black wings.',
    reproduction:
        'Egg → larva → pupa → adult. Larvae feed on pipe vine (Aristolochia) species; adults visit forest flowers and sip nectar or rotting fruit.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: tropical rainforest'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: year-round in suitable climate',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Aristolochia spp. (pipe vines)',
      ),
      InfoChipData(
        icon: Icons.info_outline,
        label: 'Wingspan: ~15–18 cm (varies with subspecies)',
      ),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look around forest clearings and riverbanks',
          'Often flies high—watch canopy gaps',
        ],
      ),
      InfoCardData(
        title: 'Conservation note',
        leading: Icons.warning_amber_outlined,
        bullets: [
          'Habitat loss is a threat in parts of its range',
          'Highly prized by collectors, so protection needed',
        ],
      ),
    ],
  ),

  // 18. Brown Argus (Aricia agestis)
  'Brown Argus': const ButterflyInfo(
    description:
        'The Brown Argus (Aricia agestis) is a small brown butterfly with orange spots along wing margins, found in Europe and parts of Asia. :contentReference[oaicite:6]{index=6}',
    reproduction:
        'Egg → larva → pupa → adult. Larvae feed on rockrose (Helianthemum) and sometimes geraniums. One or more broods depending on climate.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: grassland, sunny slopes, limestone',
      ),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Helianthemum, Geranium spp.',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~28–32 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Low to the ground—check among rockrose patches',
          'Often seen fluttering near flowers close to soil',
        ],
      ),
      InfoCardData(
        title: 'Conservation note',
        leading: Icons.warning_amber_outlined,
        bullets: [
          'Sensitive to grazing and habitat degradation',
          'Local declines where host plants lost',
        ],
      ),
    ],
  ),

  // 19. Brown Siproeta (Siproeta epaphus or Siproeta stelenes “Brown”)
  'Brown Siproeta': const ButterflyInfo(
    description:
        'The Brown Siproeta is a neotropical butterfly (e.g. Siproeta stelenes, sometimes called the brown morph) with brown wings and subtler patterns than its relative the “Brown Siproeta”.',
    reproduction:
        'Egg → larva → pupa → adult. Larvae feed on plants in the Acanthaceae and other families; adults feed on rotting fruit, tree sap and flowers.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: tropical open forest, edges',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: year-round in tropics',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval hosts: Acanthaceae & related plants',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~70–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Search near fruiting trees or fallen fruit',
          'Often rest on shaded understory leaves',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.info_outline,
        bullets: [
          'Often overlooked due to duller coloration',
          'Related to the more common Siproeta butterfly forms',
        ],
      ),
    ],
  ),

  // 20. Cabbage White (Pieris rapae)
  'Cabbage White': const ButterflyInfo(
    description:
        'The Cabbage White (Pieris rapae), also called the Small White, is a familiar white butterfly with black wing tips and black spots. :contentReference[oaicite:7]{index=7}',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid singly on leaves of mustard family (Brassicaceae). Several generations per year in warm regions. :contentReference[oaicite:8]{index=8}',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: gardens, fields, open areas',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Apr–Oct (multiple broods)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval food: cabbages & mustard family',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ~32–47 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Behavior & notes',
        leading: Icons.info_outline,
        bullets: [
          'Very common, often a pest in cabbage crops',
          'Strong flier that expands its range easily',
        ],
      ),
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look in gardens and fields with brassica plants',
          'Easy to see fluttering in sunny open areas',
        ],
      ),
    ],
  ),
  // 21. Cairns Birdwing (Ornithoptera euphorion)
  // Australia’s largest butterfly; tropical rainforests of NE Queensland; host: Aristolochia tagala; wingspan ♂ up to 15 cm.
  'Cairns Birdwing': const ButterflyInfo(
    description:
        'The Cairns Birdwing is a striking Australian swallowtail—males shimmer emerald-green and gold, females are larger and black with white patches. Found in tropical rainforests of Queensland.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid on native Dutchman’s pipe (Aristolochia tagala). One of the few species where females choose shaded vines.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Rainforest edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Aristolochia tagala',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: ♂ ~15 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look for slow-gliding adults above canopy gaps',
          'Often seen near flowering vines',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Australia’s largest butterfly',
          'Protected species in Queensland',
        ],
      ),
    ],
  ),

  // 22. Chalk Hill Blue (Polyommatus coridon)
  // Europe; chalk grasslands; host: horseshoe vetch; 1 brood Jul–Sep; wingspan 30–36 mm.
  'Chalk Hill Blue': const ButterflyInfo(
    description:
        'A pale silvery-blue butterfly common on sunny chalk and limestone downs across Europe. Males are brighter than the brown-tinted females.',
    reproduction:
        'Eggs laid on horseshoe vetch; overwinters as a tiny larva; one summer generation per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Chalk grassland'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jul–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Horseshoe vetch'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 30–36 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Prefers short-grazed slopes', 'Males patrol low over grass'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['One brood yearly', 'Highly local but abundant on sites'],
      ),
    ],
  ),

  // 23. Chequered Skipper (Carterocephalus palaemon)
  // Moist meadows & woodland clearings; larvae feed on grasses (Molinia); single spring brood; wingspan ~28–34 mm.
  'Chequered Skipper': const ButterflyInfo(
    description:
        'A small, fast-flying skipper with orange-brown chequered wings. Found in damp grassy woodland clearings and meadows.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on purple moor-grass (Molinia). One generation per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Damp woodland clearings'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Jun'),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Moor-grass (Molinia)',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 28–34 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Active on sunny mornings',
          'Often rests with open wings on grass stems',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Locally rare and reintroduced in England',
          'Adults live only about a week',
        ],
      ),
    ],
  ),

  // 24. Chestnut (Conistra vaccinii)
  // Common winter moth of Europe; adults fly Oct–Apr; larvae feed on broadleaf trees; wingspan ~30–40 mm.
  'Chestnut': const ButterflyInfo(
    description:
        'The Chestnut is a medium-sized brown moth flying through the cold months when few others are active.',
    reproduction:
        'Eggs overwinter on twigs; caterpillars feed in spring on oak, birch and fruit trees; adults emerge in autumn.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Woodlands, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Oct–Apr'),
      InfoChipData(icon: Icons.nature, label: 'Larval hosts: Deciduous trees'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 30–40 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to light traps in winter',
          'Can fly on mild nights',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['One of few moths active in winter', 'Common across Europe'],
      ),
    ],
  ),

  // 25. Cinnabar Moth (Tyria jacobaeae)
  // Distinctive black-and-red day-flying moth; larvae on ragwort; wingspan 32–42 mm.
  'Cinnabar Moth': const ButterflyInfo(
    description:
        'A bright red-and-black day-flying moth often seen fluttering over grassy fields and roadside verges.',
    reproduction:
        'Eggs laid on ragwort; black-and-orange caterpillars absorb plant toxins making them distasteful to birds.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, waste ground'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Ragwort'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 32–42 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Easily spotted by red wings in daylight',
          'Look for striped caterpillars on ragwort',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Toxic to predators', 'Used in ragwort biological control'],
      ),
    ],
  ),

  // 26. Clearwing Moth (Family Sesiidae, e.g. Synanthedon tipuliformis)
  // Transparent-winged day-flying moths; mimic wasps; larvae in woody stems; wingspan 15–30 mm.
  'Clearwing Moth': const ButterflyInfo(
    description:
        'Clearwing moths are small, wasp-mimicking day-flyers with transparent wings. They hover at flowers like bees.',
    reproduction:
        'Larvae tunnel in stems or roots of trees and shrubs depending on species. Adults live briefly in summer.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, wood edges'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Various woody plants',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 15–30 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted by pheromone lures',
          'Often mistaken for small wasps',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Includes currant, hornet & six-belted clearwings',
          'Safe mimicry deters predators',
        ],
      ),
    ],
  ),

  // 27. Cleopatra (Gonepteryx cleopatra)
  // Mediterranean cousin of the Brimstone; yellow-orange males, pale females; host: Rhamnus species; wingspan 55–70 mm.
  'Cleopatra': const ButterflyInfo(
    description:
        'The Cleopatra is a bright yellow-orange butterfly resembling the Brimstone. Common around the Mediterranean.',
    reproduction:
        'Eggs laid on buckthorn shrubs; one generation per year; adults hibernate over winter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Scrub, woodland edges'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Rhamnus spp.'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 55–70 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Flies strongly in sunny woodland',
          'Often confused with Brimstone',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Overwinters as adult', 'Common around Mediterranean basin'],
      ),
    ],
  ),

  // 28. Clodius Parnassian (Parnassius clodius)
  // Western N. America; mountain meadows; host: Dicentra; 1 brood Jun–Aug; wingspan 55–75 mm.
  'Clodius Parnassian': const ButterflyInfo(
    description:
        'A white mountain butterfly with translucent wings and red or yellow spots. Found from British Columbia to California.',
    reproduction:
        'Eggs laid near host bleeding heart (Dicentra). One annual brood; overwinters as egg.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Mountain meadows'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Dicentra species'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 55–75 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Flies in sunny alpine meadows', 'Often perches on rocks'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Closely related to Apollo group',
          'Sensitive to habitat loss',
        ],
      ),
    ],
  ),

  // 29. Clouded Sulphur (Colias philodice)
  // North America; yellow-orange butterfly; hosts clovers and alfalfa; several broods; wingspan 32–57 mm.
  'Clouded Sulphur': const ButterflyInfo(
    description:
        'A common yellow butterfly of fields and roadsides across North America, often seen with wings partly open while feeding.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Larvae feed on clovers and alfalfa; multiple generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, roadsides'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Spring–Autumn',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Clovers, alfalfa'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 32–57 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Common in sunny open areas', 'Often mud-puddles in groups'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Several broods per year',
          'One of North America’s most widespread butterflies',
        ],
      ),
    ],
  ),

  // 30. Comet Moth (Argema mittrei)
  // Madagascar endemic; huge yellow wings with long tails; host: Tambourissa trees; adults do not feed; wingspan up to 20 cm.
  'Comet Moth': const ButterflyInfo(
    description:
        'The Comet Moth, or Madagascan Moon Moth, is a spectacular bright yellow silk moth with long trailing tails on its hindwings.',
    reproduction:
        'Egg → caterpillar → cocoon → adult. Caterpillars feed on Tambourissa leaves; adults have no mouthparts and live only a few days.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Rainforests of Madagascar',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Mostly nocturnal',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Tambourissa trees'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: up to 20 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Rare in wild; often bred in captivity',
          'Attracted to light at night',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Endemic to Madagascar',
          'Adults do not feed; short lifespan',
        ],
      ),
    ],
  ),

  // 31. Common Banded Awl (Hasora chromus)
  // Widespread in South & Southeast Asia; dark brown skipper with white band; host: legumes; wingspan 45–55 mm.
  'Common Banded Awl': const ButterflyInfo(
    description:
        'A fast-flying dark brown skipper with a distinct white band across its hindwings. Common in gardens and forests of South Asia.',
    reproduction:
        'Egg → caterpillar → pupa → adult. Eggs laid on leguminous plants; larvae rest in leaf shelters during the day.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, gardens'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Legumes'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–55 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Active at dawn and dusk', 'Rests under leaves in daytime'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Common in South Asia', 'Strong and rapid flyer'],
      ),
    ],
  ),

  // 32. Common Wood-Nymph (Cercyonis pegala)
  // North America; brown butterfly with eyespots; host: grasses; wingspan 45–75 mm.
  'Common Wood-Nymph': const ButterflyInfo(
    description:
        'A soft brown butterfly with eye spots on its forewings, found in fields and open woods throughout North America.',
    reproduction:
        'Eggs laid on grasses; larvae overwinter and resume feeding in spring before pupating.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Fields, open woods'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jun–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Grasses'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–75 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Flies close to the ground',
          'Often perches on tall grass stems',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Variable eyespot patterns',
          'One brood per year in most regions',
        ],
      ),
    ],
  ),

  // 33. Copper Tail (Lycaenidae family, e.g. Cigaritis vulcanus)
  // Africa & Asia; small orange with tail tips; host: legumes, Zizyphus; wingspan 25–35 mm.
  'Copper Tail': const ButterflyInfo(
    description:
        'A small orange-brown butterfly with fine tail extensions and black markings. Common in dry open habitats.',
    reproduction:
        'Eggs laid on legumes or Zizyphus shrubs; larvae often tended by ants for protection.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Dry scrub, savanna'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Legumes, Zizyphus'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often perches on low shrubs',
          'Adults visit small flowers for nectar',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Common lycaenid butterfly', 'Larvae have mutualistic ants'],
      ),
    ],
  ),

  // 34. Crescent (Phyciodes tharos - Pearl Crescent)
  // N. America; orange patterned butterfly; host asters; wingspan 30–40 mm.
  'Crescent': const ButterflyInfo(
    description:
        'The Pearl Crescent is a small orange-and-black butterfly common in sunny meadows and roadsides across North America.',
    reproduction:
        'Eggs laid in clusters on asters; multiple generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, fields'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Asters'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 30–40 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Flies close to the ground', 'Can be abundant in open areas'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Several broods yearly',
          'Easily confused with similar crescents',
        ],
      ),
    ],
  ),

  // 35. Crimson Patch (Chlosyne janais)
  // Central America to S Texas; red and black wings; host: acanthus family; wingspan 45–55 mm.
  'Crimson Patch': const ButterflyInfo(
    description:
        'A bright red-and-black butterfly found in tropical regions from Mexico to South Texas, often near streams.',
    reproduction:
        'Eggs laid on Acanthaceae plants like Justicia; larvae are spiny and gregarious.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, streams'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Acanthaceae'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–55 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Perches on low vegetation', 'Often sunning with open wings'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Named for its bright red “patches”',
          'Occasional visitor to southern U.S.',
        ],
      ),
    ],
  ),

  // 36. Danaid Eggfly (Hypolimnas misippus)
  // Tropical butterfly; mimic of monarchs; host: Portulaca, Sida; wingspan 70–85 mm.
  'Danaid Eggfly': const ButterflyInfo(
    description:
        'A striking butterfly with dark brown wings and white spots, the female mimics monarchs and other toxic species.',
    reproduction:
        'Eggs laid on Portulaca and Sida plants; larvae black with orange spines; several generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, open woodland'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Portulaca, Sida'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–85 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Common in sunny clearings', 'Males defend territories'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Females mimic toxic monarchs', 'Widespread across tropics'],
      ),
    ],
  ),

  // 37. Eastern Comma (Polygonia comma)
  // N. America; orange wings with ragged edges; host: nettle, elm; wingspan 45–60 mm.
  'Eastern Comma': const ButterflyInfo(
    description:
        'The Eastern Comma is an orange butterfly with irregular wing edges and a small silver comma mark on the underside.',
    reproduction:
        'Eggs laid on nettles, elms, and hops; two broods per year; adults hibernate over winter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Elm, Nettle, Hop'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–60 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often basks on tree trunks',
          'Underside provides excellent camouflage',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Overwinters as adult butterfly',
          'Common across eastern North America',
        ],
      ),
    ],
  ),

  // 38. Eastern Dapple White (Euchloe ausonides)
  // Western North America; white butterfly with green marbling; host: mustards; wingspan 35–50 mm.
  'Eastern Dapple White': const ButterflyInfo(
    description:
        'A white butterfly with greenish marbled underwings, found in open fields and sagebrush habitats.',
    reproduction:
        'Eggs laid singly on mustards; larvae blend with green stems; one or two broods yearly.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Open fields, foothills'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Mustards'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 35–50 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Flies close to the ground', 'Best seen in spring bloom'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Camouflaged underside pattern',
          'Common in western U.S. prairies',
        ],
      ),
    ],
  ),

  // 39. Eastern Pine Elfin (Callophrys niphon)
  // Small hairstreak of pine forests; wingspan 22–28 mm; host: pines.
  'Eastern Pine Elfin': const ButterflyInfo(
    description:
        'A tiny brown butterfly with a faint tail and pale line, found in pine forests of eastern North America.',
    reproduction:
        'Eggs laid on pine needles; larvae feed on new growth; one early-spring generation.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Pine forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Jun'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Pines'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 22–28 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Perches on pine twigs', 'Tiny and quick in early spring'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'One of the earliest spring hairstreaks',
          'Single brood per year',
        ],
      ),
    ],
  ),

  // 40. Elbowed Pierrot (Caleta elna)
  // South & Southeast Asia; small black-and-white butterfly; host: Zizyphus; wingspan 25–35 mm.
  'Elbowed Pierrot': const ButterflyInfo(
    description:
        'A tiny black-and-white butterfly with angular hindwing bands, found fluttering close to the ground in open woods.',
    reproduction:
        'Eggs laid on Zizyphus leaves; larvae green with short hairs; several broods per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Scrub, forest edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Zizyphus spp.'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Flutters low near paths', 'Often settles with wings closed'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Common in Asia’s woodlands', 'Fast, erratic flyer'],
      ),
    ],
  ),

  // 41. Emperor Gum Moth (Opodiphthera eucalypti)
  // Large Australian silk moth; wingspan up to 15 cm; host: Eucalyptus.
  'Emperor Gum Moth': const ButterflyInfo(
    description:
        'A large Australian silk moth with eye spots on all four wings. Adults do not feed and live only a few days.',
    reproduction:
        'Egg → caterpillar → cocoon → adult. Larvae feed on Eucalyptus leaves; pupate in tough cocoons.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Eucalyptus woodland'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Late summer–autumn',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Eucalyptus'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: up to 15 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Attracted to lights at night', 'Large and slow-flying moth'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Adults do not feed', 'Iconic Australian silk moth'],
      ),
    ],
  ),

  // 42. Garden Tiger Moth (Arctia caja)
  // Europe & N. America; hairy caterpillar “woolly bear”; wingspan 45–65 mm.
  'Garden Tiger Moth': const ButterflyInfo(
    description:
        'A colorful moth with brown-and-white forewings and bright orange hindwings with blue spots. Common in temperate regions.',
    reproduction:
        'Eggs laid on low plants; larvae are “woolly bears” feeding on dandelion and dock.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Dandelion, Dock'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–65 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Often seen at lights', 'Larvae overwinter in leaf litter'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Aposematic coloration deters predators',
          'Declining in some regions',
        ],
      ),
    ],
  ),

  // 43. Giant Leopard Moth (Hypercompe scribonia)
  // Eastern U.S.; white wings with black spots; wingspan 50–80 mm.
  'Giant Leopard Moth': const ButterflyInfo(
    description:
        'A beautiful white moth with bold black spots, found in gardens and woodlands of eastern North America.',
    reproduction:
        'Eggs laid on low plants; black spiny caterpillars feed on broadleaf weeds.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, woodland edges'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Dandelion, Plantain',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 50–80 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to lights at night',
          'Caterpillars curl when disturbed',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Found across eastern U.S.',
          'Distinctive white-and-black pattern',
        ],
      ),
    ],
  ),

  // 44. Glittering Sapphire (Iolaus diametra)
  // Africa; small, bright blue hairstreak; host: mistletoe; wingspan 30–35 mm.
  'Glittering Sapphire': const ButterflyInfo(
    description:
        'A tiny African butterfly with brilliant metallic-blue wings and short tails. Common in open woodlands and near mistletoe plants.',
    reproduction:
        'Eggs laid on mistletoe; larvae feed within leaves; several broods per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Woodland, savanna'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Mistletoe'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 30–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often perches high near host trees',
          'Best seen in morning sunlight',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Shimmering blue coloration varies with light',
          'Common across sub-Saharan Africa',
        ],
      ),
    ],
  ),

  // 45. Gold Banded (Autochton cellus - Gold-banded Skipper)
  // Americas; large brown skipper with golden band; host: legumes; wingspan 45–65 mm.
  'Gold Banded': const ButterflyInfo(
    description:
        'A robust brown skipper with a bright golden diagonal band across each forewing. Found from the southern U.S. through Central America.',
    reproduction:
        'Eggs laid on legumes such as wisteria and false indigo; caterpillars live in folded leaves.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Woodland edges, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Legumes'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–65 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Flies fast and low in shaded areas',
          'Often rests on leaves with wings spread',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Common in the southern U.S. and tropics',
          'Recognizable by its bright golden stripe',
        ],
      ),
    ],
  ),

  // 46. Great Eggfly (Hypolimnas bolina)
  // Asia-Pacific region; large butterfly; males black with violet sheen; host: Portulaca, Sida; wingspan 70–85 mm.
  'Great Eggfly': const ButterflyInfo(
    description:
        'A large tropical butterfly. Males are black with vivid purple-blue spots, while females mimic other species for protection.',
    reproduction:
        'Eggs laid on Portulaca and Sida plants; larvae black with orange spines; multiple generations yearly.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, forest edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Portulaca, Sida'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–85 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Common in sunny open areas', 'Males defend territories'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Female mimics toxic species',
          'Widespread across Asia and Pacific islands',
        ],
      ),
    ],
  ),

  // 47. Great Jay (Graphium evemon)
  // Southeast Asia; swallowtail with blue bands; host: citrus and laurels; wingspan 80–100 mm.
  'Great Jay': const ButterflyInfo(
    description:
        'A beautiful swallowtail butterfly with blue and black bands. Found in tropical forests of Southeast Asia.',
    reproduction:
        'Eggs laid on laurels and citrus trees; larvae green and smooth; several broods in warm regions.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Tropical forests'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Citrus, Lauraceae'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 80–100 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often seen feeding at flowers',
          'Swift, gliding flight in forest clearings',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'One of several “Jay” species with blue bands',
          'Prefers humid lowland forests',
        ],
      ),
    ],
  ),

  // 48. Green-celled Cattleheart (Parides childrenae)
  // Central & South America; black butterfly with red spots and green patch; host: Aristolochia; wingspan 70–90 mm.
  'Green Celled Cattleheart': const ButterflyInfo(
    description:
        'A striking black butterfly with a greenish iridescent patch on its wings and red spots on the hindwings. Common in tropical forests.',
    reproduction:
        'Eggs laid on pipevines (Aristolochia); larvae toxic due to host plant chemicals.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Tropical forests'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Aristolochia vines',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Common near forest streams',
          'Slow and graceful flight pattern',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Unpalatable to predators', 'Part of the swallowtail family'],
      ),
    ],
  ),

  // 49. Green Hairstreak (Callophrys rubi)
  // Europe & Asia; small green butterfly; host: gorse, buckthorn; wingspan 26–34 mm.
  'Green Hairstreak': const ButterflyInfo(
    description:
        'A small butterfly with brilliant green underwings and brown upperwings. Common in heathland and scrub areas.',
    reproduction:
        'Eggs laid on gorse, broom, and buckthorn; one generation per year; overwinters as pupa.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Heathland, scrub'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Jun'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Gorse, Buckthorn'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 26–34 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Perches on shrubs in sunny spots',
          'Always rests with wings closed',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Only green butterfly in Europe', 'One brood per year'],
      ),
    ],
  ),

  // 50. Grey Hairstreak (Strymon melinus)
  // Americas; gray butterfly with orange spots and tail; host: legumes and mallows; wingspan 25–38 mm.
  'Grey Hairstreak': const ButterflyInfo(
    description:
        'A small gray butterfly with delicate tails and bright orange spots near the hindwing edge. Found across the Americas.',
    reproduction:
        'Eggs laid on many host plants including mallows and legumes; multiple generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Fields, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Legumes, Mallows'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–38 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Flutters around flowers and shrubs',
          'Common in sunny, open habitats',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Very widespread in the Americas',
          'One of the most adaptable hairstreaks',
        ],
      ),
    ],
  ),

  // 51. Hercules Moth (Coscinocera hercules)
  // Northern Australia & New Guinea; world’s largest wingspan up to 27 cm; host: rainforest trees.
  'Hercules Moth': const ButterflyInfo(
    description:
        'One of the world’s largest moths, the Hercules Moth has pale brown wings with long tails and transparent patches. Found in tropical rainforests of Australia and New Guinea.',
    reproduction:
        'Egg → caterpillar → cocoon → adult. Caterpillars feed on rainforest trees such as Dysoxylum and Glochidion. Adults do not feed.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Tropical rainforest'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Summer, nocturnal',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Dysoxylum, Glochidion',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: up to 27 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Attracted to light at night', 'Adults live only a few days'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Largest wingspan of any moth', 'Adults lack mouthparts'],
      ),
    ],
  ),

  // 52. Hummingbird Hawk Moth (Macroglossum stellatarum)
  // Europe, Asia, N. Africa; day-flying moth; hovers like hummingbird; host: bedstraws; wingspan 40–50 mm.
  'Humming Bird Hawk Moth': const ButterflyInfo(
    description:
        'A fast-flying, day-active moth that hovers while feeding on flowers like a hummingbird. Common across Europe and Asia.',
    reproduction:
        'Eggs laid on bedstraw (Galium) plants; several broods per year; migratory in colder regions.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, meadows'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Apr–Oct (daytime)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Bedstraws'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 40–50 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Easily seen feeding on flowers in sunlight',
          'Hovers with blurred wings like a hummingbird',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Migrates north each summer',
          'One of the few day-flying hawk moths',
        ],
      ),
    ],
  ),

  // 53. Indra Swallowtail (Papilio indra)
  // Western North America; black swallowtail with pale bands; host: desert parsleys; wingspan 75–90 mm.
  'Indra Swallow': const ButterflyInfo(
    description:
        'A dark, elegant swallowtail of western North America with pale cream bands and short tails. Prefers desert canyons and slopes.',
    reproduction:
        'Eggs laid on desert parsley (Lomatium); one or two generations depending on region.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Arid canyons, slopes'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Jul'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Lomatium spp.'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 75–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Seen gliding along ridges and slopes',
          'Best observed in early spring',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Endemic to western U.S.', 'Prefers hot, rocky habitats'],
      ),
    ],
  ),

  // 54. Io Moth (Automeris io)
  // North America; yellow or brown with large eyespots; host: willow, clover; wingspan 60–80 mm.
  'Io Moth': const ButterflyInfo(
    description:
        'A colorful silk moth with large eye spots on its hindwings used to startle predators. Males are bright yellow, females brownish.',
    reproduction:
        'Eggs laid in clusters; spiny green caterpillars feed on willow, clover, and other plants.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Willow, Clover'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–80 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to lights at night',
          'Shows eyespots when disturbed',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Caterpillars have stinging spines',
          'Common silk moth across U.S.',
        ],
      ),
    ],
  ),

  // 55. Iphiclus Sister (Adelpha iphiclus)
  // Central & South America; brown with white and orange bands; host: Rubiaceae; wingspan 60–75 mm.
  'Iphiclus Sister': const ButterflyInfo(
    description:
        'A tropical butterfly with brown wings marked by white and orange bands. Common along forest edges and rivers.',
    reproduction:
        'Eggs laid on Rubiaceae plants; larvae green with short spines; several broods yearly.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Forest edges, riversides',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Rubiaceae'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–75 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Perches with wings open in sunlight',
          'Common in lowland forests',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Part of the “sister” group (genus Adelpha)',
          'Distinctive orange-white pattern',
        ],
      ),
    ],
  ),

  // 56. Julia (Dryas iulia)
  // Bright orange butterfly; Americas; host: passion vines; wingspan 80–90 mm.
  'Julia': const ButterflyInfo(
    description:
        'A long, bright orange butterfly with narrow wings, common in tropical gardens and forests of the Americas.',
    reproduction:
        'Eggs laid on passion vines; larvae orange with black spines; several generations per year.',
    chips: [
      InfoChipData(
        icon: Icons.park,
        label: 'Habitat: Gardens, tropical forests',
      ),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Passiflora vines'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 80–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often perches with wings spread wide',
          'Feeds at lantana and verbena flowers',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Common in butterfly houses',
          'Unpalatable to birds due to host toxins',
        ],
      ),
    ],
  ),

  // 57. Large Marble (Euchloe ausonides)
  // North America; white butterfly with green marbling; host: mustards; wingspan 35–50 mm.
  'Large Marble': const ButterflyInfo(
    description:
        'A white butterfly with greenish marbled underwings, often found in meadows and open fields in North America.',
    reproduction:
        'Eggs laid on mustards and rock cress; one generation in cool areas, two in warm regions.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, foothills'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Jul'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Mustards'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 35–50 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Flies near ground level', 'Restless in warm sunlight'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Common throughout western North America',
          'Similar to other marble whites',
        ],
      ),
    ],
  ),

  // 58. Luna Moth (Actias luna)
  // North America; large pale green silk moth; host: walnut, birch; wingspan 8–11 cm.
  'Luna Moth': const ButterflyInfo(
    description:
        'A beautiful pale green moth with long tails and eye spots on each wing. Common in eastern North America.',
    reproduction:
        'Egg → caterpillar → cocoon → adult. Caterpillars feed on walnut, birch, and sweetgum; adults do not feed.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Deciduous forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Jul'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Walnut, Birch'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 80–110 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to lights at night',
          'Rarely seen due to short lifespan',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Adults live only a week', 'Iconic North American moth'],
      ),
    ],
  ),

  // 59. Madagascan Sunset Moth (Chrysiridia rhipheus)
  // Endemic to Madagascar; iridescent rainbow-colored wings; host: Omphalea; wingspan 70–90 mm.
  'Madagascan Sunset Moth': const ButterflyInfo(
    description:
        'A spectacular day-flying moth with iridescent rainbow-colored wings. Found only in Madagascar.',
    reproduction:
        'Eggs laid on Omphalea trees; larvae feed on toxic leaves, gaining chemical protection.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Madagascar forests'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (day-flying)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Omphalea species'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'One of few colorful day-flying moths',
          'Best seen in forest clearings',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Endemic to Madagascar',
          'Considered one of the most beautiful insects',
        ],
      ),
    ],
  ),

  // 60. Malachite (Siproeta stelenes)
  // Central & South America; green and brown wings; host: Ruellia; wingspan 80–95 mm.
  'Malachite': const ButterflyInfo(
    description:
        'A tropical butterfly with vivid green and brown patterned wings. Common in Central and South America.',
    reproduction:
        'Eggs laid on Ruellia and related plants; larvae dark with spines; several broods per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, gardens'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Ruellia, Acanthaceae',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 80–95 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often seen gliding in shaded clearings',
          'Nectars on bright tropical flowers',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Named for malachite-green coloration',
          'Common in butterfly gardens',
        ],
      ),
    ],
  ),

  // 61. Mangrove Skipper (Phocides pigmalion)
  // Coastal Florida, Caribbean, Central America; large dark skipper; host: red mangrove; wingspan 60–80 mm.
  'Mangrove Skipper': const ButterflyInfo(
    description:
        'A large, dark brown skipper with iridescent blue reflections, found in mangrove swamps and coastal areas.',
    reproduction:
        'Eggs laid on red mangrove leaves; larvae rest in rolled leaf shelters; several broods per year in warm climates.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Mangroves, coasts'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Red mangrove'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–80 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Flies swiftly along mangrove edges',
          'Rests with wings partially open',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Common in southern Florida',
          'Prefers humid coastal environments',
        ],
      ),
    ],
  ),

  // 62. Mestra (Mestra amymone - Common Mestra)
  // Southern U.S. to South America; white and orange; host: Tragia; wingspan 35–45 mm.
  'Mestra': const ButterflyInfo(
    description:
        'A small white butterfly with orange and black markings, found from Texas to South America in open fields and brushy areas.',
    reproduction:
        'Eggs laid on noseburn (Tragia) plants; larvae feed on leaves and stems; several generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Fields, scrub'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Nov'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Tragia spp.'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 35–45 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often flutters close to the ground',
          'Common after rains in open fields',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Sometimes migratory',
          'Only member of its genus in North America',
        ],
      ),
    ],
  ),

  // 63. Metalmark (Family Riodinidae - e.g. Calephelis nemesis)
  // Americas; small butterflies with metallic spots; host: asters, eupatorium; wingspan 25–35 mm.
  'Metalmark': const ButterflyInfo(
    description:
        'A group of small butterflies with metallic spots and patterns on their wings. Common in sunny clearings and along streams.',
    reproduction:
        'Eggs laid on asters or eupatorium; larvae often flattened and slug-like; several broods per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, woodland edges'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Spring–Autumn',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Asters, Eupatorium',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often rest with wings spread flat',
          'Look for metallic reflections in sunlight',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Hundreds of species in the Americas',
          'Named for their shiny wing scales',
        ],
      ),
    ],
  ),

  // 64. Milbert’s Tortoiseshell (Aglais milberti)
  // North America; orange and black; host: nettles; wingspan 45–60 mm.
  'Milberts Tortoiseshell': const ButterflyInfo(
    description:
        'A striking orange-and-black butterfly with a yellow border, common near moist meadows and forest edges.',
    reproduction:
        'Eggs laid on stinging nettles; one or two generations; adults hibernate through winter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, forest edges'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Nettles'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–60 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Active in bright sunlight',
          'Overwinters as an adult butterfly',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'One of the few northern overwintering species',
          'Fast, low flight near nettle patches',
        ],
      ),
    ],
  ),

  // 65. Monarch (Danaus plexippus)
  // Famous migratory butterfly; North America; host: milkweed; wingspan 90–100 mm.
  'Monarch': const ButterflyInfo(
    description:
        'The Monarch is one of the world’s most famous butterflies, known for its orange and black wings and epic migration across North America.',
    reproduction:
        'Eggs laid on milkweed; caterpillars feed exclusively on it, gaining toxins that deter predators; 3–4 generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, fields'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Mar–Oct (migratory)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Milkweed'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 90–100 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Easily recognized by its bold orange and black pattern',
          'Seen during migration in large groups',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Migrates thousands of kilometers to Mexico',
          'Toxic to predators due to milkweed diet',
        ],
      ),
    ],
  ),

  // 66. Mourning Cloak (Nymphalis antiopa)
  // North America, Europe; dark maroon with pale edges; host: willow, elm; wingspan 60–75 mm.
  'Mourning Cloak': const ButterflyInfo(
    description:
        'A large maroon butterfly edged with pale yellow and blue spots. One of the first butterflies to appear in spring.',
    reproduction:
        'Eggs laid on willow and elm; one brood per year; adults overwinter and live up to 10 months.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, parks'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Willow, Elm'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–75 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often basks on tree trunks in early spring',
          'Feeds on sap and rotting fruit',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'One of the longest-lived butterflies',
          'Known as “Camberwell Beauty” in Europe',
        ],
      ),
    ],
  ),

  // 67. Oleander Hawk Moth (Daphnis nerii)
  // Africa, Asia, Europe; large green hawk moth; host: oleander; wingspan 80–120 mm.
  'Oleander Hawk Moth': const ButterflyInfo(
    description:
        'A spectacular green moth with leaf-like camouflage patterns. Found across Africa, Asia, and southern Europe.',
    reproduction:
        'Eggs laid on oleander and periwinkle; adults nectar at night; migratory species.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, forests'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Summer, nocturnal',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Oleander, Periwinkle',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 80–120 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to light at night',
          'Often seen resting on walls or foliage by day',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Strong flyer and migrant',
          'Camouflage makes it nearly invisible on leaves',
        ],
      ),
    ],
  ),

  // 68. Orange Oakleaf (Kallima inachus)
  // South & Southeast Asia; leaf-mimicking butterfly; host: Strobilanthes; wingspan 85–110 mm.
  'Orange Oakleaf': const ButterflyInfo(
    description:
        'A remarkable butterfly with bright orange and blue upperwings but undersides that look exactly like a dead leaf.',
    reproduction:
        'Eggs laid on Strobilanthes plants; larvae green with spines; adults rest with closed wings to blend in.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forests, gardens'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Strobilanthes spp.',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 85–110 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Resting adults resemble dry leaves perfectly',
          'Open wings reveal vivid orange patches',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: ['Master of camouflage', 'Found throughout tropical Asia'],
      ),
    ],
  ),

  // 69. Orange Tip (Anthocharis cardamines)
  // Europe & Asia; white with orange wing tips; host: garlic mustard; wingspan 45–50 mm.
  'Orange Tip': const ButterflyInfo(
    description:
        'A small white butterfly with bright orange tips on male forewings. Common in spring meadows and hedgerows.',
    reproduction:
        'Eggs laid singly on garlic mustard and cuckoo flower; one spring generation per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, woodland edges'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Jun'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Garlic mustard'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–50 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'One of the first butterflies of spring',
          'Males easily spotted by orange tips',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Single generation each year',
          'Females lack orange markings',
        ],
      ),
    ],
  ),

  // 70. Orchard Swallowtail (Papilio aegeus)
  // Australia; large black-and-white swallowtail; host: citrus; wingspan 100–120 mm.
  'Orchard Swallow': const ButterflyInfo(
    description:
        'A large black-and-white swallowtail common in eastern Australia. Females are variable, with white or cream markings.',
    reproduction:
        'Eggs laid on citrus trees; larvae resemble bird droppings when young; several broods yearly.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, forests'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (warm regions)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Citrus'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 100–120 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Common around citrus trees', 'Slow, graceful flight'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Australia’s largest swallowtail',
          'Easily raised on citrus in captivity',
        ],
      ),
    ],
  ),

  // 71. Painted Lady (Vanessa cardui)
  // Worldwide; orange and black butterfly; host: thistles; wingspan 50–65 mm.
  'Painted Lady': const ButterflyInfo(
    description:
        'A widespread orange-and-black butterfly found on every continent except Antarctica. Known for its long migrations.',
    reproduction:
        'Eggs laid on thistles and mallows; caterpillars live in silk shelters; multiple generations per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Thistles, Mallows'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 50–65 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: ['Common worldwide migrant', 'Often seen on flowering plants'],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Can migrate thousands of kilometers',
          'One of the most common butterflies on Earth',
        ],
      ),
    ],
  ),

  // 72. Paper Kite (Idea leuconoe)
  // Southeast Asia; large white-and-black butterfly; host: Apocynaceae vines; wingspan 95–110 mm.
  'Paper Kite': const ButterflyInfo(
    description:
        'A graceful white-and-black butterfly that glides slowly through tropical forests of Southeast Asia. Also known as the Rice Paper butterfly.',
    reproduction:
        'Eggs laid on Apocynaceae vines; larvae white with black and orange spots; several generations yearly.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Rainforests, gardens'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(
        icon: Icons.nature,
        label: 'Larval host: Parsonsia, Cynanchum',
      ),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 95–110 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Slow, gliding flight easy to observe',
          'Common in butterfly houses',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Toxic to predators from host plant chemicals',
          'Common in Southeast Asia and the Philippines',
        ],
      ),
    ],
  ),

  // 73. Peacock (Aglais io)
  // Europe & Asia; red wings with large eyespots; host: nettles; wingspan 55–70 mm.
  'Peacock': const ButterflyInfo(
    description:
        'A vivid red butterfly with striking eye spots on each wing, common across Europe and Asia. One of the most recognizable species.',
    reproduction:
        'Eggs laid in clusters on nettles; caterpillars black and spiny; adults hibernate over winter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, meadows'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Nettles'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 55–70 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Easily seen on flowers and fallen fruit',
          'Overwinters in sheds or tree holes',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Displays eye spots to startle predators',
          'One of Europe’s best-known butterflies',
        ],
      ),
    ],
  ),

  // 74. Pine White (Neophasia menapia)
  // Western North America; white butterfly; host: pine trees; wingspan 40–55 mm.
  'Pine White': const ButterflyInfo(
    description:
        'A delicate white butterfly with black vein markings, found in mountain pine forests of western North America.',
    reproduction:
        'Eggs laid on pine needles; larvae feed on conifers; one generation per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Pine forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jul–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Pine trees'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 40–55 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often seen fluttering high among pines',
          'Adults attracted to flowers in clearings',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'One brood per year',
          'Population numbers vary widely yearly',
        ],
      ),
    ],
  ),

  // 75. Pipevine Swallowtail (Battus philenor)
  // North America; black with blue sheen; host: pipevines; wingspan 75–95 mm.
  'Pipevine Swallow': const ButterflyInfo(
    description:
        'A dark swallowtail butterfly with iridescent blue hindwings. Common in the southern and eastern United States.',
    reproduction:
        'Eggs laid on pipevine (Aristolochia); larvae absorb plant toxins, making adults distasteful to predators.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Pipevine'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 75–95 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often seen sipping nectar from lantana and milkweed',
          'Slow, gliding flight near flowers',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Model for several mimic species',
          'Unpalatable due to pipevine toxins',
        ],
      ),
    ],
  ),

  // 76. Polyphemus Moth (Antheraea polyphemus)
  // North America; large tan moth with eye spots; host: many trees; wingspan 10–15 cm.
  'Polyphemus Moth': const ButterflyInfo(
    description:
        'A large silk moth with tan wings and big blue-and-yellow eye spots. Found throughout North America.',
    reproduction:
        'Egg → caterpillar → cocoon → adult. Larvae feed on oak, maple, and birch; adults live only a few days.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forests, suburbs'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Oak, Maple, Birch'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 100–150 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Attracted to light at night',
          'Cocoons often found on branches',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Adults do not feed',
          'Named after the one-eyed giant Polyphemus',
        ],
      ),
    ],
  ),

  // 77. Popinjay (Stibochiona nicea)
  // South & Southeast Asia; black with blue-green bands; host: Lauraceae; wingspan 60–75 mm.
  'Popinjay': const ButterflyInfo(
    description:
        'A medium-sized butterfly with glossy black wings crossed by turquoise-blue bands. Common in Asian forests.',
    reproduction:
        'Eggs laid on laurel family plants; larvae green with horned heads; several broods per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Forests, clearings'),
      InfoChipData(
        icon: Icons.stacked_line_chart,
        label: 'Flight: Year-round (tropics)',
      ),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Lauraceae'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–75 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Perches on sunlit forest paths',
          'Wings shimmer blue in sunlight',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Distinct metallic sheen on wings',
          'Common forest butterfly in Asia',
        ],
      ),
    ],
  ),

  // 78. Purple Hairstreak (Favonius quercus)
  // Europe; small with purple sheen; host: oak; wingspan 28–35 mm.
  'Purple Hairstreak': const ButterflyInfo(
    description:
        'A small butterfly with a shimmering purple sheen, often seen flying high in oak canopies across Europe.',
    reproduction:
        'Eggs laid on oak buds; larvae feed on young leaves; one generation per year.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Oak forests'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Oak'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 28–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Look high in oak trees during sunny afternoons',
          'Rarely seen at ground level',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Single brood per year',
          'Purple sheen mainly visible on males',
        ],
      ),
    ],
  ),

  // 79. Purplish Copper (Lycaena helloides)
  // North America; coppery orange with purple sheen; host: dock, knotweed; wingspan 25–35 mm.
  'Purplish Copper': const ButterflyInfo(
    description:
        'A small copper-colored butterfly with a faint purple shine on its wings. Common in wet meadows of North America.',
    reproduction:
        'Eggs laid on dock and knotweed; two or more generations yearly depending on climate.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Wet meadows, fields'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Dock, Knotweed'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–35 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Active near streams and ponds',
          'Often rests with wings open in sunlight',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Males show purple reflections',
          'Common across North America',
        ],
      ),
    ],
  ),

  // 80. Question Mark (Polygonia interrogationis)
  // North America; orange with silver “?” mark on underside; host: nettle, elm; wingspan 50–70 mm.
  'Question Mark': const ButterflyInfo(
    description:
        'An orange-brown butterfly with irregular wing edges and a small silver question-mark shape on its underside.',
    reproduction:
        'Eggs laid on elm, nettle, and hackberry; two generations per year; adults overwinter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Habitat: Wood edges, gardens'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
      InfoChipData(icon: Icons.nature, label: 'Larval host: Elm, Nettle'),
      InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 50–70 mm'),
    ],
    cards: [
      InfoCardData(
        title: 'Observation tips',
        leading: Icons.visibility_outlined,
        bullets: [
          'Often basks on tree trunks or paths',
          'Eats sap, fruit, and dung instead of nectar',
        ],
      ),
      InfoCardData(
        title: 'Notes',
        leading: Icons.public,
        bullets: [
          'Overwinters as an adult',
          'Named for the silver “?” mark on its hindwing',
        ],
      ),
    ],
  ),

  // 81. Red Admiral (Vanessa atalanta)
// Worldwide; black with red bands; host: nettles; wingspan 50–65 mm.
'Red Admiral': const ButterflyInfo(
  description:
      'A bold black butterfly with red-orange bands and white spots. Found in gardens, forests, and meadows around the world.',
  reproduction:
      'Eggs laid on nettles; larvae live in rolled leaves; two or more generations per year depending on climate.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, wood edges'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Nettles'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 50–65 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Attracted to flowers and rotting fruit',
        'Often lands on people or tree trunks'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Strong flyer and migrant',
        'Common across temperate regions'
      ],
    ),
  ],
),

// 82. Red Cracker (Hamadryas amphinome)
// Central & South America; gray mottled wings with red patches; host: Dalechampia; wingspan 70–85 mm.
'Red Cracker': const ButterflyInfo(
  description:
      'A tropical butterfly with gray marbled wings and bright red hindwings. Males make a cracking sound in flight.',
  reproduction:
      'Eggs laid on Dalechampia vines; larvae feed on leaves; several broods per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Forests, riverbanks'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Dalechampia'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–85 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Rests on tree trunks with wings open',
        'Males make audible “clicks” during flight'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Camouflaged when wings are closed',
        'Common in Central and South America'
      ],
    ),
  ],
),

// 83. Red Postman (Heliconius erato)
// Central & South America; black with red and white bands; host: passion vines; wingspan 70–90 mm.
'Red Postman': const ButterflyInfo(
  description:
      'A black butterfly with bright red and white stripes, common in tropical forests. Known for slow, graceful flight.',
  reproduction:
      'Eggs laid on passion vines; larvae feed on leaves containing toxic chemicals that protect adults.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Rainforests, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Passion vines'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Often visits flowers in shaded areas',
        'Slow, fluttering flight near understory plants'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'One of the famous Heliconius “longwing” butterflies',
        'Toxic and mimicked by other species'
      ],
    ),
  ],
),

// 84. Red Spotted Purple (Limenitis arthemis astyanax)
// North America; blue-black wings with red-orange spots; host: willow, cherry; wingspan 70–90 mm.
'Red Spotted Purple': const ButterflyInfo(
  description:
      'A stunning blue-black butterfly with reddish spots along the wing edges. Found in wooded areas and near streams.',
  reproduction:
      'Eggs laid on willow, poplar, and cherry; larvae resemble bird droppings when young; two broods per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Woodlands, riversides'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Willow, Cherry'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Often rests on damp soil or stones',
        'Attracted to sap and rotting fruit'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Mimics the toxic Pipevine Swallowtail',
        'Common throughout eastern U.S.'
      ],
    ),
  ],
),

// 85. Rosy Maple Moth (Dryocampa rubicunda)
// North America; pink and yellow moth; host: maple; wingspan 35–50 mm.
'Rosy Maple Moth': const ButterflyInfo(
  description:
      'A small, fuzzy moth with pink and yellow coloring that resembles candy. Found across eastern North America.',
  reproduction:
      'Eggs laid on maple leaves; green caterpillars called “green-striped mapleworms” feed on foliage.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Deciduous forests'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Maple trees'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 35–50 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Attracted to light at night',
        'Easily identified by its pink-and-yellow fur'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'One of the most colorful North American moths',
        'Adults do not feed'
      ],
    ),
  ],
),

// 86. Scarce Swallowtail (Iphiclides podalirius)
// Europe, Asia; pale yellow with black stripes; host: blackthorn; wingspan 70–90 mm.
'Scarce Swallow': const ButterflyInfo(
  description:
      'A large pale yellow butterfly with black tiger stripes and long tails. Common across southern Europe and western Asia.',
  reproduction:
      'Eggs laid singly on blackthorn and wild plum; two generations per year in warm regions.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Orchards, scrubland'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Blackthorn, Plum'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Often seen gliding over sunny slopes',
        'Feeds on flowering shrubs and herbs'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Protected in parts of Europe',
        'Closely related to the common swallowtail'
      ],
    ),
  ],
),

// 87. Silver Spot Skipper (Epargyreus clarus)
// North America; brown skipper with silver spot; host: legumes; wingspan 45–60 mm.
'Silver Spot Skipper': const ButterflyInfo(
  description:
      'A medium-sized brown skipper with a bright silvery spot on each hindwing. Common in open fields and gardens.',
  reproduction:
      'Eggs laid on legumes; caterpillars make leaf shelters; two generations per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Legumes'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–60 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Fast, darting flight near flowers',
        'Often lands with wings partly open'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Common throughout North America',
        'Easily recognized by hindwing silver patch'
      ],
    ),
  ],
),

// 88. Six-spot Burnet Moth (Zygaena filipendulae)
// Europe; metallic blue with six red spots; host: bird’s-foot trefoil; wingspan 30–40 mm.
'Sixspot Burnet Moth': const ButterflyInfo(
  description:
      'A metallic blue day-flying moth with six vivid red spots on each forewing. Common in grasslands and meadows.',
  reproduction:
      'Eggs laid on bird’s-foot trefoil; caterpillars overwinter and pupate in yellow cocoons on grass stems.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, coastal cliffs'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Jun–Aug (daytime)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Bird’s-foot trefoil'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 30–40 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Easily spotted feeding on thistles and knapweed',
        'Slow-flying and tolerant of approach'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Day-active moth',
        'Contains cyanide-based toxins for defense'
      ],
    ),
  ],
),

// 89. Sleepy Orange (Eurema nicippe)
// North & Central America; orange butterfly; host: senna; wingspan 40–55 mm.
'Sleepy Orange': const ButterflyInfo(
  description:
      'A bright orange butterfly with small dark borders and a slow, drifting flight. Common in sunny fields.',
  reproduction:
      'Eggs laid on senna plants; several broods yearly; adults overwinter in mild regions.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, roadsides'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Oct'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Senna species'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 40–55 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Flies low among grasses',
        'Easily recognized by orange glow in sunlight'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Common in southern U.S. and Mexico',
        'Migratory in northern range'
      ],
    ),
  ],
),

// 90. Sootywing (Pholisora catullus)
// North America; dark brown skipper; host: pigweed, lamb’s quarters; wingspan 25–35 mm.
'Sootywing': const ButterflyInfo(
  description:
      'A small dark brown skipper with a fast, low flight. Often seen darting around open fields and gardens.',
  reproduction:
      'Eggs laid on pigweed and lamb’s quarters; larvae make loose shelters on leaves; several generations per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Fields, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Pigweed, Lamb’s quarters'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 25–35 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Flies close to the ground',
        'Often rests on bare soil or low leaves'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Common throughout North America',
        'Difficult to spot due to dark color and quick flight'
      ],
    ),
  ],
),

// 91. Southern Dogface (Zerene cesonia)
// North & Central America; yellow with black “dog head” marking; host: legumes; wingspan 45–60 mm.
'Southern Dogface': const ButterflyInfo(
  description:
      'A bright yellow butterfly with a black pattern on its forewings resembling a dog’s face. Common in sunny open areas.',
  reproduction:
      'Eggs laid on legumes such as clover and alfalfa; several generations per year in warm regions.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Fields, roadsides'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Mar–Nov'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Clover, Alfalfa'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–60 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Fast, erratic flight in sunny fields',
        'Distinctive dog-shaped marking visible in flight'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'State butterfly of Texas',
        'Common across southern U.S. and Mexico'
      ],
    ),
  ],
),

// 92. Striated Queen (Danaus genutia)
// South & Southeast Asia; orange with black-and-white veins; host: milkweed; wingspan 70–90 mm.
'Striated Queen': const ButterflyInfo(
  description:
      'A large orange butterfly with black-and-white stripes, closely related to the Monarch. Common in South and Southeast Asia.',
  reproduction:
      'Eggs laid on milkweed; larvae striped black, white, and yellow; several broods per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, open forests'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Milkweed'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Common in sunny clearings and gardens',
        'Slow, floating flight similar to Monarchs'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Unpalatable due to milkweed toxins',
        'Frequently seen in butterfly gardens'
      ],
    ),
  ],
),

// 93. Tropical Leafwing (Anaea aidea)
// Central & South America; orange above, leaf-like below; host: croton; wingspan 70–85 mm.
'Tropical Leafwing': const ButterflyInfo(
  description:
      'An orange butterfly whose closed wings resemble a dried leaf, providing excellent camouflage in tropical forests.',
  reproduction:
      'Eggs laid on croton plants; larvae feed on leaves; several broods per year in warm climates.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Tropical forests'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Croton species'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–85 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Rests with wings closed on leaves or bark',
        'Looks exactly like a dead leaf when at rest'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Excellent camouflage species',
        'Also called the “Orange Leafwing”'
      ],
    ),
  ],
),

// 94. Two-barred Flasher (Astraptes fulgerator)
// Central & South America; metallic blue with two white bars; host: legumes; wingspan 45–55 mm.
'Two Barred Flasher': const ButterflyInfo(
  description:
      'A swift tropical butterfly with metallic blue upperwings and two bright white bars. Common in Central and South America.',
  reproduction:
      'Eggs laid on legumes; caterpillars with large heads hide in rolled leaves; multiple generations per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Legume family'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 45–55 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Fast-flying near flowers and shrubs',
        'Flashes metallic blue when flying'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Known for its iridescent coloration',
        'Complex of several similar species'
      ],
    ),
  ],
),

// 95. Ulyses (Papilio ulysses)
// Australia & New Guinea; bright electric blue swallowtail; host: citrus; wingspan 100–120 mm.
'Ulyses': const ButterflyInfo(
  description:
      'A brilliant electric blue swallowtail from northern Australia and New Guinea. The shimmering blue is visible from afar.',
  reproduction:
      'Eggs laid on citrus and native laurels; several broods per year in tropical conditions.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Rainforests, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Citrus, Euodia'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 100–120 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Common in tropical Queensland gardens',
        'Blue upperwings flash vividly in sunlight'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Symbol of Queensland tourism',
        'Males patrol territories actively'
      ],
    ),
  ],
),

// 96. Viceroy (Limenitis archippus)
// North America; orange mimic of Monarch; host: willow, poplar; wingspan 60–80 mm.
'Viceroy': const ButterflyInfo(
  description:
      'An orange-and-black butterfly that closely resembles the Monarch but has a black line across its hindwings.',
  reproduction:
      'Eggs laid on willow and poplar; one to three generations yearly; adults mimic Monarchs for protection.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Wetlands, meadows'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Willow, Poplar'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 60–80 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Distinguished from Monarch by black hindwing band',
        'Often flies low near water edges'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Classic case of mimicry with Monarch',
        'Common throughout North America'
      ],
    ),
  ],
),

// 97. White-lined Sphinx Moth (Hyles lineata)
// Americas; large fast-flying moth; host: evening primrose; wingspan 70–100 mm.
'White Lined Sphinx Moth': const ButterflyInfo(
  description:
      'A large, fast-flying moth often mistaken for a hummingbird. Brown with white lines and pink hindwings.',
  reproduction:
      'Eggs laid on evening primrose and other plants; larvae large and green; several generations per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Gardens, deserts'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Oct (dusk)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Evening primrose'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–100 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Feeds while hovering like a hummingbird',
        'Attracted to light at night'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'One of the most widespread sphinx moths',
        'Important pollinator in dry regions'
      ],
    ),
  ],
),

// 98. Wood Satyr (Megisto cymela)
// North America; brown with eye spots; host: grasses; wingspan 40–50 mm.
'Wood Satyr': const ButterflyInfo(
  description:
      'A quiet brown butterfly with several eye spots, often fluttering through shaded woodland paths.',
  reproduction:
      'Eggs laid on grasses; larvae overwinter; one generation per year in northern regions.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Forest edges, woods'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: May–Aug'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Grasses'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 40–50 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Flies slowly in shaded paths',
        'Often rests on tree trunks or leaves'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Prefers dim forest light',
        'Subtle but elegant woodland species'
      ],
    ),
  ],
),

// 99. Yellow Swallowtail (Papilio machaon or P. canadensis)
// Northern Hemisphere; yellow with black stripes; host: carrot family; wingspan 70–90 mm.
'Yellow Swallow Tail': const ButterflyInfo(
  description:
      'A large, bright yellow butterfly with bold black stripes and long tails. Found throughout the Northern Hemisphere.',
  reproduction:
      'Eggs laid on parsley and carrot-family plants; caterpillars are green with black bands; two or more generations per year.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Meadows, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Apr–Sep'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Carrot family plants'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–90 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Easily spotted visiting flowers',
        'Graceful flight over open fields'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Common across Europe, Asia, and America',
        'One of the best-known swallowtails'
      ],
    ),
  ],
),

// 100. Zebra Longwing (Heliconius charithonia)
// Americas; black with yellow stripes; host: passion vines; wingspan 70–95 mm.
'Zebra Long Wing': const ButterflyInfo(
  description:
      'A long, slender butterfly with black wings striped in yellow. The state butterfly of Florida.',
  reproduction:
      'Eggs laid on passion vines; caterpillars feed on toxic leaves; adults live for several months.',
  chips: [
    InfoChipData(icon: Icons.park, label: 'Habitat: Forests, gardens'),
    InfoChipData(icon: Icons.stacked_line_chart, label: 'Flight: Year-round (tropics)'),
    InfoChipData(icon: Icons.nature, label: 'Larval host: Passion vines'),
    InfoChipData(icon: Icons.info_outline, label: 'Wingspan: 70–95 mm'),
  ],
  cards: [
    InfoCardData(
      title: 'Observation tips',
      leading: Icons.visibility_outlined,
      bullets: [
        'Slow, graceful flight through shaded paths',
        'Often roosts communally at night'
      ],
    ),
    InfoCardData(
      title: 'Notes',
      leading: Icons.public,
      bullets: [
        'Feeds on both nectar and pollen',
        'State butterfly of Florida'
      ],
    ),
  ],
),

};
