Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351383C89AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNRZ7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhGNRZ7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 13:25:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69877613B5;
        Wed, 14 Jul 2021 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626283386;
        bh=a4RmxSst2iAvfD+fRuC5inYX86CvpXntYp8kuy6Kfjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwR9/wgVtF8w0FtR7bO14PUbHS8f4TRJdz9MTRQrIYXUYECi/uRgw5+bAQHupOBJg
         Yj1TEPhlDi2W+UpyI5/ECIym2X08k7QYg3tH3dUmL6vgeSy8u+5V21k2LQOO0PFoul
         tvMbvwT5rLweAsjwuA6+IOSUW0HYr55b+/0GiOu8=
Date:   Wed, 14 Jul 2021 19:23:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YO8deHGP7GBYQp5x@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Azure Blob storage provides scalable and durable data storage for Azure.
> (https://azure.microsoft.com/en-us/services/storage/blobs/)
> 
> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and secure direct data link for storage server access.

So it goes around the block layer?  Why?

> This driver will be ported to FreeBSD. It's dual licensed for BSD and GPL.

Being the copyright holder, you are free to relicense this code to any
other license you want to.  So why is this single HV driver different
from all the other ones in this regard when it comes to the license?

Given that this driver only works when talking to GPL-only symbols in
the kernel, how could it be ported to freebsd as-is by anyone who is not
the copyright holder?

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andra Paraschiv <andraprs@amazon.com>
> Cc: Siddharth Gupta <sidgup@codeaurora.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
>  drivers/hv/Kconfig                                 |  10 +
>  drivers/hv/Makefile                                |   1 +
>  drivers/hv/azure_blob.c                            | 625 +++++++++++++++++++++
>  drivers/hv/channel_mgmt.c                          |   7 +
>  include/linux/hyperv.h                             |   9 +
>  include/uapi/misc/azure_blob.h                     |  34 ++
>  7 files changed, 688 insertions(+)
>  create mode 100644 drivers/hv/azure_blob.c
>  create mode 100644 include/uapi/misc/azure_blob.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 9bfc2b5..d3c2a90 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -180,6 +180,8 @@ Code  Seq#    Include File                                           Comments
>  'R'   01     linux/rfkill.h                                          conflict!
>  'R'   C0-DF  net/bluetooth/rfcomm.h
>  'R'   E0     uapi/linux/fsl_mc.h
> +'R'   F0-FF  uapi/misc/azure_blob.h                                  Microsoft Azure Blob driver
> +                                                                     <mailto:longli@microsoft.com>
>  'S'   all    linux/cdrom.h                                           conflict!
>  'S'   80-81  scsi/scsi_ioctl.h                                       conflict!
>  'S'   82-FF  scsi/scsi.h                                             conflict!
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d..e08b8d3 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,14 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_AZURE_BLOB
> +	tristate "Microsoft Azure Blob driver"
> +	depends on HYPERV && X86_64
> +	help
> +	  Select this option to enable Microsoft Azure Blob driver.
> +
> +	  This driver supports accelerated Microsoft Azure Blob access.

No definition of what this is?

> +	  To compile this driver as a module, choose M here. The module will be
> +	  called azure_blob.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 94daf82..a322575 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
> +obj-$(CONFIG_HYPERV_AZURE_BLOB)	+= azure_blob.o

Your naming scheme is different from the other hv modules, why?

>  
>  CFLAGS_hv_trace.o = -I$(src)
>  CFLAGS_hv_balloon.o = -I$(src)
> diff --git a/drivers/hv/azure_blob.c b/drivers/hv/azure_blob.c
> new file mode 100644
> index 0000000..5367d5e
> --- /dev/null
> +++ b/drivers/hv/azure_blob.c
> @@ -0,0 +1,625 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH Linux-syscall-note

.c files can NOT have the syscall note license, as that makes no sense
at all.

I'm stopping here.  Please go run this through your legal department and
get them to sign off on this as it does not seem that you all understand
the issues when it comes to licenses and the Linux kernel at all.  I
want to see a lawyer sign off on this patch next time if you all want to
attempt something crazy like this.

> +/* Copyright (c) Microsoft Corporation. */

You forgot a date, your lawyers will be signing you up for some
education classes now, have fun!

gre gk-h
