Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FF4C476F
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiBYO3f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 09:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBYO3f (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 09:29:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026F1DAC7B;
        Fri, 25 Feb 2022 06:29:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so8597428pjt.0;
        Fri, 25 Feb 2022 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=t5YAbD7vQEX4bsWhAei3DxtoVuv5IKfWxA+u2Ae9wAc=;
        b=NP47JcMNbHTMaUVy2mFxwWKAGJCIZ5XI3xAKbinOX0FQzqETFGEAcGIzKvoDi0UG6W
         HZP3q4+jxZCHBNlcy8v9M7OHMswMZT+GtnAqmjrOVZiINQh8soFHCFPirFR90K62IElR
         lCCB5VWl2SgVc2wDrNuGdgPEOHwDiRY7TRbt0qzE17Yx61PAVKkesmm5fxkskIFz5y6Y
         GiUcyvTh5f5NIN0FbZpeoTM16xTsGSx+VjPRP+OLtzbz5EOuXBSXXPS8fkkixD9Ss5RO
         IIzb1nDTqfBZ4seDQeDXZs/L9GMzxm7/II5xNHNMKAn6db2MYSsUmM6cmDI1TCpcloq2
         NaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=t5YAbD7vQEX4bsWhAei3DxtoVuv5IKfWxA+u2Ae9wAc=;
        b=rHL/XFmeXNQvjgqGVJWUOSU/0XduUkdYtnFJQxrwf6flDALNbrp0GpNvVag7AKzXWO
         +MceT6EzXQSsWz8osieIzNJNveHQNtKejWRKNrc1xH730Bn6TFmp+4zivsN+8qGByyRi
         ndH4dcZCO/6FXBi6+B4iJHUdW87BIklj9kSfazwov+3Ul+7dIRk+Al8PWc6ZWiBwF3JY
         9YEyJhgHh6ifqVq8SVOtnr2diXbPmwMd1Va4572sZP81CoFmYvH/BKLRFcpBGaKUPMsP
         e8uYSHmKZSSaEceKPpn3PEqEH7Hq0jAW/rJQuoRGsMHQfHhgpgR7ahGrvmAoPOyXCJ92
         hTuQ==
X-Gm-Message-State: AOAM533QMeaRE+d6P/T6CR/msEj+Q4zfzU2qmqw9xaNS3eEVeZ2XuGuq
        FSv8sO+8L4YrSPO7rMqzUVk=
X-Google-Smtp-Source: ABdhPJy1vgdWztGWyuXhqHpDnH/bi2diPYr1uqAWpxAf+YpS6SsZOmGBIXvXpz8SCpBBcZGUV9yxRg==
X-Received: by 2002:a17:902:db01:b0:150:274a:d314 with SMTP id m1-20020a170902db0100b00150274ad314mr3890912plx.52.1645799342814;
        Fri, 25 Feb 2022 06:29:02 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm3751492pfl.70.2022.02.25.06.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 06:29:02 -0800 (PST)
Message-ID: <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
Date:   Fri, 25 Feb 2022 22:28:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
 <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
In-Reply-To: <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/23/2022 5:46 PM, Tianyu Lan wrote:
> 
> 
> On 2/23/2022 12:00 AM, Christoph Hellwig wrote:
>> On Tue, Feb 22, 2022 at 11:07:19PM +0800, Tianyu Lan wrote:
>>> Thanks for your comment. That means we need to expose an
>>> swiotlb_device_init() interface to allocate bounce buffer and initialize
>>> io tlb mem entry. DMA API Current  rmem_swiotlb_device_init() only works
>>> for platform with device tree. The new API should be called in the bus
>>> driver or new DMA API. Could you check whether this is a right way 
>>> before
>>> we start the work.
>>
>> Do these VMs use ACPI?  We'd probably really want some kind of higher
>> level configuration and not have the drivers request it themselves.
> 
> Yes, Hyper-V isolation VM uses ACPI. Devices are enumerated via vmbus 
> host and there is no child device information in ACPI table. The host 
> driver seems to be the right place to call new API.

Hi Christoph:
      One more perspective is that one device may have multiple queues 
and each queues should have independent swiotlb bounce buffer to avoid 
spin lock overhead. The number of queues is only available in the device
driver. This means new API needs to be called in the device driver 
according to queue number.
