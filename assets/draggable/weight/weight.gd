extends DragabbleObject


var goodTypes = {
	food = "food", 
	metal = "metal", 
	magical = "magical"
}

var goodType;
var amount;
var weightPerAmount;

func _ready(): 
	
	goodType = goodTypes.keys()[floor(randf()*3)]
	
	#if (goodType == goodTypes.food):
		#$ColorRect.set_color(Color(50, 50, 50))
	#elif (goodType == goodTypes.metal):
		#$ColorRect.set_color(Color(100, 100, 100))
	#elif (goodType == goodTypes.magical):
		#$ColorRect.set_color(Color(0, 0, 0))
		
	amount = floor(randf()*10+1);
	$Sprite.scale = Vector2(1+amount*0.1, 1+amount*0.1)
	$CollisionShape2D.scale = Vector2(1+amount*0.1, 1+amount*0.1)
	#scale = Vector2(1+amount*0.2, 1+amount*0.2)
	weightPerAmount = floor(randf()*3+1);
	mass = amount*weightPerAmount;
	
	$ColorRect/Label.text = str(amount)+"";
	
	
