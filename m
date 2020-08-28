Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4162551D2
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 02:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgH1AFt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 20:05:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53502 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1AFr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 20:05:47 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id C276E20B7178;
        Thu, 27 Aug 2020 17:05:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C276E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598573144;
        bh=C0j9dTOSPNKg62PMw/xlMl1imxCA6omMwCrOaAXcdQo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QZfnUoUno/BJaDNIXFUC+Ma7iHii4XCSz/Z2BTvRCh2CyByiscBfdB2we3Kq7lYWH
         FuUuKNgqORNrqHz6WRTl2jm/w6wvJLP+PNChjp2erexPTXhZTDxyBQcXuTKSQ4fklk
         AGRtvQl7I8Ezq4LcEQGDxfdoYhWxmeMZve6qgdzU=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814130406.GC56456@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <cfb9eb69-24f9-2a0c-1f1b-9204c6666aa8@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 17:05:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200814130406.GC56456@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 8/14/2020 6:04 AM, Greg KH wrote:
> On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > Add support for a Hyper-V based vGPU implementation that exposes the
> > DirectX API to Linux userspace.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/hv/dxgkrnl/Kconfig      |   10 +
> >  drivers/hv/dxgkrnl/Makefile     |   12 +
> >  drivers/hv/dxgkrnl/d3dkmthk.h   | 1636 ++++++++++
> >  drivers/hv/dxgkrnl/dxgadapter.c | 1406 ++++++++
> >  drivers/hv/dxgkrnl/dxgkrnl.h    |  927 ++++++
> >  drivers/hv/dxgkrnl/dxgmodule.c  |  656 ++++
> >  drivers/hv/dxgkrnl/dxgprocess.c |  357 ++
> >  drivers/hv/dxgkrnl/dxgvmbus.c   | 3084 ++++++++++++++++++
> >  drivers/hv/dxgkrnl/dxgvmbus.h   |  873 +++++
> >  drivers/hv/dxgkrnl/hmgr.c       |  604 ++++
> >  drivers/hv/dxgkrnl/hmgr.h       |  112 +
> >  drivers/hv/dxgkrnl/ioctl.c      | 5413 +++++++++++++++++++++++++++++++
> >  drivers/hv/dxgkrnl/misc.c       |  279 ++
> >  drivers/hv/dxgkrnl/misc.h       |  309 ++
> >  14 files changed, 15678 insertions(+)
>
> It's almost impossible to review 15k lines at once, please break this up
> into reviewable chunks next time.

Sorry about this, but we had to replace a lot of typedefs, which are not 
allowed by the coding style.
We expect one more big patch, which cannot be split in my opinion. The 
VM vbus message format was changed to include additional header. As the 
result, every function in dxgvmbus.c needs to be changed to handle the 
new header. I do not see how this can be split to multiple patches so 
each patch produces a working driver.

>
> > +++ b/drivers/hv/dxgkrnl/Kconfig
> > @@ -0,0 +1,10 @@
> > +#
> > +# dxgkrnl configuration
> > +#
> > +
> > +config DXGKRNL
> > +	tristate "Microsoft virtual GPU support"
> > +	depends on HYPERV
> > +	help
> > +	  This driver supports Microsoft virtual GPU.
> > +
>
> You need more text here, this isn't a staging driver submission :)
Is the the proposed description good enough?
"This driver handles paravirtualized GPU devices exposed by Microsoft 
Hyper-V when Linux is running inside of a virtual machine hosted 
by Windows."
>
> > diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
> > new file mode 100644
> > index 000000000000..11505a153d9d
> > --- /dev/null
> > +++ b/drivers/hv/dxgkrnl/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Makefile for the Linux video drivers.
> > +# 5 Aug 1999, James Simmons, <mailto:jsimmons@users.sf.net>
> > +# Rewritten to use lists instead of if-statements.
>
> I really doubt these last 3 lines are relevant.
>
> > +
> > +# Each configuration option enables a list of files.
>
> We know this.
>
> > +
> > +# Uncomment to enable printing debug messages by default
> > +#ccflags-y := -DDEBUG
>
> No, don't do this please.
These lines will be removed.
>
> > +
> > +obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
> > +dxgkrnl-y		:= dxgmodule.o hmgr.o misc.o dxgadapter.o ioctl.o dxgvmbus.o dxgprocess.o
> > diff --git a/drivers/hv/dxgkrnl/d3dkmthk.h b/drivers/hv/dxgkrnl/d3dkmthk.h
> > new file mode 100644
> > index 000000000000..90cf5134b361
> > --- /dev/null
> > +++ b/drivers/hv/dxgkrnl/d3dkmthk.h
> > @@ -0,0 +1,1636 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (c) 2019, Microsoft Corporation.
> > + *
> > + * Author:
> > + *   Iouri Tarassov <iourit@microsoft.com>
> > + *
> > + * Dxgkrnl Graphics Port Driver user mode interface
> > + *
> > + */
> > +
> > +#ifndef _D3DKMTHK_H
> > +#define _D3DKMTHK_H
> > +
> > +#include "misc.h"
> > +
> > +#define D3DDDI_MAX_WRITTEN_PRIMARIES		16
> > +#define D3DDDI_MAX_MPO_PRESENT_DIRTY_RECTS	0xFFF
> > +
> > +#define D3DKMT_CREATEALLOCATION_MAX		1024
> > +#define D3DKMT_ADAPTERS_MAX			64
> > +#define D3DDDI_MAX_BROADCAST_CONTEXT		64
> > +#define D3DDDI_MAX_OBJECT_WAITED_ON		32
> > +#define D3DDDI_MAX_OBJECT_SIGNALED		32
> > +
> > +struct d3dkmt_adapterinfo {
> > +	struct d3dkmthandle		adapter_handle;
> > +	struct winluid			adapter_luid;
> > +	uint				num_sources;
> > +	uint				present_move_regions_preferred;
> > +};
> > +
> > +struct d3dkmt_enumadapters2 {
> > +	uint				num_adapters;
>
> Use kernel types please, here and everywhere.  u32?
The definition will be changed to u32.
>
> > +	struct d3dkmt_adapterinfo	*adapters;
> > +};
> > +
> > +struct d3dkmt_closeadapter {
> > +	struct d3dkmthandle		adapter_handle;
> > +};
>
> A "handle"?  And that has to be one of the most difficult structure
> names ever :)
>
> Why not just use the "handle" for the structure as obviously that's all
> that is needed here.
The structure definition matches the Windows D3DKMT interface. Some 
input structures to the interface functions have only one member. But 
there is possibility that new member could be added in the future. We 
prefer to have matching names between Windows and Linux to avoid confusion.
> > +
> > +struct d3dkmt_openadapterfromluid {
> > +	struct winluid			adapter_luid;
> > +	struct d3dkmthandle		adapter_handle;
> > +};
> > +
> > +struct d3dddi_allocationlist {
> > +	struct d3dkmthandle		allocation;
> > +	union {
> > +		struct {
> > +			uint		write_operation		:1;
> > +			uint		do_not_retire_instance	:1;
> > +			uint		offer_priority		:3;
> > +			uint		reserved		:27;
>
> endian issues?
>
> If not, why are these bit fields?
This matches the definition on the Windows side. Windows only works on 
little endian platforms.
>
> > +struct d3dkmt_destroydevice {
> > +	struct d3dkmthandle		device;
> > +};
>
> Again, single entity structures?
>
> Are you trying to pass around "handles" and cast them backwards?
>
> If so, great, but then use the real kernel structures for that like
> 'struct device' if these are actually devices.
>
Again. The structure matches the definition on the Windows side to avoid 
confusion.
> > +
> > +enum d3dkmt_clienthint {
> > +	D3DKMT_CLIENTHINT_UNKNOWN	= 0,
> > +	D3DKMT_CLIENTHINT_OPENGL	= 1,
> > +	D3DKMT_CLIENTHINT_CDD		= 2,
> > +	D3DKMT_CLIENTHINT_DX7		= 7,
> > +	D3DKMT_CLIENTHINT_DX8		= 8,
> > +	D3DKMT_CLIENTHINT_DX9		= 9,
> > +	D3DKMT_CLIENTHINT_DX10		= 10,
> > +};
> > +
> > +struct d3dddi_createcontextflags {
> > +	union {
> > +		struct {
> > +			uint		null_rendering:1;
> > +			uint		initial_data:1;
> > +			uint		disable_gpu_timeout:1;
> > +			uint		synchronization_only:1;
> > +			uint		hw_queue_supported:1;
> > +			uint		reserved:27;
>
> Endian?
>
> > +		};
> > +		uint			value;
> > +	};
> > +};
>
> <...>
The structure matches definition on the Windows side.
>
> > +static int dxgglobal_init_global_channel(struct hv_device *hdev)
> > +{
> > +	int ret = 0;
> > +
> > +	TRACE_DEBUG(1, "%s %x  %x", __func__, hdev->vendor_id, hdev->device_id);
> > +	{
> > +		TRACE_DEBUG(1, "device type   : %pUb\n", &hdev->dev_type);
> > +		TRACE_DEBUG(1, "device channel: %pUb %p primary: %p\n",
> > +			    &hdev->channel->offermsg.offer.if_type,
> > +			    hdev->channel, hdev->channel->primary_channel);
> > +	}
> > +
> > +	if (dxgglobal->hdev) {
> > +		/* This device should appear only once */
> > +		pr_err("dxgglobal already initialized\n");
> > +		ret = -EBADE;
> > +		goto error;
> > +	}
> > +
> > +	dxgglobal->hdev = hdev;
> > +
> > +	ret = dxgvmbuschannel_init(&dxgglobal->channel, hdev);
> > +	if (ret) {
> > +		pr_err("dxgvmbuschannel_init failed: %d\n", ret);
> > +		goto error;
> > +	}
> > +
> > +	ret = dxgglobal_getiospace(dxgglobal);
> > +	if (ret) {
> > +		pr_err("getiospace failed: %d\n", ret);
> > +		goto error;
> > +	}
> > +
> > +	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
> > +					     dxgglobal->mmiospace_size, 0);
> > +	if (ISERROR(ret)) {
> > +		pr_err("send_set_iospace_region failed");
> > +		goto error;
>
> You forgot to unwind from the things you initialized above :(
The caller of dxgglobal_init_global_channel() checks the return value 
and calls dxgglobal_destroy_global_channel() in case of an error, which 
does the cleanup. If preferred the call to destroy the channel could be 
moved to the end of this function.
>
> > +	}
> > +
> > +	hv_set_drvdata(hdev, dxgglobal);
> > +
> > +	dxgglobal->dxgdevice.minor = MISC_DYNAMIC_MINOR;
> > +	dxgglobal->dxgdevice.name = "dxg";
> > +	dxgglobal->dxgdevice.fops = &dxgk_fops;
> > +	dxgglobal->dxgdevice.mode = 0666;
> > +	ret = misc_register(&dxgglobal->dxgdevice);
> > +	if (ret) {
> > +		pr_err("misc_register failed: %d", ret);
> > +		goto error;
>
> Again, no cleanups so you leak resources?  Not nice :(
>
>
> > +	}
> > +	dxgglobaldev = dxgglobal->dxgdevice.this_device;
> > +	dxgglobal->device_initialized = true;
> > +
> > +error:
> > +	return ret;
> > +}
> > +
> > +static void dxgglobal_destroy_global_channel(void)
> > +{
> > +	dxglockorder_acquire(DXGLOCK_GLOBAL_CHANNEL);
> > +	down_write(&dxgglobal->channel_lock);
> > +
> > +	TRACE_DEBUG(1, "%s", __func__);
>
> ftrace is your friend :)
I mentioned in other mail that these macros will be removed when we pick 
to final tracing technology for the driver.
>
>
Thank you
Iouri


