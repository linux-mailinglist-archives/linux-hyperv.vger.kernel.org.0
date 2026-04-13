Return-Path: <linux-hyperv+bounces-10129-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FzRJiHY3GmcWQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10129-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:48:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B713EB815
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6A03037438
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F32D7DF1;
	Mon, 13 Apr 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X0gZaM1i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6D1684B4;
	Mon, 13 Apr 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080760; cv=none; b=V22SwGuIDICpZxVshFXg2gWvfv4fEKQyaLVtZa6iRTELOhJh4kP2YQ/9aceI5nJVUS6mI+lkbaYLA21j68IjqcD+MCR9bN7nLlU+zTjbazgPk3YG/XgeOypHlXzsZEEIGC+i6D1WERQmmvGj0Sye3My3tBO0DgjaN3ZtsODQ+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080760; c=relaxed/simple;
	bh=ifmlxWsvmBNj5xCG9tRar03tw0HacUgfFov82PdSNgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLwWJCNcFGoIHwTb6nEQjGiXTKlMkI1k5fZGn8xyVcCrPHsT2h2yyredjX6Kvzhd9unTQQfVBIdIXVyt4t5KGHdny6oD3XZuwtxHOnGHxPlPSh/iGdJ+UHDNAB2xzGAKl/uxuin3Gvw4rbbTwawHV0tvYUrn57n56oYcwCUuNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X0gZaM1i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.106] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8B8520B7129;
	Mon, 13 Apr 2026 04:45:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8B8520B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776080758;
	bh=/R/iDity5TJZZZ/uK70jxKQhUS8zNyau0qDvXmlQFJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0gZaM1iTAoRjPQh4ae+wdKCTyYwz71aXaaSnNofcCfSxCWn4mtrxDaNRHtayAHbO
	 mW+2MI2fYrMMA6ijE71h0hU+MKFtizhGyAvmqAHuHN+fi9UBGGi5tT9z+EJYgLH9Hr
	 Ev6Qv7kFxmZWYI8x2J58wefx+qtSqAi2on/uHzas=
Message-ID: <956d343d-6b9b-48df-8341-91ea0cfe7efd@linux.microsoft.com>
Date: Mon, 13 Apr 2026 17:15:46 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] Drivers: hv: Add support to setup percpu vmbus
 handler
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-4-namjain@linux.microsoft.com>
 <SN6PR02MB41570E0F113FE28CFC839476D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570E0F113FE28CFC839476D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10129-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6B713EB815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:25 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> Add a wrapper function - hv_setup_percpu_vmbus_handler(), similar to
>> hv_setup_vmbus_handler() to allow setting up custom per-cpu VMBus
>> interrupt handler. This is required for arm64 support, to be added
>> in MSHV_VTL driver, where per-cpu VMBus interrupt handler will be
>> set to mshv_vtl_vmbus_isr() for VTL2 (Virtual Trust Level 2).
> 
> Needing both hv_setup_vmbus_handler() and
> hv_setup_percpu_vmbus_handler() seems unfortunate. Here's an
> alternate approach to consider:
> 
> 1. I think the x86 VMBus sysvec handler and the vmbus_percpu_isr()
> functions could both use the same vmbus_handler global variable.
> Looking at your changes in this patch set, hv_setup_vmbus_handler()
> and hv_setup_percpu_vmbus_handler() are used together and always
> set the same value.
> 
> 2. So move the global variable vmbus_handler out from arch/x86
> and into hv_common.c, and export it. The x86 sysvec handler can
> still reference it, and vmbus_percpu_isr() in vmbus_drv.c can
> also reference it.  No need to have vmbus_percpu_isr() under
> arch/arm64 or have a stub in hv_common.c.
> 
> 3. hv_setup_vmbus_handler() and hv_remove_vmbus_handler()
> also move to hv_common.c.  The __weak stubs go away.
> 
> With these changes, only hv_setup_vmbus_handler() needs to
> be called, and it works for both x86 with the sysvec handler and
> for arm64 with vmbus_percpu_isr().
> 
> I haven't coded this up, so maybe there's some problematic detail,
> but the idea seems like it would work. If it does work, some of my
> comments below are no longer applicable.
> 

This is a great suggestion. Current implementation looked complex in 
design and it was becoming more complex with the changes I was making 
while addressing Sashiko's AI review comments. However your suggestion 
looks much better. I'll implement it. Thanks for suggesting.

>>
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/hyperv/mshyperv.c   | 13 +++++++++++++
>>   drivers/hv/hv_common.c         | 11 +++++++++++
>>   drivers/hv/vmbus_drv.c         |  7 +------
>>   include/asm-generic/mshyperv.h |  3 +++
>>   4 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 4fdc26ade1d7..d4494ceeaad0 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -134,3 +134,16 @@ bool hv_is_hyperv_initialized(void)
>>   	return hyperv_initialized;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>> +
>> +static void (*vmbus_percpu_handler)(void);
>> +void hv_setup_percpu_vmbus_handler(void (*handler)(void))
>> +{
>> +	vmbus_percpu_handler = handler;
>> +}
>> +
>> +irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>> +{
>> +	if (vmbus_percpu_handler)
>> +		vmbus_percpu_handler();
>> +	return IRQ_HANDLED;
>> +}
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index d1ebc0ebd08f..a5064f558bf6 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -759,6 +759,17 @@ void __weak hv_setup_vmbus_handler(void (*handler)(void))
>>   }
>>   EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
>>
>> +irqreturn_t __weak vmbus_percpu_isr(int irq, void *dev_id)
>> +{
>> +	return IRQ_HANDLED;
>> +}
>> +EXPORT_SYMBOL_GPL(vmbus_percpu_isr);
>> +
>> +void __weak hv_setup_percpu_vmbus_handler(void (*handler)(void))
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(hv_setup_percpu_vmbus_handler);
> 
> You've implemented hv_setup_percpu_vmbus_handler() following
> the pattern of hv_setup_vmbus_handler(), which is reasonable.
> But that turns out to be unnecessarily complicated. The existing
> hv_setup_vmbus_handler() has a portion in
> arch/x86/kernel/cpu/mshyperv.c as a special case because it uses a
> hard-coded interrupt vector on x86/x64, and has its own custom
> sysvec code. And there's a need for a __weak stub in hv_common.c
> so that vmbus_drv.c will compile on arm64.
> 
> But hv_setup_percpu_vmbus_handler() does not have the same
> requirements. It could be implemented entirely in vmbus_drv.c,
> with no code under arch/x86 or arch/arm64, and no __weak stub
> in hv_common.c.  vmbus_drv.c would just need to
> EXPORT_SYMBOL_FOR_MODULES, like it already does with vmbus_isr.
> I didn't code it up, but I think that approach would be simpler with
> fewer piece-parts scattered all over. If so, it would be worth
> breaking the symmetry with hv_setup_vmbus_handler().
> 

No longer applicable.

Regards,
Naman

