CREATE DATABASE ClinicaPrivata;
USE ClinicaPrivata;

CREATE TABLE Paziente (
    IdPaziente INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DataNascita DATE NOT NULL,
    Telefono VARCHAR(100) NOT NULL,
    CodiceFiscale VARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE Recensione (
    IdRecensione INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdPaziente INTEGER NOT NULL,
    Voto INTEGER CHECK(Voto BETWEEN 1 AND 5),
    DataRecensione DATE NOT NULL,
    TestoRecensione LONGTEXT,
    FOREIGN KEY (IdPaziente) REFERENCES Paziente(IdPaziente)
);

CREATE TABLE Prenotazione (
    IdPrenotazione INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdPaziente INTEGER,
    DataPrenotazione DATE NOT NULL,
    OraPrenotazione TIME NOT NULL,
    StatoPrenotazione VARCHAR(20) NOT NULL CHECK(StatoPrenotazione IN ('Confermato', 'Non confermato')),
    FOREIGN KEY (IdPaziente) REFERENCES Paziente(IdPaziente)
);


CREATE TABLE Medico (
    IdMedico INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Specializzazione VARCHAR(100),
    Tipo VARCHAR(50)
);

CREATE TABLE Pagamento (
    IdPagamento INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdPrenotazione INTEGER,
    DataPagamento DATE NOT NULL,
    Importo DECIMAL(8,2) NOT NULL,
    Metodo VARCHAR(20) NOT NULL CHECK(Metodo IN ('Contanti', 'POS', 'Bonifico')),
    StatoPagamento VARCHAR(20) NOT NULL CHECK(StatoPagamento IN ('Confermato', 'Non confermato')),
    FOREIGN KEY (IdPrenotazione) REFERENCES Prenotazione(IdPrenotazione)
);

CREATE TABLE LaboratoriConvenzionati (
    IdLaboratorio INTEGER PRIMARY KEY AUTO_INCREMENT,
    NomeLaboratorio VARCHAR(100) NOT NULL,
    Indirizzo VARCHAR(150) NOT NULL,
    Citta VARCHAR(50) NOT NULL,
    Cap VARCHAR(5) NOT NULL
);

CREATE TABLE Esame (
    IdEsame INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdMedico INTEGER,
    NomeEsame VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Costo DECIMAL(8,2) NOT NULL,
    Urgenza VARCHAR(10) NOT NULL,
    Modalita VARCHAR(20) NOT NULL CHECK(modalita IN ('Interno', 'Esterno')),
    IdLaboratorio INTEGER ,
    FOREIGN KEY (IdMedico) REFERENCES Medico(IdMedico),
    FOREIGN KEY (IdLaboratorio) REFERENCES LaboratoriConvenzionati(IdLaboratorio)
);

CREATE TABLE PrenotazioneEsame (
    IdPrenotazioneEsame INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdPrenotazione INTEGER,
    IdEsame INTEGER,
    FOREIGN KEY (IdPrenotazione) REFERENCES Prenotazione(IdPrenotazione),
    FOREIGN KEY (IdEsame) REFERENCES Esame(IdEsame)
);

CREATE TABLE Referto (
    IdReferto INTEGER PRIMARY KEY AUTO_INCREMENT,
    IdPrenotazioneEsame INTEGER UNIQUE,
    DataEmissione DATE NOT NULL,
    Esito LONGTEXT NOT NULL,
    FileDigitale VARCHAR(100) NOT NULL,
    FOREIGN KEY (IdPrenotazioneEsame) REFERENCES PrenotazioneEsame(IdPrenotazioneEsame)
);


INSERT INTO Paziente (Nome, Cognome, Email, DataNascita, Telefono, CodiceFiscale) VALUES
('Mario', 'Rossi', 'mario.rossi@email.com', '1985-06-12', '3391234567', 'RSSMRA85H12H501Z'),
('Lucia', 'Verdi', 'lucia.verdi@email.com', '1990-11-25', '3487654321', 'VRDLCU90S65C351H'),
('Giovanni', 'Bianchi', 'giovanni.bianchi@email.com', '1978-03-04', '3201122334', 'BNCGVN78C04F205T'),
('Elena', 'Ferrari', 'elena.ferrari@email.com', '2000-07-20', '3479988776', 'FRRLNE00L60C351P'),
('Sara', 'Russo', 'sara.russo@email.com', '1995-10-15', '3335566778', 'RSSSRA95R55H501Y');

INSERT INTO Recensione ( IdPaziente, Voto, DataRecensione, TestoRecensione) VALUES
( 1, 5, '2024-05-20', 'Servizio eccellente, personale molto disponibile.'),
( 2, 3, '2024-05-21', 'Tutto ok, ma ho atteso troppo per il referto.'),
( 3, 4, '2024-05-22', 'Professionali e puntuali, consigliato.'),
( 4, 2, '2024-05-23', 'Struttura buona, ma poca chiarezza alla reception.'),
( 5, 5, '2024-05-24', 'Ottima esperienza, tornerò sicuramente.');

INSERT INTO Prenotazione ( IdPaziente, DataPrenotazione, OraPrenotazione, StatoPrenotazione) VALUES
( 1, '2024-06-01', '09:00:00', 'Confermato'),
( 2, '2024-06-02', '10:30:00', 'Non confermato'),
( 3, '2024-06-03', '08:45:00', 'Confermato'),
( 4, '2024-06-04', '11:15:00', 'Confermato'),
( 5, '2024-06-05', '14:00:00', 'Non confermato');


INSERT INTO Medico ( Nome, Cognome, Specializzazione, Tipo) VALUES
('Giulia', 'Rossi', 'Cardiologia', 'Dipendente'),
( 'Marco', 'Bianchi', 'Neurologia', 'Libero Prof.'),
( 'Anna', 'Verdi', 'Pediatria', 'Dipendente'),
( 'Luca', 'Neri', 'Ortopedia', 'Libero Prof.'),
( 'Sara', 'Ferrari', 'Dermatologia', 'Dipendente'),
( 'Paolo', 'Conti', 'Psichiatria', 'Libero Prof.'),
( 'Elena', 'Russo', 'Oncologia', 'Dipendente'),
( 'Giovanni', 'Fontana', 'Endocrinologia', 'Libero Prof.'),
( 'Marta', 'Galli', 'Ginecologia', 'Dipendente'),
( 'Andrea', 'De Luca', 'Chirurgia Generale', 'Dipendente');

USE ClinicaPrivata;
INSERT INTO LaboratoriConvenzionati (NomeLaboratorio, Indirizzo, Citta, Cap) VALUES
('Laboratorio Analisi Alfa', 'Via Roma 10', 'Milano', '20121'),
('Centro Diagnostico Beta', 'Corso Garibaldi 55', 'Napoli', '80134'),
('Laboratorio Medico Gamma', 'Via Dante 23', 'Torino', '10121'),
('Centro Polispecialistico Delta', 'Viale Liberta 99', 'Bari', '70123'),
('Laboratorio Sanita Epsilon', 'Piazza Duomo 2', 'Firenze', '50122');


INSERT INTO Esame (IdMedico, NomeEsame, Categoria, Costo, Urgenza, Modalita, IdLaboratorio) VALUES
(1, 'Emocromo', 'Laboratorio', 25, 'No', 'Interno', NULL),
(2, 'Risonanza Magnetica', 'Imaging', 150, 'Si', 'Esterno', 1),
(3, 'Ecografia addome', 'Imaging', 70, 'No', 'Interno', NULL),
(1, 'Tampone COVID', 'Laboratorio', 40, 'Si', 'Interno', NULL),
(2, 'TC torace', 'Imaging', 130, 'Si', 'Esterno', 2);


USE ClinicaPrivata;
INSERT INTO PrenotazioneEsame (IdPrenotazione, IdEsame) VALUES
(1, 11),
(1, 12),
(2, 13),
(3, 11),
(4, 14);
SELECT * FROM PrenotazioneEsame;

INSERT INTO Pagamento (IdPrenotazione, DataPagamento, Importo, Metodo, StatoPagamento) VALUES
( 1, '2024-06-01', 50, 'Contanti', 'Confermato'),
( 2, '2024-06-02', 75.5, 'POS', 'Confermato'),
( 3, '2024-06-03', 100, 'Bonifico', 'Non confermato'),
( 4, '2024-06-04', 120.75, 'POS', 'Confermato'),
( 5, '2024-06-05', 80, 'Contanti', 'Non confermato');

USE ClinicaPrivata;
INSERT INTO Referto (IdPrenotazioneEsame, DataEmissione, Esito, FileDigitale) VALUES
(11, '2024-06-02', 'Valori nella norma', 'referti/001.pdf'),
(12, '2024-06-03', 'Presenza di alterazioni nei tessuti molli', 'referti/002.pdf'),
(13, '2024-06-04', 'Nessuna anomalia riscontrata', 'referti/003.pdf'),
(14, '2024-06-05', 'Positivita al test rapido', 'referti/004.pdf'),
(15, '2024-06-06', 'Versamento pleurico lieve riscontrato', 'referti/005.pdf');


SELECT * FROM Referto;





-- QUERY DI SELEZIONE
-- Prima query di selezione per i pazienti in tabella nati dopo il 1990
SELECT Nome, Cognome, DataNascita
FROM Paziente AS p
WHERE p.DataNascita > '1990-01-01';
-- Seconda query di selezione per i pazienti con urgenza
SELECT NomeEsame, Categoria, Urgenza
FROM Esame AS e
WHERE e.Urgenza = 'Si';
-- Terza query di selezione per recensioni sopra il 3;
SELECT idPaziente, Voto, TestoRecensione
FROM Recensione AS r
WHERE r.Voto >2;

-- QUERY PER MEZZO DI JOIN FRA LE TABELLE 
-- Prima query di join per i pazienti e loro prenotazioni
SELECT p.Nome, p.Cognome, pr.DataPrenotazione, pr.StatoPrenotazione
FROM Paziente AS p
JOIN Prenotazione AS pr ON p.IdPaziente = pr.IdPaziente;
-- Seconda query di join con info su esame effettuato
SELECT e.NomeEsame, r.DataEmissione, r.Esito
FROM Referto AS r
JOIN PrenotazioneEsame AS pe ON r.IdPrenotazioneEsame = pe.IdPrenotazioneEsame
JOIN Esame AS e ON pe.IdEsame = e.IdEsame;



-- QUERY CON AGGREGATI 
-- Prima query con aggregati per contare il numero di esami per categoria d'esame
SELECT e.Categoria, COUNT(*) AS NumeroEsami
FROM Esame AS e
GROUP BY e.Categoria;
-- Seconda query con aggregati per contare la media dei pagamenti per stato di pagamento
SELECT StatoPagamento, AVG(Importo) AS MediaImporto
FROM Pagamento
GROUP BY StatoPagamento;



-- QUERY INNESTATE 
-- Prima query innestata per costi esami superiori alla media
SELECT NomeEsame, Costo
FROM Esame
WHERE Costo > (SELECT AVG(Costo) FROM Esame);
-- Seconda query innestata per pazenti che hanno almeno una prenotazione
SELECT p.Nome, p.Cognome
FROM Paziente AS p
WHERE IdPaziente IN (
    SELECT pr.IdPaziente FROM Prenotazione as pr
);

