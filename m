Return-Path: <linux-hyperv+bounces-10128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLWcEvrX3GmcWQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10128-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:48:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BEC3EB7C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740CD3022606
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA6387358;
	Mon, 13 Apr 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GdpGvPY6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED532142B;
	Mon, 13 Apr 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080670; cv=none; b=VSSrZWcmFcMzGF2olLo9rROuTwQUbsA+uXlFu1SN5hY89i2uHGs7AedEix1Svcy7Wfe1fgu867qldGqz1Cr18FgWoQOGopbangU1FmoF/EoazZA14+g8T1o4v9BjOBWBZfS9l4kkn2mn7u+HmcAI+nfOzvd/NF+TXfOe74Tk55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080670; c=relaxed/simple;
	bh=bKva/ejDkQSIYxls0YT/LQV3BV++Uth+I04DP9cgoAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBWcAi82OYvbYAzGtRgKYIn+6rSv9H8E57OzSZzn7UiFQlXSfBxe9hN8EIEzHIy6paPfcP3xsBdxSuoz956fZuTIoo+Wp7oieWA1WXHrcUtC86u1pXEEvtDaVtPiqhfevP8kbvoDpYKSTAflih9SXZGCdR8mpcaf0c4QNAOlAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GdpGvPY6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.106] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED2F320B7128;
	Mon, 13 Apr 2026 04:44:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED2F320B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776080668;
	bh=cGNuEHkArBiNiNVxwIRGSAzaCURMpjmGdsqqc7Hqft0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GdpGvPY6u6Kxlr3Gwj9vd3P3c+ECIc35+EwWAEp1VNH4UT26kmYkva+RZR3iv/Msg
	 uMIxbkofXzjxjwMRBnOSfMzfdKXz8nqUEP5WL2mOZ0gf2qqY16we/vfeRP9v29dxnY
	 GSqaZM25iXA12FMSgbcU8MrMWBs5cmsQkREpOLoM=
Message-ID: <7c6e721e-d8e1-45b5-99a3-a8104c212983@linux.microsoft.com>
Date: Mon, 13 Apr 2026 17:14:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] arch: arm64: Export arch_smp_send_reschedule for
 mshv_vtl module
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
 <20260316121241.910764-2-namjain@linux.microsoft.com>
 <SN6PR02MB41570A9050B3EB6A905DFF56D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570A9050B3EB6A905DFF56D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-10128-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92BEC3EB7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:24 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
> 
> Nit: For the patch "Subject", the most common prefix for the file
> arch/arm64/kernel/smp.c is "arm64: smp:".  I'd suggest using that
> prefix for historical consistency.

Acked. Will change in v2.

> 
>> mshv_vtl_main.c calls smp_send_reschedule() which expands to
>> arch_smp_send_reschedule(). When CONFIG_MSHV_VTL=m, the module cannot
>> access this symbol since it is not exported on arm64.
>>
>> smp_send_reschedule() is used in mshv_vtl_cancel() to interrupt a vCPU
>> thread running on another CPU. When a vCPU is looping in
>> mshv_vtl_ioctl_return_to_lower_vtl(), it checks a per-CPU cancel flag
>> before each VTL0 entry. Setting cancel=1 alone is not enough if the
>> target CPU thread is sleeping - the IPI from smp_send_reschedule() kicks
>> the remote CPU out of idle/sleep so it re-checks the cancel flag and
>> exits the loop promptly.
>>
>> Other architectures (riscv, loongarch, powerpc) already export this
>> symbol. Add the same EXPORT_SYMBOL_GPL for arm64. This is required
>> for adding arm64 support in MSHV_VTL.
>>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/kernel/smp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 1aa324104afb..26b1a4456ceb 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -1152,6 +1152,7 @@ void arch_smp_send_reschedule(int cpu)
>>   {
>>   	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>>   }
>> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>>
>>   #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>>   void arch_send_wakeup_ipi(unsigned int cpu)
>> --
>> 2.43.0
>>
> 
> The "Subject" nit notwithstanding,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks,
Naman

