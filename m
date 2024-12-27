Return-Path: <linux-hyperv+bounces-3538-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF129FD69A
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2F7A06ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DF49652;
	Fri, 27 Dec 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NDdty21S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1771F192A;
	Fri, 27 Dec 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735320774; cv=none; b=k/F5lrG9jhZZPcMqGPsYcAKoh52sHTztRI/m+Nf/ktGgESYbx+wLnQNLjBKTlMyfO6YifYPz1j0+QqpdYq8sdiYj5aUVDK2WuKPOqsi7wPuPE0AA3Z360aOXmat0hO8L0OKe4CwjIBNt9T5fOpYwXRyXS6pSku2gAcwgzuCO5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735320774; c=relaxed/simple;
	bh=OYfR7yyEp4/jnEtzGE23gNLa3/50JJDFaIgbPyvgRZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leTZnh+xsjdlSRX1eXO8iY6abRkxHV9R4pTptWNvenrEOewDwRJ64IDgc12TCoOAyeRafJeLr3FWdb+aQHZQXsL7RH/TFtEK1u+LTEYPJ2C0xiSUbdrtPgJLLVcEXI+WPSSf2OSgXpA0/tO60D0ItjnK/s5XXL5GX5AUJpU77Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NDdty21S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A8DE203EC39;
	Fri, 27 Dec 2024 09:32:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A8DE203EC39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735320772;
	bh=9K0czX+VkWldopfsJxhLkWA/kSIYQMx4uzpWy7qoTAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NDdty21SOhfJEzxgKBLmtw3/o5ahS7Ot2setM0xDomt7qyyzw0mynoQ2fGiu4Rxav
	 gpYY/W5C1NoFbFnWcbgUzrmFJKDcmGhzUQ6Q6q+vFusA9bABLXtF1tDgOmS+/8sRfg
	 WANXCngY0JyHf+vbS29+Dh+7FacuHpCPrFa7VgVY=
Message-ID: <7f4b0c42-34e7-4321-858f-22e8896609af@linux.microsoft.com>
Date: Fri, 27 Dec 2024 09:32:51 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hyperv: Do not overlap the hvcall IO areas in
 hv_vtl_apicid_to_vp_id()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-6-romank@linux.microsoft.com>
 <8c564cfc-2794-45f2-a1cf-2d6b5d0d78e6@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <8c564cfc-2794-45f2-a1cf-2d6b5d0d78e6@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/26/2024 2:01 PM, Easwar Hariharan wrote:
> On 12/26/2024 1:31 PM, Roman Kisel wrote:
>> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
>> disallows overlapping of the input and output hypercall areas, and
>> hv_vtl_apicid_to_vp_id() overlaps them.
>>
>> Use the output hypercall page of the current vCPU for the hypercall.
>>
>> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
>> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_vtl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
>> index 04775346369c..ec5716960162 100644
>> --- a/arch/x86/hyperv/hv_vtl.c
>> +++ b/arch/x86/hyperv/hv_vtl.c
>> @@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>>   	input->partition_id = HV_PARTITION_ID_SELF;
>>   	input->apic_ids[0] = apic_id;
>>   
>> -	output = (u32 *)input;
>> +	output = (u32*)*this_cpu_ptr(hyperv_pcpu_output_arg);
>                       ^
> Nit: I believe the space is preferred, but I won't insist on respinning
> it for that.
I think we can drop the whole type cast thing (as the other patch does).
Type coercion will do what is needed, and the type cast just appears to
be noise I guess.

> 
> It's a good idea to give credit to Michael with a Reported-by tag, and
> maybe a Closes: tag with a link to his email.
My bad, I should have definitely done that! Will certainly do!

> 
> As with the Fixes tag for patch 2, you don't need to respin the series
> and can just reply to this thread.
"Fixes" means something when the commit is present in the Linus'es tree
as I understood from the Wei's reply 
(https://lore.kernel.org/lkml/Z2OIsFUXcjVXpqtw@liuwe-devbox-debian-v2/):

" This commit is not in the mainline kernel yet, so this tag is not
needed.

It will most likely to be wrong since I will need to rebase the
hyperv-next branch.

I can fold this patch into the original patch and leave your
Signed-off-by there."

I'll check if the commit has been pulled into the mainline tree.

> 
> Otherwise, looks good to me.
> 
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

-- 
Thank you,
Roman


