Return-Path: <linux-hyperv+bounces-1569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1687859ED7
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A51F21609
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568D2375A;
	Mon, 19 Feb 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usZaX8Cp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547923757;
	Mon, 19 Feb 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332784; cv=none; b=Q792QOum8P6ym5il6nAzt73mUjWHoQIY/HIv49P0lqx0MJmpKnD0b5pjdd3VHNuKfNBjl3RV59RJ0Tm0DI7ucKgIuP5n1hvOpEzkREpfOuT24IeAv33tA9TQYgA6Fe6pimyt3iA8+Ol47ek3N2P1cWl2nRsqm6cUIm4AaFL1tWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332784; c=relaxed/simple;
	bh=SDQufJ9z5aiPeuINsDKd9XXb7cmghsbeEma5FC1MrU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPGQ1FpmwXDbGcewRZYES2/qI8M899vNE/0qoXKeAtY8RPq2u4CEB8TjRg+UdIIN4aYBUAn75+QV2z+x3ARIEnTfOxPQkGqiNNBDI/NQr2dAv8cw+7q7QvrKF8s2ckQtPsZfMGOz5f15PBw04IMYQ5TVTl9TRreDs/FSPmWZ/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usZaX8Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5DCC433F1;
	Mon, 19 Feb 2024 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332784;
	bh=SDQufJ9z5aiPeuINsDKd9XXb7cmghsbeEma5FC1MrU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usZaX8CpwwzXVWtYNNvZz3zqkH5sbHb5Q7ImfBBj7c1ILt/jj38fmd5torqaemTBL
	 9rAKxRPStF6bWaiosQc/XDTT9TzgBf5ysirRQs0iWAn8jXS0F1YWJ0xSJ+pmLu3Oft
	 rHhjXwdWv+orYqpGX5ark3KBTkECiXpiuq02aE7w=
Date: Mon, 19 Feb 2024 09:53:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <2024021908-royal-sequester-84be@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>

On Sat, Feb 17, 2024 at 10:03:39AM -0800, Saurabh Sengar wrote:
> New fcopy application which utilizes uio_hv_vmbus_client driver

What does this "application" do?

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  tools/hv/Build                 |   3 +-
>  tools/hv/Makefile              |  10 +-
>  tools/hv/hv_fcopy_uio_daemon.c | 488 +++++++++++++++++++++++++++++++++
>  3 files changed, 495 insertions(+), 6 deletions(-)
>  create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
> 
> diff --git a/tools/hv/Build b/tools/hv/Build
> index 6cf51fa4b306..7d1f1698069b 100644
> --- a/tools/hv/Build
> +++ b/tools/hv/Build
> @@ -1,3 +1,4 @@
>  hv_kvp_daemon-y += hv_kvp_daemon.o
>  hv_vss_daemon-y += hv_vss_daemon.o
> -hv_fcopy_daemon-y += hv_fcopy_daemon.o
> +hv_fcopy_uio_daemon-y += hv_fcopy_uio_daemon.o
> +hv_fcopy_uio_daemon-y += vmbus_bufring.o
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index fe770e679ae8..944180cf916e 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -17,7 +17,7 @@ MAKEFLAGS += -r
>  
>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>  
> -ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> +ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_uio_daemon
>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
>  ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
> @@ -39,10 +39,10 @@ $(HV_VSS_DAEMON_IN): FORCE
>  $(OUTPUT)hv_vss_daemon: $(HV_VSS_DAEMON_IN)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
>  
> -HV_FCOPY_DAEMON_IN := $(OUTPUT)hv_fcopy_daemon-in.o
> -$(HV_FCOPY_DAEMON_IN): FORCE
> -	$(Q)$(MAKE) $(build)=hv_fcopy_daemon
> -$(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
> +HV_FCOPY_UIO_DAEMON_IN := $(OUTPUT)hv_fcopy_uio_daemon-in.o
> +$(HV_FCOPY_UIO_DAEMON_IN): FORCE
> +	$(Q)$(MAKE) $(build)=hv_fcopy_uio_daemon
> +$(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
>  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
>  
>  clean:
> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> new file mode 100644
> index 000000000000..f72c899328fc
> --- /dev/null
> +++ b/tools/hv/hv_fcopy_uio_daemon.c
> @@ -0,0 +1,488 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * An implementation of host to guest copy functionality for Linux.

host to guest of what?  I think it's a specific type of host and guest,
right?

> + *
> + * Copyright (C) 2023, Microsoft, Inc.
> + *
> + * Author : K. Y. Srinivasan <kys@microsoft.com>
> + * Author : Saurabh Sengar <ssengar@microsoft.com>
> + *
> + */
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <locale.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syslog.h>
> +#include <unistd.h>
> +#include <wchar.h>
> +#include <sys/stat.h>
> +#include <linux/hyperv.h>
> +#include <linux/limits.h>
> +#include "vmbus_bufring.h"
> +
> +#define ICMSGTYPE_NEGOTIATE	0
> +#define ICMSGTYPE_FCOPY		7
> +
> +#define WIN8_SRV_MAJOR		1
> +#define WIN8_SRV_MINOR		1
> +#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
> +
> +#define MAX_FOLDER_NAME		15
> +#define MAX_PATH_LEN		15
> +#define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
> +
> +#define FCOPY_VER_COUNT		1
> +static const int fcopy_versions[] = {
> +	WIN8_SRV_VERSION
> +};
> +
> +#define FW_VER_COUNT		1
> +static const int fw_versions[] = {
> +	UTIL_FW_VERSION
> +};
> +
> +#define HV_RING_SIZE		(4 * 4096)

Hey, that doesn't match the kernel driver!  Why these values?


> +
> +unsigned char desc[HV_RING_SIZE];
> +
> +static int target_fd;
> +static char target_fname[PATH_MAX];
> +static unsigned long long filesize;
> +
> +static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
> +{
> +	int error = HV_E_FAIL;
> +	char *q, *p;
> +
> +	filesize = 0;
> +	p = (char *)path_name;

Why the unneeded cast?

> +	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> +		 (char *)path_name, (char *)file_name);

Again, why all of the unneeded casts?  This feels very odd, so I've
stopped reading here, perhaps get an internal review first before
sending this out again?

thanks,

greg k-h

