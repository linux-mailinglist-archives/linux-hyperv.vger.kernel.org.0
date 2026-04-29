Return-Path: <linux-hyperv+bounces-10464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMruGgPX8WlTkwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10464-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:01:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEA49282B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8963016902
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391AB1AC44D;
	Wed, 29 Apr 2026 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q31XCORO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BD39B962;
	Wed, 29 Apr 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456653; cv=none; b=St87I+Xu/qamZtHUno9r1yt+Si9pWm66d3n7j6j+kTSg/2x5DuyAbK1oD3GSZCqxGnbSpQGfCWRd1WHt+2g+KhHZxH7rwO6e+Jm9hISMQG+VDNmDcnPMkCX9ZMVY2B0WCXGoqhpB4nR+5gPQczAdJdg5Hxz4zXy7cY9UN8VZpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456653; c=relaxed/simple;
	bh=DgWvSVm0t3Tm58/J3QHKKBz4VeXvse0bJERoO+L+XOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQRBxaQr6phThinVG9gwPqcKm6nxDyQKtp1cBQGc2/Pp7UnNolbfN5bKotadg8/G4+eEL3fR30ewSe3RgI1SO0tD48y1TGCC4fAaTX3Tk99LdHE1aplaeOlm4GJinsF+C1s/yk4PknjO+nYWFT5xmGDuD97O9P3FAe/AKL3glk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q31XCORO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.160] (unknown [167.220.238.0])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5250A20B716C;
	Wed, 29 Apr 2026 02:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5250A20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777456652;
	bh=Umh2GNLzS0ZLJ1ouGA7sN5L/Audjee+GTfXIQgbar64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q31XCOROwAjmtXRERBx2iF+/+sJsH2ybABfnJCzFn77NWB9EVyO4d6UDaaSUN2seb
	 YQ7d0/CyN4ooJv9sS8ZRGDqMJBY896FQHOvEKQgI5tVaj4mJi2D6hDXN+gA0IZ5wgq
	 80ZbIizjLbl6bTb0czS/dH3jkSHeHVV2s6z/Ha8s=
Message-ID: <80efa86b-de96-438c-ac04-fda22c655500@linux.microsoft.com>
Date: Wed, 29 Apr 2026 15:27:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] Drivers: hv: Move
 hv_call_(get|set)_vp_registers() declarations
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
 <20260423124206.2410879-9-namjain@linux.microsoft.com>
 <SN6PR02MB4157852404B5258EF13A5450D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157852404B5258EF13A5450D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6EEA49282B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10464-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]



On 4/27/2026 11:09 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 2026 5:42 AM
>>
>> Move hv_call_get_vp_registers() and hv_call_set_vp_registers()
>> declarations from drivers/hv/mshv.h to include/asm-generic/mshyperv.h.
>>
>> These functions are defined in mshv_common.c and are going to be called
>> from both drivers/hv/ and arch/x86/hyperv/hv_vtl.c. The latter never
>> included mshv.h, relying on implicit declaration visibility. Moving the
>> declarations to the arch-generic Hyper-V header makes them properly
>> visible to all architecture-specific callers.
>>
>> Provide static inline stubs returning -EOPNOTSUPP when neither
>> CONFIG_MSHV_ROOT nor CONFIG_MSHV_VTL is enabled.
> 
> Looking at the drivers/hv/Kconfig, it's possible to build with
> CONFIG_HYPERV_VTL_MODE=y, but not CONFIG_MSHV_VTL. In such a
> case, mshv_common.o doesn't get built, which is why the stubs are
> needed. Is such a configuration desirable for some scenarios?
> 
> I wonder if having CONFIG_HYPERV_VTL_MODE force the building of
> mshv_common.o would be a better approach. Then the stubs wouldn't
> be needed. The "ifneq" statement in drivers/hv/Makefile could use
> CONFIG_HYPERV_VTL_MODE instead of CONFIG_MSHV_VTL, and
> everything would be good since CONFIG_MSHV_VTL depends on
> CONFIG_HYPERV_VTL_MODE.
> 

This looks good. I'll try this and make the changes. In case there are 
some challenges with that, I'll revert back.


Regards,
Naman

