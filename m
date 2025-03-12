Return-Path: <linux-hyperv+bounces-4421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E63A5D5AD
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D5A189C50F
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A741D86F2;
	Wed, 12 Mar 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rx1kirUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC733F6;
	Wed, 12 Mar 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758328; cv=none; b=lS/l9X8G2jq4jdRKCEtDJ8ByZla4B1GyfK1y62UkHO4G1ysZLdHlxG4Z933uhB4hMcYEemKDC2sWes/8y0ODOnx/wxPvhkvNm3GQ1w+RiLQoguP6wEyJnaulajxfFp6spQRH+aNxHXob8lzwPw40wyoA4vkODAQm0PPa/VH2ccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758328; c=relaxed/simple;
	bh=2lNkWU7neUbJh5KmbEw6o4WwEOl2tG4Taxsira8ZcTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3GZWG0EktLcv5J0tEBcO5eH1ogwJEx+HxtrV/E9NADRPMA9+rX5PdWq/j+UoMcsKFuNAShXKPy5wn802Oh6JZPpOPB8EHaU0U/PY1vrmXcmNcdeqdUKHbgH+Hlw/M7/8oUnudBgva98TW56reWN3v9El67P7cZPyeLkYQ2EdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rx1kirUi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741758326; x=1773294326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2lNkWU7neUbJh5KmbEw6o4WwEOl2tG4Taxsira8ZcTU=;
  b=Rx1kirUi44u7M/TXPs+/y25z8mFv+6DEO/EJu/DgjUSPJt8LI0s8Ze3A
   z22qqjSFXjckyga3jpg1fEq4zfFyXhuvFbspzpfuaH44WqlT4TENE67gc
   8+BOGKNIBfrOdCEZm9RCN3SdrJG+M6mmhzfDPBq6q2UAtI3CkbO7sDbVo
   A44cXAMFMZytKj2Erfmi+qLC6Wt1KsIQrD8Z7/dSZSnGgImk1RU0RYWQu
   HsqrYuVAUDy8sfqk3Hlbb+WMC4J7XPRsuHCBosYStwtfCmZ/0092/RBz7
   PtZLrO/ksyW4PnHcv6TZnBoUquWw7F4McJSXEMpG/ZQ0WacsSD2vdMMh0
   g==;
X-CSE-ConnectionGUID: VqP7gBv3QkW5Eqqww8jwgQ==
X-CSE-MsgGUID: 93YgMprTRG+fGuoN4NERHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43002644"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="43002644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:45:24 -0700
X-CSE-ConnectionGUID: v7DTkxGPSDK1/jw399Duwg==
X-CSE-MsgGUID: f+/ufX8JRXGIlRtlydF+gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125593952"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:45:24 -0700
Date: Tue, 11 Mar 2025 22:51:18 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
	lenb@kernel.org, kirill.shutemov@linux.intel.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	ricardo.neri@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
Message-ID: <20250312055118.GA29492@ranerica-svr.sc.intel.com>
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
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb5fa11-9dce-44d0-85e3-e67a6a10c48f@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Mar 11, 2025 at 11:01:28AM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2025 23:21, Ricardo Neri wrote:
> > On Fri, Sep 20, 2024 at 01:15:41PM +0200, Krzysztof Kozlowski wrote:
> > 
> > [...]
> >  
> >> enable-method is part of CPUs, so you probably should match the CPUs...
> >> I am not sure, I don't have the big picture here.
> >>
> >> Maybe if companies want to push more of bindings for purely virtual
> >> systems, then they should first get involved more, instead of relying on
> >> us. Provide reviews for your virtual stuff, provide guidance. There is
> >> resistance in accepting bindings for such cases for a reason - I don't
> >> even know what exactly is this and judging/reviewing based on my
> >> practices will no be accurate.
> > 
> > Hi Krzysztof,
> > 
> > I am taking over this work from Yunhong.
> > 
> > First of all, I apologize for the late reply. I will make sure
> > communications are timely in the future.
> > 
> > Our goal is to describe in the device tree a mechanism or artifact to boot
> > secondary CPUs.
> > 
> > In our setup, the firmware puts secondary CPUs to monitor a memory location
> > (i.e., the wakeup mailbox) while spinning. From the boot CPU, the OS writes
> > in the mailbox the wakeup vector and the ID of the secondary CPU it wants
> > to boot. When a secondary CPU sees its own ID it will jump to the wakeup
> > vector.
> > 
> > This is similar to the spin-table described in the Device Tree
> > specification. The key difference is that with the spin-table CPUs spin
> > until a non-zero value is written in `cpu-release-addr`. The wakeup mailbox
> > uses CPU IDs.
> > 
> > You raised the issue of the lack of a `compatible` property, and the fact
> > that we are not describing an actual device.
> > 
> > I took your suggestion of matching by node and I came up with the binding
> > below. I see these advantages in this approach:
> > 
> >   * I define a new node with a `compatible` property.
> >   * There is precedent: the psci node. In the `cpus` node, each cpu@n has
> 

Thanks for your feedback!

> psci is a standard. If you are documenting here a standard, clearly
> express it and provide reference to the specification.

It is not really a standard, but this mailbox behaves indentically to the
wakeup mailbox described in the ACPI spec [1]. I am happy reference the
spec in the documentation of the binding... or describe in full the
mechanism of mailbox without referring to ACPI. You had indicated you don't
care about what ACPI does [2].

In a nutshell, the wakeup mailbox is similar to the spin table used in ARM
boards: it is reserved memory region that secondary CPUs monitor while
spinning.

> 
> 
> >     an `enable-method` property that specify `psci`.
> >   * The mailbox is a device as it is located in a reserved memory region.
> >     This true regardless of the device tree describing bare-metal or
> >     virtualized machines.
> > 
> > Thanks in advance for your feedback!
> > 
> > Best,
> > Ricardo
> > 
> > (only the relevant sections of the binding are shown for brevity)
> > 
> > properties:
> >   $nodename:
> >     const: wakeup-mailbox
> > 
> >   compatible:
> >     const: x86,wakeup-mailbox
> 
> You need vendor prefix for this particular device. If I pointed out lack
> of device and specific compatible, then adding random compatible does
> not solve it. I understand it solves for you, but not from the bindings
> point of view.

I see. Platform firmware will implement the mailbox. It would not be any
specific hardware from Intel. Perhaps `intel,wakeup-mailbox`?

> 
> > 
> >   mailbox-addr:
> >     $ref: /schemas/types.yaml#/definitions/uint64
> 
> So is this some sort of reserved memory?

Yes, the mailbox is located in reserved memory.

> Mailbox needs mbox-cells, so
> maybe that's not mailbox.

Your comment got me to look under Documentation/devicetree/bindings/mailbox.
Maybe I am ovethinking this and I can describe the mailbox as others
vendors do (see below).

Thanks and BR,
Ricardo

[1]. https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#multiprocessor-wakeup-structure
if that is OK.
[2]. https://lore.kernel.org/lkml/624e1985-7dd2-4abe-a918-78cb43556967@kernel.oirg

description: |
  [Removed for brevity]

properties:
  compatible:
    const: intel,wakeup-mailbox

  reg:
    maxItems: 1

  '#mbox-cells':
    const: 1

required:
  - compatible
  - reg

additionalProperties: false

examples:
  - |
    wakeupmailbox: mailbox@1c000500 {
      compatible = "intel,wakeup-mailbox";
      reg = <0x1c000500 0x100>;
      #mbox-cells = <1>;
    };

    cpus {
        #address-cells = <1>;
        #size-cells = <0>;

        cpu@0 {
            device_type = "cpu";
            reg = <0x00>;
            enable-method = "wakeup-mailbox";
        };
    };
...

