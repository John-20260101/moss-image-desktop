on run
	-- 壳内嵌应用路径
	set appPath to POSIX path of (path to me)
	if appPath ends with "/" then set appPath to text 1 thru -2 of appPath
	set innerApp to appPath & "/Contents/Resources/MOSS-Image-Cai Web.app"

	-- 交给带日志的 shell 启动器处理服务（bootstrap + kickstart + 等待就绪）
	try
		do shell script "/Users/johnsmacbook/MOSS-Image/launcher.sh"
	on error errMsg
		-- 服务启动失败也仍然打开窗口，页面会自行提示连接失败
	end try

	do shell script "open " & quoted form of innerApp
end run
