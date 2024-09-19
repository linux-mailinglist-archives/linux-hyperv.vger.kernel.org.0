Return-Path: <linux-hyperv+bounces-3051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC7E97CF2F
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 00:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF96B1C21D2A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DF17C210;
	Thu, 19 Sep 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JW881aYO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657A13AD39;
	Thu, 19 Sep 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726784123; cv=none; b=PZTf9yMxJQEkQAgiDnLvKWObO2jqQ6Rxeb3GGgwhLF8Mu40ygAMblVmf13NFe8Yi9ojh4bOtp1zkEyeHkGxMTL6ycueqESy1w/Dn+Y6iLUzO9Ndi1R1DnvJyKTA2W9AL3n9K6Xw5P7CeyMQR+arRSZriitQwF3LdARAx2zifb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726784123; c=relaxed/simple;
	bh=rhLJmk4kuQBVOQE5cPyh+wnbf8by3qiA8vQzxSAE8Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc0FcPNuNxb6e/28P7lPk93wuuFHP9V++Y+bwsXKA4/OpKvjvCWc5vhr7DCNL0GL85NfBcGTYeCfifzqgadJ+PPkeCseiAy1AU6tfEehSYNu+Bm6QCz/mGaLTezXGPCD5eXsQF1iwDVA88PEmLeUxORZnUmx+5pavYxcLnqusYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JW881aYO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726784122; x=1758320122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rhLJmk4kuQBVOQE5cPyh+wnbf8by3qiA8vQzxSAE8Zg=;
  b=JW881aYOe8rcyilJ/3ifOxw5m20m0tp1vJtNWCoKPuG1KFi2pr+59NJ9
   2QbdAlHQbdKqj49ZvXWfp/C1hnpvFE4Hi1BeFE1nsX+kAf1GdbAu/pjYc
   cvDRJjq3bZM4ThC9cnYCJQCbTb0DBPT8ZfRk06cEy5GtpicEurLxKmigg
   ze6Cu05/GCpuL/FHCCn6immCcrff1LF9XMS5/S0e9M0bfNpPW3kd3xXEt
   m9bBF0HOF0gYYLzSX50ZSR9U6eJevBIvYR3OgF9iSQBPZ1Lnp9NcnBVEu
   ZRksFlW90ElRLfidDfmij7/BicM8tTal64RrkHC8GjjVJ7LzIXpJjwOHG
   g==;
X-CSE-ConnectionGUID: qaAL8oE9Rp2vTWB6t4xTcg==
X-CSE-MsgGUID: EGa+pfPkSRK+W4v6Ddjm/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36907165"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="36907165"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 15:15:21 -0700
X-CSE-ConnectionGUID: USGk/vrfRTmMx9MJYeYlLw==
X-CSE-MsgGUID: PbHmwOY5SGCByAFvS7Pj9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="75054953"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.27.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 15:15:20 -0700
Date: Thu, 19 Sep 2024 15:15:19 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
Message-ID: <20240919221431.GA14771@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
 <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
 <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
 <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>

On Thu, Sep 19, 2024 at 12:19:01PM -0700, Yunhong Jiang wrote:
> On Mon, Sep 16, 2024 at 10:56:38AM +0200, Krzysztof Kozlowski wrote:
> > On 10/09/2024 08:13, Yunhong Jiang wrote:
> > > On Tue, Aug 27, 2024 at 01:45:49PM -0700, Yunhong Jiang wrote:
> > >> On Sun, Aug 25, 2024 at 09:10:01AM +0200, Krzysztof Kozlowski wrote:
> > >>> On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
> > >>>> Add the binding to use mailbox wakeup mechanism to bringup APs.
> > >>>>
> > >>>> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > >>>> ---
> > >>>>  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
> > >>>>  1 file changed, 64 insertions(+)
> > >>>>  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..cb84e2756bca
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > >>>> @@ -0,0 +1,64 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>>> +# Copyright (C) 2024 Intel Corporation
> > >>>> +%YAML 1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: x86 mailbox wakeup
> > >>>> +maintainers:
> > >>>> +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > >>>> +
> > >>>> +description: |
> > >>>> +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
> > >>>> +  processor (BSP) to wake up application processors (APs) through a wakeup
> > >>>> +  mailbox.
> > >>>> +
> > >>>> +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
> > >>>> +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
> > >>>> +  memory.
> > >>>> +
> > >>>> +  The wakeup mailbox structure is defined as follows.
> > >>>> +
> > >>>> +    uint16_t command;
> > >>>> +    uint16_t reserved;
> > >>>> +    uint32_t apic_id;
> > >>>> +    uint64_t wakeup_vector;
> > >>>> +    uint8_t  reservedForOs[2032];
> > >>>> +
> > >>>> +  The memory after reservedForOs field is reserved and OS should not touch it.
> > >>>> +
> > >>>> +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
> > >>>> +  routine's address into the wakeup_vector field, fill the apic_id field with
> > >>>> +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
> > >>>> +  wakeup command, the target AP will jump to the wakeup routine.
> > >>>> +
> > >>>> +  For each AP, the mailbox can be used only once for the wakeup command. After
> > >>>> +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
> > >>>> +  this AP.
> > >>>> +
> > >>>> +  The wakeup mailbox structure and the wakeup process is the same as
> > >>>> +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
> > >>>> +  section 5.2.12.19 [1].
> > >>>> +
> > >>>> +  References:
> > >>>> +
> > >>>> +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
> > >>>> +
> > >>>> +select: false
> > >>>
> > >>> This schema is still a no-op because of this false.
> > >>>
> > >>> What is the point of defining one property if it is not placed anywhere?
> > >>> Every device node can have it? Seems wrong...
> > >>>
> > >>> You need to come with proper schema. Lack of an example is another thing
> > >>> - this cannot be even validated by the tools. 
> > >>>
> > >>> Best regards,
> > >>> Krzysztof
> > > 
> > > Hi, Krzysztof, I'm working to address your comments and have some questions.
> > > Hope to get help/guide from your side.
> > > 
> > > For the select, the writing-schema.rst describes it as "A json-schema used to
> > > match nodes for applying the schema" but I'm a bit confused. In my case, should
> > > it be "cpus" node? Is there any code/tools that uses this property, so that I
> > > can have a better understanding?
> > 
> > Usually we expect matching by compatible, but it does not seem suitable
> > here because it is not related to any specific device, right? That is
> > the problem with all this DT-reuse-for-virtual-stuff work. It just does
> > not follow usual expectations and guidelines - you do not describe a device.
> 
> Thank you for the reply.
> 
> I'm a bit confused on your "do not describe a device".
> I think VM is also a device, it's just a virtual device, but I don't see much
> difference of the virtual and physical device from DT point of view, possibly I
> missed some point.
>  
> > 
> > You can still match by nodes. See all top-level bindings.
> 
> After checking the code at
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/validator.py,
> seems the 'select' is translated to 'if'/'then'.
> 
> Do you have any example of "top-level bindings"? I tried to check binding for
> enable-methods like arm/cpu-enable-method/nuvoton,npcm750-smp or
> cpu/idle-states.yaml, but they are either not schema file, or quite different.
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
> > 
> > > 
> > > For your "validated by the tools", can you please share the tools you used to
> > > validate the schema? I used "make dt_binding_check" per the
> > > submitting-patches.rst but I think your comments is about another tool.
> > 
> > See writing-schema document.
> Yes, I figured out in the end that the validate tools means the dt-schema tools.
> 
> Thank you
> --jyh

One thing just come to my mind. The
Documentation/devicetree/bindings/x86/wakeup.yaml only adds one property,
wakeup-mailbox-addr, to the cpus node, and it does not specify any new object.
Per my understanding, the json schema file normally specifies a new object.
Is my change a supported scenario in current Documentation/devicetree?

I checked similar scenario like arm/cpu-enable-method/nuvoton and
npcm750-smp/cpu-enable-method/al,alpine-smp, they don't present as a json
schema file. Wonder if it's because the same reason.

> 
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> 

