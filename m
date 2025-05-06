Return-Path: <linux-hyperv+bounces-5390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84678AAC9CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411EF7B1D02
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C3283FE1;
	Tue,  6 May 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MB7yFrPj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69525B69F;
	Tue,  6 May 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546408; cv=none; b=QCTrtJrZ2FRdySPqJJqrpT1u5lLZTAU6i+O8FH6diwOUiUuPCEsR5fpIiJZzFE5Tth+N7Q5ta6C7Xy6o+QXh3mvgNWvnejnx6eH9OIHQ9G+xQFErCK/DB+TT9MRkFVdgkRZcUdo/ys1jm0qCufGdiKbN1a1aNPLLz/HL+14rM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546408; c=relaxed/simple;
	bh=XaGt/wgvCVS+f4R0x+QN06JYj9JPXLkLe3hpPcXtxqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8PfMYaU2sX4VBIt5H2tn3+29UN+IgwBRR6+xO46C2E3A+XbjrsbBzQd/yTWAqj5+cXOj6BRM73ROJCTLmOyKGCXYW6Aw5xekJnbnDNCa0LGT4r454VU5ir6l+at1nMcr9MnylI+78nP5kG1oSqxVNAX3oCMn1x0ptimfQ/pMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MB7yFrPj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE09A2115DCE;
	Tue,  6 May 2025 08:46:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE09A2115DCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746546405;
	bh=o03gSEDectcJtbA60ZihPtdHX0CvqvofYZ/7BrhHloY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MB7yFrPjCO3DI086vQye8gYGPsGkGbL2SCT3TheA4RJKlFU/axYH+FgBZIO3y6BT7
	 gunsAQ1pQDdvxIlrXLzJUrmNmu2usjpvi2XrhUm25f5XXTuHqtmSW2Q/k47GfROhQ6
	 C/3CtxvoxL9D812S69vDpegalwY5gZ+xHUqygMw4=
Message-ID: <7f9212eb-f8c1-4f7b-a268-e7e4161fa1a9@linux.microsoft.com>
Date: Tue, 6 May 2025 08:46:44 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
To: Wei Liu <wei.liu@kernel.org>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
 mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
 tiala@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250428182705.132755-1-romank@linux.microsoft.com>
 <aBmsIjIfgCv5G3Lj@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBmsIjIfgCv5G3Lj@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/5/2025 11:28 PM, Wei Liu wrote:
> On Mon, Apr 28, 2025 at 11:27:05AM -0700, Roman Kisel wrote:
>> To start an application processor in SNP-isolated guest, a hypercall
>> is used that takes a virtual processor index. The hv_snp_boot_ap()
>> function uses that START_VP hypercall but passes as VP index to it
>> what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>>
>> As those two aren't generally interchangeable, that may lead to hung
>> APs if the VP index and the APIC ID don't match up.
>>
>> Update the parameter names to avoid confusion as to what the parameter
>> is. Use the APIC ID to the VP index conversion to provide the correct
>> input to the hypercall.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> Unfortunately this patch fails to apply. Please send a new version based
> on the latest hyperv-next.
> 

Will do, thanks a lot for letting me know!!

> Thanks,
> Wei.

-- 
Thank you,
Roman


