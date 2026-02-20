Return-Path: <linux-hyperv+bounces-8932-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBdiB1KumGl4KwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8932-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 19:56:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1316A35F
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E768A3016290
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Feb 2026 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60B366DA5;
	Fri, 20 Feb 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oZ8O5w4O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8708D315D35;
	Fri, 20 Feb 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613774; cv=none; b=ZKyEx7xf2i93YUkZzw76oKgXw4uQaO9OoPos/OAr7Va2OFlOXrDaw1aKjqSPZpQ2K8ysHRtepOflZ5finIFDME59c/cZC5P86FN4WeNL+sFqf04iTKQvumtMp0h2AI9uCFUPIelhM9jFqJfPLDG8fddTxTitw8fvkctR06mhGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613774; c=relaxed/simple;
	bh=5O8ORrKcyRo/TpsXHY+kNzLJXGt+WPaNxJMBmkLPIVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo8LXT7koj3p7WR9EAb2OXLMdmgriNsIO+nZ0uHphxVz7YNJMfrW6sEk/RfhC+kuhOe5ooJ4EpJWiVplX9MIXV1DKM0WlsCugZw9ZjPsLPIA8vZ0rAZ1bgLIZn+RBSMPmh/pQi9PctP4DX/WOMiw64LSC+EzZdwNWQLy4gqAvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oZ8O5w4O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF8DA20B6F00;
	Fri, 20 Feb 2026 10:56:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF8DA20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771613768;
	bh=JwYnJTh8Nb9Xb1ai8s2Cvv8rwYAKZsXDNcdrU7Y5uT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZ8O5w4O3T3xAv9C7DGCt0E+fYfXxhtFf/TIlkrN5rVFPnsb/LSK76mzgEo9KwcX5
	 Jxc3VSk0hhvanhG9350EhmfUFLtJzCnR424dCpoAj6UyoR7NcubNpoI5/sLn3t4xwn
	 RzlORQLkpcDNeZdyolJDgZ2R4d16SG1uEK+H5/J0=
Message-ID: <e344676b-2893-b264-68f1-b92a3e0c40c6@linux.microsoft.com>
Date: Fri, 20 Feb 2026 10:56:07 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
 <SN6PR02MB41574BE5CE887CADE406BAD3D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260220184520.GB3119916@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260220184520.GB3119916@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8932-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4D1316A35F
X-Rspamd-Action: no action

On 2/20/26 10:45, Wei Liu wrote:
> On Fri, Feb 20, 2026 at 05:14:26PM +0000, Michael Kelley wrote:
>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, February 17, 2026 3:12 PM
>>>
>>> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
>>> has an assert intrinsic that uses interrupt vector 0x29 to create an
>>> exception. This will cause hypervisor to then crash and collect core. As
>>> such, if this interrupt number is assigned to a device by Linux and the
>>> device generates it, hypervisor will crash. There are two other such
>>> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
>>> Fortunately, the three vectors are part of the kernel driver space and
>>> that makes it feasible to reserve them early so they are not assigned
>>> later.
>>>
>>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>>> ---
>>>
>>> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
>>> v2: replace ifndef with cpu_feature_enabled() (thanks hpa and tglx)
>>>
>>>   arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>>> index 579fb2c64cfd..88ca127dc6d4 100644
>>> --- a/arch/x86/kernel/cpu/mshyperv.c
>>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>>> @@ -478,6 +478,28 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>>   }
>>>   EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>>>
>>> +/*
>>> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
>>> + * will either crash or hang or attempt to break into debugger.
>>> + */
>>> +static void hv_reserve_irq_vectors(void)
>>> +{
>>> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
>>> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
>>> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
>>> +
>>> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
>>> +		return;
>>> +
>>> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>>> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
>>> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
>>> +		BUG();
>>> +
>>> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
>>> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
>>
>> I'm a little late to the party here, but I've always seen Intel interrupt vectors
>> displayed as 2-digit hex numbers. This info message is displaying decimal,
>> which is atypical and will probably be confusing.
> 
> Noted. The pull request to Linus has been sent. We will change the
> format in a follow up patch.

Well, there is no 0x prefix, so should not be confusing, but no big
deal, whatever.....

Thanks,
-Mukesh



