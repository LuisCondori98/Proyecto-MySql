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
