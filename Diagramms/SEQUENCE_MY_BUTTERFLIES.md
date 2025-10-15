```mermaid
sequenceDiagram
    actor Benutzer as User
    participant Home as HomePage
    participant Info as InfoPage
    participant MyButterflies as MyButterfliesPage
    participant SharedPrefs as SharedPreferences
    participant RetrievalSvc as RetrievalService
    participant HTTP
    participant UploadGrid as MyButterfliesUploadsGrid
    participant FindingResult as FindingResultPage
    participant Map as idToSpeciesName
    participant InfoMap as butterflyInfoMap

    %% Navigation zur Info-Seite
    User->>Home: Tab "Info" wählen
    Home->>Info: InfoPage anzeigen

    %% My Butterflies öffnen
    User->>Info: "My Butterflies" tippen
    Info->>MyButterflies: MyButterfliesPage öffnen

    %% Benutzer-ID laden und Uploads abrufen
    MyButterflies->>SharedPrefs: getInt('user_id')
    SharedPrefs-->>MyButterflies: userId
    MyButterflies->>RetrievalSvc: getUserUploads(userId, limit, sort, withButterfly)
    RetrievalSvc->>HTTP: GET /uploads/user/{userId}?limit=...&sort=...&with_butterfly=true
    HTTP-->>RetrievalSvc: JSON { items }
    RetrievalSvc-->>MyButterflies: List<UserUpload
    MyButterflies->>UploadGrid: Grid rendern (Uploads mit Thumbnails)

    %% Ein Bild auswählen
    User->>UploadGrid: Upload-Tile tippen
    UploadGrid->>MyButterflies: onTapUpload(UserUpload)
    MyButterflies->>FindingResult: öffnen (butterflyId, imageUrl)

    %% Details anzeigen
    FindingResult->>Map: butterflyId -> speciesName
    FindingResult->>InfoMap: Details zu speciesName laden
    FindingResult->>FindingResult: Detailseite mit Bild, Beschreibung, Chips & Karten rendern
