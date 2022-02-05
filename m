Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1A4AA7AC
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 09:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiBEI3E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Feb 2022 03:29:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45714 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiBEI3D (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Feb 2022 03:29:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E346B83971;
        Sat,  5 Feb 2022 08:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96830C340E8;
        Sat,  5 Feb 2022 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644049741;
        bh=Rkk8+CoJAzLvEMdIY0HlH/WdZJKsTuGCa16g5uYMEhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpaFWU0clns/MKEo4jlSDOSODEDbU3DKObclr+5Zhb1zTg3K2LZssJ7hUBQjfqojc
         /lY7UzSzRi1xUHjGfuZLWfQGDkiyFijakZz+uWvM2qbvbeWEMAyieOQLhYN4+mYEr1
         /GHFToCBm6wsFe+XeP5WCxVhOz+Kz+legQO/1Nr8=
Date:   Sat, 5 Feb 2022 09:28:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <Yf41RAFeBH6nGUgX@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/Kconfig
> @@ -0,0 +1,26 @@
> +#
> +# dxgkrnl configuration
> +#

No copyright?  No SPDX line?

Did you run checkpatch.pl on this thing?

And we do not know what a "dgxkrnl" is.  This is the kernel, so why say
it again?  And we have lots of vowels to use, please do so.


> +
> +config DXGKRNL
> +	tristate "Microsoft Paravirtualized GPU support"
> +	depends on HYPERV
> +	depends on 64BIT || COMPILE_TEST
> +	help
> +	  This driver supports paravirtualized virtual compute devices, exposed
> +	  by Microsoft Hyper-V when Linux is running inside of a virtual machine
> +	  hosted by Windows. The virtual machines needs to be configured to use
> +	  host compute adapters. The driver name is dxgkrnl.
> +
> +	  An example of such virtual machine is a  Windows Subsystem for
> +	  Linux container. When such container is instantiated, the Windows host
> +	  assigns compatible host GPU adapters to the container. The corresponding
> +	  virtual GPU devices appear on the PCI bus in the container. These
> +	  devices are enumerated and accessed by this driver.
> +
> +	  Communications with the driver are done by using the Microsoft libdxcore
> +	  library, which translates the D3DKMT interface
> +	  <https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/>
> +	  to the driver IOCTLs. The virtual GPU devices are paravirtualized,
> +	  which means that access to the hardware is done in the host. The driver
> +	  communicates with the host using Hyper-V VM bus communication channels.
> diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
> new file mode 100644
> index 000000000000..745c66bebe5d
> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for the Linux video drivers.

There's lots of linux video drivers in the kernel, this is not all of
them here.



> +
> +obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
> +dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
> diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
> new file mode 100644
> index 000000000000..e0a6fea00bd5
> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/dxgadapter.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.

Drop the trailing ',' in the copyright notice please, that's not how
these should look like.

And I doubt you last touched this in 2019, right?

thanks,

greg k-h
