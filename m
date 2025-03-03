Return-Path: <linux-hyperv+bounces-4198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD2A4CE04
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 23:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C0C7A88EF
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE02356C2;
	Mon,  3 Mar 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNlpbk/b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B50215782;
	Mon,  3 Mar 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040104; cv=none; b=k5dHMC8zgTZilUmJMpMh61frK1Va1tlO5+6+O8Z8XEVSiXWvrrhj+StjWhXNDwurxT3aHdbySOiMovLFfNNfa1+CeErUredXMHdWAOUPQZ/CiqH723FaCOtLVikk6zD33J2WfbCHtkOl6PeiLyKQ5e5rrdQKVNPjGRY+5kprop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040104; c=relaxed/simple;
	bh=zpPxLelE9Ybujo8zHlA6Bkn57MYTewjeu9jGuzQ7Jtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAIy/7gW7ig9wrkTPzcNI1AQoAlEIgKHfNVZ+s5eoEYJdpfqRlQBEvcspgdsFCv2w/lJbFtrx5b9VJM6fLFHCHsKvUrq3iKKk3IKTiIO7irs4OJt/27ZZPerbv+NURfRCuL3Z85jY9POj8n7PxlUQCBElVd67D+KKy3S4InM0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNlpbk/b; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741040103; x=1772576103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpPxLelE9Ybujo8zHlA6Bkn57MYTewjeu9jGuzQ7Jtw=;
  b=nNlpbk/bIxQ/SHA5m21NCB9LMpjYCPNLt1v5nuV8bXsqI1+bmGsZ39JO
   wePVIHpSBVJjsvl8GTWPQqocEjk+Fq8rCSbDMUEzHwxFxfSA8m1/MZT+T
   BmbNIJSNEcP5+NxhfmayGTpDHJoPh7SaQhB5JB3DUa4PyxCaukVEgu4ea
   S/vLUmNFC4qO7GRv6ASp05kG7Q7ed8ZFvaLFB9MnnO2ysj7kQaV2DN8Zc
   0dAbV90+soXnMbkuznE33pvJ1tcmCW+lmNetjiqLPLqVRXncE5I73fSJf
   QsbHDu5xy/dOSERGr5iya4O6bjCg54mzCJHd00ORwq3pqgfjtH/MCeIiw
   A==;
X-CSE-ConnectionGUID: QjHes+I2ToeNUFLu5kpitg==
X-CSE-MsgGUID: 4QzwpZm8RUe4dB3xDWcFtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52914242"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="52914242"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:15:02 -0800
X-CSE-ConnectionGUID: 7OFb8wluTW6tVcy0CNgGPA==
X-CSE-MsgGUID: xb8BCAlYSYq5R7HwB9qaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117909222"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:15:01 -0800
Date: Mon, 3 Mar 2025 14:21:02 -0800
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
Message-ID: <20250303222102.GA16733@ranerica-svr.sc.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
 <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
 <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
 <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
 <874d5908-f1db-412f-96a2-83fcebe8dd98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874d5908-f1db-412f-96a2-83fcebe8dd98@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Sep 20, 2024 at 01:15:41PM +0200, Krzysztof Kozlowski wrote:

[...]
 
> enable-method is part of CPUs, so you probably should match the CPUs...
> I am not sure, I don't have the big picture here.
> 
> Maybe if companies want to push more of bindings for purely virtual
> systems, then they should first get involved more, instead of relying on
> us. Provide reviews for your virtual stuff, provide guidance. There is
> resistance in accepting bindings for such cases for a reason - I don't
> even know what exactly is this and judging/reviewing based on my
> practices will no be accurate.

Hi Krzysztof,

I am taking over this work from Yunhong.

First of all, I apologize for the late reply. I will make sure
communications are timely in the future.

Our goal is to describe in the device tree a mechanism or artifact to boot
secondary CPUs.

In our setup, the firmware puts secondary CPUs to monitor a memory location
(i.e., the wakeup mailbox) while spinning. From the boot CPU, the OS writes
in the mailbox the wakeup vector and the ID of the secondary CPU it wants
to boot. When a secondary CPU sees its own ID it will jump to the wakeup
vector.

This is similar to the spin-table described in the Device Tree
specification. The key difference is that with the spin-table CPUs spin
until a non-zero value is written in `cpu-release-addr`. The wakeup mailbox
uses CPU IDs.

You raised the issue of the lack of a `compatible` property, and the fact
that we are not describing an actual device.

I took your suggestion of matching by node and I came up with the binding
below. I see these advantages in this approach:

  * I define a new node with a `compatible` property.
  * There is precedent: the psci node. In the `cpus` node, each cpu@n has
    an `enable-method` property that specify `psci`.
  * The mailbox is a device as it is located in a reserved memory region.
    This true regardless of the device tree describing bare-metal or
    virtualized machines.

Thanks in advance for your feedback!

Best,
Ricardo

(only the relevant sections of the binding are shown for brevity)

properties:
  $nodename:
    const: wakeup-mailbox

  compatible:
    const: x86,wakeup-mailbox

  mailbox-addr:
    $ref: /schemas/types.yaml#/definitions/uint64

required:
  - compatible
  - mailbox-addr

additionalProperties: false

examples:
  - |
    wakeup-mailbox {
      compatible = "x86,wakeup-mailbox";
      mailbox-addr = <0 0x1c000500>;
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

