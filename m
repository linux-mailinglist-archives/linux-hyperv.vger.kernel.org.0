Return-Path: <linux-hyperv+bounces-3322-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA69C5131
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 09:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A30282AA0
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836E20C00A;
	Tue, 12 Nov 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyGqB5r0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC920BB44
	for <linux-hyperv@vger.kernel.org>; Tue, 12 Nov 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401512; cv=none; b=mXiaWapz1fILR8E40rAk0YadWJXc/dUipOwUJPswc3Sj8JwiB/BYpHS2hUZT8RHAx5Qb1R9jl6ZWFkOZGGJkO3+moKNSmX/RVITZ51zJK1cXllFWxsnUuCUQljjDnyXHOboIH1rpYOVBG/H/Y1K7+qZifD0BvHi2JrZ2+w4qZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401512; c=relaxed/simple;
	bh=hqeAJY76rhFiFf6cAio6VT0Icw2e1fXd60fyjszZKEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qArPWTxIqoF8h6HACxLvFH2nf1eUG5n08+NC8rm0rYiw5B5Nw++hMaqiu2iNcCoQUeJDkAtEL0+6hXuKgz6SvGEnSaSfIPEAjJwOnhRjWpzWPmdjo4W3Ev/8+3Uchqqw46SXba/i/84t+uIfcFgTCgJfjyLOgz+NpGnHXG2ro3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cyGqB5r0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731401509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOb8rWtwHrk24MmNOtLxS6mQv73INDj+nqVSb0TDgSc=;
	b=cyGqB5r093wJtjYojb4Gbqnz3AcmvzxLx4ATFnuMKam7N2k4InND+8cXNNJti6x40/BsEx
	BJRA6CNn13tbzVGyyfp5xC+7/y/bSRp7u9qBFJShhjNecc9JsW4Lw6qABfTmF6ArjPa2R2
	R4dHjTFPsqzXpFUlkIoZGJHHPSvCS4o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-tEkqufXSMBetZYtWur_dLQ-1; Tue, 12 Nov 2024 03:51:48 -0500
X-MC-Unique: tEkqufXSMBetZYtWur_dLQ-1
X-Mimecast-MFC-AGG-ID: tEkqufXSMBetZYtWur_dLQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c88bde66bdso4173997a12.2
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Nov 2024 00:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401507; x=1732006307;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOb8rWtwHrk24MmNOtLxS6mQv73INDj+nqVSb0TDgSc=;
        b=rmxHCiuD3v3ibxVNey/17bW/6ARN+RmOORGOLLFvrPriOxtPZi9jvLSqG7LCYIKjdf
         9rgJXRNnACLQu7GUBXqVGlloagqXTHC57ANyuaH5nPvsOTMCVhKXNAGYHXVndgMR3dLF
         1SbQLVLECmgZsz9mTGre0xQEyecBgDcgx4r46cCzqH1UsiBwt0tscLvlvHmGCYmdE69z
         8ZKC0u6COCr+qLlEElqUvAUmrs0OFz5hv1AznVTPYv/Iyal07eoNZFUgWS3UzPzYTQbm
         PPMq+oCzz0UNErP6WMXS+5h0rPCe+4XgyTFwj5q3XKHbPEzIORjdpLqLJgbJOWcDdx8x
         9TGg==
X-Gm-Message-State: AOJu0YxB1R3qm/+5mg7oUZ44luJtinWjSpEG3nppAPaRUSI2InVDGNm7
	B/uEttWvuaA+82UbZZXR0155Y8k6zIvmrGPQI02FBRhzVC5cNABgqj7j5LdTcIuJOzOU6xGCizs
	7I0peRyfgdgvys0jBjYO2O/zQRGIBhxpLiZbfeqNOMOTM4Lu2wBibiOcMyLVtbQ==
X-Received: by 2002:a05:6402:26c2:b0:5cf:fa1:892d with SMTP id 4fb4d7f45d1cf-5cf0fa18bf4mr12296047a12.6.1731401507184;
        Tue, 12 Nov 2024 00:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4zvcjt9uYCBVnjxtXCYSgME6kAyJUMDQvcV2l83TFUVIwcuhE/MGhLyVOr7UFAiD2r3dlfA==
X-Received: by 2002:a05:6402:26c2:b0:5cf:fa1:892d with SMTP id 4fb4d7f45d1cf-5cf0fa18bf4mr12296029a12.6.1731401506637;
        Tue, 12 Nov 2024 00:51:46 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7f0d8sm5759578a12.24.2024.11.12.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:51:46 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres
 issues
In-Reply-To: <20241112060449.GA18117@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241111131240.35158-1-vkuznets@redhat.com>
 <SN6PR02MB41577C6B7BF387BEB9114A05D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241112060449.GA18117@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Tue, 12 Nov 2024 09:51:45 +0100
Message-ID: <877c98x2am.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saurabh Singh Sengar <ssengar@linux.microsoft.com> writes:

> On Mon, Nov 11, 2024 at 04:50:24PM +0000, Michael Kelley wrote:
>> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, November 11, 2024 5:13 AM
>> > 
>> > It was found that unloading 'hid_hyperv' module results in a devres
>> > complaint:
>> > 
>> >  ...
>> >  hv_vmbus: unregistering driver hid_hyperv
>> >  ------------[ cut here ]------------
>> >  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691
>> > devres_release_group+0x1f2/0x2c0
>> >  ...
>> >  Call Trace:
>> >   <TASK>
>> >   ? devres_release_group+0x1f2/0x2c0
>> >   ? __warn+0xd1/0x1c0
>> >   ? devres_release_group+0x1f2/0x2c0
>> >   ? report_bug+0x32a/0x3c0
>> >   ? handle_bug+0x53/0xa0
>> >   ? exc_invalid_op+0x18/0x50
>> >   ? asm_exc_invalid_op+0x1a/0x20
>> >   ? devres_release_group+0x1f2/0x2c0
>> >   ? devres_release_group+0x90/0x2c0
>> >   ? rcu_is_watching+0x15/0xb0
>> >   ? __pfx_devres_release_group+0x10/0x10
>> >   hid_device_remove+0xf5/0x220
>> >   device_release_driver_internal+0x371/0x540
>> >   ? klist_put+0xf3/0x170
>> >   bus_remove_device+0x1f1/0x3f0
>> >   device_del+0x33f/0x8c0
>> >   ? __pfx_device_del+0x10/0x10
>> >   ? cleanup_srcu_struct+0x337/0x500
>> >   hid_destroy_device+0xc8/0x130
>> >   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
>> >   device_release_driver_internal+0x371/0x540
>> >   driver_detach+0xc5/0x180
>> >   bus_remove_driver+0x11e/0x2a0
>> >   ? __mutex_unlock_slowpath+0x160/0x5e0
>> >   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
>> >   ...
>
> Do we want to mention the other error as well this patch is fixing:

The error itself is likely the same ('hid_dev->driver' override with
'mousevsc_hid_driver' stub which doesn't do anything) but the trace
stack is a bit different, yes.

>
> [   68.237679] ------------[ cut here ]------------
> [   68.237681] WARNING: CPU: 23 PID: 579 at drivers/hid/hid-core.c:1262 hid_open_report+0x2c0/0x350 [hid]
> <snip>
> [   68.237741] RIP: 0010:hid_open_report+0x2c0/0x350 [hid]
> [   68.237765] Call Trace:
> [   68.237767]  <TASK>
> [   68.237769]  ? show_regs+0x6c/0x80
> [   68.237774]  ? __warn+0x8d/0x150
> [   68.237777]  ? hid_open_report+0x2c0/0x350 [hid]
> [   68.237784]  ? report_bug+0x182/0x1b0
> [   68.237788]  ? handle_bug+0x6e/0xb0
> [   68.237791]  ? exc_invalid_op+0x18/0x80
> [   68.237794]  ? asm_exc_invalid_op+0x1b/0x20
> [   68.237799]  ? hid_open_report+0x2c0/0x350 [hid]
> [   68.237805]  mousevsc_probe+0x1d5/0x250 [hid_hyperv]
> [   68.237808]  vmbus_probe+0x3b/0xa0 [hv_vmbus]
> [   68.237822]  really_probe+0xee/0x3c0
> [   68.237827]  __driver_probe_device+0x8c/0x180
> [   68.237830]  driver_probe_device+0x24/0xd0
> [   68.237832]  __driver_attach_async_helper+0x6e/0x110
> [   68.237835]  async_run_entry_fn+0x30/0x130
> [   68.237837]  process_one_work+0x178/0x3d0
> [   68.237839]  worker_thread+0x2de/0x410
> [   68.237841]  ? __pfx_worker_thread+0x10/0x10
> [   68.237843]  kthread+0xe1/0x110
> [   68.237847]  ? __pfx_kthread+0x10/0x10
> [   68.237849]  ret_from_fork+0x44/0x70
> [   68.237852]  ? __pfx_kthread+0x10/0x10
> [   68.237854]  ret_from_fork_asm+0x1a/0x30
> [   68.237858]  </TASK>
> [   68.237859] ---[ end trace 0000000000000000 ]---
> [   68.237861] hid-generic 0006:045E:0621.0002: parse failed
> [   68.238276] hv_vmbus: probe failed for device 58f75a6d-d949-4320-99e1-a2a2576d581c (-19)
>
>
>> > 
>> > And the issue seems to be that the corresponding devres group is not
>> > allocated. Normally, devres_open_group() is called from
>> > __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
>> > with 'mousevsc_hid_driver' stub and basically re-implements
>> > __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
>> > devres_open_group(). hid_device_probe() does not call __hid_device_probe()
>> > for it. Later, when the driver is removed, hid_device_remove() calls
>> > devres_release_group() as it doesn't check whether hdev->driver was
>> > initially overridden or not.
>> > 
>> > The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
>> > timely release of driver-allocated resources") but the commit itself seems
>> > to be correct.
>> > 
>> > Fix the issue by dropping the 'hid_dev->driver' override and using
>> > hid_register_driver()/hid_unregister_driver() instead. Alternatively, it
>> > would have been possible to rely on the default handling but
>> > HID_CONNECT_DEFAULT implies HID_CONNECT_HIDRAW and it doesn't seem to work
>> > for mousevsc as-is.
>> > 
>> > Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated resources")
>> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> > Changes since v1:
>> > - Keep custom HID driver for mousevsc but do it properly
>> > [Michael Kelley].
>> > - Add 'Fixes:' tag [Saurabh Singh Sengar].
>> > ---
>> >  drivers/hid/hid-hyperv.c | 58 ++++++++++++++++++++++++++++------------
>> >  1 file changed, 41 insertions(+), 17 deletions(-)
>> > 
>> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> > index f33485d83d24..0fb210e40a41 100644
>> > --- a/drivers/hid/hid-hyperv.c
>> > +++ b/drivers/hid/hid-hyperv.c
>> > @@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_device *hid,
>> >  	return 0;
>> >  }
>> > 
>> > +static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid_device_id *id)
>> > +{
>> > +	int ret;
>> > +
>> > +	ret = hid_parse(hid_dev);
>> > +	if (ret) {
>> > +		hid_err(hid_dev, "parse failed\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
>> > +	if (ret) {
>> > +		hid_err(hid_dev, "hw start failed\n");
>> > +		return ret;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> >  static const struct hid_ll_driver mousevsc_ll_driver = {
>> >  	.parse = mousevsc_hid_parse,
>> >  	.open = mousevsc_hid_open,
>> > @@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
>> >  	.raw_request = mousevsc_hid_raw_request,
>> >  };
>> > 
>> > -static struct hid_driver mousevsc_hid_driver;
>> > +static const struct hid_device_id mousevsc_devices[] = {
>> > +	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
>> > +	{ }
>> > +};
>> > +
>> > +static struct hid_driver mousevsc_hid_driver = {
>> > +	.name = "hid-hyperv",
>> > +	.id_table = mousevsc_devices,
>> > +	.probe = mousevsc_hid_probe,
>> > +};
>> > 
>> >  static int mousevsc_probe(struct hv_device *device,
>> >  			const struct hv_vmbus_device_id *dev_id)
>> > @@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
>> >  	}
>> > 
>> >  	hid_dev->ll_driver = &mousevsc_ll_driver;
>> > -	hid_dev->driver = &mousevsc_hid_driver;
>> >  	hid_dev->bus = BUS_VIRTUAL;
>> >  	hid_dev->vendor = input_dev->hid_dev_info.vendor;
>> >  	hid_dev->product = input_dev->hid_dev_info.product;
>> > @@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device,
>> >  	if (ret)
>> >  		goto probe_err2;
>> > 
>> > -
>> > -	ret = hid_parse(hid_dev);
>> > -	if (ret) {
>> > -		hid_err(hid_dev, "parse failed\n");
>> > -		goto probe_err2;
>> > -	}
>> > -
>> > -	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
>> > -
>> > -	if (ret) {
>> > -		hid_err(hid_dev, "hw start failed\n");
>> > -		goto probe_err2;
>> > -	}
>> > -
>> >  	device_init_wakeup(&device->device, true);
>> > 
>> >  	input_dev->connected = true;
>> > @@ -579,12 +592,23 @@ static struct  hv_driver mousevsc_drv = {
>> > 
>> >  static int __init mousevsc_init(void)
>> >  {
>> > -	return vmbus_driver_register(&mousevsc_drv);
>> > +	int ret;
>> > +
>> > +	ret = hid_register_driver(&mousevsc_hid_driver);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	ret = vmbus_driver_register(&mousevsc_drv);
>> > +	if (ret)
>> > +		hid_unregister_driver(&mousevsc_hid_driver);
>> > +
>> > +	return ret;
>> >  }
>> > 
>> >  static void __exit mousevsc_exit(void)
>> >  {
>> >  	vmbus_driver_unregister(&mousevsc_drv);
>> > +	hid_unregister_driver(&mousevsc_hid_driver);
>> >  }
>> > 
>> >  MODULE_LICENSE("GPL");
>> > --
>> > 2.47.0
>> 
>> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>
> Tested V2 as well, please feel free to  add,
> Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Thank you!

-- 
Vitaly


