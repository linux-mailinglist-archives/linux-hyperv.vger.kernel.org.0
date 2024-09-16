Return-Path: <linux-hyperv+bounces-3024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B50979D59
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2024 10:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CAA1C21E1B
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Sep 2024 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015E146592;
	Mon, 16 Sep 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzIE8eaz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3343ABD;
	Mon, 16 Sep 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477009; cv=none; b=sNzEUMzA+pwd3M/t+Et9V/2TK3Uf807wHAbthwSMn3EI5y8Fc5nyesaw/7LU1UCIVYJcG3syuHabKm/eiLsvBvokcTcmRYo/u0FyiTSJ3d9PoBwEixDtWrpuabo9Nah2ymDk7CZoXBO6vYzb5gknJguySlbT0eZr4SxkDfZlgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477009; c=relaxed/simple;
	bh=6PG9+yFv0G0z38SfyC4Tpo7NjQfaUQZR7EYLAmj8bOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLGU+cPTwEO3xSZbp8w+Tfbmg/Mg5y/+2/yPKbdd4eLFtTipuaBtHP1W14bmPF7R2PS6zBSkW4H4UYSS8e+PevPEgun2DsfzciiOAY/P1HE0gSZlSAPsSjnhsuwrigymdxt0RuLmh60yJ3mrCVcFsDGIOqAUAaY4055WPJJn2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzIE8eaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9E0C4CEC4;
	Mon, 16 Sep 2024 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726477008;
	bh=6PG9+yFv0G0z38SfyC4Tpo7NjQfaUQZR7EYLAmj8bOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzIE8eazLfbc0sYSALaK9vXRgfht+Oiz/qZoTdvMN6Q7/j+QnnC+3XPBGY8ZQN6VQ
	 7uXwdLEVfH0S7VXfIjGncAX+/Hw91RQAanoksZEDJLX2VK53xCdmQMDpu6kTcqRGLi
	 05biWkqns/m7LPOz8xfaVXKVrAmQLJ+yRGGlYXP7uZfEHq36aeQSDOcNfEVeSsKcAH
	 17NyDezyaO7nbUekR631EC4VeFY+CTQ5i6W5N17dxk6JoOswtoLs7dUpApsFW8yXJh
	 miXnUWW9alFu8XEtkuGlmow1pM6hiyTCG590sExjb+LHNEAHLUpkKg70tWghGLo/dg
	 j85KkTtxZ9Haw==
Message-ID: <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
Date: Mon, 16 Sep 2024 10:56:38 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2024 08:13, Yunhong Jiang wrote:
> On Tue, Aug 27, 2024 at 01:45:49PM -0700, Yunhong Jiang wrote:
>> On Sun, Aug 25, 2024 at 09:10:01AM +0200, Krzysztof Kozlowski wrote:
>>> On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
>>>> Add the binding to use mailbox wakeup mechanism to bringup APs.
>>>>
>>>> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>>> ---
>>>>  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
>>>>  1 file changed, 64 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
>>>> new file mode 100644
>>>> index 000000000000..cb84e2756bca
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
>>>> @@ -0,0 +1,64 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2024 Intel Corporation
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: x86 mailbox wakeup
>>>> +maintainers:
>>>> +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
>>>> +
>>>> +description: |
>>>> +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
>>>> +  processor (BSP) to wake up application processors (APs) through a wakeup
>>>> +  mailbox.
>>>> +
>>>> +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
>>>> +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
>>>> +  memory.
>>>> +
>>>> +  The wakeup mailbox structure is defined as follows.
>>>> +
>>>> +    uint16_t command;
>>>> +    uint16_t reserved;
>>>> +    uint32_t apic_id;
>>>> +    uint64_t wakeup_vector;
>>>> +    uint8_t  reservedForOs[2032];
>>>> +
>>>> +  The memory after reservedForOs field is reserved and OS should not touch it.
>>>> +
>>>> +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
>>>> +  routine's address into the wakeup_vector field, fill the apic_id field with
>>>> +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
>>>> +  wakeup command, the target AP will jump to the wakeup routine.
>>>> +
>>>> +  For each AP, the mailbox can be used only once for the wakeup command. After
>>>> +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
>>>> +  this AP.
>>>> +
>>>> +  The wakeup mailbox structure and the wakeup process is the same as
>>>> +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
>>>> +  section 5.2.12.19 [1].
>>>> +
>>>> +  References:
>>>> +
>>>> +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
>>>> +
>>>> +select: false
>>>
>>> This schema is still a no-op because of this false.
>>>
>>> What is the point of defining one property if it is not placed anywhere?
>>> Every device node can have it? Seems wrong...
>>>
>>> You need to come with proper schema. Lack of an example is another thing
>>> - this cannot be even validated by the tools. 
>>>
>>> Best regards,
>>> Krzysztof
> 
> Hi, Krzysztof, I'm working to address your comments and have some questions.
> Hope to get help/guide from your side.
> 
> For the select, the writing-schema.rst describes it as "A json-schema used to
> match nodes for applying the schema" but I'm a bit confused. In my case, should
> it be "cpus" node? Is there any code/tools that uses this property, so that I
> can have a better understanding?

Usually we expect matching by compatible, but it does not seem suitable
here because it is not related to any specific device, right? That is
the problem with all this DT-reuse-for-virtual-stuff work. It just does
not follow usual expectations and guidelines - you do not describe a device.

You can still match by nodes. See all top-level bindings.

> 
> For your "validated by the tools", can you please share the tools you used to
> validate the schema? I used "make dt_binding_check" per the
> submitting-patches.rst but I think your comments is about another tool.

See writing-schema document.


Best regards,
Krzysztof


