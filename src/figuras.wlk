import wollok.game.*
import clases.*

object figuras{
	const coleccionFiguras = [figuraL,figuraLInvertido,figuraS,figuraSInvertido,figuraT,figuraCuadrado,figuraLargo]
	
	method randomFigura() = coleccionFiguras.get(0.randomUpTo(coleccionFiguras.size()).roundUp() - 1)		
}

object figuraL{
	const color = "naranja.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []	
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1,y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1,y-1), image = color))
		return bloquesActivos
	}
}

object figuraCuadrado{
	const color = "amarillo.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x,y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1,y), image = color))
		return bloquesActivos
	}
}

object figuraLargo{
	const color = "celeste.png"
	const x = 5
	const y = 20

	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y-1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y-2), image = color))
		return bloquesActivos
	}
}
object figuraLInvertido{
	const color = "azul.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y+1), image = color))
		return bloquesActivos
	}
}
object figuraT{
	const color = "violeta.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x+1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		return bloquesActivos
	}
}
object figuraS{
	const color = "verde.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y+1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y-1), image = color))
		return bloquesActivos
	}
}
object figuraSInvertido{
	const color = "rojo.png"
	const x = 5
	const y = 20
	
	method instanciar(){
		const bloquesActivos = []
		bloquesActivos.add(new Bloque(position = game.at(x, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x, y-1), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y), image = color))
		bloquesActivos.add(new Bloque(position = game.at(x-1, y+1), image = color))
		return bloquesActivos
	}
}