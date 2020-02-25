function hasCollided = check_collisions(obj1, obj2)
distance = sqrt((obj1.position(1) - obj2.position(1))^2 + (obj1.position(2) - obj2.position(2))^2);
if distance < obj1.radius + obj2.radius
    hasCollided = true;
else
    hasCollided = false;
end
end