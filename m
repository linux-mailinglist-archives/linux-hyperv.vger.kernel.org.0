Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13D568558
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGFKWC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 06:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiGFKVj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 06:21:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55D2714D;
        Wed,  6 Jul 2022 03:21:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m14so13286771plg.5;
        Wed, 06 Jul 2022 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UzsK5A/Pd2DS/q+pu2TPIXsF74uXoZ2jR8FiWqOBTf0=;
        b=jPknnkWS+HyznwuLvLZ32EFNaMi2kYHUveXX06LBsxWi8WWk54fdGGslOYuaNSzAC1
         +C/+81V/BTWAnyuW8zpzEOQ+3m5kTKePsPyILyW85ZxloaLy8smIa1RrjtcLHK+50AnN
         yH5/1g7GUFT38DXkivHkyB65dBQ5OBuhhzy8EUzkCEJTf3ZiONObArhVTtB/OcViMTCO
         X8KJZBJU4Y7DZ7cizzptUG1IJyL3aKSnpY0xM5e5mg68r1rnl3nGzJWE9g1ZeO/yvMHJ
         7jvS9E7520rHkopiOmyafXJGnjCstN3kCYMy2ZH1/+Y8EfKqhyAZCsV/fFXXHCJrvG+e
         ygDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UzsK5A/Pd2DS/q+pu2TPIXsF74uXoZ2jR8FiWqOBTf0=;
        b=w2Y6SpmJBMIP8pXWlIVkOuLu0pbSMIpNPyIM57uEV3EpEgf4KrkJWXTBPF1fkEzlzk
         3fjU0rN2xN/hQyIl3nVIbu/4f35SanMyY5MH5PLpgvUCGC4IknXEB1H71B7jei9iEN1C
         Nh07tWJCVfBAaI0AJh8yJ1TOAfLiVvfItTSP35E/c+yX9ijfmK1nOkqw6FEhft2onbP5
         GtujuryDzNnKM3yhd8BWxEg4gUPoavz2sVhbsdgpLp7Y2eJSPUx58xjPKQEuqg63244C
         g8JYmAt/zwanWcDzlhPT9lj/X8GSQ98Q/3N8u2u+YxNGjVipJvdTCvISXwz1VlbcWV33
         dFOg==
X-Gm-Message-State: AJIora9HhR2u8Q3E16508TwNPd967xYkTau5ZDOBObafM29Dcav9ET0f
        J7u/ZP2RySDr7b4/ze+q/PM=
X-Google-Smtp-Source: AGRyM1u62ff8Zjp/L+wMPt2MQjdQjkuAxTYu9AnfGkSn1v7kxGjrvXqT5UyLr/SkNP7QrlRhVQcR8g==
X-Received: by 2002:a17:90a:c7cc:b0:1ef:775e:8df1 with SMTP id gf12-20020a17090ac7cc00b001ef775e8df1mr26574178pjb.28.1657102874543;
        Wed, 06 Jul 2022 03:21:14 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id w21-20020a656955000000b0041282c423e6sm2085990pgq.71.2022.07.06.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:21:13 -0700 (PDT)
Message-ID: <71242da1-8a7a-53ca-06d6-7a1363141bd8@gmail.com>
Date:   Wed, 6 Jul 2022 18:21:02 +0800
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
 <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
 <YsVPwYGHUoctAKjs@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YsVPwYGHUoctAKjs@infradead.org>
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

On 7/6/2022 5:02 PM, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 04:57:33PM +0800, Tianyu Lan wrote:
>> Swiotlb_init() is called in the mem_init() of different architects and
>> memblock free pages are released to the buddy allocator just after
>> calling swiotlb_init() via memblock_free_all().
> 
> Yes.
> 
>> The mem_init() is called before smp_init().
> 
> But why would that matter?  cpu_possible_map is set up from
> setup_arch(), which is called before that.

Sorry. I just still focus online cpu number and the number is got after
smp_init(). Possible cpu number includes some offline cpus. I will have 
a try. Thanks for suggestion.
