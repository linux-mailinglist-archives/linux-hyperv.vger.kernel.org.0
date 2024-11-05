Return-Path: <linux-hyperv+bounces-3264-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E99BD3AC
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3611F222DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Nov 2024 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45B1E3791;
	Tue,  5 Nov 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoMFJbCi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D151E5735
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Nov 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828684; cv=none; b=mkgICObl+54pQ+6NiU1baMWiia915xPOQ2TMtBGzCepKniqvbXgw6R570+EBiZO9qaRK85w4EM9Y/iXm9fno52ZIjK+DE8CA1y25zBXymcLUZ+B3p2mqTgBGFBl/axglvV0FyUQgQXDgkzHzgKmtC1BI5wpXKX1c2amauDkMNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828684; c=relaxed/simple;
	bh=gDzLrINgfVtRbrz8ISTxrBxrW8vBnVT0Zr8IfF/kQio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0fj0Cogewt63QvVoVrRfi6qPpD9msMYd0/xXjmw7tktiajKmg+gPDR+ETphIMMNVpEFQR+peBGAYpj9zAVXAQBcxlfQu8bjk0kbZR1cYq3505rinISsj3q0sPK5ppihxkDAAT6Elm1M3tNiLTe7cmLACUV3/iHzkzecOK2t5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoMFJbCi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730828681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJc+m/8eSug2jV44rIxLzKEMZCl/ZEAJC+KZbHNsHGc=;
	b=KoMFJbCimyeRfRMd8A+kW6mnBbiSRIQtMhInW2VH3Vs7O+cHXJnsTxjy9fTL9UTm+JqtUr
	ZWuCgE4BO5qklFP16SWkNEUz28GVZvAaXgtZqJUVvT5HwzyEEgH9SfNZn4fvh5JmW/i0M+
	xyTvu49uBrUOtE+KQNMSb2Sgr6/Y2Sw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-iSt2YDYHOcmkHfxGUhqnxw-1; Tue, 05 Nov 2024 12:44:40 -0500
X-MC-Unique: iSt2YDYHOcmkHfxGUhqnxw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso40448955e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Nov 2024 09:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828678; x=1731433478;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJc+m/8eSug2jV44rIxLzKEMZCl/ZEAJC+KZbHNsHGc=;
        b=Gg98KQordi/Vi/7hLhRK57Ecg7GzkB13VCi9yZudwePepCRAYu91d/JwQclXUR3U5A
         ZlWfiE1hO4kpYDiRd3/osexD/9gAO/pI0DGAYDs/fJZnSNlZ1fJtcdCoFqVRXjW+6pcY
         rFqtpesiEDVMvYkDkLfpabF2xqgV6/SFaWBx7tu+9oSlsA5VMTnhjwVhKJR5kf9l55rc
         11gm+q8lT2CaoXTT2BtztCV0oqHZAU71dcwPp0wSa5eKuTKvGbvxcVipHx0eSnHI4BHT
         dCTUAXZfvdu9G062H5o23tXUqZZbR5DhPMeYG0ruXJ2Kg9UG49hcVhfBa3JXtuALiqxQ
         5cEw==
X-Gm-Message-State: AOJu0Yxo/dpoROp1K1FE42g3FYx4rRYblFaAthPJOC1CMOTz0em2KZm6
	cJ43hd7JkNLSDEdYokL+Lextvkc3EjnMiype6c7T4xtusn88YiifSVXT1PwqULdNgicQgO24wvJ
	7HPiAjp7tnszeK70FBm2Gj6uxItNZQ8GfsLpmOaDAx7GbpaHWCzMyS8b5N2DQ+A==
X-Received: by 2002:a05:6000:1a8c:b0:37d:4ebe:1650 with SMTP id ffacd0b85a97d-381be907958mr16994904f8f.46.1730828678232;
        Tue, 05 Nov 2024 09:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDYpjCWzF8DoioV9OVq2/Y64CA9zuGDGV8jhmTXtoMRxtUohS406WzsjpuNdVUvW9GmMi03Q==
X-Received: by 2002:a05:6000:1a8c:b0:37d:4ebe:1650 with SMTP id ffacd0b85a97d-381be907958mr16994878f8f.46.1730828677843;
        Tue, 05 Nov 2024 09:44:37 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd8asm16911065f8f.73.2024.11.05.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:44:37 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, mhklinux@outlook.com
Cc: linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
In-Reply-To: <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
 <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Tue, 05 Nov 2024 18:44:36 +0100
Message-ID: <877c9htw1n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saurabh Singh Sengar <ssengar@linux.microsoft.com> writes:

> On Mon, Nov 04, 2024 at 05:48:24PM +0100, Vitaly Kuznetsov wrote:
>> It was found that unloading 'hid_hyperv' module results in a devres
>> complaint:
>> 
>>  ...
>>  hv_vmbus: unregistering driver hid_hyperv
>>  ------------[ cut here ]------------
>>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691 devres_release_group+0x1f2/0x2c0
>>  ...
>>  Call Trace:
>>   <TASK>
>>   ? devres_release_group+0x1f2/0x2c0
>>   ? __warn+0xd1/0x1c0
>>   ? devres_release_group+0x1f2/0x2c0
>>   ? report_bug+0x32a/0x3c0
>>   ? handle_bug+0x53/0xa0
>>   ? exc_invalid_op+0x18/0x50
>>   ? asm_exc_invalid_op+0x1a/0x20
>>   ? devres_release_group+0x1f2/0x2c0
>>   ? devres_release_group+0x90/0x2c0
>>   ? rcu_is_watching+0x15/0xb0
>>   ? __pfx_devres_release_group+0x10/0x10
>>   hid_device_remove+0xf5/0x220
>>   device_release_driver_internal+0x371/0x540
>>   ? klist_put+0xf3/0x170
>>   bus_remove_device+0x1f1/0x3f0
>>   device_del+0x33f/0x8c0
>>   ? __pfx_device_del+0x10/0x10
>>   ? cleanup_srcu_struct+0x337/0x500
>>   hid_destroy_device+0xc8/0x130
>>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
>>   device_release_driver_internal+0x371/0x540
>>   driver_detach+0xc5/0x180
>>   bus_remove_driver+0x11e/0x2a0
>>   ? __mutex_unlock_slowpath+0x160/0x5e0
>>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
>>   ...
>> 
>> And the issue seems to be that the corresponding devres group is not
>> allocated. Normally, devres_open_group() is called from
>> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
>> with 'mousevsc_hid_driver' stub and basically re-implements
>> __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
>> devres_open_group(). hid_device_probe() does not call __hid_device_probe()
>> for it. Later, when the driver is removed, hid_device_remove() calls
>> devres_release_group() as it doesn't check whether hdev->driver was
>> initially overridden or not.
>> 
>> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
>> timely release of driver-allocated resources") but the commit itself seems
>> to be correct.
>> 
>> Fix the issue by dropping the 'hid_dev->driver' override and the
>> now unneeded hid_parse()/hid_hw_start() calls. One notable difference of
>> the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT which
>> implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate issues
>> but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in the
>> driver for a long time and it is unclear whether hidraw was excluded on
>> purpose or not.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> A fixme tag would be helpful.

I concluded that it's the unusual 'hid_dev->driver' override in
hid-hyperv to blame and not the 62c68e7cee33 ("HID: ensure timely
release of driver-allocated resources") but the override was there since
the inception of the driver so I'm not sure, mentioning 62c68e7cee33
probably makes more sense...

>
>> ---
>>  drivers/hid/hid-hyperv.c | 17 -----------------
>>  1 file changed, 17 deletions(-)
>> 
>> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> index f33485d83d24..1609a56ffa7c 100644
>> --- a/drivers/hid/hid-hyperv.c
>> +++ b/drivers/hid/hid-hyperv.c
>> @@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_driver = {
>>  	.raw_request = mousevsc_hid_raw_request,
>>  };
>>  
>> -static struct hid_driver mousevsc_hid_driver;
>> -
>>  static int mousevsc_probe(struct hv_device *device,
>>  			const struct hv_vmbus_device_id *dev_id)
>>  {
>> @@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *device,
>>  	}
>>  
>>  	hid_dev->ll_driver = &mousevsc_ll_driver;
>> -	hid_dev->driver = &mousevsc_hid_driver;
>>  	hid_dev->bus = BUS_VIRTUAL;
>>  	hid_dev->vendor = input_dev->hid_dev_info.vendor;
>>  	hid_dev->product = input_dev->hid_dev_info.product;
>> @@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *device,
>>  	if (ret)
>>  		goto probe_err2;
>>  
>> -
>> -	ret = hid_parse(hid_dev);
>> -	if (ret) {
>> -		hid_err(hid_dev, "parse failed\n");
>> -		goto probe_err2;
>> -	}
>> -
>> -	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
>> -
>> -	if (ret) {
>> -		hid_err(hid_dev, "hw start failed\n");
>> -		goto probe_err2;
>> -	}
>> -
>>  	device_init_wakeup(&device->device, true);
>>  
>>  	input_dev->connected = true;
>> -- 
>> 2.47.0
>> 
>
> I have tested this patch, but the original issue reported in commit message is
> not observed in latest kernel due to an other error reported by Michael here:
> https://lore.kernel.org/linux-hyperv/SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com/
>

Let's Cc: Michael then!

> The error addressed by this patch is observed before the commit
> "8b7fd6a15f8c: HID: bpf: move HID-BPF report descriptor fixup earlier",
> and is resolved by this patch. In fact, this patch appears to fix both issues.
>
> Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Thanks! I was reproducing the issue on 6.12-rc6 by just doing 'rmmod
hid_hyperv' and tested my patch there.

-- 
Vitaly


