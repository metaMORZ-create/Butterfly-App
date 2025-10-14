import 'package:flutter/material.dart';

/// A small data class used to describe a single informational chip.  Each chip
/// appears as a pill‑shaped label with an icon and a short label.  These
/// chips summarise key traits of a butterfly such as its habitat, flight
/// period, wingspan or typical food source.
class InfoChipData {
  final IconData icon;
  final String label;

  const InfoChipData({
    required this.icon,
    required this.label,
  });
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
final Map<String, ButterflyInfo> butterflyInfoMapOld = {
  // 1. Admiral (Vanessa atalanta)
  // Facts gathered from Biologie‑Schule: wingspan 5–6 cm, found in forests,
  // meadows and gardens; adults feed on nectar from butterfly bush,
  // phlox and goldenrod; larvae feed on nettles; eggs laid on nettles;
  // two generations with the last migrating south【89588682556175†L74-L98】.
  'Admiral': const ButterflyInfo(
    description:
        'Der Admiral (Vanessa atalanta) ist ein auffälliger Wanderfalter mit roten Bändern und dunkelbraunen Flügeln. Er kommt in Wäldern, an Waldrändern, in Gärten und auf Streuobstwiesen vor und besitzt eine Flügelspannweite von rund 5–6 cm. Erwachsene Falter ernähren sich von Blütennektar etwa von Sommerflieder, Phlox und Goldrute sowie Fallobst.',
    reproduction:
        'Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier einzeln auf Brennnesseln ab. Die Raupen fressen mehrere Wochen an den Blättern, ehe sie sich in lockeren Gespinsten verpuppen. Es gibt meist zwei Generationen; die im Herbst schlüpfende Generation wandert im Winter in südlichere Regionen.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Wälder, Gärten'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Juni–Okt'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Sommerflieder, Phlox'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Brennnesseln'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier werden einzeln auf Brennnesseln abgelegt',
          'Raupennahrung: Brennnesselblätter',
          'Verpuppung nach mehreren Wochen',
          '2 Generationen pro Jahr; Herbstgeneration wandert südwärts'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Mag warme, sonnige Standorte',
          'Häufig an Sommerflieder und reifem Obst zu sehen',
          'Raupen bevorzugen nährstoffreiche Brennnesselbestände',
        ],
      ),
    ],
  ),

  // 2. Aurorafalter (Anthocharis cardamines)
  // Larval food plants cardamine and garlic mustard; flight time mid/late
  // April to June; moist meadows and forest edges; relies on cruciferous
  // plants【965069978339699†L84-L97】.
  'Aurorafalter': const ButterflyInfo(
    description:
        'Der Aurorafalter (Anthocharis cardamines) ist ein Frühlingsfalter mit orangefarbenen Flecken auf den Vorderflügeln der Männchen. Er bewohnt feuchte Wiesen, Waldränder und Gebüschsäume. Sein Vorkommen hängt eng mit kreuzblütigen Pflanzen zusammen, auf denen die Raupen leben.',
    reproduction:
        'Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier einzeln an Blütenständen von Wiesen-Schaumkraut und Knoblauchrauke. Die Raupen schlüpfen und fressen zuerst Blüten und Samenschoten. Nach dem Verpuppen überwintern die Puppen; im Frühjahr schlüpfen die Falter.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: feuchte Wiesen'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Jun'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Schaumkraut, Rauke'),
      InfoChipData(icon: Icons.palette, label: 'Männchen mit orangen Spitzen'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Blütenknospen von Wiesen-Schaumkraut und Knoblauchrauke',
          'Raupen fressen Blüten, Früchte und Schoten',
          'Puppen überwintern an Stängeln',
          'Eine Generation pro Jahr'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Gut im zeitigen Frühling zu entdecken',
          'Weibchen besitzen keine orangefarbene Spitze',
          'Bevorzugt feuchte, sonnige Wiesen mit Kreuzblütlern',
        ],
      ),
    ],
  ),

  // 3. Distelfalter (Vanessa cardui)
  // Wingspan approx. 6 cm; flight April–Sept; habitats include forest edges
  // and grasslands; adults feed on nectar, particularly thistle flowers;
  // larvae feed on thistles, nettles, mallows; eggs laid on leaves; two
  // generations, migrating south in autumn【548225091542521†L44-L104】.
  'Distelfalter': const ButterflyInfo(
    description:
        'Der Distelfalter (Vanessa cardui) ist ein weltweit verbreiteter Wanderfalter mit rötlich-orangefarbenen Flügeln. Er bevorzugt trockene offene Landschaften, Waldränder und Gärten. Die Flügelspannweite beträgt etwa 5–6 cm.',
    reproduction:
        'Ei → Raupe → Puppe → Falter. Weibchen legen ihre Eier einzeln auf die Blätter von Disteln, Brennnesseln, Malven und anderen Korbblütlern. Die Raupen leben zunächst einzeln und rollen Blätter zusammen; nach zwei bis drei Wochen verpuppen sie sich. Es gibt zwei Generationen pro Jahr; die Art zieht im Herbst nach Süden.',
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: offene Flächen'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Sep'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Disteln, Blüten'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Distel, Brennnessel'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Distel- und Brennnesselblättern',
          'Raupen rollen Blätter zu Schutzhüllen',
          'Zwei Generationen pro Jahr',
          'Herbstgeneration zieht in wärmere Regionen'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Oft an Distelblüten und Sommerflieder zu sehen',
          'Langstreckenzieher – im Frühjahr aus Südeuropa eingewandert',
          'An warmen Standorten und auf Brachflächen besonders zahlreich',
        ],
      ),
    ],
  ),

  // 4. Kleiner Fuchs (Aglais urticae)
  // Wingspan up to 4–6 cm; inhabits forests, woodland edges, meadows, parks
  // and gardens; eggs laid on nettles; larvae feed on nettles; pupal
  // stage lasts about 12 days; up to three generations per season【5684916276817†L76-L100】.
  'Kleiner Fuchs': const ButterflyInfo(
    description:
        """Der Kleine Fuchs (Aglais urticae) ist ein häufig vorkommender
orangefarbener Falter mit markanten schwarzen und blauen Flecken an den
Flügelrändern. Er lebt in Wäldern, an Waldrändern, in Gärten und auf
Wiesen. Die Flügelspannweite beträgt 4–6 cm.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen bis zu 200 Eier in
Gruppen an Brennnesseln. Die jungen Raupen leben gesellig in
Gespinsten und fressen die Blätter. Nach etwa 12 Tagen verpuppen sie
sich einzeln hängend. Es können zwei bis drei Generationen pro Jahr
auftreten; die letzte Generation überwintert als Falter und fliegt
bereits im Frühjahr.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Waldränder, Gärten'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Mär–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Brennnessel'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Disteln, Katzenminze'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier in Gruppen an Brennnesselblättern',
          'Junge Raupen leben gesellig in Gespinsten',
          'Verpuppung nach rund 12 Tagen',
          'Mehrere Generationen, letztere überwintert als Falter'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Häufig in Gärten mit Brennnesseln zu sehen',
          'Frühe Flugzeit bereits ab März',
          'Beim Sonnenbaden mit ausgebreiteten Flügeln gut zu beobachten',
        ],
      ),
    ],
  ),

  // 5. Tagpfauenauge (Aglais io)
  // Wingspan about 5 cm; pairs twice a year; lays 50–150 eggs; larvae feed
  // exclusively on nettles; adults feed on nectar and pollen of various
  // plants and overwinter as adults【185671522518812†L53-L100】.
  'Tagpfauenauge': const ButterflyInfo(
    description:
        """Das Tagpfauenauge (Aglais io) ist durch seine bunten Augenflecken auf den
Flügeln unverwechselbar und dient als Schreckmuster gegenüber Fressfeinden.
Es lebt in Parks, Gärten und an Waldrändern. Die Flügelspannweite beträgt
etwa 5 cm.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Das Weibchen legt in zwei Jahreszeiten
50–150 Eier in Haufen an Brennnesseln. Die Raupen sind schwarz mit
Dornen und leben gesellig, bevor sie sich verpuppen. Die erwachsenen
Falter überwintern und können bei mildem Wetter bereits im Februar
aktiv werden.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Parks, Gärten'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Feb–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Brennnessel'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Distel, Klee, Buddleja'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Zwei Eiablagen pro Jahr mit 50–150 Eiern',
          'Larven fressen ausschließlich Brennnesseln',
          'Puppen hängen frei unter Blättern',
          'Überwinterung als erwachsener Falter'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Häufig an Blüten wie Buddleja und Klee',
          'Früh flugfähig durch Überwinterung als Falter',
          'Bei Bedrohung werden Flügel geöffnet, um Augenflecken zu zeigen',
        ],
      ),
    ],
  ),

  // 6. Schwalbenschwanz (Papilio machaon)
  // Largest of German butterflies with wingspan up to 9 cm; inhabits dry,
  // warm areas; eggs laid near dill, fennel, carrot and other Umbelliferae;
  // three generations; larvae pupate and some overwinter【994918144652453†L71-L99】.
  'Schwalbenschwanz': const ButterflyInfo(
    description:
        """Der Schwalbenschwanz (Papilio machaon) ist einer der größten
Tagfalter Europas mit einer Flügelspannweite von bis zu 9 cm. Die
gelb-schwarzen Flügel haben charakteristische „Schwalbenschwänze“ an
den Hinterflügeln. Er bewohnt trockene, warme Wiesen, Magerrasen und
Waldränder.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Weibchen legen ihre Eier einzeln an
Dill, Fenchel, Karotten und andere Doldenblütler. Die Raupen sind
zunächst dunkel und stachelig, später leuchtend grün mit schwarzen
Querbändern und orangefarbenen Punkten. Nach rund einem Monat
verpuppen sie sich. Je nach Witterung entwickeln sich zwei bis drei
Generationen; manche Puppen überwintern und schlüpfen im Frühling.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Magerrasen, Äcker'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Dill, Fenchel, Möhre'),
      InfoChipData(icon: Icons.straighten, label: 'Spannweite: bis 9 cm'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Doldenblütler (Dill, Fenchel, Möhre)',
          'Raupe mit Osmeterium (gelb-orange Duftorgan) zur Abschreckung',
          '2–3 Generationen, Puppen können überwintern',
          'Falter schlüpfen ab April'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Bevorzugt sonnige, windgeschützte Standorte',
          'Raupen sind leuchtend grün mit schwarzen Ringen',
          'Falter flattern majestätisch über Wiesen',
        ],
      ),
    ],
  ),

  // 7. Kaisermantel (Argynnis paphia)
  // Largest fritillary; females lay eggs on bark near violets; larvae
  // overwinter on bark, feed on violets in spring and pupate early
  // summer【587864077790355†L174-L182】.
  'Kaisermantel': const ButterflyInfo(
    description:
        """Der Kaisermantel (Argynnis paphia) ist der größte mitteleuropäische
Perlmutterfalter. Die orangefarbenen Flügel tragen schwarze Punkte;
Weibchen besitzen zusätzliche olivgrüne Streifen. Man findet ihn an
sonnigen Waldwegen, Lichtungen und Waldrändern.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Weibchen legen ihre Eier im Sommer an
Moos oder Baumrinde in der Nähe von Veilchenbeständen. Die Larven
schlüpfen im Spätsommer, fressen nur die Eihülle und überwintern ohne
Nahrung in der Rinde. Erst im Frühjahr kriechen sie zu den Veilchen,
fressen deren Blätter, verpuppen sich im Juni und schlüpfen als
Falter.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Lichtungen, Wälder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Veilchen'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Distel, Brombeere'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier an Baumrinde nahe Veilchenbeständen',
          'Larven überwintern ohne Nahrung in der Rinde',
          'Nahrung im Frühjahr: Blätter von Veilchen',
          'Puppenbildung im Frühsommer, Falter fliegen ab Juni'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Bevorzugt sonnige Waldlichtungen mit violetten Blüten',
          'Weibchen oft etwas größer und dunkler',
          'Trinkt gern Mineralien aus feuchtem Boden',
        ],
      ),
    ],
  ),

  // 8. Landkärtchen (Araschnia levana)
  // Eggs laid in stacks of 8–10 on undersides of nettles; larvae have
  // spines and two head horns and live gregariously; adults have seasonal
  // dimorphism; summer pupae overwinter【6431750989143†L164-L174】.
  'Landkärtchen': const ButterflyInfo(
    description:
        """Das Landkärtchen (Araschnia levana) zeigt eine ausgeprägte
Jahreszeiten-Dimorphie: Die erste Generation im Frühling ist orange
schwarz gefleckt, die Sommergeneration überwiegend schwarz mit weißen
Bändern. Es besiedelt halbschattige Waldränder, Ufer und Feuchtwiesen.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen 8–10 grüne Eier in
kleinen Stapeln an die Unterseite von Brennnesselblättern. Die
schwarzen, dornigen Raupen mit zwei Kopfhörnern leben zuerst
gesellig. Nach der Verpuppung schlüpft die Sommergeneration bereits
nach wenigen Wochen; die Herbstpuppen überwintern und schlüpfen
erst im Frühjahr.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: halbschattig'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Brennnessel'),
      InfoChipData(icon: Icons.color_lens, label: 'Frühling orange, Sommer schwarz'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier in Gruppen von 8–10 an Brennnesselblättern',
          'Raupen leben zunächst gesellig mit Dornen am Körper',
          'Frühjahrs- und Sommergeneration unterscheidbar',
          'Herbstpuppen überwintern, Falter im Frühjahr'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Halbschattige, feuchte Standorte wie Gräben und Waldränder aufsuchen',
          'Farben der Flügel variieren je nach Generation',
          'Raupen an Brennnesseln leicht zu finden',
        ],
      ),
    ],
  ),

  // 9. Kleiner Kohlweißling (Pieris rapae)
  // Eggs laid singly on the underside of leaves; larvae are green; pupate on
  // host plant; two to three generations; overwinter as pupae; feed on
  // cruciferous crops【204525633294783†L188-L247】.
  'Kleiner Kohlweißling': const ButterflyInfo(
    description:
        """Der Kleine Kohlweißling (Pieris rapae) ist ein häufiger Falter in
Gärten und Agrarlandschaften. Er besitzt weiße Flügel mit dunklen
Spitzen und einen schlanken Körper. Die Art ist deutlich kleiner als
der Große Kohlweißling.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Weibchen legen ihre 0,5 mm breiten Eier
einzeln auf die Unterseiten von Kohlblättern und anderen
Kreuzblütlern. Die grünen Raupen mit gelblichen Linien ernähren sich
von den Blättern und verpuppen sich direkt an der Pflanze. Pro Jahr
treten zwei bis drei Generationen auf; die Puppen überwintern.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Gärten, Felder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Mär–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Kohl, Radieschen'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Klee, Löwenzahn'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln auf Blattunterseiten von Kohlgewächsen',
          'Grüne Raupen mit gelblicher Linie',
          'Verpuppung an der Futterpflanze',
          '2–3 Generationen pro Jahr; Puppen überwintern'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Häufig in Gemüsebeeten und auf Äckern',
          'Unverkennbar durch die dunklen Flügelspitzen',
          'Raupen können Schäden an Kohlpflanzen verursachen',
        ],
      ),
    ],
  ),

  // 10. Waldbrettspiel (Pararge aegeria)
  // Eggs singly on grasses; larvae feed on grasses and overwinter; two
  // generations from April to October; inhabits open woodlands and edges【776840310573213†L63-L78】.
  'Waldbrettspiel': const ButterflyInfo(
    description:
        """Das Waldbrettspiel (Pararge aegeria) ist ein bräunlicher Falter mit
gelben Augenflecken, der häufig in lichten Wäldern und an Waldrändern
anzutreffen ist. Männchen sind territorial und sitzen auf Ästen oder
am Boden, um vorbeifliegende Weibchen abzufangen.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier einzeln an
Grashalme. Die grünen Raupen fressen verschiedene Süßgräser und
überwintern als Raupe oder Puppe. Es gibt zwei Generationen pro Jahr;
die Falter fliegen von April bis Oktober.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: lichte Wälder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Gräser'),
      InfoChipData(icon: Icons.flag, label: 'Territorialverhalten'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Grashalme gelegt',
          'Grüne Raupen fressen verschiedenste Süßgräser',
          'Überwinterung als Raupe oder Puppe',
          'Zwei Generationen zwischen April und Oktober'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Männchen sitzen oft am Boden, um ihr Revier zu verteidigen',
          'Gut an Waldrändern und in lichten Wäldern zu finden',
          'Fliegt häufig knapp über dem Boden im Zickzackflug',
        ],
      ),
    ],
  ),

  // 11. Großes Ochsenauge (Maniola jurtina)
  // Eggs laid on mown meadows or grass stems; larvae feed on grasses; one
  // generation; adults feed on a wide range of plants; widely distributed
  //【658918225035511†L255-L276】.
  'Großes Ochsenauge': const ButterflyInfo(
    description:
        """Das Große Ochsenauge (Maniola jurtina) ist ein brauner Falter mit
charakteristischem Augenfleck auf den Vorderflügeln. Es lebt in
offenen, trockenen bis mäßig feuchten Lebensräumen wie Wiesen,
Waldrändern, Parkanlagen und Böschungen. Das Weibchen ist heller als
das Männchen.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Nach der Paarung im Sommer lassen die
Weibchen ihre Eier auf abgemähte Wiesen fallen oder befestigen sie an
Grashalmen. Die schlüpfenden Raupen fressen verschiedene Gräser und
überwintern. Im folgenden Frühjahr verpuppen sie sich, und ab Juni
schlüpft eine Generation Falter.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Wiesen, Ränder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Gräser'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Distel, Klee'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier auf abgemähte Wiesen oder Grashalme abgelegt',
          'Raupen fressen verschiedene Grasarten',
          'Überwinterung als Raupe',
          'Eine Generation pro Jahr, Falter ab Juni'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Oft in größerer Zahl auf Wiesen anzutreffen',
          'Fliegt in langsamem, wellenförmigem Flug',
          'Augenfleck auf Vorderflügeln als Erkennungsmerkmal',
        ],
      ),
    ],
  ),

  // 12. Zitronenfalter (Gonepteryx rhamni)
  // Overwinters as adult; larvae feed on buckthorn; early flying; one
  // generation.  While citations exist for general info (plants and
  // overwintering) but not all details, this entry summarises common
  // knowledge.
  'Zitronenfalter': const ButterflyInfo(
    description:
        """Der Zitronenfalter (Gonepteryx rhamni) ist leicht an seiner
zitronengelben Färbung der Männchen und dem grünen Farbton der Weibchen
zu erkennen. Er gilt als einer der ersten Frühlingsboten, da er als
überwinterter Falter bereits an den ersten warmen Tagen fliegt.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Eier werden einzeln an den
Wirtspflanzen Kreuzdorn oder Faulbaum abgelegt. Die grünlichen Raupen
fressen an den Blättern dieser Sträucher. Im Spätsommer verpuppen sich
die Raupen; der Falter überwintert jedoch als fertiger Falter in
Verstecken und fliegt im nächsten Frühling wieder.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Auwälder, Hecken'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Feb–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Kreuzdorn'),
      InfoChipData(icon: Icons.eco, label: 'Überwintert als Falter'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Kreuzdorn oder Faulbaum',
          'Raupen fressen die Blätter der Wirtspflanze',
          'Verpuppung im Spätsommer',
          'Überwinterung als Falter in dichter Vegetation'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Als einer der ersten Falter im Jahr zu sehen',
          'Männchen sind zitronengelb, Weibchen grünlich',
          'Übernachtet frei hängend in Hecken oder Büschen',
        ],
      ),
    ],
  ),

  // 13. C-Falter (Polygonia c-album)
  // Two to three generations; eggs on nettles and hops; last generation
  // hibernates.  Common in woodland edges and hedgerows.
  'C‑Falter': const ButterflyInfo(
    description:
        """Der C‑Falter (Polygonia c‑album) verdankt seinen Namen dem
weißlichen „C“ auf der Unterseite der Hinterflügel. Er besitzt stark
gezackte Flügelränder und lebt an Waldrändern, in Gärten und
Heckenlandschaften.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier einzeln an
Brennnesseln, Hopfen oder Ulmen ab. Die Raupen sind dunkel mit weißen
Markierungen und Dornfortsätzen. Es entstehen zwei bis drei
Generationen pro Jahr; die letzte überwintert als Falter in
geschützten Verstecken.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Waldränder, Hecken'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Mär–Okt'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Brennnessel, Hopfen'),
      InfoChipData(icon: Icons.eco, label: 'Überwintert als Falter'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln auf Brennnessel, Hopfen oder Ulme',
          'Raupen besitzen Stacheln und weiße Flecken',
          '2–3 Generationen pro Jahr',
          'Herbstgeneration überwintert als Falter'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Weibchen legen Eier bevorzugt an sonnigen Standorten',
          'Die gezackten Flügelränder helfen bei der Tarnung',
          'Überwintern oft in Holzstapeln oder Baumhöhlen',
        ],
      ),
    ],
  ),

  // 14. Großer Kohlweißling (Pieris brassicae)
  // Two to three generations; eggs laid in clusters on crucifers; larvae
  // feed on cabbage; overwinter as pupae.  Common in gardens and
  // agricultural fields.
  'Großer Kohlweißling': const ButterflyInfo(
    description:
        """Der Große Kohlweißling (Pieris brassicae) ist größer als sein
kleiner Verwandter und hat weiße Flügel mit schwarzen Spitzen und
zwei schwarzen Flecken auf den Vorderflügeln. Er ist ein typischer
Schädling in Kohlgärten und Feldern.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier in
Gruppen von 20 bis 50 auf der Unterseite von Kohl- und anderen
Kreuzblütlerblättern ab. Die gelblichen, geselligen Raupen fressen
gemeinsam und können erhebliche Schäden verursachen. Nach der
Verpuppung treten zwei bis drei Generationen pro Jahr auf; die
Puppen überwintern.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Gärten, Felder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Apr–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Kohlgewächse'),
      InfoChipData(icon: Icons.eco, label: 'Schädling im Garten'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier in Gruppen an Blattunterseiten von Kreuzblütlern',
          'Raupen fressen gesellig und verursachen Fraßschäden',
          '2–3 Generationen pro Jahr',
          'Puppen überwintern an Zäunen oder Pflanzen'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Größer und heller als der Kleine Kohlweißling',
          'Raupen bilden häufig Trauben an den Futterpflanzen',
          'Zur Bekämpfung können Netze und natürliche Feinde eingesetzt werden',
        ],
      ),
    ],
  ),

  // 15. Hauhechel-Bläuling (Polyommatus icarus)
  // Eggs laid on alfalfa and clover; larvae feed on legumes; two to three
  // generations; overwinters as caterpillar or pupa.  Common in
  // meadows and grasslands.
  'Hauhechel-Bläuling': const ButterflyInfo(
    description:
        """Der Hauhechel-Bläuling (Polyommatus icarus) ist ein kleiner Bläuling,
dessen Männchen intensiv blau, die Weibchen bräunlich mit blauen
Schatten sind. Er lebt auf Wiesen, Weiden und an Wegrändern.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Weibchen legen ihre Eier einzeln an
Leguminosen wie Hauhechel, Luzerne und Klee ab. Die grünen Raupen
werden oft von Ameisen gepflegt (Symbiose). Es gibt zwei bis drei
Generationen, und die Art überwintert als Raupe oder Puppe.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Wiesen, Wegränder'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Mai–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Leguminosen'),
      InfoChipData(icon: Icons.eco, label: 'Symbiose mit Ameisen'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Klee, Luzerne, Hauhechel',
          'Raupen werden von Ameisen betreut (Schutz vor Feinden)',
          '2–3 Generationen pro Jahr',
          'Überwinterung als Raupe oder Puppe'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Männchen leuchtend blau, Weibchen braun mit orangefarbenen Randflecken',
          'Bevorzugt magere, sonnige Wiesen',
          'Kleiner Falter mit flatterndem Flug',
        ],
      ),
    ],
  ),

  // 16. Schachbrett (Melanargia galathea)
  // Eggs dropped on grasses; larvae feed on various grasses; one
  // generation; flight time June–Aug; overwinters as larva.  Common in dry
  // meadows.
  'Schachbrett': const ButterflyInfo(
    description:
        """Das Schachbrett (Melanargia galathea) ist an seinem schwarz-weißen
Schachmuster gut zu erkennen. Es bewohnt trockene Wiesen, Magerrasen
und Böschungen. Männchen und Weibchen unterscheiden sich nur wenig.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen lassen die Eier im Flug über
Gräsern fallen. Die Raupen fressen verschiedene Süßgräser und
überwintern als junge Raupe. Nach der Verpuppung im Frühsommer
schlüpft eine Generation Falter im Juni und Juli.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Magere Wiesen'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Gräser'),
      InfoChipData(icon: Icons.pattern, label: 'Schwarz-weißes Muster'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier werden im Flug über Wiesen abgelegt',
          'Raupen fressen verschiedenste Gräser',
          'Überwinterung als junge Raupe',
          'Eine Generation im Frühsommer'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Oft in Trockenrasen und kalkreichen Wiesen zu finden',
          'Schachbrettmuster sorgt für gute Tarnung',
          'Falter sitzen gerne mit geschlossenen Flügeln auf Blüten',
        ],
      ),
    ],
  ),

  // 17. Trauermantel (Nymphalis antiopa)
  // Eggs on willow and birch; larvae feed on willow; adults feed on tree sap
  // and fruit; one generation; hibernates as adult.  Known for its dark
  // wings with blue spots.
  'Trauermantel': const ButterflyInfo(
    description:
        """Der Trauermantel (Nymphalis antiopa) ist ein großer, dunkelbrauner
Falter mit cremefarbenem Rand und blauem Punktmuster. Er bewohnt
Laubwälder, Parks und Flusstäler und ist in Deutschland relativ
selten.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Im Frühjahr legen Weibchen ihre Eier in
größeren Gelegen an die Zweige von Weiden oder Birken. Die Raupen
sind schwarz mit roten Flecken und fressen in Gruppen an den jungen
Blättern. Nach der Verpuppung schlüpft eine Generation, die als
Falter überwintert.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Laubwald, Auen'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Weide, Birke'),
      InfoChipData(icon: Icons.eco, label: 'Überwintert als Falter'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier in Gelegen an Weiden- und Birkenzweigen',
          'Raupen leben gesellig auf jungen Blättern',
          'Eine Generation pro Jahr',
          'Überwinterung als erwachsener Falter'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Seltener Falter, vor allem in nordischen Gebieten',
          'Besucht gern Baumsaft und Fallobst',
          'Großer Falter mit langsamen, segelnden Flug',
        ],
      ),
    ],
  ),

  // 18. Großer Perlmutterfalter (Speyeria aglaja)
  // Eggs laid near violets; larvae feed on violets; one generation; flight
  // June–Aug; adults feed on thistle, knapweed.  This entry summarises
  // widely known information about the species.
  'Großer Perlmutterfalter': const ButterflyInfo(
    description:
        """Der Große Perlmutterfalter (Speyeria aglaja) besitzt orangefarbene
Flügel mit schwarzen Punkten und einer Reihen weißer Flecken auf der
Unterseite. Er lebt auf mageren Wiesen, Heideflächen und Waldrändern.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Eier werden einzeln in der Nähe von
Veilchenbeständen abgelegt. Die Raupen schlüpfen, überwintern jedoch
ohne zu fressen und beginnen erst im Frühjahr mit der Nahrungsaufnahme
an Veilchenblättern. Nach der Verpuppung im Frühsommer erscheint eine
Generation im Juni und Juli.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Wiesen, Heiden'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Veilchen'),
      InfoChipData(icon: Icons.eco, label: 'Nektar: Distel, Kratzdistel'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln in der Nähe von Veilchen',
          'Larven schlüpfen und überwintern ohne Nahrung',
          'Nahrung im Frühjahr: Blätter von Veilchen',
          'Eine Generation pro Jahr, Falter ab Juni'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Bevorzugt trockenwarme Wiesen mit Veilchen',
          'Schwer zu unterscheiden von anderen Perlmutterfaltern',
          'Falter besuchen Distel- und Skabiosenblüten',
        ],
      ),
    ],
  ),

  // 19. Pflaumen-Zipfelfalter (Thecla betulae)
  // Eggs laid on blackthorn; larvae feed on blackthorn; flight Aug–Sept; one
  // generation.  The species overwinters as an egg.
  'Pflaumen-Zipfelfalter': const ButterflyInfo(
    description:
        """Der Pflaumen-Zipfelfalter (Thecla betulae) ist ein kleiner Falter
mit orangebraunen Flügeloberseiten bei den Männchen und orangefarbenen
Fleck auf den Hinterflügeln der Weibchen. Er bewohnt Hecken,
Waldränder und Obstgärten.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Weibchen legen ihre Eier im Spätsommer an
die jungen Zweige von Schlehen (Schwarzdorn) und Pflaumen. Die Eier
überwintern. Im Frühjahr schlüpfen die Raupen und fressen an den
Knospen und Blättern der Schlehen. Nach der Verpuppung erscheint eine
Generation im Hochsommer.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Hecken, Obstgärten'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Aug–Sep'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Schlehe'),
      InfoChipData(icon: Icons.eco, label: 'Überwintert als Ei'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier im Spätsommer an Schlehen- und Pflaumenzweigen',
          'Überwinterung als Ei',
          'Raupen fressen im Frühjahr an Knospen und Blättern',
          'Eine Generation pro Jahr'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Fliegt spät im Jahr (August–September)',
          'Männchen sitzen oft auf Blattoberseiten zum Sonnen',
          'Weibchen legen Eier vorzugsweise an gut besonnten Zweigen',
        ],
      ),
    ],
  ),

  // 20. Kleiner Schillerfalter (Apatura ilia)
  // Eggs laid singly on poplars; larvae feed on poplar leaves; two
  // generations; males show iridescent blue sheen; overwinters as larva.
  'Kleiner Schillerfalter': const ButterflyInfo(
    description:
        """Der Kleine Schillerfalter (Apatura ilia) besitzt eine schillernde
bläuliche Färbung, die vor allem bei den Männchen im Sonnenlicht
aufblitzt. Er kommt in Auenwäldern, an Flussufern und in parkähnlichen
Landschaften vor.""",
    reproduction:
        """Ei → Raupe → Puppe → Falter. Die Weibchen legen ihre Eier einzeln an
Pappel- und Weidenblättern ab. Die Raupen sind grün und haben zwei
charakteristische Hörner am Kopf. Nach der Überwinterung als Raupe
verpuppen sie sich im Frühjahr. Es gibt zwei Generationen im Juni und
August.""",
    chips: [
      InfoChipData(icon: Icons.park, label: 'Lebensraum: Auwald, Flussufer'),
      InfoChipData(icon: Icons.stacked_line_chart, label: 'Flugsaison: Jun–Aug'),
      InfoChipData(icon: Icons.nature, label: 'Raupenfutter: Pappel, Weide'),
      InfoChipData(icon: Icons.brightness_4, label: 'Bläulicher Schimmer'),
    ],
    cards: [
      InfoCardData(
        title: 'Vermehrung',
        leading: Icons.change_circle_outlined,
        bullets: [
          'Eier einzeln an Pappel- und Weidenblättern',
          'Larven überwintern, sind grün mit Hörnern am Kopf',
          'Zwei Generationen pro Jahr (Juni und August)',
          'Falter saugen an Baumsaft und überreifen Früchten'
        ],
      ),
      InfoCardData(
        title: 'Hinweise zur Beobachtung',
        leading: Icons.visibility_outlined,
        bullets: [
          'Männchen schillern intensiv blau im Sonnenlicht',
          'Beobachtung oft in Kronen von Pappeln und Weiden',
          'Falter werden von Aas und Exkrementen angelockt',
        ],
      ),
    ],
  ),
};