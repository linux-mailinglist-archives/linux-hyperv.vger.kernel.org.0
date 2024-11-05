Return-Path: <linux-hyperv+bounces-3262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9B9BD320
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3921C22535
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886741DE3C9;
	Tue,  5 Nov 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NUddSwWk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A21E25FA;
	Tue,  5 Nov 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826703; cv=none; b=OD4wofFtzNYc/Zc6eaSPrRX3BKr8MZa2SZg7R08D0TqOZGqcCDYAMOVd6KlLTS0VFkGO4iJTLJtiLsTdJnc3cS5tztKBHWOoKXGQ2GJU5mK7sZe4QvgnN+fYKxZWI+xpqka0RnTKHE/OlHvH7ycxEeuUa1m6wbAp0uduRdmyLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826703; c=relaxed/simple;
	bh=2oPQB2Lp0LD3jSjcyM+iyTsku/4Xcte/GJ6GGqz8pJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMR2KQDkWoZqUKX0bzwyxrQtKoshxqlApNoq0tIq/WT3dCL0RkJnRbJOMfwLis+EEHCxj/GjB5qMqsOQ8Z1rB/TzIZTtWeeLfsRiObn62uPAI1W4YWMaIQnCGVH5Qneb/oxXnBszDFak1eTCaBIxqeIENmNv9ERO7HEDNpnosNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NUddSwWk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 7AE292127C6B; Tue,  5 Nov 2024 09:11:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AE292127C6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730826701;
	bh=Od55Nzc+oBTOYL7n27AAYsLOGebwXGfUgpBjMQpANto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUddSwWkbwMarVbAA3iGOn3+2U8Pa2FasroN4C8uKyHvi+5KKv5344vLiPjbo4Z+A
	 6N9oR5CCnGJyxpQRRWoJN1atiIQu1u1TgOjrdNAC7cOBC+ORgtTV+5NrMtwtLcgmYt
	 IGISYDhCO5NiVcX50FzzF2J57hGvIyM+CSwj1nvc=
Date: Tue, 5 Nov 2024 09:11:41 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, mhklinux@outlook.com
Cc: linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
Message-ID: <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104164824.1213529-1-vkuznets@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 04, 2024 at 05:48:24PM +0100, Vitaly Kuznetsov wrote:
> It was found that unloading 'hid_hyperv' module results in a devres
> complaint:
> 
>  ...
>  hv_vmbus: unregistering driver hid_hyperv
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release_group+0x1f2/0x2c0
>  ...
>  Call Trace:
>   <TASK>
>   ? devres_release_group+0x1f2/0x2c0
>   ? __warn+0xd1/0x1c0
>   ? devres_release_group+0x1f2/0x2c0
>   ? report_bug+0x32a/0x3c0
>   ? handle_bug+0x53/0xa0
>   ? exc_invalid_op+0x18/0x50
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? devres_release_group+0x1f2/0x2c0
>   ? devres_release_group+0x90/0x2c0
>   ? rcu_is_watching+0x15/0xb0
>   ? __pfx_devres_release_group+0x10/0x10
>   hid_device_remove+0xf5/0x220
>   device_release_driver_internal+0x371/0x540
>   ? klist_put+0xf3/0x170
>   bus_remove_device+0x1f1/0x3f0
>   device_del+0x33f/0x8c0
>   ? __pfx_device_del+0x10/0x10
>   ? cleanup_srcu_struct+0x337/0x500
>   hid_destroy_device+0xc8/0x130
>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
>   device_release_driver_internal+0x371/0x540
>   driver_detach+0xc5/0x180
>   bus_remove_driver+0x11e/0x2a0
>   ? __mutex_unlock_slowpath+0x160/0x5e0
>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
>   ...
> 
> And the issue seems to be that the corresponding devres group is not
> allocated. Normally, devres_open_group() is called from
> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
> with 'mousevsc_hid_driver' stub and basically re-implements
> __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
> devres_open_group(). hid_device_probe() does not call __hid_device_probe()
> for it. Later, when the driver is removed, hid_device_remove() calls
> devres_release_group() as it doesn't check whether hdev->driver was
> initially overridden or not.
> 
> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
> timely release of driver-allocated resources") but the commit itself seems
> to be correct.
> 
> Fix the issue by dropping the 'hid_dev->driver' override and the
> now unneeded hid_parse()/hid_hw_start() calls. One notable difference of
> the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT which
> implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate issues
> but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in the
> driver for a long time and it is unclear whether hidraw was excluded on
> purpose or not.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

A fixme tag would be helpful.

> ---
>  drivers/hid/hid-hyperv.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index f33485d83d24..1609a56ffa7c 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
>  	.raw_request = mousevsc_hid_raw_request,
>  };
>  
> -static struct hid_driver mousevsc_hid_driver;
> -
>  static int mousevsc_probe(struct hv_device *device,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
> @@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *device,
>  	}
>  
>  	hid_dev->ll_driver = &mousevsc_ll_driver;
> -	hid_dev->driver = &mousevsc_hid_driver;
>  	hid_dev->bus = BUS_VIRTUAL;
>  	hid_dev->vendor = input_dev->hid_dev_info.vendor;
>  	hid_dev->product = input_dev->hid_dev_info.product;
> @@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *device,
>  	if (ret)
>  		goto probe_err2;
>  
> -
> -	ret = hid_parse(hid_dev);
> -	if (ret) {
> -		hid_err(hid_dev, "parse failed\n");
> -		goto probe_err2;
> -	}
> -
> -	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
> -
> -	if (ret) {
> -		hid_err(hid_dev, "hw start failed\n");
> -		goto probe_err2;
> -	}
> -
>  	device_init_wakeup(&device->device, true);
>  
>  	input_dev->connected = true;
> -- 
> 2.47.0
> 

I have tested this patch, but the original issue reported in commit message is
not observed in latest kernel due to an other error reported by Michael here:
https://lore.kernel.org/linux-hyperv/SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com/

The error addressed by this patch is observed before the commit
"8b7fd6a15f8c: HID: bpf: move HID-BPF report descriptor fixup earlier",
and is resolved by this patch. In fact, this patch appears to fix both issues.

Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh



