ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:Draw()

	local owner = self:GetOwner()

	if !self:IsValid() || !IsValid(owner) then return end

	self:SetPos( owner:GetPos() )

	local propAngle = owner:EyeAngles()
	-- snap to 45 degree increments on yaw and pitch


		-- angle snapping stuff
		if( owner.wantAngleSnap ) then
			propAngle:SnapTo("p",45):SnapTo("y",45)
		end

		-- angle locking stuff
		if( !owner.wantAngleLock ) then
			self:SetAngles(propAngle)
			self.lockedAngle = propAngle
		else
			self:SetAngles(owner.lockedAngle)
		end

	if( CLIENT ) then
		-- third person stuff
		if( LocalPlayer().wantThirdPerson || self:GetOwner() != LocalPlayer() ) then
			self:DrawModel()
		end
	end
end

function ENT:Think()
	self:Draw()
end
