Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1D4C0F7B
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 10:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiBWJrR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 04:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiBWJrQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 04:47:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB340923;
        Wed, 23 Feb 2022 01:46:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l19so14813425pfu.2;
        Wed, 23 Feb 2022 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JB14j33OIPs1OGizD0q9pEqsxND8clVKLhTJqZTYOEc=;
        b=h2qK/+1UhNIaADfvFYzi0SHlb7e0Q/Ppl0nuTgX88goT4YiO3WoB5x46n31RnWQ6FK
         rQ4PIPSEy2IREvN5KHI8eBNErn2eu0xq7kJOc7Lsk6hL9nFBEZTEIqB9LIfQc57AsnlE
         jklVKf/CwE3i1EgmHTfY/xIbeY7EXJq/gdSgDKa4kPAUU7gnMj/Q7eQDHW+8r9xv2I46
         Rs3Zjq+UJKWXzGx0Kz3M/QjATpgD7wR8rIpeH7gvrh7sXAFhUgUUP7eeRTEZ2chkYNWr
         xE/Bula0Tta+VO7n7NXnjhT4SJwVZ5qhrEjLUkxA5BUaY8HcNlW07ZOUTpNcXW+bIO5n
         2ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JB14j33OIPs1OGizD0q9pEqsxND8clVKLhTJqZTYOEc=;
        b=4LwCRglPTs7OOeBIdOjUaA5pc5zldCxdSbsV3Wqrk+uollVwQxdJexOGshxuTpCpuo
         bGYXfJ9wbh4gfk7E2FGmMNg9rFjnI4rdFq3sOaq0o64yg6eOwM8ryxfUR0ZPBT7BnxsU
         p7IaXNFFrvlze93PRJOCSIey8a/nEWuuJb2uWYSGfQsWNVzYQvsklxtqQW3V9SboTZkc
         Q5muL1hY1e5wdUqF3J6+0IQnacFvzjkx5PuFsh7HsPlDO+38SWcXW38jF9PHWE/BrrIk
         sdVCfodz6D+e85HJGS8ZHSieKRhFN2tpdk2yItCWcn2v36vjK3oNW1BwTftq3f2SPmn1
         LD/g==
X-Gm-Message-State: AOAM530MfTebnevAqEzTU/EJONHIjtvgbsJ0E8NBoAH2jyAWMTfz73H5
        xL109eR7AnCxaVEhEqjrruI=
X-Google-Smtp-Source: ABdhPJwO+VZiM9CHOaWQb//I+ozQnEAAeKik4xggTRSisdu0hPGa/PxgcNPeZUw+9X4py3EPVZSr8A==
X-Received: by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with SMTP id b18-20020a056a000a9200b004e057a72d5dmr29045712pfl.81.1645609607206;
        Wed, 23 Feb 2022 01:46:47 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
        by smtp.gmail.com with ESMTPSA id w2sm19827467pfb.139.2022.02.23.01.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 01:46:46 -0800 (PST)
Message-ID: <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
Date:   Wed, 23 Feb 2022 17:46:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
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
        parri.andrea@gmail.com, thomas.lendacky@amd.com
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220222160039.GA13380@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 2/23/2022 12:00 AM, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 11:07:19PM +0800, Tianyu Lan wrote:
>> Thanks for your comment. That means we need to expose an
>> swiotlb_device_init() interface to allocate bounce buffer and initialize
>> io tlb mem entry. DMA API Current  rmem_swiotlb_device_init() only works
>> for platform with device tree. The new API should be called in the bus
>> driver or new DMA API. Could you check whether this is a right way before
>> we start the work.
> 
> Do these VMs use ACPI?  We'd probably really want some kind of higher
> level configuration and not have the drivers request it themselves.

Yes, Hyper-V isolation VM uses ACPI. Devices are enumerated via vmbus 
host and there is no child device information in ACPI table. The host 
driver seems to be the right place to call new API.
