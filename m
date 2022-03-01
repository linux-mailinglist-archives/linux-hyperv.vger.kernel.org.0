Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFA4C8D35
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiCAOCT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCAOCT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 09:02:19 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE2985BD;
        Tue,  1 Mar 2022 06:01:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 195so14488128pgc.6;
        Tue, 01 Mar 2022 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F/G/xOe5a6nu2fkfw8uYGgqkNpKpcFX9OCeRV8lAMEA=;
        b=M/WZf0dAladje4iv4F/hGYw9kuGhDb1eMm48tQLJEnoRzblIt/aaanhWYp0t9h/V3M
         SuaN66brC8T6KHk+R352mSC/VcYpyj2kjP8Ez3Pql0l0SR3cJnKqcNDtz3DeI3ap70EY
         Dw9fSmqgFY6SnfEnzJTOVO/8sM7qM+TG8qri/2MqjQvfLBNT2Eg+xxxc18Rs2QnPbwVe
         nyT3fQITL+d+iJXkZ/aLWAK6khTJABVSLpet4naIZNrsJC8rk6DSCLvu0OE0mcsJNfqz
         q5Wv//Jl1c/DV9aXHGm0x0OOLuU9+/G4Z6Paou3BJS59ZU0TiD78jiaA9ZFpmpiSMOk6
         /JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F/G/xOe5a6nu2fkfw8uYGgqkNpKpcFX9OCeRV8lAMEA=;
        b=ncTDZ/MhIgK0O9YItmw9/te0DqzwUlL+XR9x9rr4ZeVOKTOddpM6ThypMl2HPYClrd
         xvdquSV0tdlq5ijKuyodUE2UHoXNMjiPUZtocRHB+YFydNeEPpBf/RojVdfKO8a3543+
         SYfFGcQ/m8KDYZQyUN9McmTDuwoJYzHMpPZONSgWFJNOV8XDCrKN0Uks5LcPn2WBBfBh
         RlnbhjzuA2hXnqqp4WYCGB6yVXrmQd3lyJzqMN4CqNL4r5fbDKUoDKGhFJjNc4gDDDdZ
         S/5Jo3Pv9UnJgmUF2P3B2Loo103AKulZ3X2JmVF5fBZdZ6gZNDFGqq1zgcFxqtYcicof
         a0tQ==
X-Gm-Message-State: AOAM531NTl9Cyt7czEiwBVA8emgZJ7uBjJH5ZGPu5mY+Q01CNALGuFWE
        nQaUhiTehsnNDNmoFrCHjnc=
X-Google-Smtp-Source: ABdhPJxvTIlnU3gMQxETAVp/xnqA49sq44Qij7ZknsOWr166EOYo94ZbcpGEHGEGivB+qWQ6chrIaQ==
X-Received: by 2002:a63:b06:0:b0:374:5e1a:150a with SMTP id 6-20020a630b06000000b003745e1a150amr21702994pgl.137.1646143297904;
        Tue, 01 Mar 2022 06:01:37 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b004e1cee6f6b4sm17730734pfu.47.2022.03.01.06.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:01:37 -0800 (PST)
Message-ID: <f76c15c5-9ee4-a825-73c8-223564a26d74@gmail.com>
Date:   Tue, 1 Mar 2022 22:01:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
 <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
 <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
 <20220301115340.GA3077@lst.de>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220301115340.GA3077@lst.de>
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

On 3/1/2022 7:53 PM, Christoph Hellwig wrote:
> On Fri, Feb 25, 2022 at 10:28:54PM +0800, Tianyu Lan wrote:
>>       One more perspective is that one device may have multiple queues and
>> each queues should have independent swiotlb bounce buffer to avoid spin
>> lock overhead. The number of queues is only available in the device
>> driver. This means new API needs to be called in the device driver
>> according to queue number.
> 
> Well, given how hell bent people are on bounce buffering we might
> need some scalability work there anyway.

According to my test on the local machine with two VMs, Linux guest 
without swiotlb bounce buffer or with the fix patch from Andi Kleen can
achieve about 40G/s throughput but it's just 24-25G/s with current 
swiotlb code. Otherwise, the spinlock contention also consumes more cpu 
usage.





