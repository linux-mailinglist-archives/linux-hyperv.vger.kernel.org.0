Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86C5284FB
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 May 2022 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiEPNJM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 May 2022 09:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiEPNJH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 May 2022 09:09:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DE13E82;
        Mon, 16 May 2022 06:09:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q76so14018400pgq.10;
        Mon, 16 May 2022 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hhS13NV1du4/5RVMnn0KKcWVRMzgQIx1d7kjkoctpig=;
        b=dqff7cEf+YiKcmpwvNHD98s9Y/gznpGA1n0UHShTOIF3V276B2JTqhQx62EHWto6Na
         xlKvL+P4npCqLCAegGKQ3FS+rLpmko+BwMvn7n7lj72p8KeYb3ZQmz1YKYU2IR0yPnDH
         KRELbnohr2g5t0EdQnYkhgRaXNRU/ZgmtM+BrNSFtLCKLOWqSiXKggCLNUBvoPdLJcBE
         9yP7JlJVBM5rPQM0yOV8kqj4U4zCHkVT9mvKvfvhfvWmU2GQwY2dvyTESAYdT38dKpJW
         whanVpLF8jEGJqgaFIqkTaUg3sdKBBBKYtLguWa6zwHNzvGIU+a08GpAer4TE+DI8hNS
         uKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=hhS13NV1du4/5RVMnn0KKcWVRMzgQIx1d7kjkoctpig=;
        b=SHPL81aTBygGnv7I/N1yvO5KhNq5U397POzh7P7A1pEg8qZymN9h5/ISNp31KtItbP
         +ZdoIcsUr+pLhe7VF5vCuF6lSHjqxr11v2GjWGuTh7grJgpxlv1Qvu5gJmNWHYYP1ssS
         uPUCZ0n5EeuxDW9Sgd1NDq8c4Cu1RIBFS6vdv8AgE6knOI4nQ1tlCy1VWoXYqYhuqHbq
         vR/ARqLP2mphwcVLI289nlvXnV4Tkr/C0BhiIlHxiw8isozS1ia+gACwADbAHZtPLmAW
         C0aIFQtrVgAGhB3pfNYaGqLnS3dNzbFW14AdvFgseOX0JEDVKKrlBTXHPBvxw1mfE7bq
         3Bew==
X-Gm-Message-State: AOAM530Rp95IB72KcbYpsHl6qjjupTME0DuZGRoht6ATScWvAWK1iC91
        ty3Ao1553tldTjeQhQZvD48=
X-Google-Smtp-Source: ABdhPJy5OzuugvWNhSWVWfm3wmq6awyPhqi3qnfEcfsdsTuOnu5O0udXQ9MhGMXCLG+FQx4ZyJQnQQ==
X-Received: by 2002:a63:1645:0:b0:3c2:4706:f62b with SMTP id 5-20020a631645000000b003c24706f62bmr15556314pgw.11.1652706546139;
        Mon, 16 May 2022 06:09:06 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
        by smtp.gmail.com with ESMTPSA id ju10-20020a17090b20ca00b001df313f6628sm3135246pjb.21.2022.05.16.06.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 06:09:05 -0700 (PDT)
Message-ID: <ad2f9bcb-1aa7-0a35-942f-6a5f674823fe@gmail.com>
Date:   Mon, 16 May 2022 21:08:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: tiala@microsoft.com
Subject: Re: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <YoH+mbxQAp/2XGyG@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/16/2022 3:34 PM, Christoph Hellwig wrote:
> I don't really understand how 'childs' fit in here.  The code also
> doesn't seem to be usable without patch 2 and a caller of the
> new functions added in patch 2, so it is rather impossible to review.

Hi Christoph:
      OK. I will merge two patches and add a caller patch. The motivation
is to avoid global spin lock when devices use swiotlb bounce buffer and
this introduces overhead during high throughput cases. In my test
environment, current code can achieve about 24Gb/s network throughput
with SWIOTLB force enabled and it can achieve about 40Gb/s without
SWIOTLB force. Storage also has the same issue.
      Per-device IO TLB mem may resolve global spin lock issue among
devices but device still may have multi queues. Multi queues still need
to share one spin lock. This is why introduce child or IO tlb areas in
the previous patches. Each device queues will have separate child IO TLB
mem and single spin lock to manage their IO TLB buffers.
      Otherwise, global spin lock still cost cpu usage during high 
throughput even when there is performance regression. Each device queues 
needs to spin on the different cpus to acquire the global lock. Child IO
TLB mem also may resolve the cpu issue.

> 
> Also:
> 
>   1) why is SEV/TDX so different from other cases that need bounce
>      buffering to treat it different and we can't work on a general
>      scalability improvement

	Other cases also have global spin lock issue but it depends on
         whether hits the bottleneck. The cpu usage issue may be ignored.

>   2) per previous discussions at how swiotlb itself works, it is
>      clear that another option is to just make pages we DMA to
>      shared with the hypervisor.  Why don't we try that at least
>      for larger I/O?

	For confidential VM(Both TDX and SEV), we need to use bounce
	buffer to copy between private memory that hypervisor can't
	access directly and shared memory. For security consideration,
	confidential VM	should not share IO stack DMA pages with
        	hypervisor directly to avoid attack from hypervisor when IO
	stack handles the DMA data.
	
