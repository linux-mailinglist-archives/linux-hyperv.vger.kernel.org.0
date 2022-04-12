Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535384FE8AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Apr 2022 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348493AbiDLTew (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 15:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbiDLTev (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 15:34:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4549CAE;
        Tue, 12 Apr 2022 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649791953; x=1681327953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yqoB7cYv0kxyD6VAhUk1RPiQtFKpfEZtLhAhhc5teB0=;
  b=FuGpmisN04XO933OU7s1BefVJB6ugr0n1G+gr6dF+Tf/7Hvg2u6heSxh
   lpQknFuxibrUn3t1H1n/5FNfE/+69LyJfC8VH7rEIq3ySL5tjbWVIRqgg
   iuq4ZjWKiF/h0DwXHAg2YWvy+x3ZS07jqXH8oFWAgg4533RhdufX/lp/L
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 12:32:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 12:32:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 12:32:32 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 12:32:30 -0700
Message-ID: <98bee89c-608b-79a2-d796-4a2b260cf927@quicinc.com>
Date:   Tue, 12 Apr 2022 13:32:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] PCI: hv: Fix multi-MSI to allow more than one MSI vector
Content-Language: en-US
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <jakeo@microsoft.com>
CC:     <bjorn.andersson@linaro.org>, <linux-hyperv@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1649772991-10285-1-git-send-email-quic_jhugo@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1649772991-10285-1-git-send-email-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/12/2022 8:16 AM, Jeffrey Hugo wrote:
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
> ---
>   drivers/pci/controller/pci-hyperv.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index d270a204..41be63e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -614,7 +614,16 @@ static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
>   static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
>   			  int nvec, msi_alloc_info_t *info)
>   {
> -	return pci_msi_prepare(domain, dev, nvec, info);
> +	int ret = pci_msi_prepare(domain, dev, nvec, info);
> +
> +	/*
> +	 * By using the interrupt remapper in the hypervisor IOMMU, contiguous
> +	 * CPU vectors in not needed for multi-MSI

I just noticed that "in" should be "is".

> +	 */
> +	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
> +		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
> +
> +	return ret;
>   }
>   
>   /**

