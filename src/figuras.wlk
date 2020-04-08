import wollok.game.*
import clases.*

object figuraL{
	const color = "naranja.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []	
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 19), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuraCuadrado{
	const color = "amarillo.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 21), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 21), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(6, 20), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuraLargo{
	const color = "celeste.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 21), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 19), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 18), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraLInvertido{
	const color = "azul.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 21), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraT{
	const color = "violeta.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(6, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(5, 21), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraS{
	const color = "verde.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 21), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 19), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}
object figuraSInvertido{
	const color = "rojo.png"
	var primerBloque
	
	method instanciar(){
		const bloquesActivos = []
		primerBloque = new Bloque(position = game.at(5, 20), imagen = color)
		bloquesActivos.add(primerBloque)
		bloquesActivos.add(new Bloque(position = game.at(5, 19), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 20), imagen = color))
		bloquesActivos.add(new Bloque(position = game.at(4, 21), imagen = color))
		return bloquesActivos
	}
	
	method primerBloque() = primerBloque
}

object figuras{
	method randomFigura(){
		const numero = 1.randomUpTo(8).roundUp() - 1
		if(numero == 1){
			return figuraL
		}else if(numero == 2){
			return figuraLInvertido
		}else if(numero == 3){
			return figuraS
		}else if(numero == 4){
			return figuraSInvertido
		}else if(numero == 5){
			return figuraT
		}else if(numero == 6){
			return figuraCuadrado
		}else{
			return figuraLargo
		}
	}
	
}