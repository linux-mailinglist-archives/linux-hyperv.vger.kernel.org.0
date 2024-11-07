Return-Path: <linux-hyperv+bounces-3280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7D9C00C6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55F31C21E89
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FE1DFE2F;
	Thu,  7 Nov 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI4qPYz3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9581DFDBB
	for <linux-hyperv@vger.kernel.org>; Thu,  7 Nov 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970111; cv=none; b=M570WaRik4RzP/wpQt5E0hCP42x+DfxUKKG5f5xfQQttvmkEk3ox1xU2m2XgmxslYmFftZMovrpAlLcIwbIcWy/QPyWoVggk5AXJ2tLuYOVlcabbjfwaEi0iR3eiq8GuQ5cTAxuUkkkSV4i8lMg6QgeNZvGrdoBggS26NBv/Aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970111; c=relaxed/simple;
	bh=0XFf5Idfo/p9aIS4bMVQuLKCN7U5tkcrKCWkUEx4k/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DhGvJLfI+91K6RJ9eh4G3ZJujvmJASOs3CValUwEKZoiGQALATDMl0YuKY7bCEEjVC99pSf7C7Q6BQcb7tqZexQx5ckgzcfc8qNIBKMYrZ8M7YkYlgTNPpXK8AUY6WRHy5lMj5+oDiLmP0yHxtLtOaF40uMDZsXTZ7AOBNdUYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jI4qPYz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730970108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACjKmBQIwkXpbcHbajGoL4RYtBjvcJsKqLRWnd+m5c4=;
	b=jI4qPYz3CMWVxAMMMmtZiZITegKql57UTwGjvgCYjAqqsYjV1MdO/mcGTEiYAJVOHVNUB5
	xDmzJWXqVGJDj5XwG2JhyWs7qQ4N6NoDufyXeiBlgNGJn5/ScOSE/H6cjDcplRQZ9tANoT
	8De6SPlH6DYJG/HAgCS7inzvERzFVlk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-ZoWfUs48PcCzJMoOFGpxBA-1; Thu, 07 Nov 2024 04:01:47 -0500
X-MC-Unique: ZoWfUs48PcCzJMoOFGpxBA-1
X-Mimecast-MFC-AGG-ID: ZoWfUs48PcCzJMoOFGpxBA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so9479395e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2024 01:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970106; x=1731574906;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACjKmBQIwkXpbcHbajGoL4RYtBjvcJsKqLRWnd+m5c4=;
        b=iyBXPwC0tDqc/zt9d+uYDqjMBn+druy5P8boIWWBop3ObBLyw03YN6uZF4htldDtIa
         sDWOrJpX+0HuPojp5HbftnPBzPn268MaZ72yl7U3bO3keGhTArLUKBttLhxtnh7MZxQO
         ya7xqpPZftX991yn2ZSgn0yT5w91jQUk34wzLbKzY5khywjgIS0ryq/2Lbg3qvmk3B+B
         0SpoDtpCosxTHwO9FUxPwxbt5LtVpBpba0Vp8dUmSyXBRfe7Ms5jgGOFMUeNjKbGCrSR
         9K6cTLuLzAUDNqAXucONfsJ5rENdHoFlqdVz9UEjWvRuvXu+HXMZnQyPft86vA2oak3g
         TlGg==
X-Gm-Message-State: AOJu0Yy0xeK0lrvSs2p+7umGppw/0qh+uCEhZLA4Xffvkwi+JSEIHIoT
	3ZhjOi9b+Arb6RwIHbsdjavbHlIgd+rHWK6xMHpc6w+oVuSjA06KQS2Bxo5W+d1dmejJ7np1AuX
	JQJJ14P/I4UOkthcR0PVL1GcvMrgXjoPXiv7D0jpBc3yfyinvVI0CkE+1zZo8Tw==
X-Received: by 2002:a05:600c:4704:b0:432:7c30:abf3 with SMTP id 5b1f17b1804b1-432af3239camr18503615e9.7.1730970105830;
        Thu, 07 Nov 2024 01:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWlDed+IF1zHNguTvIZKr2OVbiV9IGJsKtc8aVayQ721Zk8PcEGjgIzm3/lNBCJG4Gj0QV1w==
X-Received: by 2002:a05:600c:4704:b0:432:7c30:abf3 with SMTP id 5b1f17b1804b1-432af3239camr18503175e9.7.1730970105264;
        Thu, 07 Nov 2024 01:01:45 -0800 (PST)
Received: from fedora ([213.235.133.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm15676925e9.25.2024.11.07.01.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:01:44 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>
Subject: RE: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
In-Reply-To: <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
 <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <877c9htw1n.fsf@redhat.com>
 <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 07 Nov 2024 10:01:41 +0100
Message-ID: <87ikszv2mi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, November 5, 2024 9:45 AM
>> 
>> Saurabh Singh Sengar <ssengar@linux.microsoft.com> writes:
>> 
>> > On Mon, Nov 04, 2024 at 05:48:24PM +0100, Vitaly Kuznetsov wrote:
>> >> It was found that unloading 'hid_hyperv' module results in a devres
>> >> complaint:
>> >>
>> >>  ...
>> >>  hv_vmbus: unregistering driver hid_hyperv
>> >>  ------------[ cut here ]------------
>> >>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release_group+0x1f2/0x2c0
>> >>  ...
>> >>  Call Trace:
>> >>   <TASK>
>> >>   ? devres_release_group+0x1f2/0x2c0
>> >>   ? __warn+0xd1/0x1c0
>> >>   ? devres_release_group+0x1f2/0x2c0
>> >>   ? report_bug+0x32a/0x3c0
>> >>   ? handle_bug+0x53/0xa0
>> >>   ? exc_invalid_op+0x18/0x50
>> >>   ? asm_exc_invalid_op+0x1a/0x20
>> >>   ? devres_release_group+0x1f2/0x2c0
>> >>   ? devres_release_group+0x90/0x2c0
>> >>   ? rcu_is_watching+0x15/0xb0
>> >>   ? __pfx_devres_release_group+0x10/0x10
>> >>   hid_device_remove+0xf5/0x220
>> >>   device_release_driver_internal+0x371/0x540
>> >>   ? klist_put+0xf3/0x170
>> >>   bus_remove_device+0x1f1/0x3f0
>> >>   device_del+0x33f/0x8c0
>> >>   ? __pfx_device_del+0x10/0x10
>> >>   ? cleanup_srcu_struct+0x337/0x500
>> >>   hid_destroy_device+0xc8/0x130
>> >>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
>> >>   device_release_driver_internal+0x371/0x540
>> >>   driver_detach+0xc5/0x180
>> >>   bus_remove_driver+0x11e/0x2a0
>> >>   ? __mutex_unlock_slowpath+0x160/0x5e0
>> >>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
>> >>   ...
>> >>
>> >> And the issue seems to be that the corresponding devres group is not
>> >> allocated. Normally, devres_open_group() is called from
>> >> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
>> >> with 'mousevsc_hid_driver' stub and basically re-implements
>> >> __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
>> >> devres_open_group(). hid_device_probe() does not call __hid_device_probe()
>> >> for it. Later, when the driver is removed, hid_device_remove() calls
>> >> devres_release_group() as it doesn't check whether hdev->driver was
>> >> initially overridden or not.
>> >>
>> >> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
>> >> timely release of driver-allocated resources") but the commit itself seems
>> >> to be correct.
>> >>
>> >> Fix the issue by dropping the 'hid_dev->driver' override and the
>> >> now unneeded hid_parse()/hid_hw_start() calls. One notable difference of
>> >> the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT which
>> >> implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate issues
>> >> but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in the
>> >> driver for a long time and it is unclear whether hidraw was excluded on
>> >> purpose or not.
>> >>
>> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >
>> > A fixme tag would be helpful.
>> 
>> I concluded that it's the unusual 'hid_dev->driver' override in
>> hid-hyperv to blame and not the 62c68e7cee33 ("HID: ensure timely
>> release of driver-allocated resources") but the override was there since
>> the inception of the driver so I'm not sure, mentioning 62c68e7cee33
>> probably makes more sense...
>
> I've finished looking at the linux-next issue in detail, and I agree that
> the hid_dev->driver override is the underlying cause. I was
> commenting out that line Monday night, but had not gotten as far as
> removing the the hid_parse() and hid_hw_start().  Then your patch
> came out, Vitaly, which is great!
>
>> 
>> >
>> >> ---
>> >>  drivers/hid/hid-hyperv.c | 17 -----------------
>> >>  1 file changed, 17 deletions(-)
>> >>
>> >> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> >> index f33485d83d24..1609a56ffa7c 100644
>> >> --- a/drivers/hid/hid-hyperv.c
>> >> +++ b/drivers/hid/hid-hyperv.c
>> >> @@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
>> >>  	.raw_request = mousevsc_hid_raw_request,
>> >>  };
>> >>
>> >> -static struct hid_driver mousevsc_hid_driver;
>> >> -
>> >>  static int mousevsc_probe(struct hv_device *device,
>> >>  			const struct hv_vmbus_device_id *dev_id)
>> >>  {
>> >> @@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *device,
>> >>  	}
>> >>
>> >>  	hid_dev->ll_driver = &mousevsc_ll_driver;
>> >> -	hid_dev->driver = &mousevsc_hid_driver;
>> >>  	hid_dev->bus = BUS_VIRTUAL;
>> >>  	hid_dev->vendor = input_dev->hid_dev_info.vendor;
>> >>  	hid_dev->product = input_dev->hid_dev_info.product;
>> >> @@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *device,
>> >>  	if (ret)
>> >>  		goto probe_err2;
>> >>
>> >> -
>> >> -	ret = hid_parse(hid_dev);
>> >> -	if (ret) {
>> >> -		hid_err(hid_dev, "parse failed\n");
>> >> -		goto probe_err2;
>> >> -	}
>> >> -
>> >> -	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
>
> As you noted, using HID_CONNECT_DEFAULT in the default probe function
> __hid_device_probe() ends up adding HID_CONNECT_HIDRAW and HID_CONNECT_FF.
> The latter is benign as it only affects devices that support force-feedback. As best I
> can tell, HID_CNNECT_HIDRAW causes /dev/hidraw0 to appear, which provides a raw
> interface to the mouse device. See https://docs.kernel.org/hid/hidraw.html. It doesn't
> seem like making this interface visible hurts anything, but I'm not 100% sure.
>
> The alternative is to keep the "struct hid_driver mousevsc_hid_driver;" line
> and to populate it with a name, id_table, and an HID probe function specific
> to the Hyper-V mouse. Then instead of the incorrect assignment to
> hid_dev->driver, add a
>
> 	module_hid_driver(mousevsc_hid_driver);
>
> statement, which registers the driver. The new HID probe function does
> the hid_parse() and hid_hw_start() which have been removed from
> mousevsc_probe() as your patch does. With this arrangement, the
> hid_hw_start() can be done with the desired HID_CONNECT_*
> options so that /dev/hidraw0 won't appear. It's only a few lines
> of code.
>
> I can try to code up this approach if it is preferred. But I'm likely tied
> up with some personal things for the next few days, so might not get
> to it for a little while. Feel free to try it yourself if you want.
>
> Question: Have you tested your change with an app that consumes
> mouse data in the Hyper-V console window? I was trying to figure
> out a convenient way to do that. I usually install the server version
> of Linux distros and use only the command line, so didn't have a
> mouse-consuming app easily available.

I have tested my patch with a standard Wayland/Gnome UI and I didn't see
any issues because of hidraw. I tried rmmod/modprobe cycle, no trace
appeared and mouse worked well after.

It would be nice to check whether hidraw actually works or not. In
particular, I see that we don't implement .raw_request() hook for
mousevsc (mousevsc_hid_raw_request() exists but always returns 0). I
tried 'hid-example' from samples/hidraw and it gives me:

# ./hid-example 
Report Descriptor Size: 67
Report Descriptor:
5 1 9 2 a1 1 9 1 a1 0 5 9 19 1 29 5 15 0 25 1 95 5 75 1 81 2 95 1 75 3 81 1 5 1 9 30 9 31 15 0 26 ff 7f 75 10 95 2 81 2 5 1 9 38 16 1 80 26 ff 7f 75 10 95 1 81 6 c0 c0 

Raw Name: Microsoft Vmbus HID-compliant Mouse
Raw Phys: 
Raw Info:
	bustype: 6 (Virtual)
	vendor: 0x045e
	product: 0x0621
ioctl HIDIOCSFEATURE returned: 0
ioctl HIDIOCGFEATURE returned: 0
Report data:
	

write() wrote 0 bytes
read: Resource temporarily unavailable

but I can't really tell if this is totally broken or not. In case it is,
your approach to get rid of hidraw sounds reasonable, I can probably try
it early next week or so.

>
>> >> -
>> >> -	if (ret) {
>> >> -		hid_err(hid_dev, "hw start failed\n");
>> >> -		goto probe_err2;
>> >> -	}
>> >> -
>> >>  	device_init_wakeup(&device->device, true);
>> >>
>> >>  	input_dev->connected = true;
>> >> --
>> >> 2.47.0
>> >>
>> >
>> > I have tested this patch, but the original issue reported in commit message is
>> > not observed in latest kernel due to an other error reported by Michael here:
>> > https://lore.kernel.org/linux-hyperv/SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com/
>> >
>> 
>> Let's Cc: Michael then!
>> 
>> > The error addressed by this patch is observed before the commit
>> > "8b7fd6a15f8c: HID: bpf: move HID-BPF report descriptor fixup earlier",
>> > and is resolved by this patch. In fact, this patch appears to fix both issues.
>> >
>> > Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>
> Yes, I agree that Vitaly's patch fixes the problem I observed in linux-next.
> I've looked at the details enough to believe that the fix is the correct fix.
>
>> 
>> Thanks! I was reproducing the issue on 6.12-rc6 by just doing 'rmmod
>> hid_hyperv' and tested my patch there.
>
> FWIW, I also tested device unbind/bind of the VMBus mousevsc device,
> and its companion HID device that is created in mousevsc_probe(). Doing
> unbind/bind for the VMBus mousevsc device works correctly, and the
> companion HID device goes away and comes back as expected. Doing
> unbind/bind for just the HID device also works, and the VMBus
> mousevsc device is not affected, again as expected.
>
> Michael
>

-- 
Vitaly


