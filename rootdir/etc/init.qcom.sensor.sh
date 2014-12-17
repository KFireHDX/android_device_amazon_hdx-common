#!/system/bin/sh
# Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
# Function to start sensors for DSPS enabled platforms
#
start_sensors()
{
    if [ -c /dev/msm_dsps -o -c /dev/sensors ]; then
        mkdir -p /data/system/sensors
        touch /data/system/sensors/settings
        chmod 775 /data/system/sensors
        chmod 664 /data/system/sensors/settings
        chown system /data/system/sensors/settings

        mkdir -p /data/misc/sensors
        chmod 775 /data/misc/sensors

        if [ ! -s /data/system/sensors/settings ]; then
            # If the settings file is empty, enable sensors HAL
            # Otherwise leave the file with it's current contents
            echo 1 > /data/system/sensors/settings
        fi
	bootmode=`cat /proc/idme/bootmode`
	board_id=`cat /proc/idme/board_id`
	case $board_id in 80*) class=80;; *) class=0;; esac
	if [ "$class" != 80 -o "$bootmode" != 2 ]; then
            start sensors
        fi
    fi
}

start_sensors
