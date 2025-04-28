Return-Path: <linux-hyperv+bounces-5198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB222A9F753
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011563AE694
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4E2918C5;
	Mon, 28 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NuREiuzu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91429117C;
	Mon, 28 Apr 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861384; cv=none; b=oYlejJP7sslmm8lzzqU0zwkMQCf8o2dtz4eTrD+b1VBFHSkYx4UpOEj6DtjzKxXztMPA6PSeXFeiTiNb2ThNyebnvww3e6l1xI0GfPcPSSurQnZsD2hIv7RBsQ5z2EGcH4iVxUFeUBS445v3VYovdyNumrygezjTjYtpECx6GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861384; c=relaxed/simple;
	bh=8qv7BWmQGL+pulHOoiMvT3V6xcrG4raa9JqLOtiwmK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6JsDbj177dp7jnUcJhZxNsfDXDHCIIOndyWnsdU5apNfEQNre8ge/Nc1Aeou3n+EwUuAXVUa9JJH29F2C5PN68Ww8P97YwKzzzHAqg3I1m6krG/5vQSIspHnb4Wzl/f1Vp89/7ozjV07+FA49cJHceBk+oMpI5TiItewjsHTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NuREiuzu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AC13211AD0B;
	Mon, 28 Apr 2025 10:29:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AC13211AD0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745861381;
	bh=TMMfsNfjbT3iJYp6TbmXhQJp5PtfCMdChjjTOT1Ekfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NuREiuzuc0gftRAfEIylmNVRYupxsInMl5g0xiVF5SE8+YeMsbtJnD/U0y8U3Iqml
	 tUg2Tl3wUYsppjUIY8waXsnoHQ1IcgIPY3DMTML/8IIUEP6WpsOl95IYSQvhJVIw+k
	 Lv1WWrP+4rJ2YZBeTsCjzDwrXN7hdYsJd8bXE9qo=
Message-ID: <0001941a-2946-44ab-87f5-78bee7619fe1@linux.microsoft.com>
Date: Mon, 28 Apr 2025 10:29:41 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8a235e4f-f4ce-445e-9714-380573033455@linux.microsoft.com>
 <SN6PR02MB41577E8A06C9F8BA66A8D68AD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aA7QZPFS7WWOsahp@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aA7QZPFS7WWOsahp@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/27/2025 5:48 PM, Wei Liu wrote:
> On Fri, Apr 25, 2025 at 04:55:42PM +0000, Michael Kelley wrote:

[...]

>>>
>>> I appreciate your help with the precision. I used loose language,
>>> agreed, would like to fix that. The patch was applied though but not yet
>>> sent to the Linus'es tree as I understand. I'd appreciate guidance on
>>> the process! Should I send a v2 nevertheless and explain the situation
>>> in the cover letter?
>>>
>>> IOW, how do I make this easier for the maintainer(s)?
>>
>> Wei Liu should give his preferences. But in the past, I think he has
>> just replaced a patch that was updated. If that's the case, you can
>> send a v2 without a lot of additional explanation.
>>
> 
> Normally if you need to send a new version because the original
> patch is buggy, you can just update your patch.
> 
> If only a commit message or comment needs to be updated, I will let the
> submitter know either to send a new version or not. Sometimes I will
> just make the changes myself to save the submitter some time.
> 

Very kind of you, thanks a lot for the explanation!

> Wei.

-- 
Thank you,
Roman


