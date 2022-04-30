-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-04-2022 a las 03:39:20
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `covid`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capturas_encuesta`
--

CREATE TABLE `capturas_encuesta` (
  `id` int(11) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `matricula` varchar(32) DEFAULT NULL,
  `numero_profesor` varchar(32) DEFAULT NULL,
  `numero_empleado` varchar(32) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(128) NOT NULL,
  `contacto_covid` tinyint(1) NOT NULL DEFAULT 0,
  `vacunado` tinyint(1) NOT NULL DEFAULT 1,
  `cadena_qr` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `capturas_encuesta`
--

INSERT INTO `capturas_encuesta` (`id`, `id_tipo_usuario`, `matricula`, `numero_profesor`, `numero_empleado`, `nombre`, `correo`, `contacto_covid`, `vacunado`, `cadena_qr`, `created_at`, `updated_at`) VALUES
(1, 1, '90987', NULL, NULL, 'juan', 'saddfa', 0, 1, '12345678', '2022-04-30 07:40:32', '2022-04-30 07:40:32'),
(2, 3, NULL, NULL, NULL, 'jose', 'juan123431', 0, 1, '123456789', '2022-04-30 07:53:04', '2022-04-30 07:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sintomas`
--

CREATE TABLE `sintomas` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sintomas`
--

INSERT INTO `sintomas` (`id`, `descripcion`) VALUES
(1, 'Estoy positivo en COVID'),
(2, 'Fiebre o escalofrios'),
(3, 'Tos o Catarro'),
(4, 'Dolor de Cabeza o Garganta'),
(5, 'Cansancio o Malestar general'),
(6, 'Perdida del olfato'),
(7, 'Ninguno de los anteriores');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sintomas_captura`
--

CREATE TABLE `sintomas_captura` (
  `id` int(11) NOT NULL,
  `id_captura` int(11) NOT NULL,
  `id_sintoma` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sintomas_captura`
--

INSERT INTO `sintomas_captura` (`id`, `id_captura`, `id_sintoma`, `created_at`, `updated_at`) VALUES
(1, 2, 3, '2022-04-30 07:53:04', '2022-04-30 07:53:04'),
(2, 2, 2, '2022-04-30 07:53:04', '2022-04-30 07:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_usuario`
--

CREATE TABLE `tipos_usuario` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipos_usuario`
--

INSERT INTO `tipos_usuario` (`id`, `descripcion`) VALUES
(1, 'Alumno'),
(2, 'Profesor'),
(3, 'Empleado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `capturas_encuesta`
--
ALTER TABLE `capturas_encuesta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo_usuario` (`id_tipo_usuario`);

--
-- Indices de la tabla `sintomas`
--
ALTER TABLE `sintomas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sintomas_captura`
--
ALTER TABLE `sintomas_captura`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `combinacion_unica` (`id_captura`,`id_sintoma`),
  ADD KEY `id_sintoma` (`id_sintoma`),
  ADD KEY `id_captura` (`id_captura`);

--
-- Indices de la tabla `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `capturas_encuesta`
--
ALTER TABLE `capturas_encuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sintomas`
--
ALTER TABLE `sintomas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `sintomas_captura`
--
ALTER TABLE `sintomas_captura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `capturas_encuesta`
--
ALTER TABLE `capturas_encuesta`
  ADD CONSTRAINT `capturas_encuesta_ibfk_1` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tipos_usuario` (`id`);

--
-- Filtros para la tabla `sintomas_captura`
--
ALTER TABLE `sintomas_captura`
  ADD CONSTRAINT `sintomas_captura_ibfk_1` FOREIGN KEY (`id_captura`) REFERENCES `capturas_encuesta` (`id`),
  ADD CONSTRAINT `sintomas_captura_ibfk_2` FOREIGN KEY (`id_sintoma`) REFERENCES `sintomas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
