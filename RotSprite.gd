extends Node2D
var _sprite = preload("res://Items/IceSword.png")
var image : Image = _sprite.get_data()
var texture
var texture2
var rot = 1
var rot2
func _ready():
	
	texture = ImageTexture.new()
	#image = scale2x(image)
	#image = downscale2x(image)
	#image = nearest_neighbor(90, image)
	#texture.create_from_image(image, 0)
	#$Sprite.set_texture(texture)
	
func _process(delta):
	rot = $Sprite.get_local_mouse_position().angle() 
	texture = ImageTexture.new()
	texture2 = ImageTexture.new()
	var n_image = scale2x(image)
	n_image = scale2x(n_image)
	n_image = scale2x(n_image)
	n_image = nearest_neighbor(rot, n_image)
	n_image = downscale2x(n_image)
	n_image = downscale2x(n_image)
	n_image = downscale2x(n_image)
	var n_image2 = nearest_neighbor(rot, image)
	texture.create_from_image(n_image, 0)
	texture2.create_from_image(n_image2, 0)
	$Sprite.set_texture(texture)
	$Sprite2.set_texture(texture2)
	
func scale2x_(myimage):
	var newImage = Image.new()
	newImage.create(myimage.get_width() * 2, myimage.get_height() * 2, true, Image.FORMAT_BPTC_RGBA)
	
	newImage.decompress()
	newImage.lock()
	myimage.lock()
	for x in range (1, myimage.get_width()-1):
		for y in range (1, myimage.get_height()-1):
			var A = myimage.get_pixel(x, y-1)
			var B = myimage.get_pixel(x+1, y)
			var C = myimage.get_pixel(x-1, y)
			var D = myimage.get_pixel(x, y+1)
			var nA = myimage.get_pixel(x, y); var nB = myimage.get_pixel(x, y); var nC = myimage.get_pixel(x, y); var nD = myimage.get_pixel(x, y)
			
			if C==A and C!=D and A!=B:
				 nA=A
			if A==B and A!=C and B!=D:
				 nB=B
			if D==C and D!=B and C!=A:
				nC=C
			if B==D and B!=A and D!=C:
				nD=D
			newImage.set_pixel(2*(x-1)+1, 2*(y-1)+1, nA)
			newImage.set_pixel(2*(x-1)+2, 2*(y-1)+1, nB)
			newImage.set_pixel(2*(x-1)+1, 2*(y-1)+2, nC)
			newImage.set_pixel(2*(x-1)+2, 2*(y-1)+2, nD)
	return newImage

func scale2x(myimage):
	var newImage = Image.new()
	newImage.create(myimage.get_width() * 2, myimage.get_height() * 2, true, Image.FORMAT_BPTC_RGBA)
	newImage.decompress()
	newImage.lock()
	myimage.lock()
	for x in range (myimage.get_width()):
		for y in range (myimage.get_height()):
			newImage.set_pixel(2*x, 2*y, myimage.get_pixel(x, y))
			newImage.set_pixel(2*x+1, 2*y, myimage.get_pixel(x, y))
			newImage.set_pixel(2*x+1, 2*y+1, myimage.get_pixel(x, y))
			newImage.set_pixel(2*x, 2*y+1, myimage.get_pixel(x, y))
			
	return newImage
	
func downscale2x(myimage):
	var newImage = Image.new()
	newImage.create(myimage.get_width() / 2, myimage.get_height() / 2, true, Image.FORMAT_BPTC_RGBA)
	newImage.decompress()
	newImage.lock()
	myimage.lock()
	for x in range (newImage.get_width()):
		for y in range (newImage.get_height()):
			newImage.set_pixel(x, y, myimage.get_pixel(2*x, 2*y))
			
	return newImage
	
	
func nearest_neighbor(ang_rot, myimage):
	var newImage = Image.new()
	newImage.create(myimage.get_height() * sqrt(2), myimage.get_height() * sqrt(2), true, Image.FORMAT_BPTC_RGBA)
	newImage.decompress()
	newImage.lock()
	myimage.lock()
	var centreX = myimage.get_width()/2
	var centreY = myimage.get_height()/2
	for x in range (myimage.get_width() * sqrt(2)):
		for y in range (myimage.get_height() * sqrt(2)):
			var dir = Vector2(x - centreX, y - centreY).angle()
			var mag = Vector2(x - centreX, y - centreY).length()
			
			dir-= ang_rot
			
			var origX = centreX + mag * cos(dir)
			var origY = centreY + mag * sin(dir)
			if (origX >= 0 and origX <= myimage.get_width() and origY >= 0 and origY <= myimage.get_height()):
				newImage.set_pixel(x, y, myimage.get_pixel(origX, origY))
	newImage.unlock()
	#newImage.shrink_x2()
	return newImage
