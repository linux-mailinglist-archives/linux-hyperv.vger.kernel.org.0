Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E265A37AC
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Aug 2022 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiH0Mqx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Aug 2022 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiH0Mqw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Aug 2022 08:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F344506A
        for <linux-hyperv@vger.kernel.org>; Sat, 27 Aug 2022 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661604410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inruV9tiW8qwXrnkVI+Ao+ITZBbbO5sFc1aw762dWrY=;
        b=AR4s0pdDMsMU1McxfZABuUAI0PgnZK5dXtD6za75yrSWMUuJ57xTTzbnhiBLZORsWCXTsF
        G4JaKpwPiOpKU0BuuoPNOV9ccHnVAAZrgdEJRVxLN2oAgnpvWl6AfjXwL3b3c2b8e5YS7J
        E/8pJfwLQJogsjYDv5isXHxfpWAZYHE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-Lw7YU1nTOq-wlb7qhGYFmQ-1; Sat, 27 Aug 2022 08:46:49 -0400
X-MC-Unique: Lw7YU1nTOq-wlb7qhGYFmQ-1
Received: by mail-ed1-f69.google.com with SMTP id i6-20020a05640242c600b00447c00a776aso2744722edc.20
        for <linux-hyperv@vger.kernel.org>; Sat, 27 Aug 2022 05:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=inruV9tiW8qwXrnkVI+Ao+ITZBbbO5sFc1aw762dWrY=;
        b=R240ca6zoGmJYtWb0rKiMscd9348fDrGdN4XoBnq0MtKUfvuRKY3GcnmCZgz5rQrsI
         nE4UNP3ja98RSKHoZ4TTM/IiJ6S/UTaO3Nvt1/Khj5CLQ/I22eFayTT3aDONima3bF+B
         I7KbpgR8n/uTtx6FuwYQbYWdDmFtcrYYXcpG8ks1CQGtThaFGJwPxd48l9YQNj17eY6N
         ul1sq3BKVGadw/RoL6fQT2IbFOEuGwulzayVKbBgkVUDXSdq7dfOZ/pBO+OANSwfoUiC
         IHumwD4ZI5zq/zZAkGvSvoo8yMAhA6FYUEQQe/ptEXAbX72rjnaLcpz0oj1d/ZMhS7NW
         v1jA==
X-Gm-Message-State: ACgBeo2OHxyyaevuG+lGd2+TswxuTdNggEkIeKRNTlG/7Ur3VYhWvg+K
        hrbLwezmatcq5sUKjOSLv9FBeoqmrrGixeE0UfqyGWqPs0sI0A0OrEw18+dtJj0Q9rE8/LaS7Wp
        iFUvmgcJgpvfxdvofwKUou+Zc
X-Received: by 2002:a17:907:6890:b0:73d:a567:568c with SMTP id qy16-20020a170907689000b0073da567568cmr8053177ejc.521.1661604408243;
        Sat, 27 Aug 2022 05:46:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5TSxNxFhHIWUgDFGh6o2o5A2lHYsq2gKou43zUNTrXz2A2rDfHNazARFNTXYh+19y8woSsTQ==
X-Received: by 2002:a17:907:6890:b0:73d:a567:568c with SMTP id qy16-20020a170907689000b0073da567568cmr8053169ejc.521.1661604408027;
        Sat, 27 Aug 2022 05:46:48 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cb11-20020a0564020b6b00b0044841a78c70sm104257edb.93.2022.08.27.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:46:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 3/3] Drivers: hv: Never allocate anything besides
 framebuffer from framebuffer memory region
In-Reply-To: <SN6PR2101MB16935E50795FAE1FA352C416D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20220825090024.1007883-1-vkuznets@redhat.com>
 <20220825090024.1007883-4-vkuznets@redhat.com>
 <SN6PR2101MB16935E50795FAE1FA352C416D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
Date:   Sat, 27 Aug 2022 14:46:46 +0200
Message-ID: <87k06tvop5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 25, 2022 2:00 AM
>> 
>> Passed through PCI device sometimes misbehave on Gen1 VMs when Hyper-V
>> DRM driver is also loaded. Looking at IOMEM assignment, we can see e.g.
>> 
>> $ cat /proc/iomem
>> ...
>> f8000000-fffbffff : PCI Bus 0000:00
>>   f8000000-fbffffff : 0000:00:08.0
>>     f8000000-f8001fff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
>> ...
>> fe0000000-fffffffff : PCI Bus 0000:00
>>   fe0000000-fe07fffff : bb8c4f33-2ba2-4808-9f7f-02f3b4da22fe
>>     fe0000000-fe07fffff : 2ba2:00:02.0
>>       fe0000000-fe07fffff : mlx4_core
>> 
>> the interesting part is the 'f8000000' region as it is actually the
>> VM's framebuffer:
>> 
>> $ lspci -v
>> ...
>> 0000:00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA
>> (prog-if 00 [VGA controller])
>> 	Flags: bus master, fast devsel, latency 0, IRQ 11
>> 	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
>> ...
>> 
>>  hv_vmbus: registering driver hyperv_drm
>>  hyperv_drm 5620e0c7-8062-4dce-aeb7-520c7ef76171: [drm] Synthvid Version major 3, minor 5
>>  hyperv_drm 0000:00:08.0: vgaarb: deactivate vga console
>>  hyperv_drm 0000:00:08.0: BAR 0: can't reserve [mem 0xf8000000-0xfbffffff]
>>  hyperv_drm 5620e0c7-8062-4dce-aeb7-520c7ef76171: [drm] Cannot request framebuffer, boot fb still active?
>> 
>> Note: "Cannot request framebuffer" is not a fatal error in
>> hyperv_setup_gen1() as the code assumes there's some other framebuffer
>> device there but we actually have some other PCI device (mlx4 in this
>> case) config space there!
>
> My apologies for not getting around to commenting on the previous
> version of this patch.  The function hyperv_setup_gen1() and the
> "Cannot request framebuffer" message have gone away as of
> commit a0ab5abced55.
>

True, will fix!

>> 
>> The problem appears to be that vmbus_allocate_mmio() can allocate from
>> the reserved framebuffer region (fb_overlap_ok), however, if the
>> request to allocate MMIO comes from some other device before
>> framebuffer region is taken, it can happily use framebuffer region for
>> it. 
>
> Interesting. I had never looked at the details of vmbus_allocate_mmio().
> The semantics one might assume of a parameter named "fb_overlap_ok"
> aren't implemented because !fb_overlap_ok essentially has no effect.   The
> existing semantics are really "prefer_fb_overlap".  This patch implements
> the expected and needed semantics, which is to not allocate from the frame
> buffer space when !fb_overlap_ok.
>
> If that's an accurate high level summary, maybe this commit message
> could describe it that way?  The other details you provide about what can
> go wrong should still be included as well.

That's acually a very good summary! Let me update the commit message,
I'll be sending out v3 shortly.

>
>> Note, Gen2 VMs are usually unaffected by the issue because
>> framebuffer region is already taken by EFI fb (in case kernel supports
>> it) but Gen1 VMs may have this region unclaimed by the time Hyper-V PCI
>> pass-through driver tries allocating MMIO space if Hyper-V DRM/FB drivers
>> load after it. Devices can be brought up in any sequence so let's
>> resolve the issue by always ignoring 'fb_mmio' region for non-FB
>> requests, even if the region is unclaimed.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/vmbus_drv.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 536f68e563c6..3c833ea60db6 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2331,7 +2331,7 @@ int vmbus_allocate_mmio(struct resource **new, struct
>> hv_device *device_obj,
>>  			bool fb_overlap_ok)
>>  {
>>  	struct resource *iter, *shadow;
>> -	resource_size_t range_min, range_max, start;
>> +	resource_size_t range_min, range_max, start, end;
>>  	const char *dev_n = dev_name(&device_obj->device);
>>  	int retval;
>> 
>> @@ -2366,6 +2366,14 @@ int vmbus_allocate_mmio(struct resource **new, struct
>> hv_device *device_obj,
>>  		range_max = iter->end;
>>  		start = (range_min + align - 1) & ~(align - 1);
>>  		for (; start + size - 1 <= range_max; start += align) {
>> +			end = start + size - 1;
>> +
>> +			/* Skip the whole fb_mmio region if not fb_overlap_ok */
>> +			if (!fb_overlap_ok && fb_mmio &&
>> +			    (((start >= fb_mmio->start) && (start <= fb_mmio->end)) ||
>> +			     ((end >= fb_mmio->start) && (end <= fb_mmio->end))))
>> +				continue;
>> +
>>  			shadow = __request_region(iter, start, size, NULL,
>>  						  IORESOURCE_BUSY);
>>  			if (!shadow)
>> --
>> 2.37.1
>
> Other than my musings on the commit message,
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>

Thanks!

-- 
Vitaly

