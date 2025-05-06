Return-Path: <linux-hyperv+bounces-5365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B4AABA4E
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74386175FBA
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347A1F1905;
	Tue,  6 May 2025 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXISCohN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BD4B1E71;
	Tue,  6 May 2025 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506880; cv=none; b=WonhmzFOQXmTce7jfoyZ50/6I1+44+NNP/f4kQUscEy0KAvJxaZdpYp8YtvsgOIZkoNGiD4xWiLIM2UXkLjN022UykdjGCfqwv/4hJbe1NIvnxCZQrow2bZKo/F6bgsoqBo529PM0yf+XZcdSmzo1EFNWGejsMEG0ooMZIkFxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506880; c=relaxed/simple;
	bh=ky76C3dJ2zWIGTBoeltBiKqkv5AWib+EuPhOpuaifAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdvOw+RjD/t0fB+iH7nLlv+NP6Kl7R6qp3cROLwYc2BdJ0t3GXqP8z/McN01nz5YRhRC6ENqKImqZGTf0E+VtTL57GdWaGIFK30O2bxwjCB+yUVSC81yvSVkAb1fUbW+NtBEXAX7UvfMfiTUn7n0LEDiONVuTGF6+tObJBKd8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXISCohN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746506879; x=1778042879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ky76C3dJ2zWIGTBoeltBiKqkv5AWib+EuPhOpuaifAg=;
  b=GXISCohNw8wfwgdN1CO7SxVRsQqeanF43OQ4hAicsTS/sx54HD9adBkE
   ely6LhRF0qc98R/CRHcxkOMsP1ysn2oK7Pd31UY6Sfaiy/6zbPlxl6yX/
   cnhhGtFSO6VSJTXLQPQLSby2VmpX9sjlEwDCxHg4rHjLjsQpOH5dp5Ydq
   BT376bIiy1J4m7O/3SQMufT0Bq7nP8KdTqp9+n7aelfWviSgdIkWxH0E2
   CNyGnf1uuOIKy+wAN4ACF765V76X/XfTBLBjRCv5VgmBSmkg+f1pQwxgq
   hF3JnHf+jfuiQC/c6xkaytpp3Wyj7ggU36FiQCKttP7HM8Bbi+vXV6URx
   g==;
X-CSE-ConnectionGUID: l/fP/ptUQ7mhL/qE5DJuKw==
X-CSE-MsgGUID: LjWwOdlKQuai4nGvNFW3+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48284312"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="48284312"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:47:55 -0700
X-CSE-ConnectionGUID: jtpdzpW1R4Smrt15chOdlQ==
X-CSE-MsgGUID: wD20LN+kTcuq2mvvjvSVzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135381968"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:47:36 -0700
Date: Mon, 5 May 2025 21:52:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 04/13] dt-bindings: x86: Add CPU bindings for x86
Message-ID: <20250506045235.GB25533@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
 <20250504-happy-spoonbill-of-radiance-3b9fec@kuoka>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504-happy-spoonbill-of-radiance-3b9fec@kuoka>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, May 04, 2025 at 06:45:59PM +0200, Krzysztof Kozlowski wrote:
> On Sat, May 03, 2025 at 12:15:06PM GMT, Ricardo Neri wrote:
> > Add bindings for CPUs in x86 architecture. Start by defining the `reg` and
> 
> What for?

Thank you for your quick feedback, Krzysztof!

Do you mean for what reason I want to start bindings for x86 CPUs? Or only
the `reg` property? If the former, it is to add an enable-method property to
x86 CPUs. If the latter, is to show the relationship between APIC and `reg`.

> 
> > `enable-method` properties and their relationship to x86 APIC ID and the
> > available mechanisms to boot secondary CPUs.
> > 
> > Start defining bindings for Intel processors. Bindings for other vendors
> > can be added later as needed.
> > 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> 
> Not really tested so only limited review follows.

Sorry, I ran make dt_binding_check but only on this schema. I missed the
reported error.

> 
> >  .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/x86/cpus.yaml b/Documentation/devicetree/bindings/x86/cpus.yaml
> > new file mode 100644
> > index 000000000000..108b3ad64aea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/x86/cpus.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/x86/cpus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: x86 CPUs
> > +
> > +maintainers:
> > +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > +
> > +description: |
> > +  Description of x86 CPUs in a system through the "cpus" node.
> > +
> > +  Detailed information about the CPU architecture can be found in the Intel
> > +  Software Developer's Manual:
> > +    https://intel.com/sdm
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - intel,x86
> 
> That's architecture, not a CPU. CPUs are like 80286, 80386, so that's
> not even specific instruction set. I don't get what you need it for.

Am I to understand the the `compatible` property is not needed if the
bindings apply to any x86 CPU?

> 
> > +
> > +  reg:
> 
> Missing constraints.

I could add minItems. For maxItems, there is no limit to the number of
threads.

> 
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

OK.

> 
> > +      Local APIC ID of the CPU. If the CPU has more than one execution thread,
> > +      then the property is an array with one element per thread.
> > +
> > +  enable-method:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      The method used to wake up secondary CPUs. This property is not needed if
> > +      the secondary processors are booted using INIT assert, de-assert followed
> > +      by Start-Up IPI messages as described in the Volume 3, Section 11.4 of
> > +      Intel Software Developer's Manual.
> > +
> > +      It is also optional for the bootstrap CPU.
> > +
> > +    oneOf:
> 
> I see only one entry, so didn't you want an enum?

Indeed, enum would be more appropriate.

> 
> > +      - items:
> 
> Not a list
> 
> > +          - const: intel,wakeup-mailbox
> 
> So every vendor is supposed to come with different name for the same
> feature? Or is wakeup-mailnox really intel specific, but then specific
> to which processors?

It would not be necessary for every vendor to provide a different name for
the same feature. I saw, however that the Devicetree specification requires
a [vendor],[method] stringlist.

Also, platform firmware for any processor could implement the wakeup
mailbox.

> 
> 
> > +            description: |
> > +              CPUs are woken up using the mailbox mechanism. The platform
> > +              firmware boots the secondary CPUs and puts them in a state
> > +              to check the mailbox for a wakeup command from the operating
> > +              system.
> > +
> > +required:
> > +  - reg
> > +  - compatible
> > +
> > +unevaluatedProperties: false
> 
> Missing ref in top-level or this is supposed to be additionalProps. See
> example-schema.

I will check.

> 
> > +
> > +examples:
> > +  - |
> > +    /*
> > +     * A system with two CPUs. cpu@0 is the bootstrap CPU and its status is
> > +     * "okay". It does not have the enable-method property. cpu@1 is a
> > +     * secondary CPU. Its status is "disabled" and defines the enable-method
> > +     * property.
> > +     */
> > +
> > +    cpus {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      cpu@0 {
> > +        reg = <0x0 0x1>;
> > +        compatible = "intel,x86";
> > +        status = "okay";
> 
> Drop

I will drop status = "okay"

> 
> > +      };
> > +
> > +      cpu@1 {
> > +        reg = <0x0 0x1>;
> > +        compatible = "intel,x86";
> > +        status = "disabled";
> 
> Why?

Because this is a secondary CPU that the operating system will enable using
the method specified in the `enable-method` property.

Thanks and BR,
Ricardo

