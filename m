Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEED508A7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Apr 2022 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358302AbiDTOTK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Apr 2022 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380138AbiDTOSi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BB443C7;
        Wed, 20 Apr 2022 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650464005; x=1682000005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xSVtxqfp4JLpW3WWMuvDsq9oB3gov9dYbIhWlNNxBEo=;
  b=fGaX0bEOO3yLXFTRbq+fdgafIeGDFeJSRJ9m20mLf12anuDBZWeoG+og
   QfEEp6aSbz2pKHDakxjmBfzwFh0s/avH/K+alifaEr0LCaeNlHyxOctpG
   tIY8TBua3yeqAxX1pkTfuuQ9zVPinzSU+BoajTVh3oPALYm40g8WX2iOr
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2022 07:13:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:13:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 07:13:24 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 07:13:23 -0700
Message-ID: <2100eed4-8081-6070-beaf-7c6ba65ad9be@quicinc.com>
Date:   Wed, 20 Apr 2022 08:13:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] PCI: hv: Fix multi-MSI to allow more than one MSI
 vector
Content-Language: en-US
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <jakeo@microsoft.com>
CC:     <bjorn.andersson@linaro.org>, <linux-hyperv@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1649856981-14649-1-git-send-email-quic_jhugo@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1649856981-14649-1-git-send-email-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/13/2022 7:36 AM, Jeffrey Hugo wrote:
> If the allocation of multiple MSI vectors for multi-MSI fails in the core
> PCI framework, the framework will retry the allocation as a single MSI
> vector, assuming that meets the min_vecs specified by the requesting
> driver.
> 
> Hyper-V advertises that multi-MSI is supported, but reuses the VECTOR
> domain to implement that for x86.  The VECTOR domain does not support
> multi-MSI, so the alloc will always fail and fallback to a single MSI
> allocation.
> 
> In short, Hyper-V advertises a capability it does not implement.
> 
> Hyper-V can support multi-MSI because it coordinates with the hypervisor
> to map the MSIs in the IOMMU's interrupt remapper, which is something the
> VECTOR domain does not have.  Therefore the fix is simple - copy what the
> x86 IOMMU drivers (AMD/Intel-IR) do by removing
> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS after calling the VECTOR domain's
> pci_msi_prepare().
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> ---

Ping?

I don't see this in -next, nor have I seen any replies.  It is possible 
I have missed some kind of update, but currently I'm wondering if this 
change is progressing or not.  If there is some kind of process used in 
this area, I'm not familiar with it, so I would appreciate an introduction.

Thanks

-Jeff
