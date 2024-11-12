Return-Path: <linux-hyperv+bounces-3321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076639C4E82
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B332F28723A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595B2038C3;
	Tue, 12 Nov 2024 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SqKWR/aD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B541C79;
	Tue, 12 Nov 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391497; cv=none; b=RvIjJMKRSKP6w/R+o31SxGT5Tsgj2T2vAavibb9M1EBW0R4qqQK3LKNjMxz/yT9H9UVonxPWCh28rAsaX+OexDJPldgdbucv9MjEXHJ2yRk27Emw8ivqL0nj/1Dk+vmkBRqSBG40O01yvwhgLB3VhbOCpD+Zo1pqc/U9tbASoAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391497; c=relaxed/simple;
	bh=VDovnK/VdUb2UO9oiRw8X0wL86M/m2cDJuvJ+pboJ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epWNixUqYbqbTHqVYwUYAi6n/lvdyoZ6zhrp7mm0zE5CPQws/6ynncQQOzfLBSeUINoqRweq1j75MXeaIlCPnl0ZK10psZnz6HNffd5Zz+sz9U/OKrE0cA5Q7L3EMGzgs/cMHJFbEXVsben9DHjcIUL4qcZy9CcjScwj4vXpB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SqKWR/aD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 5384D23834B2; Mon, 11 Nov 2024 22:04:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5384D23834B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731391489;
	bh=WFPyDGhv8RnYMo1MYeX1ZSP9SwhkJPfogurLOJEkza8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqKWR/aDsLZcBdhQjCcCsyXkaazozWeOvtkFS7xqWIZe60cY8oaYeIn9mG2aNpBkE
	 dH54/+xnfgCJJyP1P9lk7Ta0sg6otS7n/GN1XEDTu3ARM/JGPOI6YhiljppbIq7Nyv
	 EFgxk0964gUy/tFBgswZ3pYk0OMCXZqcgyEAmUt4=
Date: Mon, 11 Nov 2024 22:04:49 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres
 issues
Message-ID: <20241112060449.GA18117@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241111131240.35158-1-vkuznets@redhat.com>
 <SN6PR02MB41577C6B7BF387BEB9114A05D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577C6B7BF387BEB9114A05D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 11, 2024 at 04:50:24PM +0000, Michael Kelley wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, November 11, 2024 5:13 AM
> > 
> > It was found that unloading 'hid_hyperv' module results in a devres
> > complaint:
> > 
> >  ...
> >  hv_vmbus: unregistering driver hid_hyperv
> >  ------------[ cut here ]------------
> >  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691
> > devres_release_group+0x1f2/0x2c0
> >  ...
> >  Call Trace:
> >   <TASK>
> >   ? devres_release_group+0x1f2/0x2c0
> >   ? __warn+0xd1/0x1c0
> >   ? devres_release_group+0x1f2/0x2c0
> >   ? report_bug+0x32a/0x3c0
> >   ? handle_bug+0x53/0xa0
> >   ? exc_invalid_op+0x18/0x50
> >   ? asm_exc_invalid_op+0x1a/0x20
> >   ? devres_release_group+0x1f2/0x2c0
> >   ? devres_release_group+0x90/0x2c0
> >   ? rcu_is_watching+0x15/0xb0
> >   ? __pfx_devres_release_group+0x10/0x10
> >   hid_device_remove+0xf5/0x220
> >   device_release_driver_internal+0x371/0x540
> >   ? klist_put+0xf3/0x170
> >   bus_remove_device+0x1f1/0x3f0
> >   device_del+0x33f/0x8c0
> >   ? __pfx_device_del+0x10/0x10
> >   ? cleanup_srcu_struct+0x337/0x500
> >   hid_destroy_device+0xc8/0x130
> >   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
> >   device_release_driver_internal+0x371/0x540
> >   driver_detach+0xc5/0x180
> >   bus_remove_driver+0x11e/0x2a0
> >   ? __mutex_unlock_slowpath+0x160/0x5e0
> >   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
> >   ...

Do we want to mention the other error as well this patch is fixing:

[   68.237679] ------------[ cut here ]------------
[   68.237681] WARNING: CPU: 23 PID: 579 at drivers/hid/hid-core.c:1262 hid_open_report+0x2c0/0x350 [hid]
<snip>
[   68.237741] RIP: 0010:hid_open_report+0x2c0/0x350 [hid]
[   68.237765] Call Trace:
[   68.237767]  <TASK>
[   68.237769]  ? show_regs+0x6c/0x80
[   68.237774]  ? __warn+0x8d/0x150
[   68.237777]  ? hid_open_report+0x2c0/0x350 [hid]
[   68.237784]  ? report_bug+0x182/0x1b0
[   68.237788]  ? handle_bug+0x6e/0xb0
[   68.237791]  ? exc_invalid_op+0x18/0x80
[   68.237794]  ? asm_exc_invalid_op+0x1b/0x20
[   68.237799]  ? hid_open_report+0x2c0/0x350 [hid]
[   68.237805]  mousevsc_probe+0x1d5/0x250 [hid_hyperv]
[   68.237808]  vmbus_probe+0x3b/0xa0 [hv_vmbus]
[   68.237822]  really_probe+0xee/0x3c0
[   68.237827]  __driver_probe_device+0x8c/0x180
[   68.237830]  driver_probe_device+0x24/0xd0
[   68.237832]  __driver_attach_async_helper+0x6e/0x110
[   68.237835]  async_run_entry_fn+0x30/0x130
[   68.237837]  process_one_work+0x178/0x3d0
[   68.237839]  worker_thread+0x2de/0x410
[   68.237841]  ? __pfx_worker_thread+0x10/0x10
[   68.237843]  kthread+0xe1/0x110
[   68.237847]  ? __pfx_kthread+0x10/0x10
[   68.237849]  ret_from_fork+0x44/0x70
[   68.237852]  ? __pfx_kthread+0x10/0x10
[   68.237854]  ret_from_fork_asm+0x1a/0x30
[   68.237858]  </TASK>
[   68.237859] ---[ end trace 0000000000000000 ]---
[   68.237861] hid-generic 0006:045E:0621.0002: parse failed
[   68.238276] hv_vmbus: probe failed for device 58f75a6d-d949-4320-99e1-a2a2576d581c (-19)


> > 
> > And the issue seems to be that the corresponding devres group is not
> > allocated. Normally, devres_open_group() is called from
> > __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
> > with 'mousevsc_hid_driver' stub and basically re-implements
> > __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
> > devres_open_group(). hid_device_probe() does not call __hid_device_probe()
> > for it. Later, when the driver is removed, hid_device_remove() calls
> > devres_release_group() as it doesn't check whether hdev->driver was
> > initially overridden or not.
> > 
> > The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
> > timely release of driver-allocated resources") but the commit itself seems
> > to be correct.
> > 
> > Fix the issue by dropping the 'hid_dev->driver' override and using
> > hid_register_driver()/hid_unregister_driver() instead. Alternatively, it
> > would have been possible to rely on the default handling but
> > HID_CONNECT_DEFAULT implies HID_CONNECT_HIDRAW and it doesn't seem to work
> > for mousevsc as-is.
> > 
> > Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated resources")
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> > Changes since v1:
> > - Keep custom HID driver for mousevsc but do it properly
> > [Michael Kelley].
> > - Add 'Fixes:' tag [Saurabh Singh Sengar].
> > ---
> >  drivers/hid/hid-hyperv.c | 58 ++++++++++++++++++++++++++++------------
> >  1 file changed, 41 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > index f33485d83d24..0fb210e40a41 100644
> > --- a/drivers/hid/hid-hyperv.c
> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_device *hid,
> >  	return 0;
> >  }
> > 
> > +static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid_device_id *id)
> > +{
> > +	int ret;
> > +
> > +	ret = hid_parse(hid_dev);
> > +	if (ret) {
> > +		hid_err(hid_dev, "parse failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
> > +	if (ret) {
> > +		hid_err(hid_dev, "hw start failed\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct hid_ll_driver mousevsc_ll_driver = {
> >  	.parse = mousevsc_hid_parse,
> >  	.open = mousevsc_hid_open,
> > @@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
> >  	.raw_request = mousevsc_hid_raw_request,
> >  };
> > 
> > -static struct hid_driver mousevsc_hid_driver;
> > +static const struct hid_device_id mousevsc_devices[] = {
> > +	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
> > +	{ }
> > +};
> > +
> > +static struct hid_driver mousevsc_hid_driver = {
> > +	.name = "hid-hyperv",
> > +	.id_table = mousevsc_devices,
> > +	.probe = mousevsc_hid_probe,
> > +};
> > 
> >  static int mousevsc_probe(struct hv_device *device,
> >  			const struct hv_vmbus_device_id *dev_id)
> > @@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
> >  	}
> > 
> >  	hid_dev->ll_driver = &mousevsc_ll_driver;
> > -	hid_dev->driver = &mousevsc_hid_driver;
> >  	hid_dev->bus = BUS_VIRTUAL;
> >  	hid_dev->vendor = input_dev->hid_dev_info.vendor;
> >  	hid_dev->product = input_dev->hid_dev_info.product;
> > @@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device,
> >  	if (ret)
> >  		goto probe_err2;
> > 
> > -
> > -	ret = hid_parse(hid_dev);
> > -	if (ret) {
> > -		hid_err(hid_dev, "parse failed\n");
> > -		goto probe_err2;
> > -	}
> > -
> > -	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
> > -
> > -	if (ret) {
> > -		hid_err(hid_dev, "hw start failed\n");
> > -		goto probe_err2;
> > -	}
> > -
> >  	device_init_wakeup(&device->device, true);
> > 
> >  	input_dev->connected = true;
> > @@ -579,12 +592,23 @@ static struct  hv_driver mousevsc_drv = {
> > 
> >  static int __init mousevsc_init(void)
> >  {
> > -	return vmbus_driver_register(&mousevsc_drv);
> > +	int ret;
> > +
> > +	ret = hid_register_driver(&mousevsc_hid_driver);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = vmbus_driver_register(&mousevsc_drv);
> > +	if (ret)
> > +		hid_unregister_driver(&mousevsc_hid_driver);
> > +
> > +	return ret;
> >  }
> > 
> >  static void __exit mousevsc_exit(void)
> >  {
> >  	vmbus_driver_unregister(&mousevsc_drv);
> > +	hid_unregister_driver(&mousevsc_hid_driver);
> >  }
> > 
> >  MODULE_LICENSE("GPL");
> > --
> > 2.47.0
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Tested V2 as well, please feel free to  add,
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

