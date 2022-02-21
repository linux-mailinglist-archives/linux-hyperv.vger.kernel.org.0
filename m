Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3414BE826
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiBUPPc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 10:15:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiBUPPb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 10:15:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978B01B792;
        Mon, 21 Feb 2022 07:15:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i21so9120192pfd.13;
        Mon, 21 Feb 2022 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=rQjzrJUBJUG4lrXY3qHLoN254Z+Hvh/Va/Cpr5SArPA=;
        b=YB37ZflfT9ggqvpHpDLeP8hKKD9vSOva3ZaRBtd3tgoeYOYCGS/+oOCm9dvs5+8Wr3
         9m9VOC1yL/2ha0cc8D9+MLPdWVL5Y0UtghNB+2KfdcOAl7UfAZ8JSEDIDQBuBUpsSd05
         YfAu3GG7/z4rqLLCa7Ur4F0fYf79Ri2KUmBE/N+KsRRrqtnuzULfCX1i78dghi1zf+0V
         qqA4m2PtIrmFeaTmVPH+e1otxTv9qMz0z/PuOXXfneytP+fflzqJ+CmI32BrqCWU5OSE
         gO9FLaK9LU2vQkti/b7TlzQvzfLpeNUkv9G8DzVCo2XbOtXOO6yJyP7LVqqCye+nyFjk
         aOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rQjzrJUBJUG4lrXY3qHLoN254Z+Hvh/Va/Cpr5SArPA=;
        b=EFK/rFEd9gikuyKiWbUGzHEGnOmAWkAiEEZs80wrvdsewoDm/fFALgu4oPhl8qE+4U
         UAA0q+YnHuPr3MAGzO5sWOm48ov3eDfqAzSxUE2KEH6N5kfl1pca+ZrwnC0Zc5JfgMEH
         Xf6GNceec4IUnAKVL4TLXhd58PFW8OPNK9AymlG8j6iqS4D8FDaYjwNiZAToBHzP2jyk
         Rd/jo8paskmL5yRl2e9FdbYmPRlyfo5fYqG9dL0xmD/BxsRVz9ZfJpz3xppXh6ADvi1H
         Bgme72af55TFUDFX5JNSx71FzG5oADak5uiW7apTlLHSz+PUaosYyBQkUdaz91DhJLA0
         2v1w==
X-Gm-Message-State: AOAM533cy5au6LDYRJCaDxjse2oEwJLk7ja3LWLE+3K1avJ/h7JzUu3l
        vn9TGiMzFZiDpuwZ0cARxRU=
X-Google-Smtp-Source: ABdhPJylmsV+h5d8jn8qiDmtwnHSxu0TXVS9IMCo+KFkNe8tAnqXy4KJ+vAfQkmA12bMTt5jor+fkw==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr2835424pgb.616.1645456506920;
        Mon, 21 Feb 2022 07:15:06 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:1a:efea::754])
        by smtp.gmail.com with ESMTPSA id s2sm13819900pfk.3.2022.02.21.07.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 07:15:06 -0800 (PST)
Message-ID: <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
Date:   Mon, 21 Feb 2022 23:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
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
In-Reply-To: <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
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

On 2/15/2022 11:32 PM, Tianyu Lan wrote:
> On 2/14/2022 9:58 PM, Christoph Hellwig wrote:
>> On Mon, Feb 14, 2022 at 07:28:40PM +0800, Tianyu Lan wrote:
>>> On 2/14/2022 4:19 PM, Christoph Hellwig wrote:
>>>> Adding a function to set the flag doesn't really change much.  As Robin
>>>> pointed out last time you should fine a way to just call
>>>> swiotlb_init_with_tbl directly with the memory allocated the way you
>>>> like it.  Or given that we have quite a few of these trusted hypervisor
>>>> schemes maybe add an argument to swiotlb_init that specifies how to
>>>> allocate the memory.
>>>
>>> Thanks for your suggestion. I will try the first approach first 
>>> approach.
>>
>> Take a look at the SWIOTLB_ANY flag in this WIP branch:
>>
>>     
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-init-cleanup 
>>
>>
>> That being said I'm not sure that either this flag or the existing 
>> powerpc
>> code iѕ actually the right thing to do.  We still need the 4G limited
>> buffer to support devices with addressing limitations.  So I think we 
>> need
>> an additional io_tlb_mem instance for the devices without addressing
>> limitations instead.
>>
> 
> Hi Christoph:
>       Thanks for your patches. I tested these patches in Hyper-V trusted 
> VM and system can't boot up. I am debugging and will report back.

Sorry. The boot failure is not related with these patches and the issue
has been fixed in the latest upstream code.

There is a performance bottleneck due to io tlb mem's spin lock during
performance test. All devices'io queues uses same io tlb mem entry
and the spin lock of io tlb mem introduce overheads. There is a fix 
patch from Andi Kleen in the github. Could you have a look?

https://github.com/intel/tdx/commit/4529b5784c141782c72ec9bd9a92df2b68cb7d45

Thanks.

