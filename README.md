```mermaid
sequenceDiagram
    %% Teilnehmende Akteure und Komponenten
    actor Benutzer as User
    participant Main as main()
    participant SharedPrefs as SharedPreferences
    participant Intro as IntroPage
    participant Login as LoginPage
    participant Register as RegisterPage
    participant LoginSvc as LoginRegisterService
    participant Home as HomePage
    participant Info as InfoPage
    participant MyButterflies as MyButterfliesPage
    participant RetrievalSvc as RetrievalService
    participant UploadGrid as MyButterfliesUploadsGrid
    participant FindingResult as FindingResultPage
    participant Camera as CameraPage
    participant ImageSvc as ImageService
    participant IdSvc as IdentificationService
    participant NewResult as NewCaptureResultPage
    participant UploadSvc as UploadService
    participant FindingSvc as FindingService

    %% App-Start: prüfen, ob Benutzer bereits eingeloggt ist
    User->>Main: App starten
    Main->>SharedPrefs: getInstance()
    SharedPrefs-->>Main: prefs
    Main->>SharedPrefs: getBool("loggedIn")
    alt Benutzer bereits eingeloggt
        SharedPrefs-->>Main: true
        Main->>Home: HomePage anzeigen
    else Benutzer nicht eingeloggt
        SharedPrefs-->>Main: false
        Main->>Intro: IntroPage anzeigen
        alt Benutzer wählt „Login“
            User->>Intro: tippt Login-Button
            Intro->>Login: LoginPage öffnen
            User->>Login: Eingabe von Benutzername & Passwort
            Login->>LoginSvc: login(username,password)
            LoginSvc->>+HTTP: POST /api/users/login
            HTTP-->>LoginSvc: Antwort mit user und user_id
            LoginSvc->>SharedPrefs: clear() und set loggedIn=true, username, user_id
            LoginSvc-->>Login: Erfolg = true
            Login->>Home: zu HomePage navigieren
        else Benutzer wählt „Register“
            User->>Intro: tippt Register-Button
            Intro->>Register: RegisterPage öffnen
            User->>Register: Eingabe von E-Mail, Benutzername & Passwort
            Register->>LoginSvc: register(email,username,password)
            LoginSvc->>+HTTP: POST /api/users/register
            HTTP-->>LoginSvc: Antwort mit user und user_id
            LoginSvc->>SharedPrefs: clear() und set loggedIn=true, username, user_id
            LoginSvc-->>Register: Erfolg = true
            Register->>Home: zu HomePage navigieren
        end
    end

    %% Navigation innerhalb der HomePage
    User->>Home: wechselt Tab auf InfoPage
    Home->>Info: InfoPage anzeigen
    %% „Meine Schmetterlinge“ öffnen
    User->>Info: tippt „My Butterflies”
    Info->>MyButterflies: MyButterfliesPage öffnen
    MyButterflies->>SharedPrefs: getInt('user_id')
    alt user_id vorhanden
        SharedPrefs-->>MyButterflies: userId
        MyButterflies->>RetrievalSvc: getUserUploads(userId,limit,sort,withButterfly)
        RetrievalSvc->>+HTTP: GET /uploads/user/{userId}?limit…
        HTTP-->>RetrievalSvc: JSON mit „items”
        RetrievalSvc-->>MyButterflies: Liste von UserUpload
        MyButterflies->>UploadGrid: Grid aus Upload-Tiles bauen
        User->>UploadGrid: tippt auf ein Upload-Tile
        UploadGrid->>MyButterflies: onTapUpload(UserUpload)
        MyButterflies->>FindingResult: FindingResultPage öffnen (butterflyId,imageUrl)
        FindingResult->>idToSpeciesName: butterflyId → speciesName
        alt speciesName & Info vorhanden
            FindingResult->>butterflyInfoMap: Info laden
            FindingResult: Detailseite mit Bild, Beschreibung, Chips & Karten anzeigen
        else Information fehlt
            FindingResult: Fehlermeldung „Unknown species“ anzeigen
        end
    else user_id fehlt
        SharedPrefs-->>MyButterflies: null
        MyButterflies: SnackBar „No User ID found“ anzeigen
    end

    %% Kameraseite zum Aufnehmen & Klassifizieren
    User->>Home: wechselt Tab auf CameraPage
    Home->>Camera: CameraPage anzeigen
    User->>Camera: tippt „Take Photo & Classify”
    Camera->>ImageSvc: takePhoto()
    ImageSvc-->>Camera: File? image
    alt Foto erfolgreich aufgenommen
        Camera->>Camera: _lastImage setzen
        Camera->>Dialog: CircularProgressIndicator anzeigen
        Camera->>IdSvc: classifyPhoto(file)
        IdSvc->>+HTTP: POST /api/predict
        HTTP-->>IdSvc: species-String
        IdSvc-->>Camera: species
        Camera->>Camera: _speciesToId(species)
        alt ID gefunden
            Camera->>Dialog: Loader schließen
            Camera->>NewResult: zu NewCaptureResultPage navigieren (butterflyId,imagePath)
            NewResult->>idToSpeciesName: butterflyId → speciesName
            alt speciesName & Info vorhanden
                NewResult->>butterflyInfoMap: Info laden
                User->>NewResult: tippt „Save to My Butterflies”
                NewResult->>SharedPrefs: getInt('user_id')
                alt user_id vorhanden
                    SharedPrefs-->>NewResult: userId
                    NewResult->>Dialog: CircularProgressIndicator anzeigen
                    NewResult->>UploadSvc: uploadPhoto(file,userId,butterflyId,lat,lon)
                    UploadSvc->>+HTTP: POST /uploads
                    HTTP-->>UploadSvc: Upload-Resultat
                    UploadSvc-->>NewResult: Erfolg
                    NewResult->>FindingSvc: saveFinding(new Finding(...))
                    FindingSvc->>SharedPrefs: vorhandene Funde laden & neuen Fund speichern
                    NewResult->>Dialog: Loader schließen
                    NewResult->>Home: SnackBar „Upload ok!“ und zurück zur Kamera
                else user_id fehlt
                    SharedPrefs-->>NewResult: null
                    NewResult: SnackBar „No User ID found“ anzeigen
                end
            else speciesName unbekannt
                NewResult: „Unknown species“ anzeigen
            end
        else keine ID gefunden
            Camera->>Dialog: Loader schließen
            Camera: SnackBar „Unknown species returned“ anzeigen
        end
    else Foto ist null (abgebrochen)
        Camera: Keine Aktion
    end

    %% Einstellungen und Logout
    User->>Home: wechselt Tab auf SettingsPage
    Home->>Settings: SettingsPage anzeigen
    User->>Settings: tippt „Logout”
    Settings->>LoginSvc: logout()
    LoginSvc->>SharedPrefs: clear()
    LoginSvc-->>Settings: true
    Settings->>Intro: pushAndRemoveUntil(IntroPage)
    Intro: IntroPage wieder sichtbar
``` 