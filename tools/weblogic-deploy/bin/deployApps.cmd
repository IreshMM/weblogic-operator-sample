@ECHO OFF
@rem **************************************************************************
@rem deployApps.cmd
@rem
@rem Copyright (c) 2017, 2024, Oracle and/or its affiliates.
@rem Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
@rem
@rem     NAME
@rem       deployApps.cmd - WLS Deploy tool to provision apps and resources.
@rem
@rem     DESCRIPTION
@rem       This script configures the base domain, adds resources, and
@rem       deploys applications.
@rem
@rem This script uses the following variables:
@rem
@rem JAVA_HOME             - The location of the JDK to use.  The caller must set
@rem                         this variable to a valid Java 7 (or later) JDK.
@rem
@rem WLSDEPLOY_PROPERTIES  - Extra system properties to pass to WLST.  The caller
@rem                         can use this environment variable to add additional
@rem                         system properties to the WLST environment.
@rem

SETLOCAL

SET WLSDEPLOY_PROGRAM_NAME=deployApps

SET SCRIPT_NAME=%~nx0
SET SCRIPT_ARGS=%*
SET SCRIPT_PATH=%~dp0
FOR %%i IN ("%SCRIPT_PATH%") DO SET SCRIPT_PATH=%%~fsi
IF %SCRIPT_PATH:~-1%==\ SET SCRIPT_PATH=%SCRIPT_PATH:~0,-1%

call "%SCRIPT_PATH%\shared.cmd" :checkArgs %SCRIPT_ARGS%
SET RETURN_CODE=%ERRORLEVEL%
if %RETURN_CODE% NEQ 0 (
  GOTO done
)

@rem required Java version and patch level is dependent on use of encryption.
@rem later versions of JDK 7 support encryption so let WDT figure it out.
SET MIN_JDK_VERSION=7
call "%SCRIPT_PATH%\shared.cmd" :javaSetup %MIN_JDK_VERSION%
SET RETURN_CODE=%ERRORLEVEL%
if %RETURN_CODE% NEQ 0 (
  GOTO done
)

call "%SCRIPT_PATH%\shared.cmd" :runWlst deploy.py
SET RETURN_CODE=%ERRORLEVEL%

:done
set SHOW_USAGE=false
if %RETURN_CODE% == 100 set SHOW_USAGE=true
if %RETURN_CODE% == 99 set SHOW_USAGE=true
if "%SHOW_USAGE%" == "false" (
    GOTO exit_script
)

:usage
ECHO.
ECHO Usage: %SCRIPT_NAME% [-help] [-use_encryption]
ECHO              [-oracle_home ^<oracle_home^>]
ECHO              [-domain_home ^<domain_home^>]
ECHO              -model_file ^<model_file^>
ECHO              [-archive_file ^<archive_file^>]
ECHO              [-variable_file ^<variable_file^>]
ECHO              [-domain_type ^<domain_type^>]
ECHO              [-passphrase_env ^<passphrase_env^>]
ECHO              [-passphrase_file ^<passphrase_file^>]
ECHO              [-passphrase_prompt]
ECHO              [-wlst_path ^<wlst_path^>]
ECHO              [-cancel_changes_if_restart_required]
ECHO              [-discard_current_edit]
ECHO              [-wait_for_edit_lock]
ECHO              [-output_dir ^<output_dir^>]
ECHO              [-admin_url ^<admin_url^>
ECHO               -admin_user ^<admin_user^>
ECHO               -admin_pass_env ^<admin_pass_env^> ^| -admin_pass_file ^<admin_pass_file^>
ECHO               [-remote]
ECHO              ]
ECHO              [-ssh_host ^<ssh_host^>
ECHO               -ssh_port ^<ssh_port^>
ECHO               -ssh_user ^<ssh_user^>
ECHO               -ssh_pass_env ^<ssh_pass_env^> ^| -ssh_pass_file ^<ssh_pass_file^> ^| -ssh_pass_prompt
ECHO               -ssh_private_key ^<ssh_private_key^>
ECHO               -ssh_private_key_pass_env ^<ssh_private_key_pass_env^> ^| -ssh_private_key_pass_file ^<ssh_private_key_pass_file^> ^| -ssh_private_key_pass_prompt
ECHO            ]
ECHO.
ECHO     where:
ECHO         oracle_home     - the existing Oracle Home directory for the domain.
ECHO                           This argument is required unless the ORACLE_HOME
ECHO                           environment variable is set.
ECHO.
ECHO         domain_home     - the domain home directory.  This argument is
ECHO                           required if running in offline mode.
ECHO.
ECHO         model_file      - the location of the model file to use.  This can also
ECHO                           be specified as a comma-separated list of model
ECHO                           locations, where each successive model layers on top
ECHO                           of the previous ones.  This argument is required.
ECHO.
ECHO         archive_file    - the path to the archive file to use.  This can also
ECHO                           be specified as a comma-separated list of archive
ECHO                           files.  The overlapping contents in each archive take
ECHO                           precedence over previous archives in the list.
ECHO.
ECHO         variable_file   - the location of the property file containing the
ECHO                           values for variables used in the model. This can also
ECHO                           be specified as a comma-separated list of property
ECHO                           files, where each successive set of properties layers
ECHO                           on top of the previous ones.
ECHO.
ECHO         domain_type     - the type of domain (e.g., WLS, JRF).
ECHO                           Used to locate wlst.cmd if -wlst_path not specified
ECHO.
ECHO         passphrase_env  - An alternative to entering the encryption passphrase
ECHO                           at a prompt. The value is an ENVIRONMENT VARIABLE
ECHO                           name that WDT will use to retrieve the passphrase.
ECHO.
ECHO         passphrase_file - An alternative to entering the encryption passphrase
ECHO                           at a prompt. The value is the name of a file with a
ECHO                           string value which WDT will read to retrieve the
ECHO                           passphrase.
ECHO.
ECHO         wlst_path       - the Oracle Home subdirectory of the wlst.cmd
ECHO                           script to use (e.g., ^<ORACLE_HOME^>\soa)
ECHO.
ECHO         output_dir      - if specified, files containing restart information
ECHO                           are written to this directory, including
ECHO                           restart.file, non_dynamic_changes.file, and
ECHO                           results.json.
ECHO.
ECHO         admin_url       - the admin server URL (used for online deploy)
ECHO.
ECHO         admin_user      - the admin username (used for online deploy)
ECHO.
ECHO         admin_pass_env  - An alternative to entering the admin password at a
ECHO                           prompt. The value is a ENVIRONMENT VARIABLE name
ECHO                           that WDT will use to retrieve the password.
ECHO.
ECHO         admin_pass_file - An alternative to entering the admin password at a
ECHO                           prompt. The value is a the name of a file with a
ECHO                           string value which WDT will read to retrieve the
ECHO                           password.
ECHO.
ECHO          ssh_host        - the host name for admin server when SSH protocol is used to collect resources
ECHO                            from the admin server host. 
ECHO.
ECHO          ssh_port        - the SSH port number for the admin server host.
ECHO.
ECHO          ssh_user        - the SSH user name for the admin server host.
ECHO.
ECHO          ssh_pass_env    - An alternative to entering the SSH password at the prompt.  The value is specified
ECHO                            in an ENVIRONMENT VARIABLE name that WDT will use to retrieve the password 
ECHO.
ECHO          ssh_pass_file   - An alternative to entering the SSH password at the prompt.  The value is the name of a
ECHO                            file with a string value which WDT will read to retrieve the password. 
ECHO.
ECHO          ssh_pass_prompt - Prompt for the SSH password.
ECHO.
ECHO          ssh_private_key - the private key to use for connecting to the admin server host using SSH.
ECHO.
ECHO          ssh_private_key_pass_env - An alternative to entering the SSH private keystore password at the prompt.
ECHO                                     The value is specified in an ENVIRONMENT VARIABLE name that WDT will use 
ECHO                                     to retrieve the password 
ECHO.
ECHO          ssh_private_key_pass_file - An alternative to entering the SSH private keystore password at the prompt.
ECHO                                      The value is the name of a file with a string value which WDT will read 
ECHO                                      to retrieve the password. 
ECHO.
ECHO          ssh_private_key_pass_prompt - Prompt for the SSH private keystore password.
ECHO.
ECHO    The -cancel_changes_if_restart_required switch tells the program to cancel
ECHO    the changes if the update requires domain restart.
ECHO.
ECHO    The -discard_current_edit switch tells the program to discard all existing
ECHO    changes before starting the update.
ECHO.
ECHO    The -wait_for_edit_lock switch tells the program to skip checking for WLST
ECHO    edit sessions and wait for the WLST edit lock.
ECHO.

:exit_script
IF DEFINED USE_CMD_EXIT (
  EXIT %RETURN_CODE%
) ELSE (
  EXIT /B %RETURN_CODE%
)

ENDLOCAL
