import wollok.game.*
import objects.*
import figuras.*

//Usado para bloques moviles y para bloques que fueron desactivados
class Bloque {
	
	var activo = true	
	var property position = game.at(5, 10)
	var property image = "pared.png"
	
	method esActivo() = activo	
	method desactivar(){ activo = false }
	
	//Devuelve si un moviento en coordenadas relativas es valido
	method ver(x, y){
		const objetos = game.getObjectsIn(game.at(position.x() + x, position.y() + y))
		return objetos.all({bloque => bloque.esActivo()})
	}
	
	//Devuelve si un moviento en coordenadas absolutas es valido
	method verEn(x, y){
		const objetos = game.getObjectsIn(game.at(x, y))
		return objetos.all({bloque => bloque.esActivo()})
	}
	
	//Mover relativo
	method mover(x, y){ position = game.at(position.x() + x, position.y() + y) }	
	//Mover absoluto
	method moverA(x, y){ position = game.at(x, y) }
	
	method columna() = position.x()
	method fila() = position.y()
	method eliminar(){ game.removeVisual(self) }
}



class Figura {
	
	var bloquesActivos = []
	var bloquePrincipal
	var bloquesBajos = []
	
	method instanciar(figura, x, y){
		bloquesActivos = figura.instanciar(x, y)		
		bloquePrincipal = bloquesActivos.first()
		
		//Si no hay espacio para otro bloque es que esta en derrota
		if(!self.comprobarDerrota()){
			logicaPrincipal.activarDerrota()
			console.println("Derrota")
		}
		// Lo dibujo de todos modos para demostrar que se superponen
		bloquesActivos.forEach({bloque =>
			game.addVisual(bloque)
		})
		
		self.obtenerBloquesBajos()
	}
	
	
	//Combprueba si no hay bloques donde se va a instanciar la figura
	method comprobarDerrota(){
		var valido = true
		bloquesActivos.forEach({bloque => 
			const columna = bloque.columna()
			const fila = bloque.fila()
			
			if(!game.getObjectsIn(game.at(columna, fila)).isEmpty()){
				valido = false
			}
		})	
		return valido
	}
	
	method ver(x, y) = bloquesActivos.all({bloque => bloque.ver(x,y)})
	
	//Como el ver normal todavia se utiliza para girar, no lo puedo reemplazar para la optimizacion.
	//El verOptimizado se utiliza para bajar bloques, ya que solo se fija los bloques mas bajos por columna de la figura
	method verOptimizado(x,y) = bloquesBajos.all({bloque => bloque.ver(x,y)})
	
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
		if(self.verOptimizado(0, -1)){
			return self.verMasAbajo(-1)
		}else{
			return 0
		}
	}
	
	method verMasAbajo(num){
		if(self.verOptimizado(0, num)){
			return self.verMasAbajo(num-1)
		}else{
			return num+1
		}
	}
	
	method bloqueMasBajo(){
		var bloqueMasBajo = 24
		bloquesActivos.forEach({bloque => 
			if(bloque.fila() < bloqueMasBajo){
				bloqueMasBajo = bloque.fila()
			}
		})	
		return bloqueMasBajo
	}
	
	method girar(){
		const centroX = bloquePrincipal.columna()
		const centroY = bloquePrincipal.fila()
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
		
		//Calculo los bloques bajos durante la rotacion para hacer lo menos posible durante la caida (ya que es uno de los momentos computacionalmente mas pesados)
		self.obtenerBloquesBajos()
	}
	
	//Obtengo las columnas que abarca la figura
	method obtenerColumnas(){
		const columnas = #{}
		bloquesActivos.forEach({bloque =>
			columnas.add(bloque.columna())
		})
		
		return columnas
	}
	
	//Obtengo los bloques mas bajos por cada columna para despues hacer el calculo cuando baja la figura (no es necesario saber si los bloque mas altos colisionan con algo al bajar)
	//Si fuera a agregar bloques convexos no se podria hacer esta optimizacion
	//Ejemplo de un bloque convexo
	// **
	//  *
	// **
	method obtenerBloquesBajos(){
		bloquesBajos = []
		self.obtenerColumnas().forEach({columna =>
			bloquesBajos.add(bloquesActivos.filter({bloque => 
				bloque.columna() == columna
			}).min({bloque =>
				bloque.fila()
			}))
		})
	}
	
	//Se utiliza en la logica principal para una optimizacion de tiro
	method obtenerBloquesAltos(){
		return self.obtenerColumnas().forEach({columna =>
			bloquesBajos.add(bloquesActivos.filter({bloque => 
				bloque.columna() == columna
			}).max({bloque =>
				bloque.fila()
			}))
		})
	}
}

