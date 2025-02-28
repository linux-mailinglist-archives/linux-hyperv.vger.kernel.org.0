Return-Path: <linux-hyperv+bounces-4177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B755A4A638
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 23:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3ED168543
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBDB1DE4FE;
	Fri, 28 Feb 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lrLbKq5M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8823F372;
	Fri, 28 Feb 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783277; cv=none; b=NufSHhqIF2gIy3Sp60ZoJCa0wuq3tr5aWY2f4VvxHAtHKjD67qNE8prOvhxG/H6zaTcZ2XM3/eNhHttd3SnOWy+DmDEPxwF9c2IY4V1TIkQOSX5NShgl+jNE6pfu1K+01ec8zPn2H5Ibdu1ouDdrKx1cQYEtxpHxCpAHPUVNE6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783277; c=relaxed/simple;
	bh=Y0G3FnraSQXiNQhkOrQUyVD84KOBIVeLzxdHqm2PlH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJClwyuWr+NhnlttKV3a5hOu85sekAVbm534LDM9viIbY5kLy1oi/EvPwhGcUcG7jB3bhmtnZ6xuQ7emKXHsKolTSe6Ima4kjMxyOvIrYZblnuJ6K/3qIls779SvsqQhgQCN7Eg3QqgkveyBAjpim2vfVcFw0P2cWHDE0/IP7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lrLbKq5M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63053210D0EB;
	Fri, 28 Feb 2025 14:54:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63053210D0EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740783275;
	bh=TCatK5jzZyZHj5IWMa9vYckFbMN+IcQtVDdwoyNHQFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lrLbKq5Msbgdg556oQJ/q3Vkhz2eFIziDB/Hf1Tzs4Gma9XSJpfWnkLJQKvlZtwLa
	 k2d8Kk6UneLTSaa1ZEqgRkj49xfyCebhGSPSYnhnLtV/p+lT9gs5iNJgRnRgL34Old
	 8BgrpEjxHQrb/ycRBfKyWULbvrcCIEbWRSNkZTwY=
Message-ID: <aba327ea-ee90-4868-b23e-c2a3ce2ede43@linux.microsoft.com>
Date: Fri, 28 Feb 2025 14:54:35 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
To: Michael Kelley <mhklinux@outlook.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250227233110.36596-1-romank@linux.microsoft.com>
 <SN6PR02MB4157749BCF2F3226008575E0D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157749BCF2F3226008575E0D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/2025 12:55 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, February 27, 2025 3:31 PM
>>
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
>>   			scsi_cmd_to_rq(request->cmd)->tag,
>>   			stor_pkt->vm_srb.cdb[0],
>>   			vstor_packet->vm_srb.scsi_status,
> 
> FWIW, I added that last status value labelled "hv" in commit 08f76547f08d. And
> to confirm the discussion on the other thread, it's not a hypercall status -- it's a
> standard Windows NT status returned by the host-side VMBus or storvsp code.
> The "hv" is shorthand for Hyper-V, not hypercall. Perhaps that status is
> interpretable in a Windows guest, but it's not really interpretable in a Linux
> guest. The hex value would be useful only in the context of a support case
> where someone on the host side could be engaged to help with the
> interpretation.
> 
> I have no strong opinions on the label. Changing it from "hv" to "sts" or
> to "host" works for me.

Thank you, Michael, for helping us out with that! I'm leaning towards
"host" after Easwar's suggestion. As I understand from your reply,
it's fair to keep the tag as you're fine with the "host" option.

> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

-- 
Thank you,
Roman


