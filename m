Return-Path: <linux-hyperv+bounces-4168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B136A4A42C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 21:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0387B18890C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F346523F368;
	Fri, 28 Feb 2025 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H/PvLRLQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4923F362;
	Fri, 28 Feb 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774125; cv=none; b=Dl/n+VByiPEAJnIScmuDTKLTSPIK87+Aap3UqafcE9HBGmnOyBqSr6XkuzkzwTtngQASA0+4Yw8dIvJ7x0wo+o5AUbUVgQsCpkDbrPi4nhbXsYIJeYmRRawjXoTda5w8+U+Ifz2fv3RTvT0SeR9bZGkYa1T8o09Nc+9xra7Lztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774125; c=relaxed/simple;
	bh=o/l2bMwVBB38YORUnkTP9+moISfTV7Mu1AD98nT7SF4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=niZZzXtJP8UyZgij+CA3/zFtA2R+eArqBabumYIofOEELtKA7M3VIFRWYKB/CGI0/Ahb0dMKNKzcU4tm3QLZmOYwY9VC6WHswluaIMYBBsHm/xRYhxKvR2ap9Of6+Cbol1ZFEpQmOILX1thCAR4zxX66SZ/+1OcLszDXIdTzuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H/PvLRLQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA472210D0DB;
	Fri, 28 Feb 2025 12:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA472210D0DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740774118;
	bh=slzyIXqsJX8WxAkijLeHQaPM9dg81dMIPBdv/9p2VAQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=H/PvLRLQx++2lkUSwbWPLJGhMTIxPkHKQYd2hKUzIAwub7NBj6N9tXs5JCNFelUPr
	 afAZUQJvCZiWCAQ7H0WhJz11EHyk/1H/PMPB4rB7D09BgHxR16A6xnYladbn8FaPL0
	 uwOysYCSPoNw96W3VYB3JUvQHIUhI1SKJTkWcBtQ=
Message-ID: <40d016eb-e701-4872-b0bc-f5ba34093a53@linux.microsoft.com>
Date: Fri, 28 Feb 2025 12:21:57 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
To: Roman Kisel <romank@linux.microsoft.com>
References: <20250227233110.36596-1-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250227233110.36596-1-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2025 3:31 PM, Roman Kisel wrote:
> The log statement reports the packet status code as the hypercall
> status code which causes confusion when debugging.
> 
> Fix the name of the datum being logged.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a8614e54544e..d7ec79536d9a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
>  			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>  
>  		storvsc_log_ratelimited(device, loglevel,
> -			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
> +			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x sts 0x%x\n",

I'd suggest using "host" than the opaque "sts", since this is already part of the different
levels of status (scsi, srb...) being printed out. With "host", for e.g. the print would be seen
as the following and clearly point out the offending part of the stack.

hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: tag#599 cmd 0x28 status: scsi 0x2 srb 0x4 host 0xc0000001

Thanks,
Easwar (he/him)

