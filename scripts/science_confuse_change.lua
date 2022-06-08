function Science_Confuse:GetSkillEffect(p1,p2) -- Override
  local ret = SkillEffect()
  -- Get the direction and path the Confuse Shot projectile goes in
  local direction = GetDirection(p2 - p1)
  local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
  
  local doMagic = false -- Half (90 degrees) flip
  
  -- Setup the "damage"
  local damage = SpaceDamage(target, self.Damage)
  if self.Flip == 1 then
    if Board:IsPawnSpace(target) then  -- Check if target is a pawn
      local pawn = Board:GetPawn(target) 
      if pawn:GetType() == "FireflyBoss" then
        doMagic = true
      end
    end
    if doMagic == false then
      damage = SpaceDamage(target,self.Damage,DIR_FLIP)
    end
  end
  
  if doMagic then
    local pawn = Board:GetPawn(target) 
    
    if pawn:GetType() == "FireflyBoss" then
      -- The magic
      ret:AddScript([[
      local cutils = _G["cutils-dll"]
      local pawn = Board:GetPawn(]]..target:GetString()..[[)
      local pawnTarget = Point(
          cutils.Pawn.GetQueuedTargetX(pawn),
          cutils.Pawn.GetQueuedTargetY(pawn)
      )
      local loc = pawn:GetSpace()
      local dir = (GetDirection(pawnTarget - loc) + 1) % 4
      local dist = loc:Manhattan(pawnTarget)

      pawnTarget = loc + DIR_VECTORS[dir] * dist

      cutils.Pawn.SetQueuedTargetX(pawn, pawnTarget.x)
      cutils.Pawn.SetQueuedTargetY(pawn, pawnTarget.y)
      ]])
    end
  end

  ret:AddProjectile(damage, self.ProjectileArt, NO_DELAY)

  return ret
end
