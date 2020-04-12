import wollok.game.*
import clases.*
import figuras.*

object iniciador {
	const paredes = []
	method crearParedes(){
		
		//Inicio paredes del campo de juego
		 (0 .. 23).forEach({i => 
		 	paredes.add(new Bloque(position = game.at(0,i), activo = false))
		 	paredes.add(new Bloque(position = game.at(11,i), activo = false))
		 	//Genera paredes fuera del area visible pero Yao
		 	paredes.add(new Bloque(position = game.at(i,0), activo = false))
		 })	 
	}
	
	method dibujarParedes(){
		paredes.forEach({pared => game.addVisual(pared)})
		
		game.getObjectsIn(game.at(14,20)).forEach({pared =>
			pared.image("puntos.png")
		})
	}	
}

object logicaPrincipal {
	
	var figura //Guarda la abstraccion de la figura activa
	var ultimoTiro = 0 //Distancia de la cual se tiro una pieza por ultima vez
	var velocidad = 0 //Velocidad actual del juego
	var alturaMax = 1 //Altura del bloque mas alto
	var derrota = false
	
	//Inicia la logica
	method iniciar(){
		//Objeto iniciador dibuja las paredes necesarias
		iniciador.crearParedes()
		iniciador.dibujarParedes()
		//Objeto figura es la abtraccion de los bloques activos
		figura = new Figura()
		figura.instanciar(figuras.randomFigura())
		game.onTick(750, "bajar figura",{
			self.bajarFigura()
		})
		self.iniciarControles()
	}
	
	//Desactiva la figura cuando cae
	method desactivarFigura(){
		//obtengo las filas que abarca la pieza
		var filas = figura.filasActivas()		
		figura.desactivar()
		
		//veo si hace falta modifica el bloque mas alto, lo hago por cada fila involucrada
		
		filas.forEach({fila => 
			if(fila > alturaMax){
				alturaMax = fila
			}	
		})
		
		//me fijo que filas de las que abarcaba la pieza tengo que eliminar
		self.eliminarFilas(filas)
		//siempre que se desactivo una figura debe activarse otra
		self.nuevaFigura()
	}
	
	//Metodo que se fija que filas fueron afectadas cuando cae una pieza, y borra las que sea necesario borrar. Despues invoca reacomodarFilas para bajar las que esten arriba
	method eliminarFilas(filas){
		
		//me guardo que filas tengo que eliminar
		var filasEliminadas = []
		filas.forEach({fila =>	
			//por cada fila potencial me fijo si la tengo que eliminar
			var eliminar = true
			(1 .. 11).forEach({i =>
				//me fijo que cada casillero tenga algo
				if(game.getObjectsIn(game.at(i, fila)).isEmpty()){
					//hay por lo menos un casillero vacio, no elimino
					eliminar = false
				}
			})
			if(eliminar){
				filasEliminadas.add(fila)
				(1 .. 10).forEach({i =>
					//elimino los bloques
					game.getObjectsIn(game.at(i, fila)).forEach({bloque =>
						bloque.eliminar()
					})		
				})
			}
		})	
		
		// necesito bajar las filas de arriba
		if(filasEliminadas.size() > 0){
			self.reacomodarFilas(filasEliminadas)
		}	
		
		// sumo los puntos
		puntuaje.sumarPuntos(ultimoTiro, velocidad, filasEliminadas.size())
	}

	method reacomodarFilas(filasAEliminar){
		var bias = 1
		var size = filasAEliminar.size()
		//Empiezo desde filaElim (que es la fila mas baja a eliminar), la saco afuera del forEach porque no la puedo sacar una vez adentro
		var filaElim = filasAEliminar.min()
		filasAEliminar.remove(filasAEliminar.min())
		//Me fijo todas las filas desde la fila a reubicar mas baja + 1 hasta la fila mas alta
		(filaElim + 1 .. alturaMax).forEach({fila =>
			
			if(filasAEliminar.size() > 0){
				var filaElim = filasAEliminar.min()
			}
			
			if(filaElim == fila){
				//Si la fila minima que queda dentro de "filasAEliminar" es en la que estoy parado, la saco de filasAEliminar y sumo 1 al bias
				bias += 1
				filasAEliminar.remove(filasAEliminar.min())
			}else{
				//console.println("Reubico fila " + fila + "con un bias de " + bias)
				//Si la fila no es la misma, tengo que reubicar, y la reubico por el bias (si saltee 1 fila, lo muevo 1 abajo, si saltee 3, muevo 3 abajo)
				(1 .. 10).forEach({columna =>
					game.getObjectsIn(game.at(columna, fila)).forEach({bloque =>
						bloque.mover(0, -bias)
					})
				})
			}
				
			//Reubico, si es una fila eliminada no reubico ya que no hay nada para reubicar, sumo 1 al bias y voy a la siguiente fila
			
		})
		
		alturaMax -= size
	}
	
	//Metodo que instancia una nueva figura
	method nuevaFigura(){
		if(!derrota){
			figura = new Figura()
			figura.instanciar(figuras.randomFigura())
			
					
			//accelero el juego
			velocidad += 5
			game.removeTickEvent("bajar figura")
			game.onTick(750 - velocidad, "bajar figura",{
				self.bajarFigura()
			})
		}
	}
	
	//Metodo que se invoca por tick de "bajar figura"
	method bajarFigura(){
		if(figura.ver(0, -1)){
			figura.mover(0, -1)
		}else{
			self.desactivarFigura()
		}
	}
	
	//Inicia los controles de la figura
	method iniciarControles(){
		keyboard.left().onPressDo {
			if(figura.ver(-1, 0)){
				figura.mover(-1, 0)
			}
		}
		
		keyboard.right().onPressDo {
			if(figura.ver(1, 0)){
				figura.mover(1, 0)
			}
		}
		
		keyboard.up().onPressDo{
			figura.girar()
		}
		
		keyboard.down().onPressDo{
			figura.mover(0, -(figura.bloqueMasBajo() - alturaMax) + 1)
			ultimoTiro = figura.encontrarFondo()
			figura.mover(0, ultimoTiro)
			self.desactivarFigura()	
		}
	}
	
	//Metodo que se invoca cuando la nueva pieza que entra se superpone con un bloque ya existente
	method derrota(){
		derrota = true
		game.removeTickEvent("bajar figura")
	}
}


object puntuaje{
	var puntos = 0
	
	method sumarPuntos(ultimoTiro, velocidad, lineasEliminadas){
		puntos += (ultimoTiro.abs() + velocidad) * (lineasEliminadas + 1)
		//console.println(puntos)
	}
}