Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1B6264C9
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 23:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKKWyC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 17:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKKWyC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 17:54:02 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C319C56EE2;
        Fri, 11 Nov 2022 14:54:00 -0800 (PST)
Received: from [192.168.0.5] (71-212-113-106.tukw.qwest.net [71.212.113.106])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41AC520B717A;
        Fri, 11 Nov 2022 14:54:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41AC520B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668207240;
        bh=E1cYAShkFwLJuK7d/qqdtMRNldtQEcFrsAuldrsATQc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pwFifZLBiU8rZFBQk5Wr7OcBe28raXBorwSev/19x2Q8da2nqW/GclLu0uMqE3pQI
         x+F9Iso1ztkM3V2oAh6m+I2ICmVS2nssaMtw5D8uoyDXqkRX2ocf/enSaOiaZTbVNr
         KPrxo/ulL4lte4grZRarUXvCyuCTyqbbxtGBiV3c=
Message-ID: <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
Date:   Fri, 11 Nov 2022 14:53:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Language: en-US
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/11/2022 9:58 AM, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:27 AM
>>
>> On Fri, Nov 11, 2022 at 04:55:22PM +0000, Michael Kelley (LINUX) wrote:
>>> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 8:33 AM
>>>>
>>>> Hi Tianyu
>>>>
>>>> On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
>>>>> If x2apic is not available, hyperv-iommu skips remapping
>>>>> irqs. This breaks root partition which always needs irqs
>>>>> remapped.
>>>>>
>>>>> Fix this by allowing irq remapping regardless of x2apic,
>>>>> and change hyperv_enable_irq_remapping() to return
>>>>> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
>>>>>
>>>>
>>>> Do you remember why it was x2apic only?
>>>>
>>>> We tested this patch on different VM SKUs and it worked fine. I'm just
>>>> wondering if there would be some subtle breakages that we couldn't
>>>> easily test.
>>>>
>>>> Thanks,
>>>> Wei.
>>>
>>> My recollection is that originally Hyper-V provided the x2apic in the
>>> guest only when the number of vCPUs exceeded 255, and that was
>>> the only case where IRQ remapping was needed.  The intent was to
>>> not disturb the case where # of vCPUs was < 255 and the xapic is used.
>>> I don't remember there being any potential for subtle breakages.
>>
>> Thanks for the information.
>>
>>>
>>> I think more recent versions of Hyper-V now provide the x2apic
>>> in the guest in some cases when # of vCPUs is < 255.
>>>
>>
>> On Azure the default for AMD SKUs is still xapic unless the number of
>> VCPUs exceeds 2XX (can't remember the exact number -- maybe it is 255).
> 
> I don't think Azure has any VM sizes based on AMD processors with more
> than 255 vCPUs.  All the >255 vCPUs VM sizes use Intel processors.
> 
> FWIW, I have a D2ds_v5 VM (2 CPUs & Intel processor) that shows an
> x2apic instead of an xapic.  My memory is vague, but I think that's the
> requirements to get an x2apic in a smaller VM:  must be a "v5" series and
> must be Intel processor.
> 
> Michael
>

Yes this seems to be the case, although I didn't realise it until now!
I sort of assumed since x2apic has been around so long, all the intel VMs
just had it enabled...

>>
>> Nuno, can you list the tests you've done? They will need to cover Linux
>> running as a normal guest on Azure and Hyper-V.
>>>> Thanks,
>> Wei.
>>

I've tested this patch on these Azure SKUs:
- Standard_D2S_v2 (intel xapic)
- Standard_D4ds_v4 (intel xapic)
- Standard_D4ds_v5 (intel x2apic)
- Standard_D4ads_v5 (amd xapic)

I've tested with linux Dom0 (nested hyperv root partition) and as a
regular L1 guest.

>>
>>> Michael
>>>
>>>>
>>>>> Tested with root and non-root hyperv partitions.
>>>>>
>>>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>>>> ---
>>>>>  drivers/iommu/Kconfig        | 6 +++---
>>>>>  drivers/iommu/hyperv-iommu.c | 7 ++++---
>>>>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index dc5f7a156ff5..cf7433652db0 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -474,13 +474,13 @@ config QCOM_IOMMU
>>>>>  	  Support for IOMMU on certain Qualcomm SoCs.
>>>>>
>>>>>  config HYPERV_IOMMU
>>>>> -	bool "Hyper-V x2APIC IRQ Handling"
>>>>> +	bool "Hyper-V IRQ Handling"
>>>>>  	depends on HYPERV && X86
>>>>>  	select IOMMU_API
>>>>>  	default HYPERV
>>>>>  	help
>>>>> -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
>>>>> -	  guests to run with x2APIC mode enabled.
>>>>> +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
>>>>> +	  guest and root partitions.
>>>>>
>>>>>  config VIRTIO_IOMMU
>>>>>  	tristate "Virtio IOMMU driver"
>>>>> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
>>>>> index e190bb8c225c..abd1826a9e63 100644
>>>>> --- a/drivers/iommu/hyperv-iommu.c
>>>>> +++ b/drivers/iommu/hyperv-iommu.c
>>>>> @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>>>>>  	const struct irq_domain_ops *ops;
>>>>>
>>>>>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>>>>> -	    x86_init.hyper.msi_ext_dest_id() ||
>>>>> -	    !x2apic_supported())
>>>>> +	    x86_init.hyper.msi_ext_dest_id())
>>>>>  		return -ENODEV;
>>>>>
>>>>>  	if (hv_root_partition) {
>>>>> @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(void)
>>>>>
>>>>>  static int __init hyperv_enable_irq_remapping(void)
>>>>>  {
>>>>> -	return IRQ_REMAP_X2APIC_MODE;
>>>>> +	if (x2apic_supported())
>>>>> +		return IRQ_REMAP_X2APIC_MODE;
>>>>> +	return IRQ_REMAP_XAPIC_MODE;
>>>>>  }
>>>>>
>>>>>  struct irq_remap_ops hyperv_irq_remap_ops = {
>>>>> --
>>>>> 2.25.1
>>>>>
