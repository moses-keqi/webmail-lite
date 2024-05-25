<?php
include_once '/var/www/html/system/autoload.php';
\Aurora\System\Api::Init(true);

$oSettings = \Aurora\System\Api::GetSettings();
if ($oSettings)
{
	$oSettings->SetConf('DBHost', 'mysql:3306');
	$oSettings->SetConf('DBName', 'afterlogic');
	$oSettings->SetConf('DBLogin', 'root');
	$oSettings->SetConf('DBPassword', 'xLnHamLbN9RD');
	$oSettings->Save();

	\Aurora\System\Api::GetModuleManager()->SyncModulesConfigs();
}