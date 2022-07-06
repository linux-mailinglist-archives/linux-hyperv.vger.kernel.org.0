Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81D568239
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiGFI5u (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGFI5q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 04:57:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D124BEE;
        Wed,  6 Jul 2022 01:57:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 3so3669483pfx.3;
        Wed, 06 Jul 2022 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9bOXUBsbXZmaBYzdut2n91pd8GDpqQDkHHTCpALSOcI=;
        b=WbD1If6fFhm+DWvJ31AEQrrcggmBAVShmCuXjXNLR/EVZnRJUDmLjPBezh+u8N3upE
         GXKjZxORcv3nTuTsXheqqTeRS4skn7EUMwPYGKEcKo3ObhN6T6QIWqvqxX6Jr8F8QElY
         /FFM0dQQSlpothQOx+YeobkCdnpTL1e0JIO9lvz1yIw30dwxN0fdT4a7Kza3H9j4qj6X
         xkNgj8iH/9xz6YGbQQGnLUiRk7GZcv/bnxehkOG5U5RMwAvat4EhTh1NTM/tC6yV7UUl
         l/1BXoGHW0yM0j0TcLjhlJm98q9lR4zh/p+boW25L80TLyb3fhDy9DvPsO/ZJQjltXZE
         u58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9bOXUBsbXZmaBYzdut2n91pd8GDpqQDkHHTCpALSOcI=;
        b=3tyE3cz2re6g7D14fKZd/H+Q76R52jkAQIuJdgU6zCnU0WrfvZGFErC18cN0lfLelO
         0eTLU08/2gyLmZI53VaFLR+yFX9AXKv9UYOmk32jHmWo/5I242aeWjRjC+PTd+nnk5CS
         7UkrNTsxNcwIZjAFmNy7Ltk5iCloOGDnKoNKW+IfLtyH5RWBS8B+Uf5lslWCcSObES8N
         k3lqFuUMiBmTrQX9O3reEAAVgAaG2VkwFcMtaHNzRgS41+AN8IG3fUHxdapVswIsriyz
         vJEndRKqkL5eRaXP2dVzA1DQLiHaukfjpdFYl/8kVzKpjmNx10j81p55PGYbQZc186EI
         cFLg==
X-Gm-Message-State: AJIora+g3bwc+phzOW9iejv6A+30SfjHOW2tz5NaqGyZt0kfRUw/gKtq
        1fImLsu+S7JX5zvFSCO5VvI=
X-Google-Smtp-Source: AGRyM1sYGXX9loS3JRKD0954hjKimsXBBNwAgBw0D8WiC3yUj6I/JN7LKTG9QaIQg312XdOckDYv7w==
X-Received: by 2002:a05:6a00:1303:b0:528:2ed8:7e86 with SMTP id j3-20020a056a00130300b005282ed87e86mr29108564pfu.4.1657097864729;
        Wed, 06 Jul 2022 01:57:44 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b0016bf7981d0bsm2501495plh.86.2022.07.06.01.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:57:43 -0700 (PDT)
Message-ID: <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
Date:   Wed, 6 Jul 2022 16:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vkuznets@redhat.com, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
 <YsVBKgxiQKfnCjvn@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YsVBKgxiQKfnCjvn@infradead.org>
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

On 7/6/2022 4:00 PM, Christoph Hellwig wrote:
> On Fri, Jul 01, 2022 at 01:02:21AM +0800, Tianyu Lan wrote:
>>> Can we reorder that initialization?  Because I really hate having
>>> to have an arch hook in every architecture.
>>
>> How about using "flags" parameter of swiotlb_init() to pass area number
>> or add new parameter for area number?
>>
>> I just reposted patch 1 since there is just some coding style issue and area
>> number may also set via swiotlb kernel parameter. We still need figure out a
>> good solution to pass area number from architecture code.
> 
> What is the problem with calling swiotlb_init after nr_possible_cpus()
> works?

Swiotlb_init() is called in the mem_init() of different architects and
memblock free pages are released to the buddy allocator just after
calling swiotlb_init() via memblock_free_all().

The mem_init() is called before smp_init(). If calling swiotlb_init()
after smp_init(), that means we can't allocate large chunk low end
memory via memblock_alloc() in the swiotlb(). Swiotlb_init() needs
to rework to allocate memory from the buddy allocator and just like
swiotlb_init_late() does. This will limit the bounce buffer size.
Otherwise We need to do the reorder for all achitectures and there maybe
some other unknown issues.

swiotlb flags parameter of swiotlb_init() seems to be a good place to
pass the area number in current code. If not set the swiotlb_area
number/flag, the area number will be one and keep the original behavior
of one single global spinlock protecting io tlb data structure.














