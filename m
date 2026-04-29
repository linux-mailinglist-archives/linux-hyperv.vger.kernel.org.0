Return-Path: <linux-hyperv+bounces-10461-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J3gFbPW8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10461-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:00:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A714927C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB85300B059
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D83C1973;
	Wed, 29 Apr 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T8QQBSnu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF23C063B;
	Wed, 29 Apr 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456572; cv=none; b=dCERMN6GrrToKw/Xngbn2PebIuWOrQ30tTgPmZPCD01HKIZMGn6mR0uLrhCF5aO7ymT9yIMe6ODtONIyI45gVbHAVIHfEnkDqdjs7YDsI+09N1kQNuXSNdLwLRvAr0eDSaTC+xWrVsT+PtqMOrnxvUV4hbMvPdKUjgWkbvG86DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456572; c=relaxed/simple;
	bh=vEWoJownw+5W+hTP3smOvgta2AR1WsxNBLddquqfH/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1xPKEU2mgmlOm9hy6Nwd0FtLUTuxksApqsXJPcbgQWWxlKckUjEOdDALhmtv05RpBdAUsANBwaYPzIKqkwn/qlDaYd/6SQOiw4GpadnJPD9TQY9w7azBErRj3XW74IVpeN8N5dGImQVKSGXPYCZ3W8NpeXoFb2GVNRHLpR2JIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T8QQBSnu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 64EEC20B716D;
	Wed, 29 Apr 2026 02:55:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64EEC20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456562;
	bh=fPeBJsFqpoo+2GdY4mHjPpIMHuwqDUdZaSruCXTJrak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T8QQBSnuhbdga7x4qEdwC5GZPzFgwlYf2WqARJb11uBsZQpYGJmwXoDwqDXFtzto5
	 fPLHAG0knbJHiSxvTqL44F14Cc2BFS+PyBGByoqAywuQ8/vZQellbl02B5e1OOdsJ6
	 DjHGtk8P6ExJYnkJrl2siSeOafxOqtujr+xxRSFE=
Message-ID: <f0d97ca9-4620-4448-90ca-ecc327be5efa@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:25:51 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] Drivers: hv: Move vmbus_handler to common code
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
 Sascha Bischoff <sascha.bischoff@arm.com>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "vdso@mailbox.org" <vdso@mailbox.org>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-4-namjain@linux.microsoft.com>
 <SN6PR02MB4157E3B0A6F76E4686D8C3E4D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E3B0A6F76E4686D8C3E4D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3A714927C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10461-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]



On 4/27/2026 11:08 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> Move the vmbus_handler global variable and hv_setup_vmbus_handler()/
>> hv_remove_vmbus_handler() from arch/x86 to drivers/hv/hv_common.c.
>>
>> hv_setup_vmbus_handler() is called unconditionally in vmbus_bus_init()
>> and works for both x86 (sysvec handler) and arm64 (vmbus_percpu_isr).
>>
>> This eliminates the need for separate percpu vmbus handler setup
>> functions and __weak stubs, that are needed for adding ARM64 support
>> in MSHV_VTL driver where we need to set a custom per-cpu vmbus handler.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c | 12 ------------
>>   drivers/hv/hv_common.c         |  9 +++++++--
>>   drivers/hv/vmbus_drv.c         | 17 +++++++++--------
>>   include/asm-generic/mshyperv.h |  1 +
>>   4 files changed, 17 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 89a2eb8a0722..68706ff5880e 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -145,7 +145,6 @@ void hv_set_msr(unsigned int reg, u64 value)
>>   EXPORT_SYMBOL_GPL(hv_set_msr);
>>
>>   static void (*mshv_handler)(void);
>> -static void (*vmbus_handler)(void);
>>   static void (*hv_stimer0_handler)(void);
>>   static void (*hv_kexec_handler)(void);
>>   static void (*hv_crash_handler)(struct pt_regs *regs);
>> @@ -172,17 +171,6 @@ void hv_setup_mshv_handler(void (*handler)(void))
>>   	mshv_handler = handler;
>>   }
>>
>> -void hv_setup_vmbus_handler(void (*handler)(void))
>> -{
>> -	vmbus_handler = handler;
>> -}
>> -
>> -void hv_remove_vmbus_handler(void)
>> -{
>> -	/* We have no way to deallocate the interrupt gate */
>> -	vmbus_handler = NULL;
>> -}
>> -
>>   /*
>>    * Routines to do per-architecture handling of stimer0
>>    * interrupts when in Direct Mode
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index e8633bc51d56..eb7b0028b45d 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -758,13 +758,18 @@ bool __weak hv_isolation_type_tdx(void)
>>   }
>>   EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
>>
>> -void __weak hv_setup_vmbus_handler(void (*handler)(void))
>> +void (*vmbus_handler)(void);
>> +EXPORT_SYMBOL_GPL(vmbus_handler);
>> +
>> +void hv_setup_vmbus_handler(void (*handler)(void))
>>   {
>> +	vmbus_handler = handler;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
>>
>> -void __weak hv_remove_vmbus_handler(void)
>> +void hv_remove_vmbus_handler(void)
>>   {
>> +	vmbus_handler = NULL;
>>   }
>>   EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
> 
> I'd suggest moving hv_setup_vmbus_handler() and
> hv_remove_vmbus_handler() above or below the group
> of __weak stubs in this source code file. There's a comment
> describing the purpose of these __weak functions, and
> intermixing these two functions that are no longer __weak
> produces something of a jumble.
> 

Acked.

>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index bc4fc1951ae1..052ca8b11cee 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1415,7 +1415,8 @@ EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
>>
>>   static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>>   {
>> -	vmbus_isr();
>> +	if (vmbus_handler)
>> +		vmbus_handler();
> 
> Is it necessary to test vmbus_handler first? From what I can
> see, it is always set before the per-cpu interrupt is setup.

After the shuffle of hv_remove_vmbus_handler() and freeing the irq, it 
can be safely removed. When I was setting the vmbus_handler to NULL 
first, before freeing the IRQ, this was required.

> 
>>   	return IRQ_HANDLED;
>>   }
>>
>> @@ -1517,8 +1518,10 @@ static int vmbus_bus_init(void)
>>   		vmbus_irq_initialized = true;
>>   	}
>>
>> +	hv_setup_vmbus_handler(vmbus_isr);
>> +
>>   	if (vmbus_irq == -1) {
>> -		hv_setup_vmbus_handler(vmbus_isr);
>> +		/* x86: sysvec handler uses vmbus_handler directly */
>>   	} else {
>>   		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
>>   				"Hyper-V VMbus", &vmbus_evt);
>> @@ -1553,9 +1556,8 @@ static int vmbus_bus_init(void)
>>   	return 0;
>>
>>   err_connect:
>> -	if (vmbus_irq == -1)
>> -		hv_remove_vmbus_handler();
>> -	else
>> +	hv_remove_vmbus_handler();
>> +	if (vmbus_irq != -1)
>>   		free_percpu_irq(vmbus_irq, &vmbus_evt);
> 
> These operations should be reordered so they are the inverse
> of how they are setup.  I.e., free_percpu_irq() first, then remove
> the VMBus handler. That's just good standard practice unless
> there's a specific reason to do the cleanup ordering differently. In
> fact, hv_remove_vmbus_handler() needs to be moved down
> to the err_setup label so it's done if request_percpu_irq()
> fails.


Acked. I will do the same for other hv_remove_vmbus_handler() as well.

> 
>>   err_setup:
>>   	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
>> @@ -3026,9 +3028,8 @@ static void __exit vmbus_exit(void)
>>   	vmbus_connection.conn_state = DISCONNECTED;
>>   	hv_stimer_global_cleanup();
>>   	vmbus_disconnect();
>> -	if (vmbus_irq == -1)
>> -		hv_remove_vmbus_handler();
>> -	else
>> +	hv_remove_vmbus_handler();
>> +	if (vmbus_irq != -1)
>>   		free_percpu_irq(vmbus_irq, &vmbus_evt);
> 
> Ordering should be changed here as well so it is the inverse
> of how things are set up.
> 
>>   	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
>>   		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 2810aa05dc73..db183c8cfb95 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -179,6 +179,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
>>
>>   int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>>
>> +extern void (*vmbus_handler)(void);
>>   void hv_setup_vmbus_handler(void (*handler)(void));
>>   void hv_remove_vmbus_handler(void);
>>   void hv_setup_stimer0_handler(void (*handler)(void));
>> --
>> 2.43.0
>>


Regards,
Naman


