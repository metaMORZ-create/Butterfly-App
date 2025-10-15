```mermaid
sequenceDiagram
    actor Benutzer as User
    participant Intro as IntroPage
    participant Register as RegisterPage
    participant Login as LoginPage
    participant ClientSvc as LoginRegisterService
    participant HTTPS
    participant API as Backend API
    participant Hasher as PasswordHasher (Argon2id)
    participant DB as Database
    participant SharedPrefs as SharedPreferences
    participant Home as HomePage

    %% --- Registrierung (Erfolgsfluss) ---
    User->>Intro: "Register" tippen
    Intro->>Register: RegisterPage öffnen
    User->>Register: E-Mail, Username, Password eingeben
    Register->>ClientSvc: register(email, username, password)
    ClientSvc->>HTTPS: POST /users/register {username, email, password}
    HTTPS->>API: Request weiterleiten
    API->>Hasher: generateSalt()
    Hasher-->>API: salt
    API->>Hasher: hash(password, salt)  %% Argon2id
    Hasher-->>API: passwordHash
    API->>DB: INSERT user {username, email, salt, passwordHash}
    DB-->>API: ok
    API-->>HTTPS: { user, user_id }
    HTTPS-->>ClientSvc: Response
    ClientSvc->>SharedPrefs: setBool('loggedIn', true)
    ClientSvc->>SharedPrefs: setString('username', user)
    ClientSvc->>SharedPrefs: setInt('user_id', user_id)
    ClientSvc-->>Register: Erfolg
    Register->>Home: pushAndRemoveUntil(HomePage)

    %% --- Login (Erfolgsfluss) ---
    User->>Intro: "Login" tippen
    Intro->>Login: LoginPage öffnen
    User->>Login: Username, Password eingeben
    Login->>ClientSvc: login(username, password)
    ClientSvc->>HTTPS: POST /users/login {username, password}
    HTTPS->>API: Request weiterleiten
    API->>DB: SELECT salt, passwordHash BY username
    DB-->>API: {salt, passwordHash}
    API->>Hasher: verify(password, salt, passwordHash)
    Hasher-->>API: valid=true
    API-->>HTTPS: { user, user_id }
    HTTPS-->>ClientSvc: Response
    ClientSvc->>SharedPrefs: setBool('loggedIn', true)
    ClientSvc->>SharedPrefs: setString('username', user)
    ClientSvc->>SharedPrefs: setInt('user_id', user_id)
    ClientSvc-->>Login: Erfolg
    Login->>Home: pushAndRemoveUntil(HomePage)
