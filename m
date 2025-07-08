Return-Path: <linux-hyperv+bounces-6148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D89CAFC809
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D271BC3FF2
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C426A0A0;
	Tue,  8 Jul 2025 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HYFKHH4A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F6269808;
	Tue,  8 Jul 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969711; cv=none; b=RKBlJzhfNyJb+w8d0tE2FQsKCq8CfhouXKmdMsg/UgYX2+eluvvBKwne5iN1ADm4s7Pj6ErxHeX4b6nmAdY6drFm0IHheP4/meBVnHWB09hQCL8XSMAGU66c+1f2za1hnvb/uMI4hSLzD3n3AQqIedQjYPskxuKsHR6zoDf8d2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969711; c=relaxed/simple;
	bh=ypgHm087Xc7lQlIDXuaSqhZX1vxmTBgr40MkhXP/6Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzjF3nlre7oJhTKYKRWmRSbOz6cZCHFSbG8jx8dHHBgZfM1X59cam/YRMmRfF+2/JabRdGwo6vaFuZUwZwqzUPbtHvXcEoJUp08GCh+N6aZadfaN90WJ4zt5DwMvtBisVW+6gezyryC/BbncR70ZyZsAyfNvxhEhHylteGZG4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HYFKHH4A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3172721130BF;
	Tue,  8 Jul 2025 03:15:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3172721130BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751969709;
	bh=qSQslTvZ8czgzGkDmCKdSG5fbdaS8P4nA6ShaGvRcnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYFKHH4Aey2qzFFTz42SRG0SONPH8Azc9IyN/XMiZ7yJxX1MZ9anZYAbXvF/w86Y4
	 ymyl9nA3TRWBMA6BbOAKSE1hbTsGSm//vn8i0pvPAhY0+uE7uh7Qn17CL0LTs8S2vX
	 czxnuuWHqj3nS/BOuxnlk4+LzYdzLev/wWCh5efY=
Message-ID: <e589da81-ed8d-4fbd-8a29-687eb271d1fe@linux.microsoft.com>
Date: Tue, 8 Jul 2025 15:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Initialize the prepare descriptor by default
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Roman Kisel <romank@linux.microsoft.com>
References: <20250708051848.3214-1-namjain@linux.microsoft.com>
 <20250708100248.GA27472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250708100248.GA27472@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 3:32 PM, Shradha Gupta wrote:
> On Tue, Jul 08, 2025 at 10:48:48AM +0530, Naman Jain wrote:
>> Plug the default MSI-X prepare descriptor for non-implemented ops by
>> default to workaround the inability of Hyper-V vPCI module to setup
>> the MSI-X descriptors properly; especially for dynamically allocated
>> MSI-X.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/pci/msi/irqdomain.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index 765312c92d9b..655e99b9c8cc 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -84,6 +84,8 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
>>   	} else {
>>   		if (ops->set_desc == NULL)
>>   			ops->set_desc = pci_msi_domain_set_desc;
>> +		if (ops->prepare_desc == NULL)
>> +			ops->prepare_desc = pci_msix_prepare_desc;
>>   	}
>>   }
>>   
>>
>> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
>> -- 
>> 2.34.1
>>
> 
> Hey Naman,
> 
> can you please try your tests with this patch:
> https://lore.kernel.org/all/1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com/
> I think this should help your use case
> 
> Regards,
> Shradha.

Hey,
Thanks for sharing this, this works for me.

Closing this thread.

Regards,
Naman

