Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AC244A15
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHNNDp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 09:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgHNNDo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 09:03:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68468206B2;
        Fri, 14 Aug 2020 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597410224;
        bh=OaJzTXasYwLO/M+YYozR9BRANETxqbmfOLZ6r01jc3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jE5vMMpwk83Lxb3+ielGdIS4W2eXFb1YpXCJ1dJTZUXj+w3zzvHRq00qSpnvTYTy0
         hf15Eu1wcrsMa4r1EZD5tdg3Oyr61Uite1TlDOLp+Xnftt6KnCGZf2wvFVHy7uarsy
         NHKM78vQgdSxcOrdR3vMN2L1JvkRbLtR1bwobhx4=
Date:   Fri, 14 Aug 2020 15:04:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200814130406.GC56456@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123856.3880009-2-sashal@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> Add support for a Hyper-V based vGPU implementation that exposes the
> DirectX API to Linux userspace.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hv/dxgkrnl/Kconfig      |   10 +
>  drivers/hv/dxgkrnl/Makefile     |   12 +
>  drivers/hv/dxgkrnl/d3dkmthk.h   | 1636 ++++++++++
>  drivers/hv/dxgkrnl/dxgadapter.c | 1406 ++++++++
>  drivers/hv/dxgkrnl/dxgkrnl.h    |  927 ++++++
>  drivers/hv/dxgkrnl/dxgmodule.c  |  656 ++++
>  drivers/hv/dxgkrnl/dxgprocess.c |  357 ++
>  drivers/hv/dxgkrnl/dxgvmbus.c   | 3084 ++++++++++++++++++
>  drivers/hv/dxgkrnl/dxgvmbus.h   |  873 +++++
>  drivers/hv/dxgkrnl/hmgr.c       |  604 ++++
>  drivers/hv/dxgkrnl/hmgr.h       |  112 +
>  drivers/hv/dxgkrnl/ioctl.c      | 5413 +++++++++++++++++++++++++++++++
>  drivers/hv/dxgkrnl/misc.c       |  279 ++
>  drivers/hv/dxgkrnl/misc.h       |  309 ++
>  14 files changed, 15678 insertions(+)

It's almost impossible to review 15k lines at once, please break this up
into reviewable chunks next time.

> +++ b/drivers/hv/dxgkrnl/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# dxgkrnl configuration
> +#
> +
> +config DXGKRNL
> +	tristate "Microsoft virtual GPU support"
> +	depends on HYPERV
> +	help
> +	  This driver supports Microsoft virtual GPU.
> +

You need more text here, this isn't a staging driver submission :)

> diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
> new file mode 100644
> index 000000000000..11505a153d9d
> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for the Linux video drivers.
> +# 5 Aug 1999, James Simmons, <mailto:jsimmons@users.sf.net>
> +# Rewritten to use lists instead of if-statements.

I really doubt these last 3 lines are relevant.

> +
> +# Each configuration option enables a list of files.

We know this.

> +
> +# Uncomment to enable printing debug messages by default
> +#ccflags-y := -DDEBUG

No, don't do this please.

> +
> +obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
> +dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
> diff --git a/drivers/hv/dxgkrnl/d3dkmthk.h b/drivers/hv/dxgkrnl/d3dkmthk.h
> new file mode 100644
> index 000000000000..90cf5134b361
> --- /dev/null
> +++ b/drivers/hv/dxgkrnl/d3dkmthk.h
> @@ -0,0 +1,1636 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2019, Microsoft Corporation.
> + *
> + * Author:
> + *   Iouri Tarassov <iourit@microsoft.com>
> + *
> + * Dxgkrnl Graphics Port Driver user mode interface
> + *
> + */
> +
> +#ifndef _D3DKMTHK_H
> +#define _D3DKMTHK_H
> +
> +#include "misc.h"
> +
> +#define D3DDDI_MAX_WRITTEN_PRIMARIES		16
> +#define D3DDDI_MAX_MPO_PRESENT_DIRTY_RECTS	0xFFF
> +
> +#define D3DKMT_CREATEALLOCATION_MAX		1024
> +#define D3DKMT_ADAPTERS_MAX			64
> +#define D3DDDI_MAX_BROADCAST_CONTEXT		64
> +#define D3DDDI_MAX_OBJECT_WAITED_ON		32
> +#define D3DDDI_MAX_OBJECT_SIGNALED		32
> +
> +struct d3dkmt_adapterinfo {
> +	struct d3dkmthandle		adapter_handle;
> +	struct winluid			adapter_luid;
> +	uint				num_sources;
> +	uint				present_move_regions_preferred;
> +};
> +
> +struct d3dkmt_enumadapters2 {
> +	uint				num_adapters;

Use kernel types please, here and everywhere.  u32?

> +	struct d3dkmt_adapterinfo	*adapters;
> +};
> +
> +struct d3dkmt_closeadapter {
> +	struct d3dkmthandle		adapter_handle;
> +};

A "handle"?  And that has to be one of the most difficult structure
names ever :)

Why not just use the "handle" for the structure as obviously that's all
that is needed here.
> +
> +struct d3dkmt_openadapterfromluid {
> +	struct winluid			adapter_luid;
> +	struct d3dkmthandle		adapter_handle;
> +};
> +
> +struct d3dddi_allocationlist {
> +	struct d3dkmthandle		allocation;
> +	union {
> +		struct {
> +			uint		write_operation		:1;
> +			uint		do_not_retire_instance	:1;
> +			uint		offer_priority		:3;
> +			uint		reserved		:27;

endian issues?

If not, why are these bit fields?

> +struct d3dkmt_destroydevice {
> +	struct d3dkmthandle		device;
> +};

Again, single entity structures?

Are you trying to pass around "handles" and cast them backwards?

If so, great, but then use the real kernel structures for that like
'struct device' if these are actually devices.


> +
> +enum d3dkmt_clienthint {
> +	D3DKMT_CLIENTHINT_UNKNOWN	= 0,
> +	D3DKMT_CLIENTHINT_OPENGL	= 1,
> +	D3DKMT_CLIENTHINT_CDD		= 2,
> +	D3DKMT_CLIENTHINT_DX7		= 7,
> +	D3DKMT_CLIENTHINT_DX8		= 8,
> +	D3DKMT_CLIENTHINT_DX9		= 9,
> +	D3DKMT_CLIENTHINT_DX10		= 10,
> +};
> +
> +struct d3dddi_createcontextflags {
> +	union {
> +		struct {
> +			uint		null_rendering:1;
> +			uint		initial_data:1;
> +			uint		disable_gpu_timeout:1;
> +			uint		synchronization_only:1;
> +			uint		hw_queue_supported:1;
> +			uint		reserved:27;

Endian?

> +		};
> +		uint			value;
> +	};
> +};

<...>


> +static int dxgglobal_init_global_channel(struct hv_device *hdev)
> +{
> +	int ret = 0;
> +
> +	TRACE_DEBUG(1, "%s %x  %x", __func__, hdev->vendor_id, hdev->device_id);
> +	{
> +		TRACE_DEBUG(1, "device type   : %pUb\n", &hdev->dev_type);
> +		TRACE_DEBUG(1, "device channel: %pUb %p primary: %p\n",
> +			    &hdev->channel->offermsg.offer.if_type,
> +			    hdev->channel, hdev->channel->primary_channel);
> +	}
> +
> +	if (dxgglobal->hdev) {
> +		/* This device should appear only once */
> +		pr_err("dxgglobal already initialized\n");
> +		ret = -EBADE;
> +		goto error;
> +	}
> +
> +	dxgglobal->hdev = hdev;
> +
> +	ret = dxgvmbuschannel_init(&dxgglobal->channel, hdev);
> +	if (ret) {
> +		pr_err("dxgvmbuschannel_init failed: %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = dxgglobal_getiospace(dxgglobal);
> +	if (ret) {
> +		pr_err("getiospace failed: %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
> +					     dxgglobal->mmiospace_size, 0);
> +	if (ISERROR(ret)) {
> +		pr_err("send_set_iospace_region failed");
> +		goto error;

You forgot to unwind from the things you initialized above :(

> +	}
> +
> +	hv_set_drvdata(hdev, dxgglobal);
> +
> +	dxgglobal->dxgdevice.minor = MISC_DYNAMIC_MINOR;
> +	dxgglobal->dxgdevice.name = "dxg";
> +	dxgglobal->dxgdevice.fops = &dxgk_fops;
> +	dxgglobal->dxgdevice.mode = 0666;
> +	ret = misc_register(&dxgglobal->dxgdevice);
> +	if (ret) {
> +		pr_err("misc_register failed: %d", ret);
> +		goto error;

Again, no cleanups so you leak resources?  Not nice :(


> +	}
> +	dxgglobaldev = dxgglobal->dxgdevice.this_device;
> +	dxgglobal->device_initialized = true;
> +
> +error:
> +	return ret;
> +}
> +
> +static void dxgglobal_destroy_global_channel(void)
> +{
> +	dxglockorder_acquire(DXGLOCK_GLOBAL_CHANNEL);
> +	down_write(&dxgglobal->channel_lock);
> +
> +	TRACE_DEBUG(1, "%s", __func__);

ftrace is your friend :)

