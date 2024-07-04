DROP DATABASE IF EXISTS SteelEcht;

CREATE DATABASE SteelEcht;

USE SteelEcht;

CREATE TABLE Categorias(

	CategoriaId INT PRIMARY KEY AUTO_INCREMENT,
    NombreCategoria VARCHAR(100) NOT NULL,
    Descripcion TEXT
);

CREATE TABLE Proveedores(

	ProveedorId INT PRIMARY KEY AUTO_INCREMENT,
    NombreProveedor VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Direccion VARCHAR(100),
    Ciudad VARCHAR(100)
);

CREATE TABLE Bicicletas(

	BicicletaId INT PRIMARY KEY AUTO_INCREMENT,
    Modelo VARCHAR(100) NOT NULL,
    Marca Varchar(100) NOT NULL,
    Stock INT NOT NULL,
    Descripcion TEXT,
    CategoriaId INT,
    ProveedorId INT,
    FOREIGN KEY (CategoriaId) REFERENCES Categorias(CategoriaId),
    FOREIGN KEY (ProveedorId) REFERENCES Proveedores(ProveedorId)
);

CREATE TABLE Clientes(

	ClienteId INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) NOT NULL UNIQUE,
    Telefono VARCHAR(20),
    Direccion VARCHAR(100)
);

CREATE TABLE Empleados(

	EmpleadoId INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(20),
    Direccion VARCHAR(100),
    FechaContratacion DATE NOT NULL,
    Cargo VARCHAR(100)
);

CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteId INT,
    EmpleadoId INT,
    FechaPedido DATE NOT NULL,
    ImporteTotal DECIMAL(10, 2) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(ClienteId) ON DELETE CASCADE,
    FOREIGN KEY (EmpleadoId) REFERENCES Empleados(EmpleadoId) ON DELETE SET NULL
);

CREATE TABLE DetallesPedidos (
    DetallePedidoID INT PRIMARY KEY AUTO_INCREMENT,
    PedidoId INT,
    BicicletaId INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoId) REFERENCES Pedidos(PedidoId) ON DELETE CASCADE,
    FOREIGN KEY (BicicletaId) REFERENCES Bicicletas(BicicletaId) ON DELETE CASCADE
);

CREATE TABLE Inventario (
    InventarioId INT PRIMARY KEY AUTO_INCREMENT,
    BicicletaId INT,
    CantidadEnStock INT NOT NULL,
    FOREIGN KEY (BicicletaId) REFERENCES Bicicletas(BicicletaId)
);