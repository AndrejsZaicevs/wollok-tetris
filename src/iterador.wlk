//no se como hacer loops, asi que hago este objeto que con funsiones recursivas arma una lista
//que puedo recorrer con forEach()

object iterador {
	
	var vector = []
	
	method veces(num){
		if(num >= 0){
			vector.add(num)
			self.veces(num - 1)
			return vector
		}else{
			return vector
		}
	}
	
	method iter(num){
		vector = []
		return self.veces(num)
	}
}
