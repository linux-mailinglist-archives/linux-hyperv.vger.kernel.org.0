Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE71557E22
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jun 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiFWOst (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jun 2022 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiFWOss (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jun 2022 10:48:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7EC46B2C;
        Thu, 23 Jun 2022 07:48:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p14so13637466pfh.6;
        Thu, 23 Jun 2022 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NsGuoNrKOwZi4+BNGtJiyK4WoJSitQyKFNOmJMq17xI=;
        b=V2o5Ehf6KJjGJXdWPnxArGMA5u68nQNPZm7nxJHmFuS/1tpE8JNXxg6GBlNJgaPPFx
         aHia/s+4wZmGBIBYLMsxrA+XRCg6ZpCdlq6zLzoLvli88rxxGavMue/9OT7OT3l1BM55
         +csszujMGX+HWqrj4ur/ALcKQDaY4XtH5XJq8fu39qbhOw92BJxEfFc/zpJfoeTNOTC6
         h//c8jmvej323nlLvc3FLJ99uDvgbHaaIdsIuQ7rUf1rCytujpZNamgA7f/awCe3P5eN
         AmkU52yJCHoMG8iHVNNcHGDzcQF7lHfYKcZoIB60QvPyYQ4tVM30wxbPngmCd0owLbfs
         /Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NsGuoNrKOwZi4+BNGtJiyK4WoJSitQyKFNOmJMq17xI=;
        b=3FJdMerhZ8rQm337MFWCC3lMZJln7EyUBht1zNZZi94FnZw166JSoD1Q7p3jU8pziq
         3IbqShoSrapt/wHB5fy/kYdd/4tYsb4uxkfN57xmOXdD2X18KMbgq0BSdZ8rKPRO1bHJ
         0/PfqzDQghWNaVNf4d7pIJlGtqOsakNQHgIlHrKEWUMWhjwj63jOmXTvoF6A9KGnhukP
         J54Y7zNqZnumIh9xc7wqtdpg58PfBLFA+PVXPFYPnFYsN9t69B9vplL1b0XWI03g97Qn
         bXkvx1YhCRESSIvhF9fcPYLdRJEFD9j+KByNefTB5gitrNNK8DJ/uLnWT1CTZGiPwDF3
         iSZg==
X-Gm-Message-State: AJIora/T/WsGJG+CDZ2gYDsLomJ0rpTOGj4XI0aK6mE7a2B9erpOO5Tx
        6YHu8MyYqrv7MI+FRugsYBk=
X-Google-Smtp-Source: AGRyM1uvG03JMk59g0aypaxhEUWEhGYWbNHLb64IATh4yVcG+Esi2oTV7YSoyn9H7gBse6gMRy873A==
X-Received: by 2002:a63:f415:0:b0:408:808b:238f with SMTP id g21-20020a63f415000000b00408808b238fmr7684450pgi.469.1655995725433;
        Thu, 23 Jun 2022 07:48:45 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79159000000b00522c0a75c39sm15815422pfi.196.2022.06.23.07.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:48:44 -0700 (PDT)
Message-ID: <d80ad697-ed71-6671-c4ea-a7ca5883f65e@gmail.com>
Date:   Thu, 23 Jun 2022 22:48:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH V4 1/1] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, akpm@linux-foundation.org, bp@suse.de,
        tglx@linutronix.de, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
References: <20220617144741.921308-1-ltykernel@gmail.com>
 <YrL02y/fYxDkDRlA@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YrL02y/fYxDkDRlA@infradead.org>
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

On 6/22/2022 6:54 PM, Christoph Hellwig wrote:
> Thanks,
> 
> this looks pretty good to me.  A few comments below:
> 

Thanks for your review.

> On Fri, Jun 17, 2022 at 10:47:41AM -0400, Tianyu Lan wrote:
>> +/**
>> + * struct io_tlb_area - IO TLB memory area descriptor
>> + *
>> + * This is a single area with a single lock.
>> + *
>> + * @used:	The number of used IO TLB block.
>> + * @index:	The slot index to start searching in this area for next round.
>> + * @lock:	The lock to protect the above data structures in the map and
>> + *		unmap calls.
>> + */
>> +struct io_tlb_area {
>> +	unsigned long used;
>> +	unsigned int index;
>> +	spinlock_t lock;
>> +};
> 
> This can go into swiotlb.c.

struct io_tlb_area is used in the struct io_tlb_mem.

> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas);
> 
> And this should be marked static.
> 
>> +#define DEFAULT_NUM_AREAS 1
> 
> I'd drop this define, the magic 1 and a > 1 comparism seems to
> convey how it is used much better as the checks aren't about default
> or not, but about larger than one.
> 
> I also think that we want some good way to size the default, e.g.
> by number of CPUs or memory size.

swiotlb_adjust_nareas() is exposed to platforms to set area number.
When swiotlb_init() is called, smp_init() isn't called at that point and
so standard API of checking cpu number (e.g, num_online_cpus()) doesn't
work. Platforms may have other ways to get cpu number(e.g x86 may ACPI
MADT table entries to get cpu nubmer) and set area number. I will post 
following patch to set cpu number via swiotlb_adjust_nareas(),

> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas)
>> +{
>> +	if (!is_power_of_2(nareas)) {
>> +		pr_err("swiotlb: Invalid areas parameter %d.\n", nareas);
>> +		return;
>> +	}
>> +
>> +	default_nareas = nareas;
>> +
>> +	pr_info("area num %d.\n", nareas);
>> +	/* Round up number of slabs to the next power of 2.
>> +	 * The last area is going be smaller than the rest if
>> +	 * default_nslabs is not power of two.
>> +	 */
> 
> Please follow the normal kernel comment style with a /* on its own line.
> 

OK. Will update.
