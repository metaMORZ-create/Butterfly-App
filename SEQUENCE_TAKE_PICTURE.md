```mermaid
sequenceDiagram
    %% Teilnehmer
    actor Benutzer as User
    participant Home as HomePage
    participant Camera as CameraPage
    participant ImageSvc as ImageService
    participant Dialog
    participant IdSvc as IdentificationService
    participant HTTP
    participant idToSpeciesName
    participant NewResult as NewCaptureResultPage
    participant butterflyInfoMap

    %% Wechsel zur Kamera
    User->>Home: Tab "Camera" wählen
    Home->>Camera: Seite anzeigen

    %% Foto aufnehmen
    User->>Camera: Tippt "Take Photo & Classify"
    Camera->>ImageSvc: takePhoto()
    ImageSvc-->>Camera: File? image

    alt Foto erfolgreich
        Camera->>Camera: _lastImage setzen
        Camera->>Dialog: Loader anzeigen

        %% Klassifikation
        Camera->>IdSvc: classifyPhoto(file)
        IdSvc->>HTTP: POST /api/predict
        HTTP-->>IdSvc: species (String)
        IdSvc-->>Camera: species

        %% Mapping zur internen ID
        Camera->>idToSpeciesName: species → butterflyId
        alt ID gefunden
            Camera->>Dialog: Loader schließen
            Camera->>NewResult: öffnen (butterflyId, imagePath)

            %% (Nur Anzeige der Infos auf Result-Seite)
            NewResult->>idToSpeciesName: butterflyId → speciesName
            NewResult->>butterflyInfoMap: Details laden
            NewResult->>NewResult: Detailseite mit Bild & Info anzeigen
        else keine ID gefunden
            Camera->>Dialog: Loader schließen
            Camera->>Camera: SnackBar "Unknown species returned"
        end
    else Foto abgebrochen/null
        Camera->>Camera: Keine Aktion
    end
