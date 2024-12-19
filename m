Return-Path: <linux-hyperv+bounces-3506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38E9F8555
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773211661F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155151A304A;
	Thu, 19 Dec 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jGT1UaXY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79F13D279;
	Thu, 19 Dec 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638459; cv=none; b=KoZ9X0aEiiKAGpSBd2srgCVthXPw/uBEDAY49CBBEc0bR7aFd1WLgXMu01UqERkDnqCJeYWVhI/jUxDsaVOFLS2qIe8RAQH76lQ5Mi+K6JTWQZ+mY8+314WMcuiU7id08UvtTBVgDqrXEQ30k206td1MmnJZ8dBDbGJJoYthIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638459; c=relaxed/simple;
	bh=1TeQ+UviK+m2QKvLJGDdIwUpa80+OLiNAQOD2/rq/9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBAOsQcio1dTfYMXzqZpeaTnaIbslGL2A6TyRr6Okp957f9Yj7OP4i9CFmIrIau9kxDwzXMJTkP2EiNJSwWxX/yGwaScLGADWVD7cdrx5TE970Vlyj6AmDA6M8K97q2jEooR/RZoTbwAJj/QELRkRCYjJHTjllAyUDN//mkJXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jGT1UaXY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E80AD203FC95;
	Thu, 19 Dec 2024 12:00:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E80AD203FC95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734638457;
	bh=r3ETTHElTu0o0O0zuRlfcpY4I+WoN9BnBxhiJXW/foc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jGT1UaXYtW4V/oQgi04r7k3KZroP0WxvP1AILnCP06aMFIzOHSrf2SbMokWxyiXRy
	 Dk2qI9kiJnxyBIfqvLEe3FyMHcx+vG3nooaFJAgFR71UTP+zpb31DTPkbcl2ssN6ct
	 +bYr6f3HM9b/omtz/re6OC7BrCS2zioTIgzJSOfY=
Message-ID: <07820167-b415-40b0-9858-d25325c348ba@linux.microsoft.com>
Date: Thu, 19 Dec 2024 12:00:56 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
 <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/2024 11:13 AM, Easwar Hariharan wrote:
> On 12/19/2024 10:40 AM, Nuno Das Neves wrote:
>> On 12/18/2024 12:54 PM, Roman Kisel wrote:
>>> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>>> changed the type of the output pointer to `struct hv_register_assoc` from
>>> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
>>> and leaves the system broken.
>>>
>> My bad! But, lets not use `struct hv_get_registers_output`. Instead, use
>> `struct hv_register_value`, since that is the more complete definition of a
>> register value. The output of the get_vp_registers hypercall is just an array
>> of these values.
>>
>> Ideally we remove `struct hv_get_vp_registers_output` at some point, since
>> it serves the same role as `struct hv_register_value` but in a more limited
>> capacity.
>>
>> Thanks
>> Nuno
>>
> 
> I had much the same conversation with Roman off-list yesterday.
Appreciate your help, Easwar!

> 
> The choice is between using hv_get_registers_output which is clearly the
> output of the GetVpRegisters hypercall by name, albeit limited as you
> said, and hv_register_value which is the more complete definition and
> what the hypervisor actually returns, but does not currently include the
> arm64 definitions in our copy of hvgdk_mini.h. hv_get_registers_output
> and hv_register_value overlap in layout for Roman's purposes.
> 
> FWIW, I'm in favor of adding the arm64 definitions to hv_register_value
> and using it for this get_vtl() patch.
I could do that, will wait to see if no objections.

> 
> This could be accompanied with migration of hv_get_vpreg128 in arm64/
> and removal of struct hv_get_registers_output, or that could be deferred
> to a later patch.
Having an equivalent of `hv_get_vpreg128` would be awesome on x64!
I'd bet something like that should exist in dom0/mshv already if you'd
like to have a dedicated function. So perhaps we could let mshv take
the lead with that?

If the desire is also to use the fast hypercall technique as
`hv_get_vpreg128` does, then we'd need fast hypercalls on x64 that
can use XMM registers (aka the fast extended hypercalls) that aren't
implemented in the hyperv drivers from my read of the code (although
it seems KVM knows how to do that when it emulates Hyper-V,
arch/x86/kvm/hyperv.c, struct kvm_hv_hcall *hc).

These considerations make me lean towards deferring hv_get_vpreg128-like
implementation to a later time.

> 
> - Easwar
> 

-- 
Thank you,
Roman


