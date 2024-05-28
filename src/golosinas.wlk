//sabores
object frutilla {}
object chocolate {}
object vainilla {}
object naranja {}
object limon {}
object heladera{
	var property humedad
}

//golosinas
class Bombon {
	var peso = 15
	
	method precio() = 5
	method peso() = peso
	method mordisco(){peso = peso * 0.8 - 1}
	method sabor() = frutilla
	method libreGluten() = true
	//
	method esBaniada() = false
}

class Alfajor {
	var peso = 15
	
	method precio() = 12
	method peso() = peso
	method mordisco() {peso = peso * 0.8}
	method sabor() = chocolate
	method libreGluten() = false
	//
	method esBaniada() = false
}

class Caramelo {
	var peso = 5
	var property sabor

	method precio() = 12
	method peso() = peso
	method mordisco() {peso = peso - 1}
	//method sabor() = frutilla
	method libreGluten() = true
	//
	method esBaniada() = false
}

class Chupetin {
	var peso = 7
	
	method precio() = 2
	method peso() = peso
	method mordisco(){if (peso >= 2){peso = peso * 0.9}}
	method sabor() = naranja
	method libreGluten() = true
	//
	method esBaniada() = false
}

class Oblea {
	var peso = 250
	
	method precio() = 5
	method peso() = peso
	method mordisco() {
		if (peso >= 70) {
			peso = peso * 0.5
		} else { 
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() = vainilla
	method libreGluten() = false
	//
	method esBaniada() = false
}

class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso){ pesoInicial = unPeso }
	method precio() = pesoInicial * 0.50 
	method peso() = (pesoInicial - comido).max(0)
	method mordisco() { comido = comido + 2 }
	method sabor() = chocolate
	method libreGluten() = false
	//
	method esBaniada() = false
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() = golosinaInterior.precio() + 2 
	method peso() = golosinaInterior.peso() + pesoBanio 
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() = golosinaInterior.sabor()
	method libreGluten() = golosinaInterior.libreGluten()
	//
	method esBaniada() = true
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco(){ saborActual += 1 }	
	method sabor() = sabores.get(saborActual % 3)

	method precio() = if(self.libreGluten()) 7 else 10
	method peso() = 5 
	method libreGluten() = libreDeGluten	
	method libreGluten(valor){ libreDeGluten = valor }
	//
	method esBaniada() = false
}

// más golosinas

class BombonesDuros inherits Bombon{
	override method mordisco(){peso -=1}
	method dureza() = if(peso > 12) 3 else if(peso.between(8, 12)) 2 else 1 
}

class CarameloConCorazonDeChocolate inherits Caramelo{
	override method mordisco(){
		super()
		self.sabor(chocolate)
	}
	override method precio() = super()+1
}

class ObleaCrujiente inherits Oblea{
	var comido = 0
	override method mordisco(){
		super()
		comido += 1
	}
	method estaDebil() = comido>3
	override method peso() = super() - if(comido < 4) 3 else 0
}

class ChocolatinVIP inherits Chocolatin{
	override method peso() = super() * (1+self.humedadHeladera())
	method humedadHeladera() = heladera.humedad()
}

class ChocolatinPremiun inherits ChocolatinVIP{
	override method peso() = super() * (1+(self.humedadHeladera()/2))
}