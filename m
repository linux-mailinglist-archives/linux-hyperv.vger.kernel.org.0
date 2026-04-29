Return-Path: <linux-hyperv+bounces-10465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM9QE1HW8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10465-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:58:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7125492709
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C174303FFC8
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C93C6A56;
	Wed, 29 Apr 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DwwTmFw8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE83C555B;
	Wed, 29 Apr 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456681; cv=none; b=oa88kzd9db1xN2Nm6ZsK18Cv4UdCJg/rLMSo0zfzstVQW3+BWEVuNK1Xt2E2mZKOwz3/hYXWIwYcMfz11B8uLrWTKZ6tAviA3sQBY/wzF+5RlYIqLhIzU2IUC2wD4j00s8rYBbNNNPxDNqz6mJheczaxPFDrGjRpZ6yPKXBePq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456681; c=relaxed/simple;
	bh=SGFpjDx3Fh1/hVA49l0HXV517Okej9pbdw/Axq6b/Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZZxLQD4h5t2uSzL1Tibfzc7VW45+b5Ts9hEbJiftxFAhQ0hVq/uMniZJ9Nyulcoq/OuFP7Moh33vdD8kcJ3n/rs67V469+4mm69U2VV/OTVCr9Ld6v9syeaTKgqxyBNyPULUbKktiPJTmWa421/YGZ+sGLGqKyqlhIzNm8lTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DwwTmFw8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAA8120B716C;
	Wed, 29 Apr 2026 02:57:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAA8120B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456680;
	bh=glqfSPnZSBsC5GJM5wPOsyYjmETqsJsgYXJ3trO0o1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DwwTmFw8lT7PO8/kvWlFCX434M1go88YAYUFiOB7xJ1F+kocEhvrlQaUtuLbFgsgs
	 qpczmKHfDoN6xdxyX2dSLL7A3qYuWuJopov32H33TocopnxktApYAXXhDjaAJcsMV+
	 D/AJqX3CMxDfu3j87LG09egBB30+fv785wOjDaK0=
Message-ID: <567cf73b-6a48-4fc3-b312-9be6d71e2f22@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:27:49 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
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
 <20260423124206.2410879-10-namjain@linux.microsoft.com>
 <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7125492709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10465-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 4/27/2026 11:10 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> Move hv_vtl_configure_reg_page() from drivers/hv/mshv_vtl_main.c to
>> arch/x86/hyperv/hv_vtl.c. The register page overlay is an x86-specific
>> feature that uses HV_X64_REGISTER_REG_PAGE, so its configuration belongs
>> in architecture-specific code.
>>
>> Move struct mshv_vtl_per_cpu and union hv_synic_overlay_page_msr to
>> include/asm-generic/mshyperv.h so they are visible to both arch and
>> driver code.
>>
>> Change the return type from void to bool so the caller can determine
>> whether the register page was successfully configured and set
>> mshv_has_reg_page accordingly.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/x86/hyperv/hv_vtl.c       | 32 ++++++++++++++++++++++
>>   drivers/hv/mshv_vtl_main.c     | 49 +++-------------------------------
>>   include/asm-generic/mshyperv.h | 17 ++++++++++++
>>   3 files changed, 53 insertions(+), 45 deletions(-)
>>

<snip>

>>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> 
> This comment pre-dates your patch, but I don't understand the point
> it is trying to make. The comment is factually true, but I don't know
> why calling that out is relevant. The REG_PAGE MSR seems to be
> conceptually separate and distinct from the SIMP MSR, so the fact
> that the layouts are the same is just a coincidence. Or is there some
> relationship between the two MSRs that I'm not aware of, and the
> comment is trying (and failing?) to point out?

This was added as per suggestion from Nuno in my initial series for 
MSHV_VTL. If the reference in "identical to" is misleading, I should 
remove it.

https://lore.kernel.org/all/68143eb0-e6a7-4579-bedb-4c2ec5aaef6b@linux.microsoft.com/

Quoting:
"""
it is a generic structure that
appears to be used for several overlay page MSRs (SIMP, SIEF, etc).

But, the type doesn't appear in the hv*dk headers explicitly; it's just
used internally by the hypervisor.

I think it should be renamed with a hv_ prefix to indicate it's part of
the hypervisor ABI, and a brief comment with the provenance:

/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
union hv_synic_overlay_page_msr {
	/* <snip> */
};
"""

> 
>> +union hv_synic_overlay_page_msr {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enabled: 1;
>> +		u64 reserved: 11;
>> +		u64 pfn: 52;
>> +	} __packed;
>> +};
>> +
>>   u8 __init get_vtl(void);
>>   void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>> +bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
>>   #else
>>   static inline u8 get_vtl(void) { return 0; }
>>   static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0) {}
>> +static inline bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu) { return false; }
> 
> As with Patch 8, if CONFIG_HYPERV_VTL_MODE caused mshv_common.o
> to be built, this stub wouldn't be needed.
> 

Acked.


>>   #endif
>>
>>   #endif
>> --
>> 2.43.0
>>

Regards,
Naman

