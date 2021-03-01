Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB174327FC8
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Mar 2021 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhCANob (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Mar 2021 08:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhCANoa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Mar 2021 08:44:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432BC061756;
        Mon,  1 Mar 2021 05:43:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so2716170plg.5;
        Mon, 01 Mar 2021 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfAZvtIygNFdBK63fVviAdwDHt8uPCG5pASN7/qd2Kc=;
        b=uQLww7m9+73xMFaqdHyrLxYjc7kc1XasgbudiD0TT7oED3m6p93rjDX3Hyq+8GWXzx
         cf+JynprThekzYhDjCzv6mRCGVaAXzMRfANxEwG+9MnnWkRjPmJOaL1Aalbnzo6+8r5B
         UlNznfSfqW3pWyz/VkJFEd2bOQbbSvOqZN3hDCK6Um1PuDWEUBpE4CW3MbqgqaH6D36d
         gpNotei/kYhV3YXyhSSRHZjtWhaf0rFlwJVZuOEMJWaHTqsEJGYxH/z5fEXrDF1qpMXQ
         +9Rw/AfX+cJUjTrtDJzP5g9nWIgOUBIgSReATuew3i2aQdXBTnamkPZjCV8ApLNDztbe
         x6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfAZvtIygNFdBK63fVviAdwDHt8uPCG5pASN7/qd2Kc=;
        b=ljbnrhn7MbkVnWZrUcSTOxXCRSBYn+rmDpfHydIqKa13e9XFLSWyiI05YKPYcZETOg
         DlxIh+hN+qcg2iQpmsO3QeeymgZpjvDxoq/GGSAxfdhpjdp1GirVwbBgILV8lD66DhgK
         lSMfVItufzD7g0itaoHJdIcTNCfgogeWeDeYW1M3Ht19TvAtKF0mipHQ4KGtCDQKVOYK
         Hnb4kccin9UWQKjlOiKlWLovAqlIOiSZhvrgzypljtTvBbPIVBDDcOtvNHzMH5jg5zpO
         6kGOOl0e4HKhWThew/qMST0MU4Y7UjjpgDUVfOBfgbOG8c3w/YW1F5AAfP4m2RBH4rkQ
         m++A==
X-Gm-Message-State: AOAM530zxTVOGLyj4yaArgc90iRoaeF+dxQ8pZQ4fN+dCMbEe2sbvums
        DruNLqyft3qm69W15wmediA=
X-Google-Smtp-Source: ABdhPJztNTO8OOssYR2Xrrgrpt5t41ko6mjdpqhOv/LpuEBeU6on3uCr23u+NUC38mKfbCt21tAzWA==
X-Received: by 2002:a17:90a:4603:: with SMTP id w3mr17922576pjg.125.1614606230291;
        Mon, 01 Mar 2021 05:43:50 -0800 (PST)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
        by smtp.gmail.com with ESMTPSA id v3sm17156974pff.217.2021.03.01.05.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 05:43:49 -0800 (PST)
Subject: Re: [RFC PATCH 12/12] HV/Storvsc: Add bounce buffer support for
 Storvsc
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
References: <20210228150315.2552437-1-ltykernel@gmail.com>
 <20210228150315.2552437-13-ltykernel@gmail.com>
 <20210301065454.GA3669027@infradead.org>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <9a5d3809-f1e1-0f4a-8249-9ce1c6df6453@gmail.com>
Date:   Mon, 1 Mar 2021 21:43:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301065454.GA3669027@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Christoph:
      Thanks a lot for your review. There are some reasons.
      1) Vmbus drivers don't use DMA API now.
      2) Hyper-V Vmbus channel ring buffer already play bounce buffer 
role for most vmbus drivers. Just two kinds of packets from 
netvsc/storvsc are uncovered.
      3) In AMD SEV-SNP based Hyper-V guest, the access physical address 
of shared memory should be bounce buffer memory physical address plus
with a shared memory boundary(e.g, 48bit) reported Hyper-V CPUID. It's
called virtual top of memory(vTom) in AMD spec and works as a watermark. 
So it needs to ioremap/memremap the associated physical address above 
the share memory boundary before accessing them. swiotlb_bounce() uses
low end physical address to access bounce buffer and this doesn't work 
in this senario. If something wrong, please help me correct me.

Thanks.


On 3/1/2021 2:54 PM, Christoph Hellwig wrote:
> This should be handled by the DMA mapping layer, just like for native
> SEV support.
> 
