Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0704B7056
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Feb 2022 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbiBOPj1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Feb 2022 10:39:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiBOPjW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Feb 2022 10:39:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B85F12BF74;
        Tue, 15 Feb 2022 07:32:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 10so13367538plj.1;
        Tue, 15 Feb 2022 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FBiiPLPd7+SxOKLK0aIlgBvmX6QhgUZILG2dW+7FR74=;
        b=VahgQg1aE4Q1WwSRu/onKUxVYusoGE7A0NZya041wsiB0hGdWZPSC+YkJF54JCcbV0
         GxboLQcl2O+XxOOI55HQDACuUC4gJF14nUwST4D0X/SDv6IwBWpLjbcMgQ6s7sl2YJYk
         aWWS4HeXlHhWUN/ZuSFJZJ7Ocy1DVg0RkntPRtLnmonVKjuJE/yo5AJ+YwVfpsW4QKhH
         V95rhbfecsSX7EC2sKuuEn1qolUVWHjjz+jp9hlQaWicj4l3coURFekSjwZ86lwSU9VM
         2u4HJ1eNS1nSrETG2qv99BoKVZMcVlzX6bbYvyyRcCeHfZr/rBqgayhrIiEf/xPLweeb
         sqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FBiiPLPd7+SxOKLK0aIlgBvmX6QhgUZILG2dW+7FR74=;
        b=TiYX41yrb2gmXwc+1tSjmLtGzSOSnz3JycllTmF8cv5falTAmbkZvBErKV0zceB9Dd
         GBJYABq3p9mngPeNan72+H9htUoxSdb2ONmXNczAlDbaaz+Pgo0xQEbSo1LzCwhIeqFp
         egEztOQx6R25ku9hZ2jjTxcrXJsydXaP7ELwvtQlRnRkAWto9BSNJNnc/+yVY057K63F
         I10DPc5gnejVIQNMBrGjC2lp0Yo60znlikiXH6K0RadcOJ3Q70d9ZmgMpmNtmqqJHqPn
         Ix31RoC/0VuTddfq3rVqbI+yk4l2dZme6zPduquCN+TsRz0SFlokX+2IPQSFgy48trhN
         1sxQ==
X-Gm-Message-State: AOAM532lxioj8aPV9NyFLbRdYIXfwLxL2Oz+Ctz01m4AwIqlua6zPp37
        QWCI2ZHc8SYmlwyGz3QaKRQ=
X-Google-Smtp-Source: ABdhPJyeBo29foNKLBgSDKrg7awYd2jwbDbxYcS+BFn21/cqlDPFYCebhzbjY4jE9940TBqU6OXztA==
X-Received: by 2002:a17:90b:4c8a:: with SMTP id my10mr4871894pjb.97.1644939162155;
        Tue, 15 Feb 2022 07:32:42 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
        by smtp.gmail.com with ESMTPSA id g6sm20301632pfv.158.2022.02.15.07.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:32:41 -0800 (PST)
Message-ID: <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
Date:   Tue, 15 Feb 2022 23:32:32 +0800
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
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220214135834.GA30150@lst.de>
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

On 2/14/2022 9:58 PM, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 07:28:40PM +0800, Tianyu Lan wrote:
>> On 2/14/2022 4:19 PM, Christoph Hellwig wrote:
>>> Adding a function to set the flag doesn't really change much.  As Robin
>>> pointed out last time you should fine a way to just call
>>> swiotlb_init_with_tbl directly with the memory allocated the way you
>>> like it.  Or given that we have quite a few of these trusted hypervisor
>>> schemes maybe add an argument to swiotlb_init that specifies how to
>>> allocate the memory.
>>
>> Thanks for your suggestion. I will try the first approach first approach.
> 
> Take a look at the SWIOTLB_ANY flag in this WIP branch:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-init-cleanup
> 
> That being said I'm not sure that either this flag or the existing powerpc
> code iѕ actually the right thing to do.  We still need the 4G limited
> buffer to support devices with addressing limitations.  So I think we need
> an additional io_tlb_mem instance for the devices without addressing
> limitations instead.
> 

Hi Christoph:
      Thanks for your patches. I tested these patches in Hyper-V trusted 
VM and system can't boot up. I am debugging and will report back.


	
