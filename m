Return-Path: <linux-hyperv+bounces-4171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9888A4A58A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B252189BCBD
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24B1C700A;
	Fri, 28 Feb 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="THzzadIz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42451A3158;
	Fri, 28 Feb 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780161; cv=none; b=CzVOrJyZgC9iq77zxLCXSB3Cl1MKA2dBHffAjW0b540pAgAE7mbVEc6ksMppol1JKqVBxVbEd5aoPhJQ5EHph24+OZg3tao7pxd+MoXgNyOIQIQvVHbAw2RycYXKeLcZc0sWNXVIZqFBPaa25Vlhx1suwIrfHwzUmdxjpprBuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780161; c=relaxed/simple;
	bh=VirSJrxm4LAX4bsOCbuBsjJagnBAB6adwvR7ofMu05w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MswVGKrWVumUvy6PiI9IzZBdfK2+n+jf1HefiaDcvfQxt5i/+Chzv03VTv8EeHKej3+8T6bwH7X25cnUTCFSDXDC68qPj+usMgcXEHchZITj+ozwoKOWj0wXZkWjV8TFo88F9VpIVXLP+64HLBuEaFI66RtNBlJSDbtM3lDsqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=THzzadIz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2EFBD210D0EA;
	Fri, 28 Feb 2025 14:02:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EFBD210D0EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740780159;
	bh=L4wtjzQ+VCyMpsZoFNfDhp8k4YQtImF+RaC9Ro8r2Pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THzzadIzAYIMf/59ZwCLjEx0zpFtizAoiuwJAfsYPDt94Bzp739fwahmnAMKo+gw5
	 cmoqAISH4ldER8ZnvmvwMsc0RT0KlsK6+/HibJBi9iw2nOdaXkRx+IM3gLNobr0mBV
	 LJsPcC43pRcAhzPy+yQfccr5cnf2+E+rFlfhdoRM=
Message-ID: <ca615c23-fa9a-4cb3-b2bf-150fca2047ef@linux.microsoft.com>
Date: Fri, 28 Feb 2025 14:02:38 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 apais@microsoft.com, benhill@microsoft.com, sunilmut@microsoft.com
References: <20250227233110.36596-1-romank@linux.microsoft.com>
 <40d016eb-e701-4872-b0bc-f5ba34093a53@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <40d016eb-e701-4872-b0bc-f5ba34093a53@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/2025 12:21 PM, Easwar Hariharan wrote:
> On 2/27/2025 3:31 PM, Roman Kisel wrote:
>> The log statement reports the packet status code as the hypercall
>> status code which causes confusion when debugging.
>>
>> Fix the name of the datum being logged.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/scsi/storvsc_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index a8614e54544e..d7ec79536d9a 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
>>   			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>>   
>>   		storvsc_log_ratelimited(device, loglevel,
>> -			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
>> +			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x sts 0x%x\n",
> 
> I'd suggest using "host" than the opaque "sts", since this is already part of the different
> levels of status (scsi, srb...) being printed out. With "host", for e.g. the print would be seen
> as the following and clearly point out the offending part of the stack.
> 
> hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: tag#599 cmd 0x28 status: scsi 0x2 srb 0x4 host 0xc0000001

I went with the flow calling this "sts": the rest of the file does that.
Your suggestion is better than that, will implement in the next version.

Appreciate your help very much!

> 
> Thanks,
> Easwar (he/him)

-- 
Thank you,
Roman


