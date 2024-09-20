Return-Path: <linux-hyperv+bounces-3053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95797D4A1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC84B22259
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45A13C80C;
	Fri, 20 Sep 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9qtaxQk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AC4A04;
	Fri, 20 Sep 2024 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830950; cv=none; b=dIFUW+6EwBkOyytrSDBW+xnmIoKBWUoUBYaKylX430ZG9WDHBcXMAlvZFQc/jXgmk+O8bgytrzQVQbde6JSKRuh6J7mvqcCKxLoME7Vu3geo4CzkxYPQWzLTSNqG0og5F6cFMuxns6+937q9qIhPoVAiCvtT7ipN+hOBDLGJik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830950; c=relaxed/simple;
	bh=h+s82IjrmrSosXMhpHFrn5GaNziYR2LeeA9e/OGajkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctppXn0s+ibzwFgLY8hN9NXnztN72TPNHxw8GP2UdINrIesZHVpFoOysRMFVWnLJGEjbpkuL0MRfBypC8/6AHsZlgqlEsBr+qXdh2+rDzK4XXRHpY7F6bxLdV6dQudgWyIDb+5ddLkKQGZ0a1Kbrb+/W0GldcKkoH44PPOsN930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9qtaxQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75ACC4CEC3;
	Fri, 20 Sep 2024 11:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726830949;
	bh=h+s82IjrmrSosXMhpHFrn5GaNziYR2LeeA9e/OGajkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S9qtaxQkWq5AmwV6HOSzjTrq8IP+NCm+tnHJFZoHGJa0Qcvc2JG1weGvIdd19vSQm
	 I55KwXzwglpSXaLaWgQ4dewBmrAeLmtAYh6KcuhKcvEt9q66yK1e/2JMRHVVppmRtN
	 Z/40hvw5qseayQvjV9Ioz4H6TzYqfpBeeTqiNXZqnSGk/LsKIwONo4LlaON8iJfM9T
	 N/M+r5LazaCWuif5G+WV342X39S0Y/8+QWOmU31fMYBj6/7wGVfPugtJblIFzFx7ZI
	 zgAHC5WKmU6wh24n//AnnkBnvbvKLJPBqkrQSBOdToEUI23lunvIRXoxNCBZYrOn2x
	 9mglxQCl5CplQ==
Message-ID: <874d5908-f1db-412f-96a2-83fcebe8dd98@kernel.org>
Date: Fri, 20 Sep 2024 13:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 rafael@kernel.org, lenb@kernel.org, kirill.shutemov@linux.intel.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
 <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
 <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
 <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2024 21:19, Yunhong Jiang wrote:
> On Mon, Sep 16, 2024 at 10:56:38AM +0200, Krzysztof Kozlowski wrote:
>> On 10/09/2024 08:13, Yunhong Jiang wrote:
>>> On Tue, Aug 27, 2024 at 01:45:49PM -0700, Yunhong Jiang wrote:
>>>> On Sun, Aug 25, 2024 at 09:10:01AM +0200, Krzysztof Kozlowski wrote:
>>>>> On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
>>>>>> Add the binding to use mailbox wakeup mechanism to bringup APs.
>>>>>>
>>>>>> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
>>>>>>  1 file changed, 64 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..cb84e2756bca
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
>>>>>> @@ -0,0 +1,64 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +# Copyright (C) 2024 Intel Corporation
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: x86 mailbox wakeup
>>>>>> +maintainers:
>>>>>> +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
>>>>>> +  processor (BSP) to wake up application processors (APs) through a wakeup
>>>>>> +  mailbox.
>>>>>> +
>>>>>> +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
>>>>>> +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
>>>>>> +  memory.
>>>>>> +
>>>>>> +  The wakeup mailbox structure is defined as follows.
>>>>>> +
>>>>>> +    uint16_t command;
>>>>>> +    uint16_t reserved;
>>>>>> +    uint32_t apic_id;
>>>>>> +    uint64_t wakeup_vector;
>>>>>> +    uint8_t  reservedForOs[2032];
>>>>>> +
>>>>>> +  The memory after reservedForOs field is reserved and OS should not touch it.
>>>>>> +
>>>>>> +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
>>>>>> +  routine's address into the wakeup_vector field, fill the apic_id field with
>>>>>> +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
>>>>>> +  wakeup command, the target AP will jump to the wakeup routine.
>>>>>> +
>>>>>> +  For each AP, the mailbox can be used only once for the wakeup command. After
>>>>>> +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
>>>>>> +  this AP.
>>>>>> +
>>>>>> +  The wakeup mailbox structure and the wakeup process is the same as
>>>>>> +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
>>>>>> +  section 5.2.12.19 [1].
>>>>>> +
>>>>>> +  References:
>>>>>> +
>>>>>> +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
>>>>>> +
>>>>>> +select: false
>>>>>
>>>>> This schema is still a no-op because of this false.
>>>>>
>>>>> What is the point of defining one property if it is not placed anywhere?
>>>>> Every device node can have it? Seems wrong...
>>>>>
>>>>> You need to come with proper schema. Lack of an example is another thing
>>>>> - this cannot be even validated by the tools. 
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>
>>> Hi, Krzysztof, I'm working to address your comments and have some questions.
>>> Hope to get help/guide from your side.
>>>
>>> For the select, the writing-schema.rst describes it as "A json-schema used to
>>> match nodes for applying the schema" but I'm a bit confused. In my case, should
>>> it be "cpus" node? Is there any code/tools that uses this property, so that I
>>> can have a better understanding?
>>
>> Usually we expect matching by compatible, but it does not seem suitable
>> here because it is not related to any specific device, right? That is
>> the problem with all this DT-reuse-for-virtual-stuff work. It just does
>> not follow usual expectations and guidelines - you do not describe a device.
> 
> Thank you for the reply.
> 
> I'm a bit confused on your "do not describe a device".
> I think VM is also a device, it's just a virtual device, but I don't see much
> difference of the virtual and physical device from DT point of view, possibly I
> missed some point.

VM is purely a software construct, so it is not a device. But regardless
of terminology, you did not describe here VM or its part, either.

>  
>>
>> You can still match by nodes. See all top-level bindings.
> 
> After checking the code at
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/validator.py,
> seems the 'select' is translated to 'if'/'then'.
> 
> Do you have any example of "top-level bindings"? I tried to check binding for
> enable-methods like arm/cpu-enable-method/nuvoton,npcm750-smp or
> cpu/idle-states.yaml, but they are either not schema file, or quite different.

Most of board schemas, so for example in arm directory.

> 
> I have been struggling on this device binding document for a while. I
> reconsidered what this binding is for. This binding means, if the cpus node has
> "enable-method" as "acpi-wakeup-mailbox", then the device should have property
> "wakeup-mailbox-addr" with uint64 type.
> 
> In that case, I'm considering to set the "select" to be true so that it will
> apply to any potential device, and add if/then keyword to check the
> enable-method. But seems it does not work and I'm still trying to figure out the
> reason (I'm new to the json/json schema and is still learning).
> 
> I received followed error:
> cpus: '#address-cells', '#size-cells', 'cpu@0', 'enable-method' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/x86/wakeup.yaml#
> cpu@0: 'device_type', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/x86/wakeup.yaml#
> 
> With the followed yaml file (I delete some description).
> 
> $ cat Documentation/devicetree/bindings/x86/wakeup.yaml
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> # Copyright (C) 2024 Intel Corporation
> %YAML 1.2
> ---
> $id: http://devicetree.org/schemas/x86/wakeup.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> title: x86 mailbox wakeup
> maintainers:
>   - Yunhong Jiang <yunhong.jiang@linux.intel.com>
> 
> description: |
>   ......
>   Removed to save space.
> 
> properties:
>   wakeup-mailbox-addr:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description: |
>       ......
>       Removed to save space.
> 
> select: true
> 
> if:
>   properties:
>     enable-method:
>       contains:
>         const: acpi-wakeup-mailbox
>   required:
>     - enable-method

enable-method is part of CPUs, so you probably should match the CPUs...
I am not sure, I don't have the big picture here.

Maybe if companies want to push more of bindings for purely virtual
systems, then they should first get involved more, instead of relying on
us. Provide reviews for your virtual stuff, provide guidance. There is
resistance in accepting bindings for such cases for a reason - I don't
even know what exactly is this and judging/reviewing based on my
practices will no be accurate.


> 
> then:
>   required:
>     - wakeup-mailbox-addr
> 
> additionalProperties: false
> 
> examples:
>   - |
>     cpus {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       enable-method = "acpi-wakeup-mailbox";
>       wakeup-mailbox-addr = <0x1c000500>;
>       cpu@0 {
>         device_type = "cpu";
>         reg = <0x1>;
>       };
>     };
> ...
> 
>>
>>>
>>> For your "validated by the tools", can you please share the tools you used to
>>> validate the schema? I used "make dt_binding_check" per the
>>> submitting-patches.rst but I think your comments is about another tool.
>>
>> See writing-schema document.
> Yes, I figured out in the end that the validate tools means the dt-schema tools.
> 
> Thank you
> --jyh
> 
>>
>>
>> Best regards,
>> Krzysztof
>>
>>

Best regards,
Krzysztof


