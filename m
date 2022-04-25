Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B450E638
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 18:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiDYQzn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiDYQzm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 12:55:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E781A046;
        Mon, 25 Apr 2022 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650905558; x=1682441558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AgfX5/2iQb8JHqqi1XJskglaQs20L2PujAVkMJ7391c=;
  b=guWduVqxNNHNPcsGXutz/B8Ub9xwwyo2Sccrj5VhQuDSIEdxxC7hBc1G
   DP17e8T3ZAR4w4Ch5pWNGxBiWz1NQNszGgxs11z/DsRCZTuiPxyndOPVZ
   gxl/d67L3iUxrGrmk3RJepjVK+MEkDiuie5Uise8hp/07Tez6Vfutgi/1
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Apr 2022 09:52:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:52:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 09:52:28 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 09:52:27 -0700
Message-ID: <adbcd493-3821-b0d7-c4e4-4fcd92dd5a14@quicinc.com>
Date:   Mon, 25 Apr 2022 10:52:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] PCI: hv: Fix multi-MSI to allow more than one MSI
 vector
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <decui@microsoft.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <jakeo@microsoft.com>,
        <bjorn.andersson@linaro.org>, <linux-hyperv@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1649856981-14649-1-git-send-email-quic_jhugo@quicinc.com>
 <2100eed4-8081-6070-beaf-7c6ba65ad9be@quicinc.com>
 <20220425153344.lgo3kdnrbef75jcq@liuwe-devbox-debian-v2>
 <20220425154955.2glxbfeln47m4cin@liuwe-devbox-debian-v2>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220425154955.2glxbfeln47m4cin@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/25/2022 9:49 AM, Wei Liu wrote:
> On Mon, Apr 25, 2022 at 03:33:44PM +0000, Wei Liu wrote:
>> On Wed, Apr 20, 2022 at 08:13:22AM -0600, Jeffrey Hugo wrote:
>>> On 4/13/2022 7:36 AM, Jeffrey Hugo wrote:
>>>> If the allocation of multiple MSI vectors for multi-MSI fails in the core
>>>> PCI framework, the framework will retry the allocation as a single MSI
>>>> vector, assuming that meets the min_vecs specified by the requesting
>>>> driver.
>>>>
>>>> Hyper-V advertises that multi-MSI is supported, but reuses the VECTOR
>>>> domain to implement that for x86.  The VECTOR domain does not support
>>>> multi-MSI, so the alloc will always fail and fallback to a single MSI
>>>> allocation.
>>>>
>>>> In short, Hyper-V advertises a capability it does not implement.
>>>>
>>>> Hyper-V can support multi-MSI because it coordinates with the hypervisor
>>>> to map the MSIs in the IOMMU's interrupt remapper, which is something the
>>>> VECTOR domain does not have.  Therefore the fix is simple - copy what the
>>>> x86 IOMMU drivers (AMD/Intel-IR) do by removing
>>>> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS after calling the VECTOR domain's
>>>> pci_msi_prepare().
>>>>
>>>> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
>>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>> Reviewed-by: Dexuan Cui <decui@microsoft.com>
>>>> ---
>>>
>>> Ping?
>>>
>>> I don't see this in -next, nor have I seen any replies.  It is possible I
>>> have missed some kind of update, but currently I'm wondering if this change
>>> is progressing or not.  If there is some kind of process used in this area,
>>> I'm not familiar with it, so I would appreciate an introduction.
>>
>> I expect the PCI maintainers to pick this up. If I don't see this picked
>> up in this week I will apply it to hyperv-next.
> 
> Actually I will pick this up via hyperv-next, because there is another
> series which will also touch this driver but at the some time depend on
> vmbus changes. I can fix up any potential conflicts easily.

Sounds good to me.  Let me know if you do run into conflicts, and I can 
help.

-Jeff

