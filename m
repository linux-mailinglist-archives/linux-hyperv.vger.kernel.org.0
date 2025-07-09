Return-Path: <linux-hyperv+bounces-6155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078ABAFDED6
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 06:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C8F4A6476
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 04:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1FE267732;
	Wed,  9 Jul 2025 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TYlwDQDr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554113A3F2;
	Wed,  9 Jul 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752036137; cv=none; b=eTlKakylPlejzXQ15McUBMLfBs3cVpcDnJlWJOoHpMU08/9rHZy5C/ffPpi9pdUyCNJR2jaUmwmrfSMTVoZdZ49Y9QJDLZJv488rbxmD6fm5nJ2FT16SiPm9PgZ96EuCwZmtq44umquhjG4MgH88QpTpsnG8klDPFGuATa0NKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752036137; c=relaxed/simple;
	bh=Fn21aLk8KOVq18tlx6uiN1yIKZDUgjxrdNQzKFjWHZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rS7xKIxJRmnVt/LB08BmhUV8IBwQW1KALIF8JFGCHsHrr/j6kjNziW8G73cO3wm0bQTwtadrklXcT+ZK8TlbJNRcVh+Py0HSwZ9HAMhXStJ+HLKRcnsunPR5urm68zeteJnhoRhEQJ0/gL81T+VQIFWxiTVEZt70EW71ZodlY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TYlwDQDr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.218.70] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 629D9201B1AE;
	Tue,  8 Jul 2025 21:42:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 629D9201B1AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752036135;
	bh=0OdFxV7TyZBPInyMjkfna2ntk1j8yOVcJaUIxoV+hLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TYlwDQDrC8u9N4j5ib7rMwBKMQWHAH2JmrCB/O9SG/ozV8WYCCPcTYW2yisUWq84l
	 HNRPHeZJDrc67ktZFfz+KITRkkDmsgHZworX0yo2yCnCTAgmv2dFtyEBVMLGlkvyQM
	 W1DDF1b91bUnfc7NZ7lUH7Tu7U/fBvv+ZVXHLPPk=
Message-ID: <34d1f7e4-0729-4faf-95b7-e2fce6c3be2e@linux.microsoft.com>
Date: Wed, 9 Jul 2025 10:12:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Initialize the prepare descriptor by default
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Roman Kisel <romank@linux.microsoft.com>
References: <20250708160817.GA2148355@bhelgaas>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250708160817.GA2148355@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 9:38 PM, Bjorn Helgaas wrote:
> On Tue, Jul 08, 2025 at 03:45:05PM +0530, Naman Jain wrote:
>> On 7/8/2025 3:32 PM, Shradha Gupta wrote:
>>> On Tue, Jul 08, 2025 at 10:48:48AM +0530, Naman Jain wrote:
>>>> Plug the default MSI-X prepare descriptor for non-implemented ops by
>>>> default to workaround the inability of Hyper-V vPCI module to setup
>>>> the MSI-X descriptors properly; especially for dynamically allocated
>>>> MSI-X.
>>>>
>>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>>>> ---
>>>>    drivers/pci/msi/irqdomain.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>>>> index 765312c92d9b..655e99b9c8cc 100644
>>>> --- a/drivers/pci/msi/irqdomain.c
>>>> +++ b/drivers/pci/msi/irqdomain.c
>>>> @@ -84,6 +84,8 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
>>>>    	} else {
>>>>    		if (ops->set_desc == NULL)
>>>>    			ops->set_desc = pci_msi_domain_set_desc;
>>>> +		if (ops->prepare_desc == NULL)
>>>> +			ops->prepare_desc = pci_msix_prepare_desc;
>>>>    	}
>>>>    }
>>>>
>>>> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> Hey Naman,
>>>
>>> can you please try your tests with this patch:
>>> https://lore.kernel.org/all/1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com/
>>> I think this should help your use case
>>
>> Hey,
>> Thanks for sharing this, this works for me.
>>
>> Closing this thread.
> 
> I guess this means we should ignore this patch?  If it turns out that
> we do need this patch, I'd like to add some details in the commit log
> about what this problem looks like to users.
> 
> Bjorn

Yes, my patch is no longer required, since it was doing the same thing
that Shradha's patch (1-2) were doing, but in a different way. Shradha's
patch is better and would suffice for the use case. Please ignore this
patch.

Thanks.
Regards,
Naman

