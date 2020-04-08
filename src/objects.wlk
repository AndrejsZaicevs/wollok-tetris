import wollok.game.*
import clases.*
import figuras.*

object iniciador {
	const paredes = []
	method crearParedes(){
		
		//Inicio paredes del campo de juego
		 (0 .. 23).forEach({i => 
		 	paredes.add(new Pared(position = game.at(0,i)))
		 	paredes.add(new Pared(position = game.at(11,i)))
		 	//Genera paredes fuera del area visible pero Yao
		 	paredes.add(new Pared(position = game.at(i,0)))
		 })
		 
		 //Inicio paredes de la derecha
		 (0 .. 10).forEach({x =>
		 	(0 .. 23).forEach({y =>
		 		paredes.add(new Pared(position = game.at(x+12, y)))
		 	})
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
	
	var figura
	var ultimoTiro = 0
	var velocidad = 0
	
	method iniciar(){
		iniciador.crearParedes()
		iniciador.dibujarParedes()
		figura = new Figura()
		figura.instanciar(figuras.randomFigura())
		game.onTick(750, "bajar figura",{
			self.bajarFigura()
		})
		self.iniciarControles()
	}
	
	method desactivarFigura(){
		//obtengo las filas que abarca la pieza
		var filas = figura.filasActivas()		
		figura.desactivar()
		
		//me fijo que filas de las que abarcaba la pieza tengo que eliminar
		self.eliminarFilas(filas)
		//siempre que se desactivo una figura debe activarse otra
		self.nuevaFigura()
	}
	
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
				//si llego aca es porque tengo filas a eliminar
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
		self.reacomodarFilas(filasEliminadas)
		// sumo los puntos
		puntuaje.sumarPuntos(ultimoTiro, velocidad, filasEliminadas.size())
	}
	
	method reacomodarFilas(filasAEliminar){
		var bias = -1
		filasAEliminar.forEach({filaAEliminar =>
			bias += 1
			//por cada que se elimino tengo que realizar un movimiento a cada bloque que se encuentre arriba
			(1 .. 10).forEach({columna =>
				(filaAEliminar .. 23).forEach({fila => 
					game.getObjectsIn(game.at(columna, fila - bias)).forEach({bloque =>
						bloque.mover(0, -1)
					})
				})
			})
		})
	}
	
	method nuevaFigura(){
		
		figura = new Figura()
		figura.instanciar(figuras.randomFigura())
	}
	
	method bajarFigura(){
		if(figura.ver(0, -1)){
			figura.mover(0, -1)
		}else{
			self.desactivarFigura()
		}
		
		//accelero el juego
		velocidad += 1
		game.removeTickEvent("bajar figura")
		game.onTick(750 - velocidad, "bajar figura",{
			self.bajarFigura()
		})
	}
	
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
			ultimoTiro = figura.encontrarFondo()
			figura.mover(0, ultimoTiro)
			self.desactivarFigura()
			
		}
	}
	
	method pararControles(){
		keyboard.left().onPressDo {}		
		keyboard.right().onPressDo {}		
		keyboard.up().onPressDo{}		
		keyboard.down().onPressDo{}
	}
	
	method derrota(){
		game.removeTickEvent("bajar figura")
		self.pararControles()
	}
}


object puntuaje{
	var puntos = 0
	
	method sumarPuntos(ultimoTiro, velocidad, lineasEliminadas){
		puntos += (ultimoTiro.abs() + velocidad) * (lineasEliminadas + 1)
		console.println(puntos)
	}
}