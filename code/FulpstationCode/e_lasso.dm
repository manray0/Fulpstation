/obj/projectile/etether
	name = "e-tether"
	icon_state = "engineering"
	icon = 'icons/Fulpicons/fulp_medals.dmi'
	stamina = 20
	damage_type = STAMINA
	flag = "energy"
	hitsound = 'sound/effects/splat.ogg'
	var/chain
	var/knockdown_time = (0.5 SECONDS)

/obj/projectile/energy/etether(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "engineering", time = INFINITY, maxdistance = INFINITY)
	..()

/obj/projectile/energy/etether/on_hit(atom/target)
	. = ..()
	if(ismovable(target))
		var/atom/movable/A = target
		if(A.anchored)
			return
		A.visible_message("<span class='danger'>[A] is roped up by [firer]'s lasso!</span>")
		new /datum/forced_movement(A, get_turf(firer), 5, TRUE)
		if (isliving(target))
			var/mob/living/fresh_meat = target
			fresh_meat.Knockdown(knockdown_time)
			return

/obj/projectile/energy/etether/Destroy()
	qdel(chain)
	return ..()
