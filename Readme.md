# Descripción de la Temática de la Base de Datos

La base de datos "SteelEcht" está diseñada para gestionar una tienda de bicicletas. Incluye la gestión de categorías de productos, proveedores, inventario de bicicletas, pedidos de clientes, detalles de pedidos, empleados, y la relación entre estos elementos. Este sistema proporciona una forma organizada y eficiente de rastrear la información de la tienda, facilitando la toma de decisiones y el mantenimiento de la integridad de los datos.

A continuación se presenta un diagrama de entidad-relación (DER) que describe las tablas y las relaciones en la base de datos:

![Diagrama de Entidad-Relación](https://drive.google.com/uc?export=view&id=1R1TKGwgXYvtIQLGcG55ROqHDTYxn-UUc)


### Tabla PROVEEDORES

| Abreviatura     | Nombre Completo      | Tipo de Dato | Clave            |
|-----------------|----------------------|--------------|------------------|
| `ProveedorId`   | ID de Proveedor      | `INT`        | `PRIMARY KEY`    |
| `NombreProveedor` | Nombre del Proveedor | `VARCHAR(100)` |                  |
| `Telefono`      | Teléfono             | `VARCHAR(20)` |                  |
| `Direccion`     | Dirección            | `VARCHAR(100)` |                  |
| `Ciudad`        | Ciudad               | `VARCHAR(100)` |                  |

### Tabla CATEGORIAS

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `CategoriaId`   | ID de Categoría       | `INT`        | `PRIMARY KEY`    |
| `NombreCategoria` | Nombre de Categoría | `VARCHAR(100)` |                  |
| `Descripcion`   | Descripción           | `TEXT`       |                  |

### Tabla BICICLETAS

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `BicicletaId`   | ID de Bicicleta       | `INT`        | `PRIMARY KEY`    |
| `Modelo`        | Modelo de Bicicleta   | `VARCHAR(100)` |                  |
| `Marca`         | Marca de Bicicleta    | `VARCHAR(100)` |                  |
| `Stock`         | Stock de Bicicleta    | `INT`        |                  |
| `CategoriaId`   | ID de Categoría       | `INT`        | `FOREIGN KEY`    |
| `ProveedorId`   | ID de Proveedor       | `INT`        | `FOREIGN KEY`    |
| `Descripcion`   | Descripción           | `TEXT`       |                  |

### Tabla INVENTARIO

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `InventarioId`  | ID de Inventario      | `INT`        | `PRIMARY KEY`    |
| `BicicletaId`   | ID de Bicicleta       | `INT`        | `FOREIGN KEY`    |
| `CantidadEnStock` | Cantidad en Stock   | `INT`        |                  |

### Tabla PEDIDOS

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `PedidoId`      | ID de Pedido          | `INT`        | `PRIMARY KEY`    |
| `ClienteId`     | ID de Cliente         | `INT`        | `FOREIGN KEY`    |
| `EmpleadoId`    | ID de Empleado        | `INT`        | `FOREIGN KEY`    |
| `FechaPedido`   | Fecha de Pedido       | `DATE`       |                  |
| `ImporteTotal`  | Importe Total         | `DECIMAL(10,2)` |                 |
| `Estado`        | Estado del Pedido     | `VARCHAR(50)` |                  |

### Tabla DETALLEPEDIDOS

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `DetallePedidoId` | ID de Detalle de Pedido | `INT`    | `PRIMARY KEY`    |
| `PedidoId`      | ID de Pedido          | `INT`        | `FOREIGN KEY`    |
| `BicicletaId`   | ID de Bicicleta       | `INT`        | `FOREIGN KEY`    |
| `Cantidad`      | Cantidad de Bicicletas | `INT`       |                  |
| `PrecioUnitario` | Precio Unitario      | `DECIMAL(10,2)` |                 |

### Tabla EMPLEADOS

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `EmpleadoId`    | ID de Empleado        | `INT`        | `PRIMARY KEY`    |
| `Nombre`        | Nombre del Empleado   | `VARCHAR(50)` |                  |
| `Apellido`      | Apellido del Empleado | `VARCHAR(50)` |                  |
| `Correo`        | Correo Electrónico    | `VARCHAR(100)` |                  |
| `Telefono`      | Teléfono              | `VARCHAR(20)` |                  |
| `Direccion`     | Dirección             | `VARCHAR(100)` |                  |
| `FechaContratacion` | Fecha de Contratación | `DATE`   |                  |
| `Cargo`         | Cargo del Empleado    | `VARCHAR(100)` |                  |

### Tabla CLIENTES

| Abreviatura     | Nombre Completo       | Tipo de Dato | Clave            |
|-----------------|-----------------------|--------------|------------------|
| `ClienteId`     | ID de Cliente         | `INT`        | `PRIMARY KEY`    |
| `Nombre`        | Nombre del Cliente    | `VARCHAR(50)` |                  |
| `Apellido`      | Apellido del Cliente  | `VARCHAR(50)` |                  |
| `Correo`        | Correo Electrónico    | `VARCHAR(100)` |                  |
| `Telefono`      | Teléfono              | `VARCHAR(20)` |                  |
| `Direccion`     | Dirección             | `VARCHAR(100)` |                  |

## Listado de Vistas

### 1. Vista: `VistaBicicletas`
**Descripción**: Muestra un resumen de las bicicletas disponibles, incluyendo su categoría y proveedor.

**Objetivo**: Permitir una consulta rápida de las bicicletas, su stock, y la información del proveedor y la categoría.

**Tablas que Componen**: `Bicicletas`, `Categorias`, `Proveedores`

```sql
CREATE VIEW VistaBicicletas AS
SELECT 
    b.BicicletaId,
    b.Modelo,
    b.Marca,
    b.Stock,
    b.Descripcion,
    c.NombreCategoria,
    p.NombreProveedor
FROM 
    Bicicletas b
JOIN 
    Categorias c ON b.CategoriaId = c.CategoriaId
JOIN 
    Proveedores p ON b.ProveedorId = p.ProveedorId;
```

### 2. Vista: `VistaClientesPedidos`
**Descripción**: Esta vista permite visualizar todos los pedidos realizados por cada cliente, incluyendo la fecha y el importe total.

**Objetivo**: Facilitar el seguimiento de los pedidos realizados por cada cliente y analizar la actividad de compra.

**Tablas que Componen**: `Clientes`, `Pedidos`

```sql
CREATE VIEW VistaClientesPedidos AS
SELECT 
    c.ClienteId,
    c.Nombre,
    c.Apellido,
    p.FechaPedido,
    p.ImporteTotal,
    p.Estado
FROM 
    Clientes c
JOIN 
    Pedidos p ON c.ClienteId = p.ClienteId;
```

### 3. Vista: `VistaDetallesPedidos`
**Descripción**: Muestra los detalles de cada pedido, incluyendo la bicicleta, cantidad y precio unitario.

**Objetivo**: Permitir un análisis detallado de los pedidos, facilitando la gestión de inventario y ventas.

**Tablas que Componen**: `DetallesPedidos`, `Bicicletas`, `Pedidos`

```sql
CREATE VIEW VistaDetallesPedidos AS
SELECT 
    dp.DetallePedidoID,
    p.PedidoID,
    b.Modelo,
    dp.Cantidad,
    dp.PrecioUnitario
FROM 
    DetallesPedidos dp
JOIN 
    Bicicletas b ON dp.BicicletaId = b.BicicletaId
JOIN 
    Pedidos p ON dp.PedidoId = p.PedidoID;
```

## Listado de Funciones

### 1. Funcion: `CalcularTotalPedidos`
**Descripción**: Calcula el importe total de todos los pedidos realizados por un cliente específico.

**Objetivo**: Facilitar la obtención de datos financieros y evaluar el rendimiento de cada cliente.

**Tablas Manipuladas**: `Pedidos`, `DetallesPedidos`

```sql
CREATE FUNCTION CalcularTotalPedidos(clienteId INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(ImporteTotal) INTO total
    FROM Pedidos
    WHERE ClienteId = clienteId;
    RETURN total;
END;
```

### 2. Funcion: `StockBicicleta`
**Descripción**: Devuelve la cantidad de stock disponible para una bicicleta específica.

**Objetivo**: Permitir verificar rápidamente la disponibilidad de un modelo de bicicleta.

**Tablas Manipuladas**: `Bicicletas`, `Inventario`

```sql
CREATE FUNCTION StockBicicleta(bicicletaId INT)
RETURNS INT
BEGIN
    DECLARE stock INT;
    SELECT CantidadEnStock INTO stock
    FROM Inventario
    WHERE BicicletaId = bicicletaId;
    RETURN stock;
END;
```

## Listado de Stored Procedures

### 1. Procedimiento Almacenado: `AgregarPedido`
**Descripción**: Permite agregar un nuevo pedido a la base de datos, registrando la información del cliente y del empleado que gestiona la venta.

**Objetivo**: Facilitar la inserción de nuevos pedidos en el sistema de forma organizada.

**Tablas Manipuladas**: `Pedidos`, `DetallesPedidos`

```sql
CREATE PROCEDURE AgregarPedido(
    IN clienteId INT,
    IN empleadoId INT,
    IN fechaPedido DATE,
    IN importeTotal DECIMAL(10, 2),
    IN estado VARCHAR(50)
)
BEGIN
    DECLARE nuevoPedidoId INT;

    INSERT INTO Pedidos (ClienteId, EmpleadoId, FechaPedido, ImporteTotal, Estado)
    VALUES (clienteId, empleadoId, fechaPedido, importeTotal, estado);

    SET nuevoPedidoId = LAST_INSERT_ID();

    -- Aquí puedes agregar la lógica para insertar detalles del pedido
END;
```

### 2. Procedimiento Almacenado: `ActualizarStockBicicleta`
**Descripción**: Actualiza la cantidad de stock de una bicicleta específica después de realizar un pedido.

**Objetivo**: Mantener la información del inventario actualizada y precisa.

**Tablas Manipuladas**: `Bicicletas`, `Inventario`

```sql
CREATE PROCEDURE ActualizarStockBicicleta(
    IN bicicletaId INT,
    IN cantidad INT
)
BEGIN
    UPDATE Inventario
    SET CantidadEnStock = CantidadEnStock - cantidad
    WHERE BicicletaId = bicicletaId;
END;
```
