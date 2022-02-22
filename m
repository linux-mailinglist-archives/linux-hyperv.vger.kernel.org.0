Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855754BFBEF
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiBVPID (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiBVPHz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 10:07:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76F10A7FA;
        Tue, 22 Feb 2022 07:07:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso2835207pjs.1;
        Tue, 22 Feb 2022 07:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A0la35tNJG/t3KT4ifjVJqnO2+6KZI4cizqAVsM0shA=;
        b=Z+UShjS78aAT5Tl3+/AV+OD6pcYvg0Lhm0mNhZBRILwY71LwT0JOYNJt0BTHlItsLx
         AB5YQ9KmBE1O08Uku5rCaKzNG3iupQ0oT9IwMu2loGgSy3NuWG2md/M6cC6/+zzF58XC
         gHNfRLi4HKzrIUna5mBUo7DzQ1JS5v+JmzO21IkD227FdBMX24MgRyeqmG7EdGlTg5B1
         rjGvhfccoDS0TrhVAJx5BaYAca7lEbbeB+UNaSrkKOt1D2qonEtK98NSlY2dtwp+BqOu
         J4BCndcEzAcAj0t43P7FlIaFqLqaIQC37JNEmZ60QeOdZcLYlkyCkZlXVz+0V7VVNgnf
         fAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A0la35tNJG/t3KT4ifjVJqnO2+6KZI4cizqAVsM0shA=;
        b=Np8Hi9hHxkiIziEoMW3ewekiPMcUoV03cTZaAxHJ8jGOAShDEBOgqcs0ELWgnUZjEf
         dlICUSexqC0nfN4IrateE3KYXS40xb2RoKCT6mZVU6BKt8ENDg42+bfyI0ZU171fiFif
         UJM4PI0eeJFLMFA3Jiqn0ow5Xk5CRG9Mp8gRafInzA3gErX3OLRxyDXUev7AJXMu7lbU
         jr+uQ5OehPdhf7mfjY3AYqZPQHiv+5MWWlI9o5JPmvxHIspoqrJJOWIe9+ubacpswVHA
         ca7rbn82T9E6qEHWdZQzyhYUnmh/ymgEj3qyMSFEnHSUTyM71DhdpFNoTkDr/ABOZ5Ls
         zFCw==
X-Gm-Message-State: AOAM531vEFw0QUn8TAJNWvYew7QZGWOq94FioRCzISvvMnyiYE6QIg51
        wwyN+Efj06yX7w7Zk6pKrbc=
X-Google-Smtp-Source: ABdhPJxjZkuvhI0jYoEUrZ80PpIgvPyPzdJ2YaYFn255LvM62G54tIqeHQLdgJWP9o8kfhl7eScsWA==
X-Received: by 2002:a17:90b:4b92:b0:1b7:aca7:b2f3 with SMTP id lr18-20020a17090b4b9200b001b7aca7b2f3mr4632014pjb.169.1645542449216;
        Tue, 22 Feb 2022 07:07:29 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm2949253pjn.34.2022.02.22.07.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:07:28 -0800 (PST)
Message-ID: <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
Date:   Tue, 22 Feb 2022 23:07:19 +0800
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
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220222080543.GA5412@lst.de>
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



On 2/22/2022 4:05 PM, Christoph Hellwig wrote:
> On Mon, Feb 21, 2022 at 11:14:58PM +0800, Tianyu Lan wrote:
>> Sorry. The boot failure is not related with these patches and the issue
>> has been fixed in the latest upstream code.
>>
>> There is a performance bottleneck due to io tlb mem's spin lock during
>> performance test. All devices'io queues uses same io tlb mem entry
>> and the spin lock of io tlb mem introduce overheads. There is a fix patch
>> from Andi Kleen in the github. Could you have a look?
>>
>> https://github.com/intel/tdx/commit/4529b5784c141782c72ec9bd9a92df2b68cb7d45
> 
> Please post these things to the list.
> 
> But I suspect the right answer for the "secure" hypervisor case is to
> use the per-device swiotlb regions that we've recently added.

Thanks for your comment. That means we need to expose an 
swiotlb_device_init() interface to allocate bounce buffer and initialize
io tlb mem entry. DMA API Current  rmem_swiotlb_device_init() only works
for platform with device tree. The new API should be called in the bus
driver or new DMA API. Could you check whether this is a right way 
before we start the work.

Thanks.

