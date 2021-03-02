Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2C32B747
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Mar 2021 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhCCKwr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Mar 2021 05:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449078AbhCBQEC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 11:04:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E86C061356;
        Tue,  2 Mar 2021 08:03:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g20so12294012plo.2;
        Tue, 02 Mar 2021 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d4SmVPMKiOaafY7J/CIyGIRDsi1j+B4Mv91x//6bmzU=;
        b=D3uaZJ+uI8cWtUSLALwm1aenlxmUQ2LQW9fPy5EoOJY3AVlqCjj4HPn1qunaRUl9FR
         IxwLFIkHqU99ZQLxyZA6YEqGEsp3HNd9gFQnaILPzvhYBwx8DoQPaeL2R7xz1C8cDBpr
         UuxHpOB4ySqwVfAQS4YP3+NINJOwNsJ8bD5n+MJ0+sZQIJ19RwduJcrfNaeqlXx39MhV
         DZh/kWL3TGbLljXX36nwCw6YK+fgzSFrQkXDniJFyYkw90FWbJu9B7B7QeTz4PeU32/v
         iKsSgDNsBHON9zagiLXm7Z5febn2j39nX/gDpbTrKvQ9eTv6jG5jQk7Wd1kTT/qjvMBA
         ttZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d4SmVPMKiOaafY7J/CIyGIRDsi1j+B4Mv91x//6bmzU=;
        b=LpzI6BiAEHOqm45KM8/bBCjURtB9fSibvUtcaYC4EcLnn/GcDDPfyG5Nd3bwtfLTU0
         KIN6K07mVYw9QnFtqLGfa/H8Qwsrmu8HsI0/PZTJPCrxzMaufse2qdd2imVE7EB0ijYl
         XCWo1/QPYjuFTAIutDCsmb/QMX49JjHxcQOzGun2aw+hJvGS7jP8g2vEaFlMmYAqRkj+
         A20se2Qx6kgO1K8ZXuWyTgM3Soj94quW3QbMnYjoAfrXDgsuTtT6vaLGxV44WD00tX26
         gpa+rQctAevt1iUp1eqLx7V3o54dFxB7XKQfWq+RD4JTLD6nlZUhx/WWE8xxhOUr+g/s
         /QzA==
X-Gm-Message-State: AOAM530WZUVWtUrCqJKgHcnhLJr24m1EB9WsYZQDT83dlDl2j0JQdECA
        QDMcwob2C52weTPOnCwpm64=
X-Google-Smtp-Source: ABdhPJyBBfZPiS5stkHqGOo/Crjxg70pPquR1pYJCP4fsQGEGW+qyvr3JhHs3nhlYiRGBssLtnPkxA==
X-Received: by 2002:a17:902:8b86:b029:e5:bef6:56b0 with SMTP id ay6-20020a1709028b86b02900e5bef656b0mr921109plb.76.1614700995852;
        Tue, 02 Mar 2021 08:03:15 -0800 (PST)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
        by smtp.gmail.com with ESMTPSA id d7sm11231196pfh.73.2021.03.02.08.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 08:03:14 -0800 (PST)
Subject: Re: [EXTERNAL] Re: [RFC PATCH 12/12] HV/Storvsc: Add bounce buffer
 support for Storvsc
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-13-ltykernel@gmail.com>
 <20210301065454.GA3669027@infradead.org>
 <9a5d3809-f1e1-0f4a-8249-9ce1c6df6453@gmail.com>
 <SN4PR2101MB088022E836AEC0838266A8C6C09A9@SN4PR2101MB0880.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <726ac959-de27-62f8-bcd1-d194d685f16b@gmail.com>
Date:   Wed, 3 Mar 2021 00:03:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB088022E836AEC0838266A8C6C09A9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Sunil:
      Thanks for your review.

On 3/2/2021 3:45 AM, Sunil Muthuswamy wrote:
>> Hi Christoph:
>>        Thanks a lot for your review. There are some reasons.
>>        1) Vmbus drivers don't use DMA API now.
> What is blocking us from making the Hyper-V drivers use the DMA API's? They
> will be a null-op generally, when there is no bounce buffer support needed.
> 
>>        2) Hyper-V Vmbus channel ring buffer already play bounce buffer
>> role for most vmbus drivers. Just two kinds of packets from
>> netvsc/storvsc are uncovered.
> How does this make a difference here?
> 
>>        3) In AMD SEV-SNP based Hyper-V guest, the access physical address
>> of shared memory should be bounce buffer memory physical address plus
>> with a shared memory boundary(e.g, 48bit) reported Hyper-V CPUID. It's
>> called virtual top of memory(vTom) in AMD spec and works as a watermark.
>> So it needs to ioremap/memremap the associated physical address above
>> the share memory boundary before accessing them. swiotlb_bounce() uses
>> low end physical address to access bounce buffer and this doesn't work
>> in this senario. If something wrong, please help me correct me.
>>
> There are alternative implementations of swiotlb on top of the core swiotlb
> API's. One option is to have Hyper-V specific swiotlb wrapper DMA API's with
> the custom logic above.

Agree. Hyper-V should have its own DMA ops and put Hyper-V bounce buffer
code in DMA API callback. For vmbus channel ring buffer, it doesn't need 
additional bounce buffer and there are two options. 1) Not call DMA API 
around them 2) pass a flag in DMA API to notify Hyper-V DMA callback
and not allocate bounce buffer for them.

> 
>> Thanks.
>>
>>
>> On 3/1/2021 2:54 PM, Christoph Hellwig wrote:
>>> This should be handled by the DMA mapping layer, just like for native
>>> SEV support.
> I agree with Christoph's comment that in principle, this should be handled using
> the DMA API's
> 
