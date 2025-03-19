Return-Path: <linux-hyperv+bounces-4601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE64A68628
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 08:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EB04204E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD924E00D;
	Wed, 19 Mar 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZawpNJqW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39626207DEA;
	Wed, 19 Mar 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370769; cv=none; b=jSL9XOal2h7TUAO/2DvZbCTo+6H1wP99M3iwWFbT4/nIGVQEFddzZRL9ZieiPrMKUlp6rO3zWFdudHvUlWKucZ0tV/erd/GRXIoDkJc4oSKcdNC6D3iBTheKOlYbHDdEjrjRdco0xVLWaUAOnj7fQH9B/fM+hUjTfWuZO4cXQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370769; c=relaxed/simple;
	bh=ydElR4BEsnGqBeQsKA4b4OztiPjBOlEfUTp4FQDIRF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfFSKoukvgIh1G1NCjS5zy0sGX0t+huxgoZcMT4UHMsWQR2KLvCqTcGHRVrKZ6/PnPLGp6JmsgZTyfggajLza1k6DjfVTOViSlJx8S9m/2eQXxzkufzHdyq+k7IMPfTkoSky8Lc6Lc1Yy1gO2QiWjpKbg+okOk2lPHVrIhtDQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZawpNJqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECE8C4CEE9;
	Wed, 19 Mar 2025 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370768;
	bh=ydElR4BEsnGqBeQsKA4b4OztiPjBOlEfUTp4FQDIRF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZawpNJqW5F0nJzlIxTHQe8wIH6OvMljjK6B733L1oIEAIzDw3xMf/thgshXafMZfc
	 lcFSHyUDn+Kr/ygEMw2gs+IXUrGshCSz5jlYhHoGURroJoUgoKS5XJl+hsosBlzr9Z
	 cHWUBQzgJrg5JRTNW+YwzCmiIzWopgIwxI1IOFYzqO86GtPrYf+fR82vk6S92rJwnf
	 a+FZGT1CEdbodIsGN1EwdG/2Dpzh+QOvupoU8CjvRllbvPYvHi0wKifyJgIAaexVEM
	 ZzesVa0L9JtBJCpSecd3tutKPxTnZbsHZcZ3qXbZuRFicVzsIJh0v6tthIJlsulFvN
	 x6T+bpJXD4gsw==
Message-ID: <17d37eab-2275-49ff-97b9-6b6706756f04@kernel.org>
Date: Wed, 19 Mar 2025 08:52:37 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-acpi@vger.kernel.org, ricardo.neri@intel.com, ravi.v.shankar@intel.com
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
 <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
 <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
 <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
 <874d5908-f1db-412f-96a2-83fcebe8dd98@kernel.org>
 <20250303222102.GA16733@ranerica-svr.sc.intel.com>
 <acb5fa11-9dce-44d0-85e3-e67a6a10c48f@kernel.org>
 <20250312055118.GA29492@ranerica-svr.sc.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250312055118.GA29492@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2025 06:51, Ricardo Neri wrote:
> On Tue, Mar 11, 2025 at 11:01:28AM +0100, Krzysztof Kozlowski wrote:
>> On 03/03/2025 23:21, Ricardo Neri wrote:
>>> On Fri, Sep 20, 2024 at 01:15:41PM +0200, Krzysztof Kozlowski wrote:
>>>
>>> [...]
>>>  
>>>> enable-method is part of CPUs, so you probably should match the CPUs...
>>>> I am not sure, I don't have the big picture here.
>>>>
>>>> Maybe if companies want to push more of bindings for purely virtual
>>>> systems, then they should first get involved more, instead of relying on
>>>> us. Provide reviews for your virtual stuff, provide guidance. There is
>>>> resistance in accepting bindings for such cases for a reason - I don't
>>>> even know what exactly is this and judging/reviewing based on my
>>>> practices will no be accurate.
>>>
>>> Hi Krzysztof,
>>>
>>> I am taking over this work from Yunhong.
>>>
>>> First of all, I apologize for the late reply. I will make sure
>>> communications are timely in the future.
>>>
>>> Our goal is to describe in the device tree a mechanism or artifact to boot
>>> secondary CPUs.
>>>
>>> In our setup, the firmware puts secondary CPUs to monitor a memory location
>>> (i.e., the wakeup mailbox) while spinning. From the boot CPU, the OS writes
>>> in the mailbox the wakeup vector and the ID of the secondary CPU it wants
>>> to boot. When a secondary CPU sees its own ID it will jump to the wakeup
>>> vector.
>>>
>>> This is similar to the spin-table described in the Device Tree
>>> specification. The key difference is that with the spin-table CPUs spin
>>> until a non-zero value is written in `cpu-release-addr`. The wakeup mailbox
>>> uses CPU IDs.
>>>
>>> You raised the issue of the lack of a `compatible` property, and the fact
>>> that we are not describing an actual device.
>>>
>>> I took your suggestion of matching by node and I came up with the binding
>>> below. I see these advantages in this approach:
>>>
>>>   * I define a new node with a `compatible` property.
>>>   * There is precedent: the psci node. In the `cpus` node, each cpu@n has
>>
> 
> Thanks for your feedback!
> 
>> psci is a standard. If you are documenting here a standard, clearly
>> express it and provide reference to the specification.
> 
> It is not really a standard, but this mailbox behaves indentically to the
> wakeup mailbox described in the ACPI spec [1]. I am happy reference the
> spec in the documentation of the binding... or describe in full the
> mechanism of mailbox without referring to ACPI. You had indicated you don't
> care about what ACPI does [2].

Behaving like ACPI and implementing a spec are two different things. The
question is whether you need to implement it like that and I believe
answer is: no.

> 
> In a nutshell, the wakeup mailbox is similar to the spin table used in ARM
> boards: it is reserved memory region that secondary CPUs monitor while
> spinning.
> 
>>
>>
>>>     an `enable-method` property that specify `psci`.
>>>   * The mailbox is a device as it is located in a reserved memory region.
>>>     This true regardless of the device tree describing bare-metal or
>>>     virtualized machines.
>>>
>>> Thanks in advance for your feedback!
>>>
>>> Best,
>>> Ricardo
>>>
>>> (only the relevant sections of the binding are shown for brevity)
>>>
>>> properties:
>>>   $nodename:
>>>     const: wakeup-mailbox
>>>
>>>   compatible:
>>>     const: x86,wakeup-mailbox
>>
>> You need vendor prefix for this particular device. If I pointed out lack
>> of device and specific compatible, then adding random compatible does
>> not solve it. I understand it solves for you, but not from the bindings
>> point of view.
> 
> I see. Platform firmware will implement the mailbox. It would not be any
> specific hardware from Intel. Perhaps `intel,wakeup-mailbox`?
> 
>>
>>>
>>>   mailbox-addr:
>>>     $ref: /schemas/types.yaml#/definitions/uint64
>>
>> So is this some sort of reserved memory?
> 
> Yes, the mailbox is located in reserved memory.


Then why reserved memory bindings are not working?

Anyway this was half a year ago. None of the emails are in my inbox.
None of the context is in my head.

It's the second or third email this month someone responds to my email
from 2024.

Frankly, that's a neat trick. I won't remember anything, but it would be
impolite to say just "no" without arguments. So now you will resend the
same code leading to the same discussions we had half a year ago. Or
ignoring that discussions.

I don't understand why this should be reviewers problem, so no, that's
just unfair.


Best regards,
Krzysztof

