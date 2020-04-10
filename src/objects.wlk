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
	var alturaMax = 0 //Altura del bloque mas alto
	
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
		self.reacomodarFilas(filasEliminadas)
		
		// sumo los puntos
		puntuaje.sumarPuntos(ultimoTiro, velocidad, filasEliminadas.size())
	}
	
	//Reacomodar filas, pendiente optimizar
	method reacomodarFilas(filasAEliminar){
		var bias = -1
		filasAEliminar.forEach({filaAEliminar =>			
			bias += 1
			//por cada que se elimino tengo que realizar un movimiento a cada bloque que se encuentre arriba
			(1 .. 10).forEach({columna =>
				//Me fijo de reacomodar solamente desde la fila que se elimino, hasta la altura maxima que tienen los bloques
				//No empiezo de la fila a eliminar porque se elimino
				(filaAEliminar + 1 .. alturaMax).forEach({fila => 
					game.getObjectsIn(game.at(columna, fila - bias)).forEach({bloque =>
						bloque.mover(0, -1)
					})
				})
			})
		})
		alturaMax -= filasAEliminar.size()
	}
	
	//Metodo que instancia una nueva figura
	method nuevaFigura(){
		
		figura = new Figura()
		figura.instanciar(figuras.randomFigura())
	}
	
	//Metodo que se invoca por tick de "bajar figura"
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
			ultimoTiro = figura.encontrarFondo()
			figura.mover(0, ultimoTiro)
			self.desactivarFigura()
			
		}
	}
	
	//No funciona correctamente TODO
	method pararControles(){
		keyboard.left().onPressDo {}		
		keyboard.right().onPressDo {}		
		keyboard.up().onPressDo{}		
		keyboard.down().onPressDo{}
	}
	
	//Metodo que se invoca cuando la nueva pieza que entra se superpone con un bloque ya existente
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