Return-Path: <linux-hyperv+bounces-5404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D4AADD9E
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8737A9495
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D67241689;
	Wed,  7 May 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFgsvQb8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63A214A82;
	Wed,  7 May 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618235; cv=none; b=PPV1fP9U5OUQmt4zQZ4443y2iLzymfdglC5wVxgIgXaReDWA7lLNtEX7u5ZaafpPi15zQW34ZDft6/d6fLrkUNG6mrft0zmR8nkNxpktubJ37kGEirzKg5gEv4SPnHkEmfLflJTrbA71YrYL/ZA/L7gVKa56lFauVyDy1Sd039w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618235; c=relaxed/simple;
	bh=YGUKIY6MsniKGGoVznlGheoqVG6lXYDoidfAZzwwlgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdNMx7Lg8N0OrfW+s54eI3orNBTdUR7qjLLwCfOPrBWxwp/td8mAxHKuaW3wIqeH0OByF4f7fMuiUPmt1NeTN6KfUFRmlcGPvwen/u9Wa/UlIUdeUN+Tysz2pNS1XSBdtvHO6zsLjD1QBk+qkW72QkOdAaBerp5ePtOdcIiZmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFgsvQb8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746618233; x=1778154233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YGUKIY6MsniKGGoVznlGheoqVG6lXYDoidfAZzwwlgY=;
  b=VFgsvQb8QVl94CYkk5VEn8cifHSpaUVH6tunzHEOO3Pv3kmPJlKBrsL/
   6Qy+3bj9xbT9GDENTpGsJe2DkgdSWjJC96mtzMGwDoUj/7pUyW+OGcHRb
   iKx3mkyEXQWeEtSDj1EjGUSmR9EnXJ4XpRVsw1qR7eHQk28woHmTSr+pc
   c0KKggPS6CKOQE3G9dBCH0RtVsZIwP+2Djq9NZjYwqVR6Qd/W6LcB7tsF
   7ldUnPfq77A2gumvrmpkXyk8wA5kKVsPbYnl3QpbEFs+GNygbhXnhtNk4
   VAJ3UkQ5lGuwfyV45uajrbsD0nDgSlcC4UDfcEXcECSnt6bgP3Jho4Lff
   g==;
X-CSE-ConnectionGUID: JaqzB9JBRN+fBQki3EGYSg==
X-CSE-MsgGUID: XOqrkm62Q82LXNQ9p8CRcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47442143"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="47442143"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:43:52 -0700
X-CSE-ConnectionGUID: oPY4ZS6MTq6rF9bnZTWGCw==
X-CSE-MsgGUID: Oo1duMMwShKiM1ihegtnEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136945496"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:43:51 -0700
Date: Wed, 7 May 2025 04:48:57 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Message-ID: <20250507114857.GB27839@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0j262Jorbb5--WY6KedR7CWvdTTYP10ZRZTqXhTNJ1GiA@mail.gmail.com>
 <20250506055054.GG25533@ranerica-svr.sc.intel.com>
 <CAJZ5v0gC8p1kwVpd8vZkWKoyVaT7Udzj0X5ux03TdJ3=2b8gyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gC8p1kwVpd8vZkWKoyVaT7Udzj0X5ux03TdJ3=2b8gyg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, May 06, 2025 at 04:00:56PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 6, 2025 at 7:46 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Mon, May 05, 2025 at 03:07:43PM +0200, Rafael J. Wysocki wrote:
> > > On Sat, May 3, 2025 at 9:10 PM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > Add DeviceTree bindings for the wakeup mailbox used on Intel processors.
> > > >
> > > > x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> > > > followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> > > > mechanism unavailable.
> > > >
> > > > The wakeup mailbox offers more control to the operating system to boot
> > > > secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> > > > for all CPUs while maintaining control over which CPUs to boot and when.
> > > > While it is possible to achieve the same level of control using a spin-
> > > > table, it would require to specify a separate cpu-release-addr for each
> > > > secondary CPU.
> > > >
> > > > Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > Changes since v2:
> > > >  - Implemented the mailbox as a reserved-memory node. Add to it a
> > > >    `compatible` property. (Krzysztof)
> > > >  - Explained the relationship between the mailbox and the `enable-mehod`
> > > >    property of the CPU nodes.
> > > >  - Expanded the documentation of the binding.
> > > >
> > > > Changes since v1:
> > > >  - Added more details to the description of the binding.
> > > >  - Added requirement a new requirement for cpu@N nodes to add an
> > > >    `enable-method`.
> > > > ---
> > > >  .../reserved-memory/intel,wakeup-mailbox.yaml | 87 +++++++++++++++++++
> > > >  1 file changed, 87 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > > > new file mode 100644
> > > > index 000000000000..d97755b4673d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > > > @@ -0,0 +1,87 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Wakeup Mailbox for Intel processors
> > > > +
> > > > +description: |
> > > > +  The Wakeup Mailbox provides a mechanism for the operating system to wake up
> > > > +  secondary CPUs on Intel processors. It is an alternative to the INIT-!INIT-
> > > > +  SIPI sequence used on most x86 systems.
> > > > +
> > > > +  Firmware must define the enable-method property in the CPU nodes as
> > > > +  "intel,wakeup-mailbox" to use the mailbox.
> > > > +
> > > > +  Firmware implements the wakeup mailbox as a 4KB-aligned memory region of size
> > > > +  of 4KB. It is memory that the firmware reserves so that each secondary CPU can
> > > > +  have the operating system send a single message to them. The firmware is
> > > > +  responsible for putting the secondary CPUs in a state to check the mailbox.
> > > > +
> > > > +  The structure of the mailbox is as follows:
> > > > +
> > > > +  Field           Byte   Byte  Description
> > > > +                 Length Offset
> > > > +  ------------------------------------------------------------------------------
> > > > +  Command          2      0    Command to wake up the secondary CPU:
> > > > +                                        0: Noop
> > > > +                                        1: Wakeup: Jump to the wakeup_vector
> > > > +                                        2-0xFFFF: Reserved:
> > > > +  Reserved         2      2    Must be 0.
> > > > +  APIC_ID          4      4    APIC ID of the secondary CPU to wake up.
> > > > +  Wakeup_Vector    8      8    The wakeup address for the secondary CPU.
> > > > +  ReservedForOs 2032     16    Reserved for OS use.
> > > > +  ReservedForFW 2048   2048    Reserved for firmware use.
> > > > +  ------------------------------------------------------------------------------
> > > > +
> > > > +  To wake up a secondary CPU, the operating system 1) prepares the wakeup
> > > > +  routine; 2) populates the address of the wakeup routine address into the
> > > > +  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC ID of the
> > > > +  secondary CPU; 4) writes Wakeup in the Command field. Upon receiving the
> > > > +  Wakeup command, the secondary CPU acknowledges the command by writing Noop in
> > > > +  the Command field and jumps to the Wakeup_Vector. The operating system can
> > > > +  send the next command only after the Command field is changed to Noop.
> > > > +
> > > > +  The secondary CPU will no longer check the mailbox after waking up. The
> > > > +  secondary CPU must ignore the command if its APIC_ID written in the mailbox
> > > > +  does not match its own.
> > > > +
> > > > +  When entering the Wakeup_Vector, interrupts must be disabled and 64-bit
> > > > +  addressing mode must be enabled. Paging mode must be enabled. The virtual
> > > > +  address of the Wakeup_Vector page must be equal to its physical address.
> > > > +  Segment selectors are not used.
> > >
> > > This interface is defined in the ACPI specification and all of the
> > > above information is present there.
> > >
> > > Why are you copying it without acknowledging the source of it instead
> > > of just saying where this interface is defined and pointing to its
> > > definition?
> >
> > There was a discussion in the past about preferring a full description of
> > the mailbox instead of references to ACPI [1]. I am happy to acknowledge
> > the source in the changeset description. I explicitly acknowledge the ACPI
> > specification in the cover letter.
> >
> > [1]. https://lore.kernel.org/all/20240809232928.GB25056@yjiang5-mobl.amr.corp.intel.com/
> 
> In which I clearly was not involved.
> 
> Acknowledgement in the cover letter is fine, but insufficient.

I see.

> 
> Also, there is the question regarding what happens when the ASWG
> decides to update this part of the ACPI specification.  Is the DT
> binding going to be updated too?

That was my plan. The ACPI Multiprocessor Wakeup Structure has a version
field that I could have used.

But, it looks like these bindings will not be needed after all.

I will drop this patch.

Thanks and BR,
Ricardo

