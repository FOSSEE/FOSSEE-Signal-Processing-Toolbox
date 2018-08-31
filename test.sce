exec loader.sce
exec builder.sce

exec test1.sce
exec test2.sce
exec test3.sce

if test1==1
		exit(1)
elseif test2==1
		exit(1)
elseif test3==1
		exit(1)
else
		disp("ALL OK")
		exit()
end


