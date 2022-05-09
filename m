Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655BB51FBAE
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 May 2022 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiEILx4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiEILxz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 07:53:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE7233A60;
        Mon,  9 May 2022 04:50:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d25so12028715pfo.10;
        Mon, 09 May 2022 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=P8Pt48qpDGet0WO3ZKzHwCy7mbKSUJ/hQ+8osFnMYxw=;
        b=Mz5DtpZT7eJ7E/sQndaERILByLw6Fh8Cb0uCLHC2jqIiIasnF30mUpf/BujTN+KEU7
         wL93G7XaVrUzmUcbOz8Bnira9GvY8g51aHwbtV/gWUgBdISHGEaWFDwwlSPPqMQVnHoi
         RrbtTIMr/jUNj/JjITw8S3tXf1C3iWJcaVdiHnrGDGhWa6fqJ4kVVRIQbIXdCI8Ng6JO
         6jLTLzznBp6t3rREyZFuXByuSAM05e25sLPiVS4HXLrWwlJCIyWjnAS3DkTG93q28CbE
         c9ktfxeVwphxBbcJRqG1yoNTMGFgLyueDnKtbT9B2Tm3F4Fz3UvBOGOQNOHmLIvwwxRq
         qnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=P8Pt48qpDGet0WO3ZKzHwCy7mbKSUJ/hQ+8osFnMYxw=;
        b=C9D7ONLXldXZ9vix2Y5crxJA4znAkc9G4OHaPVwJ/budCbuHMz5FRzgNji+DGGBDIv
         NPwJlLCEAZ96b/r0aoLynUMlgwTS0EtuEuZFlEaUKHI4pBj56MWQR5jotDyxLF5UHJWH
         xUCuLM6GfWaoLs9sfBjR4nPREeOelQcgFrDaCopLoGM+rXt4LimhAL1ePAqXNgsvm9cl
         nA1YTNORhMB1xhwAtQ1WIh9771ZKjnK3FN1SJjuUS9e3mFY00+GsBpScBQRYgFxxHRpU
         Ro9QssV1yDXpSIQ4tqd3Qbm4bf50iWruFOCrXAQbKjTLgRjGdmbRcRBRhKv+Rx3NMnSt
         y2Hg==
X-Gm-Message-State: AOAM530olwVhdCe2jwKFN7MANGtwXaLeQU78hx3YLeHctYm5Y90RwjUG
        2G3+M5Lzk0go//i7b3LTAF+jUKvqC0ZjO1+W
X-Google-Smtp-Source: ABdhPJyKtWbdfxfuTYbyjipaToniwqfDmdzUjccHsrWp0pbRq7kPVBMCe3+tK5J2L98uV3ZTDaHNUA==
X-Received: by 2002:a62:31c1:0:b0:50a:4909:2691 with SMTP id x184-20020a6231c1000000b0050a49092691mr15959938pfx.64.1652097001285;
        Mon, 09 May 2022 04:50:01 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::206? ([2404:f801:9000:18:efed::206])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a0002c200b0050dc7628143sm8299420pft.29.2022.05.09.04.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:50:00 -0700 (PDT)
Message-ID: <419605e8-6275-8459-801e-979ea042e5d7@gmail.com>
Date:   Mon, 9 May 2022 19:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH V2 0/2] swiotlb: Add child io tlb mem support
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, robin.murphy@arm.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com,
        m.szyprowski@samsung.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com
References: <20220502125436.23607-1-ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <20220502125436.23607-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/2/2022 8:54 PM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significant lock contention on the swiotlb lock.
> 
> This patch adds child IO TLB mem support to resolve spinlock overhead
> among device's queues. Each device may allocate IO tlb mem and setup
> child IO TLB mem according to queue number. The number child IO tlb
> mem maybe set up equal with device queue number and this helps to resolve
> swiotlb spinlock overhead among devices and queues.
> 
> Patch 2 introduces IO TLB Block concepts and swiotlb_device_allocate()
> API to allocate per-device swiotlb bounce buffer. The new API Accepts
> queue number as the number of child IO TLB mem to set up device's IO
> TLB mem.

Gentile ping...

Thanks.
> 
> Tianyu Lan (2):
>    swiotlb: Add Child IO TLB mem support
>    Swiotlb: Add device bounce buffer allocation interface
> 
>   include/linux/swiotlb.h |  40 ++++++
>   kernel/dma/swiotlb.c    | 290 ++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 317 insertions(+), 13 deletions(-)
> 
