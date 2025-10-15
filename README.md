```mermaid
sequenceDiagram
    %% Teilnehmer
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
    participant Settings as SettingsPage
    participant HTTP
    participant Dialog
    participant idToSpeciesName
    participant butterflyInfoMap

    %% App-Start
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
            User->>Login: Benutzername & Passwort eingeben
            Login->>LoginSvc: login(username,password)
            LoginSvc->>HTTP: POST /api/users/login
            HTTP-->>LoginSvc: { user, user_id }
            LoginSvc->>SharedPrefs: clear(), set loggedIn=true, username, user_id
            LoginSvc-->>Login: Erfolg=true
            Login->>Home: navigieren
        else Benutzer wählt „Register“
            User->>Intro: tippt Register-Button
            Intro->>Register: RegisterPage öffnen
            User->>Register: E-Mail, Benutzername, Passwort
            Register->>LoginSvc: register(email,username,password)
            LoginSvc->>HTTP: POST /api/users/register
            HTTP-->>LoginSvc: { user, user_id }
            LoginSvc->>SharedPrefs: clear(), set loggedIn=true, username, user_id
            LoginSvc-->>Register: Erfolg=true
            Register->>Home: navigieren
        end
    end

    %% „Meine Schmetterlinge“
    User->>Home: Tab auf InfoPage wechseln
    Home->>Info: anzeigen
    User->>Info: tippt „My Butterflies”
    Info->>MyButterflies: öffnen
    MyButterflies->>SharedPrefs: getInt('user_id')
    alt user_id vorhanden
        SharedPrefs-->>MyButterflies: userId
        MyButterflies->>RetrievalSvc: getUserUploads(userId,limit,sort,withButterfly)
        RetrievalSvc->>HTTP: GET /uploads/user/{userId}?limit…
        HTTP-->>RetrievalSvc: JSON { items }
        RetrievalSvc-->>MyButterflies: List<UserUpload>
        MyButterflies->>UploadGrid: Grid rendern
        User->>UploadGrid: tippt auf Upload-Tile
        UploadGrid->>MyButterflies: onTapUpload(UserUpload)
        MyButterflies->>FindingResult: öffnen (butterflyId, imageUrl)
        FindingResult->>idToSpeciesName: butterflyId → speciesName
        alt speciesName & Info vorhanden
            FindingResult->>butterflyInfoMap: Details laden
            FindingResult->>FindingResult: Detailseite darstellen
        else Information fehlt
            FindingResult->>FindingResult: Fehlermeldung „Unknown species“
        end
    else user_id fehlt
        SharedPrefs-->>MyButterflies: null
        MyButterflies->>MyButterflies: SnackBar „No User ID found“
    end

    %% Kamera & Klassifizierung
    User->>Home: Tab auf CameraPage
    Home->>Camera: anzeigen
    User->>Camera: tippt „Take Photo & Classify”
    Camera->>ImageSvc: takePhoto()
    ImageSvc-->>Camera: File? image
    alt Foto erfolgreich
        Camera->>Camera: _lastImage setzen
        Camera->>Dialog: Loader anzeigen
        Camera->>IdSvc: classifyPhoto(file)
        IdSvc->>HTTP: POST /api/predict
        HTTP-->>IdSvc: species (String)
        IdSvc-->>Camera: species
        Camera->>Camera: _speciesToId(species)
        alt ID gefunden
            Camera->>Dialog: Loader schließen
            Camera->>NewResult: öffnen (butterflyId,imagePath)
            NewResult->>idToSpeciesName: butterflyId → speciesName
            alt speciesName & Info vorhanden
                NewResult->>butterflyInfoMap: Details laden
                User->>NewResult: tippt „Save to My Butterflies”
                NewResult->>SharedPrefs: getInt('user_id')
                alt user_id vorhanden
                    SharedPrefs-->>NewResult: userId
                    NewResult->>Dialog: Loader anzeigen
                    NewResult->>UploadSvc: uploadPhoto(file,userId,butterflyId,lat,lon)
                    UploadSvc->>HTTP: POST /uploads
                    HTTP-->>UploadSvc: Upload-Result
                    UploadSvc-->>NewResult: Erfolg
                    NewResult->>FindingSvc: saveFinding(Finding(...))
                    FindingSvc->>SharedPrefs: laden & speichern
                    NewResult->>Dialog: Loader schließen
                    NewResult->>Camera: „Upload ok!“ und zurück
                else user_id fehlt
                    SharedPrefs-->>NewResult: null
                    NewResult->>NewResult: SnackBar „No User ID found“
                end
            else speciesName unbekannt
                NewResult->>NewResult: „Unknown species“
            end
        else keine ID gefunden
            Camera->>Dialog: Loader schließen
            Camera->>Camera: SnackBar „Unknown species returned“
        end
    else Foto abgebrochen
        Camera->>Camera: keine Aktion
    end

    %% Einstellungen & Logout
    User->>Home: Tab auf SettingsPage
    Home->>Settings: anzeigen
    User->>Settings: tippt „Logout”
    Settings->>LoginSvc: logout()
    LoginSvc->>SharedPrefs: clear()
    LoginSvc-->>Settings: true
    Settings->>Intro: pushAndRemoveUntil(IntroPage)
