Return-Path: <linux-hyperv+bounces-3172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED29A9F46
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 11:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66C71F2138F
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EA19925F;
	Tue, 22 Oct 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oQamoZmR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA418E02D;
	Tue, 22 Oct 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590907; cv=none; b=l7C0GjGXkq0rvGeygKpjr7ezj5c1T5DZJlbeTbFwP0EcYY8ws52Kbn/uiuOHyBqRALATQYmyT4Mvda4lMvCxtHRR7PQEQYn7xZ7DPyYE15Bj52J8e0NEecMOq/Qw0NbSOqRutwoeAYL8OCfjJkge0SqOBqmho4ZOIkCQmSauF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590907; c=relaxed/simple;
	bh=k6Ltj/TLoYtlREJU8ZXVq//qMh3/N8PH+6mw7p68uxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kccctPZrVGLJ9AaRNd9YaJMwhpnNV9TXvzZcsU2pqBs6T+LVenQWTGk9iabL5rNc59nfoTRO2dBVU93oys4OLgz9nhRvFqg9qFkR9LET2/JCSVAysw0wVvkmEx07akGx5JakTwun8RzP81ztaS7n2BngPoVAM1kLb1ssP6w99e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oQamoZmR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.102] (unknown [49.205.243.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB9BF210D8B7;
	Tue, 22 Oct 2024 02:55:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB9BF210D8B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729590905;
	bh=cvkqsbyzhSjxciGOzPHF06gYHKGhIViMYEFthbEOjsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oQamoZmR3fug4KPcuC/vFNlA2mc66Ajq9qS5xXUgv2y2mthQku10nvs8ljfVM681D
	 i1S4kFVm0xQDWJyZpyWNoVNn1MDJbhHiuHN6ObEZ1n06Yv/39N1QSH2sGBryP68NOf
	 d3idDF1uUrA7KG2yAOthGm8v2L1EuqhaOClKxd50=
Message-ID: <91756da8-f2c3-482a-95ee-6208e1205502@linux.microsoft.com>
Date: Tue, 22 Oct 2024 15:25:00 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 jacob.pan@linux.microsoft.com,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
 <20241021045724.GB25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20241021045724.GB25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2024 10:27 AM, Saurabh Singh Sengar wrote:
> On Fri, Oct 18, 2024 at 04:58:10AM -0700, Naman Jain wrote:
>> Channels offers are requested during vmbus initialization and resume
> 
> Nit: s/vmbus/VMBus

Thanks for reviewing Saurabh.

Noted this for next patch. Thanks

> 
>> from hibernation. Add support to wait for all channel offers to be
>> delivered and processed before returning from vmbus_request_offers.
>> This is to support user mode (VTL0) in OpenHCL (A Linux based
>> paravisor for Confidential VMs) to ensure that all channel offers
>> are present when init begins in VTL0, and it knows which channels
>> the host has offered and which it has not.
> 
> Usermode isn't necessarily of VTL0, and this issue was actually identified
> at a higher VTL in OpenHCL. However, this change isn't specific to OpenHCL,
> but is intended for general use. I would prefer if the commit message were
> either more generic or precisely aligned with the specific issue it's
> addressing.
> 

I'll make it generic.

>>
>> This is in analogy to a PCI bus not returning from probe until it has
>> scanned all devices on the bus.
>>
>> Without this, user mode can race with vmbus initialization and miss
>> channel offers. User mode has no way to work around this other than
>> sleeping for a while, since there is no way to know when vmbus has
>> finished processing offers.
>>
>> With this added functionality, remove earlier logic which keeps track
>> of count of offered channels post resume from hibernation. Once all
>> offers delivered message is received, no further offers are going to
>> be received. Consequently, logic to prevent suspend from happening
>> after previous resume had missing offers, is also removed.
>>
>> Co-developed-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: John Starks <jostarks@microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
>>   drivers/hv/connection.c   |  4 ++--
>>   drivers/hv/hyperv_vmbus.h | 14 +++-----------

<..>

>>   	}
>>   
>> +	/* Wait for the host to send all offers. */
>> +	while (wait_for_completion_timeout(
>> +		&vmbus_connection.all_offers_delivered_event, msecs_to_jiffies(10 * 1000)) == 0) {
> 
> Nit: Can simply put 10000 instead of 10*1000

Noted.

> 
>> +		pr_warn("timed out waiting for all offers to be delivered...\n");
> 
> I know we are moving from async to sync, so earlier we never checked this.
> But what if some channel timed out do we want to handle this case ? Or put
> a comment why this is OK.
> 
> We could set error from here as well, but I see vmbus_request_offers return value
> is never checked.

It seems to be a best effort way to get all the offers. If its not
received in time, I think we can print a warning and continue. I can add
that to a comment.

> 
>> +	}
>> +
>> +	/*
>> +	 * Flush handling of offer messages (which may initiate work on
>> +	 * other work queues).
>> +	 */

Regards,
Naman

