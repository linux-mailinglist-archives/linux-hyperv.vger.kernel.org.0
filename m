Return-Path: <linux-hyperv+bounces-3932-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1EA332F8
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 23:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7554C188AFF5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 22:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EF202C2E;
	Wed, 12 Feb 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bjJfIcpG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527FA205ABB;
	Wed, 12 Feb 2025 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401005; cv=none; b=BY4w36OqYe3iqjo2+Gm5rXKfCav//gmIRPINAbQf21s0OP7pwkvIjdf9yxu/XZhbG8ptSzcnTsQJS6EsljujhX1Q0gvG4O0tTj6PAorPth39O8/tFRQyJkA69pWWTYOlz+mH7AcD6kGhxDMEkwb1DoaEUlsVVKzi1s59thok07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401005; c=relaxed/simple;
	bh=ppyBepEsuRbnU6t8RiDWNF0kTPuGWiGxFSKLd3ObAB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmJ0fnYIOvgVlxDLiM7g6dd9XBGmm05qsFyj+tZ5KDa2YapCs+MACGYta813Fkd+wuyDhJhUmju/ZVRyO1ax4y0p9UJQUdTpLnLEfBYbvfwA7HAqMYcji9id+5FIYYJLz5+8mbwpDT/NIWXNUTVSBdnWgG4G5KvbJvRClrcKa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bjJfIcpG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98804203F3C8;
	Wed, 12 Feb 2025 14:56:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98804203F3C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739401003;
	bh=yBO9gv4/ks05/3Yjg843ZyiIexMycnYbYFhGtNFgvCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bjJfIcpGWxwwaAiRKn+zTgzdiCoGpTxt2+IYlFU02XWPt9tRPDV0qs1e1VTqi+8Vh
	 XEWih17kyYX+VhWnuH4kybWhG51phsrZjVq+Sl4HkUqyxs+dmYIR1UuJDAOt6c/ZuG
	 rGnWquUT/YZ64ma8kLuo4oaXxTDb0wSG1AcWKK1Y=
Message-ID: <e39b1947-0ea6-4573-9b71-7c8ea6c96d8c@linux.microsoft.com>
Date: Wed, 12 Feb 2025 14:56:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 0/2] x86/hyperv: VTL mode reboot fixes
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, mingo@redhat.com,
 tglx@linutronix.de, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
 <Z6wFnoK-X7i1bd9x@liuwe-devbox-debian-v2>
 <20250212175445.GA19243@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250212175445.GA19243@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/2025 9:54 AM, Saurabh Singh Sengar wrote:
> On Wed, Feb 12, 2025 at 02:21:18AM +0000, Wei Liu wrote:
[...]
>>
>> Saurabh please review these patches. Thanks.
> 
> Hi Roman,
Hi Saurabh,

> 
> Thanks for the patch, few suggestions and queries:
> 
> 1. Please fix the kernel bot warning
Will do!

> 2. Cc Stable tree is not enough, you need to mention the "Fixes" tag as well
>     for the commit upto where you want this patch to be backported.
Understood, thanks!

> 3. In your 2/2 commit, you mention 'triple fault' is the only way to reboot in x86.
>     Is that accurate ? Do you mean to say OpenHCL/VTL here ?
>     If this behaviour is specific to OpenHCl and not VTLs in general, is there a way
>     we can make these changes only for OpenHCL.
Right, I meant OpenHCL/VTL2, thank you very much! The changes are scoped
to running in VTLs in general at the moment. I can add a check for the
VTL == 2 if you'd like me to.

For VTL1 (aka LVBS), maybe folks would like to do something else,
do you happen to know? Maybe to report that to the VTL0 guest kernel
although seems dubious: the higher VTL failed so the lights must be out
for the lower VTLs? Or kexec?

>     
> 
> - Saurabh
> 
>>
>> I don't have a strong opinion on them.
>>
>>>
>>>   arch/x86/hyperv/hv_vtl.c | 31 +++++++++++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>>
>>> base-commit: 2e03358be78b65d28b66e17aca9e0c8700b0df78
>>> -- 
>>> 2.34.1
>>>

-- 
Thank you,
Roman


