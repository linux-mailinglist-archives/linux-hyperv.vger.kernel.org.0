Return-Path: <linux-hyperv+bounces-2862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF995E7EC
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 07:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828C32813CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 05:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998044C94;
	Mon, 26 Aug 2024 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ICk5FQ1b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879F2E400;
	Mon, 26 Aug 2024 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650306; cv=none; b=qcohycAHuNoP0uJK0rIGszHDIqRhxysD6+yeBSXgFTrvAzj2i2XExnNwgqWbhm9HS1NzfpkuJhj8tqsdVx+VOB8ZW9sHcNDrolaylpus8TX8RWtQECj1X1G9juk0Tzu7usZq6CBY0Mq3Q/PMdmzNZc2lz8gD0y+wgabnQNbrDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650306; c=relaxed/simple;
	bh=Wl6iQ9exmLvbfbEZipfqq2w+vo7s4TZ/fP2e7N1r6/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g66EzN9fNtHezYQHM7MrV4hp2OmnmOrxibexg62Rv5N+WFGHOlXzaWPQ6EbfWerfaj+te7mI91Y74d4V26DKB6j3O5Ci1VL/55gxJq2Ekwt167Leplqih+C4L40b/fKJ+J78ugARRQzfElZntHtav2D+nI3JF/1yOwlnWU9UKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ICk5FQ1b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.75.183] (unknown [167.220.238.215])
	by linux.microsoft.com (Postfix) with ESMTPSA id 36B1820B7165;
	Sun, 25 Aug 2024 22:31:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36B1820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724650304;
	bh=Pz7/mxA+dgmB3ZGl3+LDfNGWOqZQC0Nmel5YIM0XAbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ICk5FQ1bYFieyUcf6RoA98ssS8Rp/OF8fQLtPgCWCDsI0qIuTczTR59ptSAW1bwH+
	 qEgwDJmk4VRiG2sLupyCwo5q5V8z9BxCC+ScMCsdBG1ZPVZM3chz07f+UQkmY+gGgI
	 QtMyMVMAYS3bTdhGwA5eRy5yvIrU1XvbDkVPq3cQ=
Message-ID: <a447911b-ef12-46de-ba01-13105e34b8fe@linux.microsoft.com>
Date: Mon, 26 Aug 2024 11:01:39 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/2024 8:27 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 22, 2024 4:09 AM
>>
>> Rescind offer handling relies on rescind callbacks for some of the
>> resources cleanup, if they are registered. It does not unregister
>> vmbus device for the primary channel closure, when callback is
>> registered.
>> Add logic to unregister vmbus for the primary channel in rescind callback
>> to ensure channel removal and relid release, and to ensure rescind flag
>> is false when driver probe happens again.
>>
>> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c       | 1 +
>>   drivers/uio/uio_hv_generic.c | 7 +++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index c857dc3975be..4bae382a3eb4 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1952,6 +1952,7 @@ void vmbus_device_unregister(struct hv_device
>> *device_obj)
>>   	 */
>>   	device_unregister(&device_obj->device);
>>   }
>> +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
>>
>>   #ifdef CONFIG_ACPI
>>   /*
>> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
>> index c99890c16d29..ea26c0b460d6 100644
>> --- a/drivers/uio/uio_hv_generic.c
>> +++ b/drivers/uio/uio_hv_generic.c
>> @@ -121,6 +121,13 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
>>
>>   	/* Wake up reader */
>>   	uio_event_notify(&pdata->info);
>> +
>> +	/*
>> +	 * With rescind callback registered, rescind path will not unregister the device
>> +	 * when the primary channel is rescinded. Without it, next onoffer msg does not come.
>> +	 */
>> +	if (!channel->primary_channel)
>> +		vmbus_device_unregister(channel->device_obj);
> 
> When the rescind callback is *not* set, vmbus_onoffer_rescind() makes the
> call to vmbus_device_unregister(). But it does so bracketed with get_device()/
> put_device(). Your code here does not do the bracketing. Is there a reason for
> the difference? Frankly, I'm not sure why vmbus_onoffer_rescind() does the
> bracketing, and I can't definitively say if it is really needed. So I guess I'm
> just asking if you know. :-)
> 
> Michael
> 
>>   }
>>
>>   /* ysfs API to allow mmap of the ring buffers
>> --
>> 2.34.1
>>

IMHO, we have already NULL checked channel->device_obj and other couple 
of things to make sure we are safe to clean this up. At other places as 
well, I don't see the use of put and get device. So I think its not 
required. I am open to suggestions.

Regards,
Naman

