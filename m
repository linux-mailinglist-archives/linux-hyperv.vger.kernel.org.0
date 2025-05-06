Return-Path: <linux-hyperv+bounces-5366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69689AABAAB
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC188500531
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03256289827;
	Tue,  6 May 2025 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXrt8zwH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A621C16A;
	Tue,  6 May 2025 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508269; cv=none; b=n4Fs5GqAXi2+NLTFdwXF8BGzAyFZC82JC8IL747lPvy9fo6EEw9Cf6DCbW5VEi7SThcZTjbJAfGpY/fiUyDuzZMuOtjSaFCQb7mmOKlNhh96wgPqdLf1IB/E9/LCyMYjkUq9BQXs7d2PUOLy85YK81bEJh+2HA9/zOpHjX1f3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508269; c=relaxed/simple;
	bh=wY6W/N3sx+maLycnHg3jBX6Qe8xr+Z3P23n1cnZ3r3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9ULAPzpRyGdV9QhSxBnaMSK1Mbl3MCbPwnE+bdc4q+tp5gtsNS649ShwBa3yu2PSHelWm9mhWQ75QNYvDEa+85L++kLOniVI96Mb3UDVQiwF9cjQIpV25frqEFUYuSGKdtB0TTLUrjLuZ14Ig4o3HS1+QX9uv1PK4QctyYJ0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXrt8zwH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746508268; x=1778044268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wY6W/N3sx+maLycnHg3jBX6Qe8xr+Z3P23n1cnZ3r3c=;
  b=JXrt8zwH0unjJTTqZJsWoKa5bwk2xpfIW9oVA+b8ThuhwU4dLaEC7XWZ
   hO8CfVwW8dcNZmWII41GDvdjGVeGr80oZQVqfa1yC8/KiESwFpEAjemrd
   yMZCV0wl7tp+l5GtEyxhw/c3Plquaa4Rn7Sgpfg/sGLxvU9pJNJmMPkVu
   vrWi27GKaVgAZoNadGadiCY/AmWRTMXgCjEewB4CFO9BpNUx8P+cJ1l7s
   6u1SJoTB8KytNorwCdvOX1syhsTmjtg/3yqQOefBjL0hs1L0wj4lmPhRo
   ZrQxk4IhGWhwbA/yLQq9de2tD81UH/tRYyfm/11bdOVJx+EmD+kosUOxh
   w==;
X-CSE-ConnectionGUID: tZ8j3jNYQr+dgeic4G1h+w==
X-CSE-MsgGUID: M1R5eT+TSRiOBDKYGQDT3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47861286"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="47861286"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:11:07 -0700
X-CSE-ConnectionGUID: hJ87dLmCQ324ofNrZq3bIA==
X-CSE-MsgGUID: 5ybXgqoJQUK7rNzDiDnfqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="139529756"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:11:06 -0700
Date: Mon, 5 May 2025 22:16:10 -0700
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
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250506051610.GC25533@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504-original-leopard-of-vigor-5702ef@kuoka>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, May 04, 2025 at 06:51:17PM +0200, Krzysztof Kozlowski wrote:
> On Sat, May 03, 2025 at 12:15:08PM GMT, Ricardo Neri wrote:
> > Add DeviceTree bindings for the wakeup mailbox used on Intel processors.
> > 
> 
> Start using b4, so your cover letter will have proper lore links to
> previous versions.

Sure. Thanks for this suggestion I will follow it.

> 
> > x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> > followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> > mechanism unavailable.
> > 
> > The wakeup mailbox offers more control to the operating system to boot
> > secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> > for all CPUs while maintaining control over which CPUs to boot and when.
> > While it is possible to achieve the same level of control using a spin-
> > table, it would require to specify a separate cpu-release-addr for each
> > secondary CPU.
> > 
> > Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> 
> What does this tag mean? Why you cannot use standard tags - SoB and
> co-developed?

Yunhong handed this work to me. We did not work in it concurrently. But
yes, SoB and Co-developed-by also looks appropriate as two individuals
worked on this.

> 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  - Implemented the mailbox as a reserved-memory node. Add to it a
> >    `compatible` property. (Krzysztof)
> >  - Explained the relationship between the mailbox and the `enable-mehod`
> >    property of the CPU nodes.
> >  - Expanded the documentation of the binding.
> > 
> > Changes since v1:
> >  - Added more details to the description of the binding.
> >  - Added requirement a new requirement for cpu@N nodes to add an
> >    `enable-method`.
> > ---
> >  .../reserved-memory/intel,wakeup-mailbox.yaml | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > new file mode 100644
> > index 000000000000..d97755b4673d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Wakeup Mailbox for Intel processors
> > +
> > +description: |
> > +  The Wakeup Mailbox provides a mechanism for the operating system to wake up
> > +  secondary CPUs on Intel processors. It is an alternative to the INIT-!INIT-
> > +  SIPI sequence used on most x86 systems.
> > +
> > +  Firmware must define the enable-method property in the CPU nodes as
> > +  "intel,wakeup-mailbox" to use the mailbox.
> > +
> > +  Firmware implements the wakeup mailbox as a 4KB-aligned memory region of size
> > +  of 4KB. It is memory that the firmware reserves so that each secondary CPU can
> > +  have the operating system send a single message to them. The firmware is
> > +  responsible for putting the secondary CPUs in a state to check the mailbox.
> > +
> > +  The structure of the mailbox is as follows:
> > +
> > +  Field           Byte   Byte  Description
> > +                 Length Offset
> > +  ------------------------------------------------------------------------------
> > +  Command          2      0    Command to wake up the secondary CPU:
> > +                                        0: Noop
> > +                                        1: Wakeup: Jump to the wakeup_vector
> > +                                        2-0xFFFF: Reserved:
> > +  Reserved         2      2    Must be 0.
> > +  APIC_ID          4      4    APIC ID of the secondary CPU to wake up.
> > +  Wakeup_Vector    8      8    The wakeup address for the secondary CPU.
> > +  ReservedForOs 2032     16    Reserved for OS use.
> > +  ReservedForFW 2048   2048    Reserved for firmware use.
> > +  ------------------------------------------------------------------------------
> > +
> > +  To wake up a secondary CPU, the operating system 1) prepares the wakeup
> > +  routine; 2) populates the address of the wakeup routine address into the
> > +  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC ID of the
> > +  secondary CPU; 4) writes Wakeup in the Command field. Upon receiving the
> > +  Wakeup command, the secondary CPU acknowledges the command by writing Noop in
> > +  the Command field and jumps to the Wakeup_Vector. The operating system can
> > +  send the next command only after the Command field is changed to Noop.
> > +
> > +  The secondary CPU will no longer check the mailbox after waking up. The
> > +  secondary CPU must ignore the command if its APIC_ID written in the mailbox
> > +  does not match its own.
> > +
> > +  When entering the Wakeup_Vector, interrupts must be disabled and 64-bit
> > +  addressing mode must be enabled. Paging mode must be enabled. The virtual
> > +  address of the Wakeup_Vector page must be equal to its physical address.
> > +  Segment selectors are not used.
> > +
> > +maintainers:
> > +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > +
> > +allOf:
> > +  - $ref: reserved-memory.yaml
> > +
> > +properties:
> > +  compatible:
> > +    const: intel,wakeup-mailbox
> 
> If this is a device, then compatibles specific to devices. You do not
> get different rules than all other bindings... or this does not have to
> be binding at all. Why standard reserved-memory does not work for here?
> 
> Why do you need compatible in the first place?

Are you suggesting something like this?

reserved-memory {
	# address-cells = <2>;
	# size-cells = <1>;

	wakeup_mailbox: wakeupmb@fff000 {
		reg = < 0x0 0xfff000 0x1000>
	}

and then reference to the reserved memory using the wakeup_mailbox
phandle?

If this is the case, IIUC, this schema is not needed at all.

}
> 
> 
> > +
> > +  alignment:
> > +    description: The mailbox must be 4KB-aligned.
> 
> Then drop it because it is implied by compatible.

Sure I can drop it.

> 
> > +    const: 0x1000
> > +
> > +required:
> > +  - compatible
> > +  - alignment
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <2>;
> > +        #size-cells = <1>;
> > +
> > +        wakeup-mailbox@12340000 {
> 
> Please use real addresses from real DT.
> 
> > +            compatible = "intel,wakeup-mailbox";
> > +            alignment = <0x1000>;
> > +            reg = <0x0 0x12340000 0x1000>;
> 
> reg is always the second property. See DTS coding style.

Sorry, I missed this convention.

Thanks and BR,
Ricardo 

