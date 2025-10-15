```mermaid
sequenceDiagram
    actor Benutzer as User
    participant Home as HomePage
    participant Camera as CameraPage
    participant ImageSvc as ImageService
    participant Dialog
    participant IdSvc as IdentificationService
    participant Map as idToSpeciesName
    participant NewResult as NewCaptureResultPage
    participant InfoMap as butterflyInfoMap

    %% Navigation zur Kamera
    User->>Home: Tab "Camera" wählen
    Home->>Camera: CameraPage anzeigen

    %% Foto aufnehmen und klassifizieren (nur Erfolgsfluss)
    User->>Camera: "Take Photo & Classify" tippen
    Camera->>ImageSvc: takePhoto()
    ImageSvc-->>Camera: image (File)

    Camera->>Camera: _lastImage setzen
    Camera->>Dialog: Loader anzeigen
    Camera->>IdSvc: classifyPhoto(image)
    IdSvc-->>Camera: species (String)
    Camera->>Camera: _speciesToId(species) (butterflyId bestimmen)
    Camera->>Dialog: Loader schließen

    Camera->>NewResult: Navigiere (butterflyId, imagePath)
    NewResult->>Map: butterflyId → speciesName
    NewResult->>InfoMap: Details laden
    NewResult->>NewResult: Detailseite rendern

