import wollok.game.*
import clases.*

object figuraL{
	const color = "naranja.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []	
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 19), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuraCuadrado{
	const color = "amarillo.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 21), image = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 21), image = color))
		bloquesActivos.add(new Bloque(position = game.at(6, 20), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuraLargo{
	const color = "celeste.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 21), image = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 19), image = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 18), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraLInvertido{
	const color = "azul.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 21), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraT{
	const color = "violeta.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 21), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraS{
	const color = "verde.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 21), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 19), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraSInvertido{
	const color = "rojo.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), image = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 19), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), image = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 21), image = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuras{
	const coleccionFiguras = [figuraL,figuraLInvertido,figuraS,figuraSInvertido,figuraT,figuraCuadrado,figuraLargo]
	
	method randomFigura() = coleccionFiguras.get(0.randomUpTo(coleccionFiguras.size()).roundUp() - 1)	
	
}