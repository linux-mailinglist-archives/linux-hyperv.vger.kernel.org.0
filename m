Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006ED5137BD
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348785AbiD1PKA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbiD1PKA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:10:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE026572;
        Thu, 28 Apr 2022 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651158405; x=1682694405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bZ5sqdG3XM6q75qcyKHc4Pvx5jv6v1ImyoirGoBvDqU=;
  b=RJQ5UnDWP4w6EyLcDg0JxNRGSKymVxPBB5GJCnliq4EXr+TP/WgLSV2a
   ra8MX7wMdOvUXY1M5TC5SsjoAzCq0SHs2Wvi12M9vgdgRYBMAc4UzLP0W
   em59J7knPyd8Mn4jkTsMuzTv1HavfKFgleLQ3TFeitqmgnyJeBUgagvlH
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 08:06:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 08:06:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 08:06:44 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 08:06:43 -0700
Message-ID: <dec6b3a9-e988-aa10-817c-21f2d45194c9@quicinc.com>
Date:   Thu, 28 Apr 2022 09:06:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <decui@microsoft.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <bjorn.andersson@linaro.org>,
        <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
 <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20220428145824.kp4p5qacgnncsxls@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/28/2022 8:58 AM, Wei Liu wrote:
> On Wed, Apr 27, 2022 at 08:07:33AM -0600, Jeffrey Hugo wrote:
>> In the multi-MSI case, hv_arch_irq_unmask() will only operate on the first
>> MSI of the N allocated.  This is because only the first msi_desc is cached
>> and it is shared by all the MSIs of the multi-MSI block.  This means that
>> hv_arch_irq_unmask() gets the correct address, but the wrong data (always
>> 0).
>>
>> This can break MSIs.
>>
>> Lets assume MSI0 is vector 34 on CPU0, and MSI1 is vector 33 on CPU0.
>>
>> hv_arch_irq_unmask() is called on MSI0.  It uses a hypercall to configure
>> the MSI address and data (0) to vector 34 of CPU0.  This is correct.  Then
>> hv_arch_irq_unmask is called on MSI1.  It uses another hypercall to
>> configure the MSI address and data (0) to vector 33 of CPU0.  This is
>> wrong, and results in both MSI0 and MSI1 being routed to vector 33.  Linux
>> will observe extra instances of MSI1 and no instances of MSI0 despite the
>> endpoint device behaving correctly.
>>
>> For the multi-MSI case, we need unique address and data info for each MSI,
>> but the cached msi_desc does not provide that.  However, that information
>> can be gotten from the int_desc cached in the chip_data by
>> compose_msi_msg().  Fix the multi-MSI case to use that cached information
>> instead.  Since hv_set_msi_entry_from_desc() is no longer applicable,
>> remove it.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 5800ecf..7aea0b7 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -611,13 +611,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>>   	return cfg->vector;
>>   }
>>   
>> -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
>> -				       struct msi_desc *msi_desc)
>> -{
>> -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
>> -	msi_entry->data.as_uint32 = msi_desc->msg.data;
>> -}
>> -
> 
> Instead of dropping this function, can you change the second argument to
> take struct tran_int_desc *?
> 
> This way you can use the same function in hv_compose_msi_msg.

I do not see how this could be reused in hv_compose_msi_msg() with the 
proposed change of the second argument.  The hv_msi_entry type is not 
used in hv_compose_msi_msg(), nor does it look like it is applicable 
anywhere within the function.

What am I missing?

> Thanks,
> Wei.
> 
>>   static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
>>   			  int nvec, msi_alloc_info_t *info)
>>   {
>> @@ -647,6 +640,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>>   {
>>   	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>>   	struct hv_retarget_device_interrupt *params;
>> +	struct tran_int_desc *int_desc;
>>   	struct hv_pcibus_device *hbus;
>>   	struct cpumask *dest;
>>   	cpumask_var_t tmp;
>> @@ -661,6 +655,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>>   	pdev = msi_desc_to_pci_dev(msi_desc);
>>   	pbus = pdev->bus;
>>   	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
>> +	int_desc = data->chip_data;
>>   
>>   	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
>>   
>> @@ -668,7 +663,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
>>   	memset(params, 0, sizeof(*params));
>>   	params->partition_id = HV_PARTITION_ID_SELF;
>>   	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>> -	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
>> +	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
>> +	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
>>   	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>>   			   (hbus->hdev->dev_instance.b[4] << 16) |
>>   			   (hbus->hdev->dev_instance.b[7] << 8) |
>> -- 
>> 2.7.4
>>

