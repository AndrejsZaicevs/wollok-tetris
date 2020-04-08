import wollok.game.*
import objects.*

//Usado para elementos estaticos y del escenario
class Pared {
	var property position = game.center()
	var imagen = "pared.png"
	method image() = imagen
	
	method esActivo(){
		return false
	}
	
	method eliminar(){
		game.removeVisual(self)
	}
	
	method image(im){
		imagen = im
	}
	
}

//Usado para bloques moviles y para bloques que fueron desactivados
class Bloque {
	
	var activo = true
	var imagen = "blanco.png"
	
	var property position = game.at(5, 10)
	method image() = imagen
	
	method image(im){
		imagen = im
	}
	
	method esActivo() = activo
	
	method desactivar(){
		activo = false
	}
	
	//Devuelve si un movimiento abajo es valido o no
	method ver(x, y){
		const objetos = game.getObjectsIn(game.at(position.x() + x, position.y() + y))
		var valido = true
		objetos.forEach({objeto => 
			if(!objeto.esActivo()){
				valido = false
			}
		})
		return valido
	}
	
	method mover(x, y){
		position = game.at(position.x() + x, position.y() + y)
	}
	
	method moverA(x, y){
		position = game.at(x, y)
	}
	
	method verEn(x, y){
		const objetos = game.getObjectsIn(game.at(x, y))
		var valido = true
		objetos.forEach({objeto => 
			if(!objeto.esActivo()){
				valido = false
			}
		})
		return valido
	}
	
	method columna() = position.x()
	method fila() = position.y()
	
	method eliminar(){
		game.removeVisual(self)
	}
}



class Figura {
	
	var bloquesActivos = []
	var bloquePrincipal
	
	method instanciar(figura){
		bloquesActivos = figura.instanciar()		
		bloquePrincipal = figura.primerBloque()
		
		//Si no hay espacio para otro bloque es que esta en derrota
		if(!self.comprobarDerrota()){
			logicaPrincipal.derrota()
			console.println("Derrota")
		}
		// Lo dibujo de todos modos para demostrar que se superponen
		bloquesActivos.forEach({bloque =>
			game.addVisual(bloque)
		})
	}
	
	method comprobarDerrota(){
		var valido = true
		bloquesActivos.forEach({bloque => 
			var columna = bloque.columna()
			var fila = bloque.fila()
			
			if(!game.getObjectsIn(game.at(columna, fila)).isEmpty()){
				valido = false
			}
		})	
		return valido
	}
	
	method ver(x, y){
		var valido = true
		bloquesActivos.forEach({bloque => 
			if(!bloque.ver(x, y)){
				valido = false
			}
		})	
		return valido
	}
	
	method mover(x, y){
		bloquesActivos.forEach({bloque =>
			bloque.mover(x,y)
		})
	}
	
	method desactivar(){
		bloquesActivos.forEach({bloque =>
			bloque.desactivar()
		})
		bloquesActivos = []
	}
	
	method filasActivas(){
		const filas = #{}
		bloquesActivos.forEach({bloque =>
			filas.add(bloque.fila())
		})
		return filas
		
	}
	
	method encontrarFondo(){
		if(self.ver(0, -1)){
			return self.verMasAbajo(-1)
		}else{
			return 0
		}
	}
	
	method verMasAbajo(num){
		if(self.ver(0, num)){
			return self.verMasAbajo(num-1)
		}else{
			return num+1
		}
	}
	
	method girar(){
		var centroX = bloquePrincipal.columna()
		var centroY = bloquePrincipal.fila()
		var valido = true
		bloquesActivos.forEach({bloque => 
			if(!bloque.verEn(centroX+(bloque.fila()-centroY), centroY+(centroX-bloque.columna()))){
				valido = false
			}
		})	
		if(valido){
			bloquesActivos.forEach({bloque =>
				bloque.moverA(centroX+(bloque.fila()-centroY), centroY+(centroX-bloque.columna()))
			})
		}
	}

	
}

