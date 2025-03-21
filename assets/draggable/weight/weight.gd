extends DragabbleObject

class_name weight

var goodTypes = {
	food = "food", 
	metal = "metal", 
	magical = "magical"
}

var goodType;
var amount;
var weightPerAmount;

func _ready(): 
	
	
	print(goodType)
	#if (goodType == goodTypes.food):
		#$ColorRect.set_color(Color(50, 50, 50))
	#elif (goodType == goodTypes.metal):
		#$ColorRect.set_color(Color(100, 100, 100))
	#elif (goodType == goodTypes.magical):
		#$ColorRect.set_color(Color(0, 0, 0))
		
	#amount = floor(randf()*5+1);
	#weightPerAmount = floor(randf()*3+1);
	#WeightSetUp(amount, weightPerAmount)
	
	

func WeightSetUp(_amount, _weightPerAmount):
	amount = _amount
	weightPerAmount = _weightPerAmount
	goodType = goodTypes.keys()[floor(randf()*2)]
	
	$Sprite.scale = Vector2(1+amount*0.1, 1+amount*0.1)
	$CollisionShape2D.scale = Vector2(1+amount*0.1, 1+amount*0.1)
	mass = floor(amount*weightPerAmount);
	SetUpSprite(goodType)
	
	$Label.text = str(floor(amount))+"";

func SetUpSprite(goodType):
	if (goodType == goodTypes.food):
		$Node2D/WheatSprite2D.show()
		$Node2D/MetalSprite2D.hide()
		$Node2D/RedWheatSprite.hide()
		#$ColorRect.set_color(Color(50, 50, 50))
	elif (goodType == goodTypes.metal):
		$Node2D/MetalSprite2D.show()
		$Node2D/WheatSprite2D.hide()
		$Node2D/RedWheatSprite.hide()
		#$ColorRect.set_color(Color(100, 100, 100))

func OnBuy(SpawnPoint = null):
	print(amount)
	for number in range(amount):
		#var packed_scene = load("res://src/scenes/trade_scene/pickable/FoodToken/FoodToken.tscn")
		#var scene_node = packed_scene.instantiate()
		#print(get_node("/root/Trade/Physics/Spawn_Food"))
		#print(get_node("/root"))
		if (goodType == goodTypes.food):
			var root = get_node("/root/Trade/Physics/Spawn_Food")._on_button_down()
		if (goodType == goodTypes.metal):
			var root = get_node("/root/Trade/Physics/Spawn_Metal")._on_button_down()
			
			
		#root.add_child(scene_node)
		#%"Spawn Food"._on_button_down()
		#$"../Spawn Food"._on_button_down();
	
	
	
