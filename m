Return-Path: <linux-hyperv+bounces-1570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5B859FA4
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 10:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7B1C20E9F
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0C23750;
	Mon, 19 Feb 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bTgGDrW1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B522F00;
	Mon, 19 Feb 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334664; cv=none; b=YPsyBJuOsSLgSyxod2zRGJ+QNvDnfHeFfRt4sZxP1XSnKkFGNxvNt/nc5eriO62fuB3eNDY/rYOHL2cGevyh9BGLWAiHS4i03h0IgzKdNf0Aw3/b8BoUYXSYgsNMGj3cEiBtj3zFwYOl6KqxywP6b+aXizNxkbXcWe/bVwdiDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334664; c=relaxed/simple;
	bh=sSjbw20SjAKVXRs7ZpPo9sns7MGZx53DmcwdKKB26kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCTf+aKt5GA9PHZWF4RWaRQKrT4z+dyucHUE21SbOiPxaf9w7dFA4JozGZxGSinpK9p2/w23wFrCgmLl0l9S4IvK1iqaE5AZzp4lG3Pgu4YCzPNWFFY6OFTMJF8XvPn1+zTtODIgOqiEGPwP68Qk8/w06wzbB3GYsa9Me2ooWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bTgGDrW1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BED5620B2000; Mon, 19 Feb 2024 01:24:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BED5620B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708334661;
	bh=fnquFv1KCsElJBmDZj/hM1namHS0+WmdD6EKPmP/sAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTgGDrW1KhTHe96Catxi0RBH/cDZ/oUkgVsXuLq4bRXpRi7YdxwTGscHwOkwR9wCM
	 ZC2vx2mD5FZ35A9vbOz6KwqTF6sm1EnXgbwyEO7I+ZHIel9T+UnaRTZFU8fFpswyV1
	 aawZBr/vZ8co3tVbBP5X/uHqqfIwpwEQiJ7aNQpQ=
Date: Mon, 19 Feb 2024 01:24:21 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 5/6] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <20240219092421.GA32526@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-6-git-send-email-ssengar@linux.microsoft.com>
 <2024021908-royal-sequester-84be@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021908-royal-sequester-84be@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 19, 2024 at 09:53:01AM +0100, Greg KH wrote:
> On Sat, Feb 17, 2024 at 10:03:39AM -0800, Saurabh Sengar wrote:
> > New fcopy application which utilizes uio_hv_vmbus_client driver
> 
> What does this "application" do?

I will improve the commit message with more information.

> 
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  tools/hv/Build                 |   3 +-
> >  tools/hv/Makefile              |  10 +-
> >  tools/hv/hv_fcopy_uio_daemon.c | 488 +++++++++++++++++++++++++++++++++
> >  3 files changed, 495 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
> > 
> > diff --git a/tools/hv/Build b/tools/hv/Build
> > index 6cf51fa4b306..7d1f1698069b 100644
> > --- a/tools/hv/Build
> > +++ b/tools/hv/Build
> > @@ -1,3 +1,4 @@
> >  hv_kvp_daemon-y += hv_kvp_daemon.o
> >  hv_vss_daemon-y += hv_vss_daemon.o
> > -hv_fcopy_daemon-y += hv_fcopy_daemon.o
> > +hv_fcopy_uio_daemon-y += hv_fcopy_uio_daemon.o
> > +hv_fcopy_uio_daemon-y += vmbus_bufring.o
> > diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> > index fe770e679ae8..944180cf916e 100644
> > --- a/tools/hv/Makefile
> > +++ b/tools/hv/Makefile
> > @@ -17,7 +17,7 @@ MAKEFLAGS += -r
> >  
> >  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >  
> > -ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> > +ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_uio_daemon
> >  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> >  
> >  ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
> > @@ -39,10 +39,10 @@ $(HV_VSS_DAEMON_IN): FORCE
> >  $(OUTPUT)hv_vss_daemon: $(HV_VSS_DAEMON_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> >  
> > -HV_FCOPY_DAEMON_IN := $(OUTPUT)hv_fcopy_daemon-in.o
> > -$(HV_FCOPY_DAEMON_IN): FORCE
> > -	$(Q)$(MAKE) $(build)=hv_fcopy_daemon
> > -$(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
> > +HV_FCOPY_UIO_DAEMON_IN := $(OUTPUT)hv_fcopy_uio_daemon-in.o
> > +$(HV_FCOPY_UIO_DAEMON_IN): FORCE
> > +	$(Q)$(MAKE) $(build)=hv_fcopy_uio_daemon
> > +$(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> >  
> >  clean:
> > diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
> > new file mode 100644
> > index 000000000000..f72c899328fc
> > --- /dev/null
> > +++ b/tools/hv/hv_fcopy_uio_daemon.c
> > @@ -0,0 +1,488 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * An implementation of host to guest copy functionality for Linux.
> 
> host to guest of what?  I think it's a specific type of host and guest,
> right?

This application is replacement of hv_fcopy_daemon, so copied the exact
comment here. This is specific to Hyper-V host, I can add these details.


> 
> > + *
> > + * Copyright (C) 2023, Microsoft, Inc.
> > + *
> > + * Author : K. Y. Srinivasan <kys@microsoft.com>
> > + * Author : Saurabh Sengar <ssengar@microsoft.com>
> > + *
> > + */
> > +
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <getopt.h>
> > +#include <locale.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <syslog.h>
> > +#include <unistd.h>
> > +#include <wchar.h>
> > +#include <sys/stat.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/limits.h>
> > +#include "vmbus_bufring.h"
> > +
> > +#define ICMSGTYPE_NEGOTIATE	0
> > +#define ICMSGTYPE_FCOPY		7
> > +
> > +#define WIN8_SRV_MAJOR		1
> > +#define WIN8_SRV_MINOR		1
> > +#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
> > +
> > +#define MAX_FOLDER_NAME		15
> > +#define MAX_PATH_LEN		15
> > +#define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
> > +
> > +#define FCOPY_VER_COUNT		1
> > +static const int fcopy_versions[] = {
> > +	WIN8_SRV_VERSION
> > +};
> > +
> > +#define FW_VER_COUNT		1
> > +static const int fw_versions[] = {
> > +	UTIL_FW_VERSION
> > +};
> > +
> > +#define HV_RING_SIZE		(4 * 4096)
> 
> Hey, that doesn't match the kernel driver!  Why these values?

This application talks to device which is recognize as HV_FCOPY
is kernel. In the first patch of current patch series I have
mentioned .pref_ring_size = 0x4000 for HV_FCOPY which matches this.

This code is well tested.


> 
> 
> > +
> > +unsigned char desc[HV_RING_SIZE];
> > +
> > +static int target_fd;
> > +static char target_fname[PATH_MAX];
> > +static unsigned long long filesize;
> > +
> > +static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
> > +{
> > +	int error = HV_E_FAIL;
> > +	char *q, *p;
> > +
> > +	filesize = 0;
> > +	p = (char *)path_name;
> 
> Why the unneeded cast?

This code is existing today as form of hv_fcopy_daemon. As this new
application is replacing hv_fcopy_daemon I reused the same code and
casting.

But, I agree I can improve these.

> 
> > +	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> > +		 (char *)path_name, (char *)file_name);
> 
> Again, why all of the unneeded casts?  This feels very odd, so I've
> stopped reading here, perhaps get an internal review first before
> sending this out again?

This patch has gone through extensive review in past, here is the
reference to the history:

https://lore.kernel.org/lkml/1691132996-11706-4-git-send-email-ssengar@linux.microsoft.com/

I will look for some more internal review and reviewed-by.

- Saurabh

> 
> thanks,
> 
> greg k-h

