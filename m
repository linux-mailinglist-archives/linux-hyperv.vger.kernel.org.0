Return-Path: <linux-hyperv+bounces-5922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4267EADBA88
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417863B199E
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320B1F4C98;
	Mon, 16 Jun 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MwygWuha"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E71F5847;
	Mon, 16 Jun 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104385; cv=none; b=UFUc5H/LfImWO2h/7t59yiIjLWqCiM1Vz67hu9sFa1pB3HraBwBuS3h1esXivFwYC+Xahw8SJPm8rKt3/zHR8StguRaC4lQtvsT/3mj2/ZZfnfDhlAEm39C1QL965pbI7GmibPv5tH299Zz+y52kHxpAe7ikmd1z3vUXzLqS8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104385; c=relaxed/simple;
	bh=DxKYfW2Y3BQiZFIE+AMWe+NyrlGjHl/jlQm63dGeKuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMB7E08JIyZZXakdDLGdci7ItBoRFNfTEY2Y6E/dU9bYWL6WOi8Nk16NqPMicWW7ONcJ0v55nNpzLQsMotM+Sj6QmqR9z+uYncRp5Fydch31ZFfmRRXYoDGmZ4A3aXTyXW5gSacroSaHt79H7MxF+7OzqjANr3tMajKZHwEBl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MwygWuha; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.1.24] (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A030C21176C6;
	Mon, 16 Jun 2025 13:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A030C21176C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750104381;
	bh=RWf4U2IMgfXaKMSLGJUCrHvubnG0tLPF0JXW2PD8mi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwygWuhajk7TGYV1hsriMnPH/Z615YS+VR6NW/7XY+ka4XNr/WLH2QUZibl6KRgys
	 duta2oQez2pfYwZQIs/JdGdS7BHRSYlkI3IaA2ECLv+a5lZnTkfKCJiuOuMTv1PfU1
	 VHKF/NIqb+R7AbxYyEWJNa2pTcbblAVqovZtzrig=
Message-ID: <38127f1a-3761-48c7-8e95-1f677d6bd7b3@linux.microsoft.com>
Date: Mon, 16 Jun 2025 13:06:20 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: hv: Do not do vmbus initialization on baremetal
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41574163515870DB8E430C56D475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574163515870DB8E430C56D475A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2025 4:06 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June 10, 2025 4:52 PM
>>
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> The patch Subject line is confusing to me. Perhaps this better captures
> the intent:
> 
>  "PCI: hv: Don't load the driver for the root partition on a bare-metal hypervisor"
> 

Thanks, that does make more sense.

>>
>> init_hv_pci_drv() is not relevant for root partition on baremetal as there
>> is no vmbus. On nested (with a Windows L1 root), vmbus is present.
> 
> This needs more precision. init_hv_pci_drv() isn't what is
> "not relevant". It's the entire driver that doesn't need to be loaded
> because the root partition on a bare-metal hypervisor doesn't use
> VMBus. It's only when the root partition is running on a nested
> hypervisor that it uses VMBus, and hence may need the Hyper-V
> PCI driver to be loaded.
> 

I'll update it so it is clearer, thanks.

>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/pci/controller/pci-hyperv.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index b4f29ee75848..4d25754dfe2f 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -4150,6 +4150,9 @@ static int __init init_hv_pci_drv(void)
>>  	if (!hv_is_hyperv_initialized())
>>  		return -ENODEV;
>>
>> +	if (hv_root_partition() && !hv_nested)
>> +		return -ENODEV;
>> +
>>  	ret = hv_pci_irqchip_init();
>>  	if (ret)
>>  		return ret;
>> --
>> 2.34.1


