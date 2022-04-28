Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F99513915
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349659AbiD1P5z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348580AbiD1P5y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:57:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9CB8997;
        Thu, 28 Apr 2022 08:54:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t13so4623905pfg.2;
        Thu, 28 Apr 2022 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zOz9eswdSnbnlgCE4u1qshAALQqhtjly6s/zYnzoZDo=;
        b=CM62eKY9hR/wJXqj/fSH1DWGMTfmyPZhE42jrqWpTk5Tb5UjPt5F2utBvVAHO90tMY
         3t/ROcUikaw6dA1pndL0nQIZHAWw7CHz2ijI3vAnTb2LOxXel+3BjBnwmEEdvR5slL1r
         x7bKFNpKvom0Vy8PQaUKmxn2OhId2Ft71PWmd51R0Lyv14320aqUgcV+KZDD4AGU0LGc
         f8Qeoi1XC8mKXU8DoC5GD+hiQ5XxLtzd3Ni45nZLjnWgbYk1el+uPGdE9w1GKTgO96W1
         3cFh014HSIYspHjf9ETJZdpmsDQV4A5Z8dp5g0PlTJlj1S58K3vf/i1sySaiR+h5q38Y
         qoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zOz9eswdSnbnlgCE4u1qshAALQqhtjly6s/zYnzoZDo=;
        b=PaLPsutr9rYWbnMFmkVnqNmva0hn++dghpIyu6nNEGoMVnJ2/S6rG9HGo/rFY4XIST
         rpdwTZx7VGkIH8e+dZIXxbYKpWrNlCu5oTdViNZM3CKCyxptdvbbwvjiifER8yXYGRuc
         i7dhBzt7Q7E2B8NQoJm9zzKVnrmSQxNPrhBxrUJmuiruxVfLvLMMMvrrmQYcbrZ02qaU
         JQPDpfftGrX9JB7ySf36fAJDD46G2o9gdIRA54/uc+ENDgqqj7DXeNoKd94wOGqe+pkh
         VVTszk4nwj/5QmcrYnO+Se+j/lZBowjHHhg31wk5X/UNYP9fBZcDydUUXWiJ9GLVKVpV
         n7rw==
X-Gm-Message-State: AOAM5332gy8+sOBECfFxpQBjdtX1RmI13U81zQ9mGQ7dHvxyjnnE0plQ
        uSPoD/KIrJYDzNRu7jRbufs=
X-Google-Smtp-Source: ABdhPJzy1CMlqjk+9uNH6NdqFcYpmSfdQG+AYRCnlMaOyH7EMI9Q+gIoiuOMIk5Wll/bh8zkd0CnAA==
X-Received: by 2002:a63:bd49:0:b0:39d:a2d3:94a2 with SMTP id d9-20020a63bd49000000b0039da2d394a2mr28279423pgp.242.1651161278983;
        Thu, 28 Apr 2022 08:54:38 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
        by smtp.gmail.com with ESMTPSA id 16-20020a621410000000b0050aca5f79f5sm261023pfu.97.2022.04.28.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:54:38 -0700 (PDT)
Message-ID: <8c390129-4fb3-dd7c-cf83-0451c405d0b9@gmail.com>
Date:   Thu, 28 Apr 2022 23:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, hch@infradead.org,
        m.szyprowski@samsung.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com
Cc:     parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/28/2022 10:44 PM, Robin Murphy wrote:
> On 2022-04-28 15:14, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Traditionally swiotlb was not performance critical because it was only
>> used for slow devices. But in some setups, like TDX/SEV confidential
>> guests, all IO has to go through swiotlb. Currently swiotlb only has a
>> single lock. Under high IO load with multiple CPUs this can lead to
>> significat lock contention on the swiotlb lock.
>>
>> This patch splits the swiotlb into individual areas which have their
>> own lock. When there are swiotlb map/allocate request, allocate
>> io tlb buffer from areas averagely and free the allocation back
>> to the associated area. This is to prepare to resolve the overhead
>> of single spinlock among device's queues. Per device may have its
>> own io tlb mem and bounce buffer pool.
>>
>> This idea from Andi Kleen 
>> patch(https://github.com/intel/tdx/commit/4529b578
>> 4c141782c72ec9bd9a92df2b68cb7d45). Rework it and make it may work
>> for individual device's io tlb mem. The device driver may determine
>> area number according to device queue number.
> 
> Rather than introduce this extra level of allocator complexity, how 
> about just dividing up the initial SWIOTLB allocation into multiple 
> io_tlb_mem instances?
> 
> Robin.

Agree. Thanks for suggestion. That will be more generic and will update
in the next version.

Thanks.

