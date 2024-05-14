function Bind(obj,func)
	
	return function (...)
		if(func~=nil and type(func)=="function") then
			func(obj,...)
		end
	end
end

