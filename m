Return-Path: <linux-hyperv+bounces-5374-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87EAABB16
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92147B9032
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E81DE2BF;
	Tue,  6 May 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/AxhGZr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE134B1E51;
	Tue,  6 May 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746516362; cv=none; b=rJaIwi2K/k+LIPd7BzlUJ0I0alrDFPnctWaGGUUVTSzQu/tRMo/GI+tn0mS6aanKbUsyvRaED/9hZA3vYkzT1jhPGJs9xucxDZqkOcdXGV9wQg1AoRzDA4ZhMK1gH0zjvx/FeJ8vSS6N8oqjG2CcY+bsq0VddSCMoZKdk67+F1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746516362; c=relaxed/simple;
	bh=8Oc0xkyq6v9wmSnKpRvRRCYkyApCq0GyR4eU9o97d10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8j2Hue3fKcehvohxZm/GWykTDm2Xa79GsRMPtpIRtgh4Cgj6AgasnMKSe+5O2tgWjJsJ42I/a2UbytH4u8t4c0IpaHYrf3t/s+EhdsCtqIC2O1hf27LVFX3z9dIe9J1yOA+AwenQYTmkLf76TlLwoxYS45ShHvdEIH682an1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/AxhGZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D75C4CEE4;
	Tue,  6 May 2025 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746516361;
	bh=8Oc0xkyq6v9wmSnKpRvRRCYkyApCq0GyR4eU9o97d10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/AxhGZrOHtwo6+F1w7BzO0PPWzgrskAu4Ole1I7TUFlEmjQhooCVGCw5v5XWU4EH
	 NLxsf0XTfRLPP09itezWit/lyooHaeTgYUosKH+jRwjNW2FkvH8Y18UDp54u3g9Daa
	 8KebqO6mBuIJjOY04DFXzVCSYhurYkadfxe/f3eh+Rpx0FQiHEuAbHEIceYguo7Le3
	 Un2reHfZNb1xSXzYgA3/DXnIBYNUyt0H40xjT/vvQMt9qX2icNmQLkb37VJbzKq38l
	 YKSQzRFyB6fBDKgM6Cp/HM3UFf28alfBpk+m92URSacW14zjFeqza4RRXgwX56mJLv
	 7JsHQFDlzsi/w==
Date: Tue, 6 May 2025 09:25:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 04/13] dt-bindings: x86: Add CPU bindings for x86
Message-ID: <20250506-alluring-beaver-of-modernism-65ff8a@kuoka>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
 <20250504-happy-spoonbill-of-radiance-3b9fec@kuoka>
 <20250506045235.GB25533@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506045235.GB25533@ranerica-svr.sc.intel.com>

On Mon, May 05, 2025 at 09:52:35PM GMT, Ricardo Neri wrote:
> On Sun, May 04, 2025 at 06:45:59PM +0200, Krzysztof Kozlowski wrote:
> > On Sat, May 03, 2025 at 12:15:06PM GMT, Ricardo Neri wrote:
> > > Add bindings for CPUs in x86 architecture. Start by defining the `reg` and
> > 
> > What for?
> 
> Thank you for your quick feedback, Krzysztof!
> 
> Do you mean for what reason I want to start bindings for x86 CPUs? Or only

Yes. For which devices, what purpose.

> the `reg` property? If the former, it is to add an enable-method property to
> x86 CPUs. If the latter, is to show the relationship between APIC and `reg`.
> 
> > 
> > > `enable-method` properties and their relationship to x86 APIC ID and the
> > > available mechanisms to boot secondary CPUs.
> > > 
> > > Start defining bindings for Intel processors. Bindings for other vendors
> > > can be added later as needed.
> > > 
> > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > ---
> > 
> > Not really tested so only limited review follows.
> 
> Sorry, I ran make dt_binding_check but only on this schema. I missed the
> reported error.
> 
> > 
> > >  .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
> > >  1 file changed, 80 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/x86/cpus.yaml b/Documentation/devicetree/bindings/x86/cpus.yaml
> > > new file mode 100644
> > > index 000000000000..108b3ad64aea
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/x86/cpus.yaml
> > > @@ -0,0 +1,80 @@
> > > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/x86/cpus.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: x86 CPUs
> > > +
> > > +maintainers:
> > > +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > +
> > > +description: |
> > > +  Description of x86 CPUs in a system through the "cpus" node.
> > > +
> > > +  Detailed information about the CPU architecture can be found in the Intel
> > > +  Software Developer's Manual:
> > > +    https://intel.com/sdm
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - intel,x86
> > 
> > That's architecture, not a CPU. CPUs are like 80286, 80386, so that's
> > not even specific instruction set. I don't get what you need it for.
> 
> Am I to understand the the `compatible` property is not needed if the
> bindings apply to any x86 CPU?

Every device needs compatible. Its meaning is explained:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#compatible

If you add here a device representing CPU, then look at existing
bindings for CPUs how they do it.

It again feels like you add DT for platform which is not a real thing.
If you use DT, you do not get different rules, therefore read all
standard guides and tutorials (there were many, quite comprehensive).


> 
> > 
> > > +
> > > +  reg:
> > 
> > Missing constraints.
> 
> I could add minItems. For maxItems, there is no limit to the number of
> threads.

I am pretty sure that any given CPU, e.g. 80486 has a fixed number of
threads...

> 
> > 
> > > +    description: |
> > 
> > Do not need '|' unless you need to preserve formatting.
> 
> OK.
> 
> > 
> > > +      Local APIC ID of the CPU. If the CPU has more than one execution thread,
> > > +      then the property is an array with one element per thread.
> > > +
> > > +  enable-method:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    description: |
> > > +      The method used to wake up secondary CPUs. This property is not needed if
> > > +      the secondary processors are booted using INIT assert, de-assert followed
> > > +      by Start-Up IPI messages as described in the Volume 3, Section 11.4 of
> > > +      Intel Software Developer's Manual.
> > > +
> > > +      It is also optional for the bootstrap CPU.
> > > +
> > > +    oneOf:
> > 
> > I see only one entry, so didn't you want an enum?
> 
> Indeed, enum would be more appropriate.
> 
> > 
> > > +      - items:
> > 
> > Not a list
> > 
> > > +          - const: intel,wakeup-mailbox
> > 
> > So every vendor is supposed to come with different name for the same
> > feature? Or is wakeup-mailnox really intel specific, but then specific
> > to which processors?
> 
> It would not be necessary for every vendor to provide a different name for
> the same feature. I saw, however that the Devicetree specification requires
> a [vendor],[method] stringlist.

Indeed, it's fine then.

> 
> Also, platform firmware for any processor could implement the wakeup
> mailbox.
> 
> > 
> > 
> > > +            description: |
> > > +              CPUs are woken up using the mailbox mechanism. The platform
> > > +              firmware boots the secondary CPUs and puts them in a state
> > > +              to check the mailbox for a wakeup command from the operating
> > > +              system.
> > > +
> > > +required:
> > > +  - reg
> > > +  - compatible
> > > +
> > > +unevaluatedProperties: false
> > 
> > Missing ref in top-level or this is supposed to be additionalProps. See
> > example-schema.
> 
> I will check.
> 
> > 
> > > +
> > > +examples:
> > > +  - |
> > > +    /*
> > > +     * A system with two CPUs. cpu@0 is the bootstrap CPU and its status is
> > > +     * "okay". It does not have the enable-method property. cpu@1 is a
> > > +     * secondary CPU. Its status is "disabled" and defines the enable-method
> > > +     * property.
> > > +     */
> > > +
> > > +    cpus {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +
> > > +      cpu@0 {
> > > +        reg = <0x0 0x1>;
> > > +        compatible = "intel,x86";
> > > +        status = "okay";
> > 
> > Drop
> 
> I will drop status = "okay"
> 
> > 
> > > +      };
> > > +
> > > +      cpu@1 {
> > > +        reg = <0x0 0x1>;
> > > +        compatible = "intel,x86";
> > > +        status = "disabled";
> > 
> > Why?
> 
> Because this is a secondary CPU that the operating system will enable using
> the method specified in the `enable-method` property.

OK, so this was intentional to express it is in quiescent state.

Best regards,
Krzysztof


