exec loader.sce
exec builder.sce

exec('test1.sce',-1)
exec('test2.sce',-1)
exec('test3.sce',-1)
exec('test4.sce',-1)

if test1==1
		exit(1)
elseif test2==1
		exit(1)
elseif test3==1
		exit(1)
elseif test4==1
		exit(1)
else
		disp("ALL OK")
		exit()
end


