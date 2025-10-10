Return-Path: <linux-hyperv+bounces-7186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B0BCEB6F
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Oct 2025 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 883364E3C7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C6277030;
	Fri, 10 Oct 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LxwsIT+R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A927702A;
	Fri, 10 Oct 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136027; cv=none; b=Jb/L5ThXjO9ORAWZJZAn+aqRkgkPaRvEIA+zTem9fvQs4q1XQ5P2WFIh1TOGsXZuc8QoO6iQEHvFOWclP8A8miXCSy8CC7dOl05RAlW9uvfskX0fc/lmM39ONFwPbrX/V+7r8Y5IJ+Frfwfek3hekfLaojl5Djzxv1mETsM5cX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136027; c=relaxed/simple;
	bh=MkEU/ngljpEF2CJglgAGPtKPs9rKrk8RyDy6pTSNxHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVTFBljpch2jHqeJVdAs1lycaIwHmtMMSyhbripibEWscMrxoiYFKxWAGqH2R75cAAec/9r9wqB0WY/iuauso3qIcGRRVnybI0axB5FKeK/XbJhghuVouNhYi6on5Ea8Yz1PUb/BXXc/R1bAb1V8MeBsXYEBO2AY/l8+iZ7mBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LxwsIT+R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.55] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 231912016015;
	Fri, 10 Oct 2025 15:40:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 231912016015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760136025;
	bh=co0o1UVfCT/1Bs0Yaa6xVQJMpwHFpxrTTf+fZcYfdao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LxwsIT+R3M7s2HA/7uZZPYxb2bh7EwIUvlLQOCsv6psE0dbFoVVm9F18l0IZH+YxT
	 /llteZU/es+Dvmjte4J3P7vLYHFOjI0IilVCBvvRvxp6MamCgKhYHhrRtvxB1wEPwB
	 NbPDZcOjoNZdJw/JZp0ZH5/akVr7eTCmtoNqWdLM=
Message-ID: <479242d4-ae08-442c-b61b-c9408ba2e9b0@linux.microsoft.com>
Date: Fri, 10 Oct 2025 15:40:24 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Drivers: hv: Use better errno matches for HV_STATUS
 values
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
 <2768abf3-6974-49e6-9ea2-5e5e04f533a7@linux.microsoft.com>
 <61be3488-9ea8-42e6-8c2b-35fbfb31e8c6@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <61be3488-9ea8-42e6-8c2b-35fbfb31e8c6@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 12:10 PM, Easwar Hariharan wrote:
> On 10/9/2025 11:53 AM, Nuno Das Neves wrote:
>> On 10/6/2025 4:08 PM, Easwar Hariharan wrote:
>>> Use a better mapping of hypervisor status codes to errno values and
>>> disambiguate the catch-all -EIO value. While here, remove the duplicate
>>> INVALID_LP_INDEX and INVALID_REGISTER_VALUES hypervisor status entries.
>>>
>>
>> To be honest, in retrospect the idea of 'translating' the hypercall error
>> codes is a bit pointless. hv_result_to_errno() allows the hypercall helper
>> functions to be a bit cleaner, but that's about it. When debugging you
>> almost always want to know the actual hypercall error code. Translating
>> it imperfectly is often useless, and at worst creates a red
>> herring/obfuscates the true source of the error.
> 
> I feel like you're thinking from the perspective of Microsoft engineers working with
> the hypervisor. IMHO, the translation is useful for the rest of the kernel to understand
> and possibly handle differently the possible errors. EBUSY for example is
> meant to indicate that the operation is already done, or that the target (device/hypervisor)
> is busy with something else. Timeouts may be handled by a retry, perhaps with a backoff period.

In your patch you've mapped EBUSY to HV_STATUS_NOT_ACKNOWLEDGED and
HV_STATUS_VTL_ALREADY_ENABLED. Neither of those can be handled by kernel code
that isn't aware of the hypervisor. They are logic bugs that just need to be
surfaced and fixed by someone familiar with the related code.

This is the case for most hypercall errors: they indicate a bug and we need to
surface the error and fix the code, not handle it at runtime.

The few examples (in the mshv_root driver) where a hypercall error is handled at
runtime are:
1. HV_STATUS_INSUFFICIENT_MEMORY where pages are deposited.
2. HV_STATUS_NO_RESOURCES which happens on withdrawing pages when there's none
   left. That is treated as a success.
3. HV_STATUS_CALL_PENDING means waiting for a completion on an async hypercall

All of these are context-specific - the errors can only be handled there.
>>
>> With that in mind, updating the errno mappings to be more accurate feels
>> like unnecessary churn. It might even be better to remove the errno mappings
>> altogether and just translate HV_STATUS_SUCCESS to 0 and any other error
>> to -EIO or some other 'signal' error code to make it more obvious that
>> a *hypercall* error occurred and not some other Linux error. We'd still
>> want to keep the table in some form because it's also used for the error
>> strings.
> 
> IMHO, an arbitrarily chosen 'signal' error code wouldn't tell support or the rest of the community that
> a hypercall error occurred, without a print or trace closest to the hypercall location.
> 

The other Linux error codes don't either. I agree we should almost always have a
debug or error print right after the hypercall fails.

>>
>> The cleanup removing the duplicates in the table is welcome.
>>
>> Nuno
>>
> <snip>


