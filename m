Return-Path: <linux-hyperv+bounces-10136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKAeG58f3WmsaAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10136-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:53:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 147623F023B
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C51383034DB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AD3168EE;
	Mon, 13 Apr 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F8eRxB/+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB831715D;
	Mon, 13 Apr 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099118; cv=none; b=moU3tD/1i/rIlJ57LTYqAOtqvtLMUuD4dRfG9qSR2ZA7OVQUizbcMeC+x4lXI22pYUP7Ce/2lXTBwrzCfenIUtX2dOxyTLu91XZWbjHFNnJZesdbws7OgwH5pXMWOrEyMUSlwUdxbIL8zVsgEQn4jfsK/Rdt3Fk2+4JQ+7Wysc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099118; c=relaxed/simple;
	bh=sMG8afdKQPOl/iLEke8g8ctMUh9PAhr6hByBi9LInHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5fvmHPPU+GzpQYrnQKLo4NiI/JysBnPGnELNMBcxZci6JYzy+ToSoNKLPzF87ZBFqvYMym+RViJX8slRfo9wNnztsqA4gD0msqETaDjTAZGZHTTpWfqobLnZWcrQCDyNGnEE30UIT2Bg0UCR6tImyHa5qQYJIkiJVTaglkqT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F8eRxB/+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.106] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4DCF620B6F01;
	Mon, 13 Apr 2026 09:51:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DCF620B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776099116;
	bh=BZg4EuUfpHNS+JSwjQ1D2m4I/BJ7BVsxLCpbabF/7+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F8eRxB/+wsF8U83KHRZ7cGnuJTXK5ScgYWX22s7lQ01sfWax4WFRBAp9xYWL/CNID
	 q09Rk6ZIJASUKh7q2NOci1dN+XraY4q45tViJ0uFadXnEvrwoBJgWYZpiE3cTp6T9j
	 esOfCpHOGKPfaTr4Wp5rVM7XMgeDVZeMzjIHtFi4=
Message-ID: <3264b2e6-f6fb-41b1-97da-22b5249c1839@linux.microsoft.com>
Date: Mon, 13 Apr 2026 22:21:47 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
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
 <20260316121241.910764-7-namjain@linux.microsoft.com>
 <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b5125f61-173f-45d0-a6dc-d795ba0f8693@linux.microsoft.com>
 <SN6PR02MB4157DA00A31F0BA8585B9B69D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157DA00A31F0BA8585B9B69D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10136-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 147623F023B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/13/2026 9:19 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, April 13, 2026 4:48 AM
>>
>> On 4/1/2026 10:27 PM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>>>
>>>> Generalize Synthetic interrupt source vector (sint) to use
>>>> vmbus_interrupt variable instead, which automatically takes care of
>>>> architectures where HYPERVISOR_CALLBACK_VECTOR is not present (arm64).
>>>
>>> Sashiko AI raised an interesting question about the startup timing --
>>> whether the vmbus_platform_driver_probe() is guaranteed to have
>>> set vmbus_interrupt before the VTL functions below run and use it.
>>> What causes the mshv_vtl.ko module to be loaded, and hence run
>>> mshv_vtl_init()?
>>
>> There is no race condition here. The init ordering guarantees that
>> vmbus_interrupt is always set before mshv_vtl_synic_enable_regs()
>> reads it.
>>
>> The call chain for setting vmbus_interrupt:
>>
>>     subsys_initcall(hv_acpi_init)                          [level 4]
>>       -> platform_driver_register(&vmbus_platform_driver) and so on.
>>
>>
>> The call chain for reading vmbus_interrupt:
>>
>>     module_init(mshv_vtl_init)                             [level 6]
>>       -> hv_vtl_setup_synic()
>>         -> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, ..., mshv_vtl_alloc_context, ...)
>>           -> mshv_vtl_alloc_context()
>>             -> mshv_vtl_synic_enable_regs()
>>               -> sint.vector = vmbus_interrupt
>>
>> do_initcalls() processes sections in order 0 through 7, so
>> hv_acpi_init() (level 4) is guaranteed to complete before
>> mshv_vtl_init() (level 6) runs.
>>
> 
> I think the situation is more complex than what you describe, depending
> on whether the VMBus driver and/or MSHV_VTL are built as modules vs.
> being built-in to the kernel image. In include/linux/module.h, see the
> comment for module_init() and how subsys_initcall() is mapped
> to module_init() when built as a module.
> 
> If both are built-in, then what you describe is correct. But if either or
> both are modules, then the respective init functions (hv_acpi_init
> and mshv_vtl_init) get called at the time the module is loaded, and
> not by do_initcalls(). I think hv_vmbus.ko gets loaded when an attempt
> is first made to access a disk, but I would need to look more closely to
> be sure. I don't have any understanding of what causes mshv_vtl.ko
> to be loaded. And what is the ordering if MSHV_VTL is built-in while
> VMBus is built as a module, or vice versa?
> 
> Michael
> 

Based on this, I still feel that this race is not possible.

hv_vmbus   mshv_vtl
    y          y  -> different initcall levels, no issues
    y          m  -> use without initialization is not possible
    m          y  -> config dependencies take care of this, and mshv_vtl 
is forced to compile as a module in this case.
    m          m  -> config and symbol dependencies should take care of 
it. mshv_vtl has symbol and config dependencies on hv_vmbus, and it 
won't allow loading mshv_vtl if hv_vmbus module is not loaded.

Relevant code here: kernel/module/main.c

Regards,
Naman

