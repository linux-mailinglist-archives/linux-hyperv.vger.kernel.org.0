Return-Path: <linux-hyperv+bounces-2745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96B94AE7C
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB24E1F216B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049B13AD0F;
	Wed,  7 Aug 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLACsGuJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4D84D02;
	Wed,  7 Aug 2024 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049825; cv=none; b=fZbJzokAI3151olyE62L88q6j+DOrpA84WWyPbgfR0AytY10hEMwFivGQ8cmo+IuYZJgnlVg2gyFFvFD29rJdafAyzI3SRZniVL4w47kbHCTewSvLVEqLKArHhouOhkLoX7s1VfXHfo+BKy2UCLGOzfGRt0E/gHE3JQMQJQdtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049825; c=relaxed/simple;
	bh=xDm+ivfSN/HC2ca9CTYeLvWnqKmqIYVJSNyWdx/9SYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLrMqGdhVLQeFndOebkOgEkjotd7FMdxtQyq8Z9AEms5ipD7X4UBrf+8vz9NFhSJY12qk8XbCiu3pDNww9tVbKBUDIgLVRU9COxotdkLne3PjV3EN/OuNjlJIVMBVM3+yFXfJral6Jw8C0BYndiMlP/qnuY5bMeyMiV+MIkSpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLACsGuJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723049824; x=1754585824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDm+ivfSN/HC2ca9CTYeLvWnqKmqIYVJSNyWdx/9SYM=;
  b=iLACsGuJIaIjC0FK5qQa47qG7Zj8VmE7MwDTr//YwZtbaDJi6IUDLeVS
   jpiickJJCo8aqvI6fO3ur4+i+TAvKgDOAAMb4mdZFyMyrIEcPsmFUVhXA
   2VCDkFq0HMB7tT0b/loK65AvZAnFBrK59l7OyHYXrNrhWaWmHbM0gGLer
   BGxKQBipG+4opppeTZ/JUVqoUl5TBIDY82pLtdiMt2dO+7GSgzDXrc74a
   JlBKAWB71iuWfUR7XYj86UfFUm+R8pxVtxE76V5L27MgtvsitDPbJl1Ik
   6AxiwcSDgO6Dz3x7zQ2S7AjhgqRLk+jC8ALdPqvGccKsOdDf1xV6laSTq
   w==;
X-CSE-ConnectionGUID: Gr5CoyC2Q1yfTJyrT/WBSg==
X-CSE-MsgGUID: PZ+S5ZinT+K9IDT24kKG0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32277178"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32277178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:57:03 -0700
X-CSE-ConnectionGUID: FLWJikZ0TZyuhtQlQSPiog==
X-CSE-MsgGUID: jT9W66pUT3qz+yOP4pslIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56598375"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.166.194])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:56:59 -0700
Date: Wed, 7 Aug 2024 09:56:58 -0700
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
Subject: Re: [PATCH 2/7] dt-bindings: x86: Add ACPI wakeup mailbox
Message-ID: <20240807165658.GA17382@yjiang5-mobl.amr.corp.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
 <ce4903f2-2a9d-45c4-bd4d-ac5165211a83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4903f2-2a9d-45c4-bd4d-ac5165211a83@kernel.org>

On Wed, Aug 07, 2024 at 07:57:43AM +0200, Krzysztof Kozlowski wrote:
> On 07/08/2024 00:12, Yunhong Jiang wrote:
> > Add the binding to use the ACPI wakeup mailbox mechanism to bringup APs.
> 
> We do not have bindings for ACPI. I think in the past it was mentioned
> pretty clear - we do not care what ACPI has in the wild.

Thank you for review.
Can you please give a bit more information on "do not have bindings for ACPI"?
We don't put the ACPI table into the device tree, but reuse some existing ACPI
mailbox mechanism. Is this acceptable for you?

> 
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  .../devicetree/bindings/x86/wakeup.yaml       | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > new file mode 100644
> > index 000000000000..8af40dcdb592
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +
> > +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> This was absolutely never tested and does not look like proper bindings
> file. This just does not work. Go to example-schema and use it as template.
> 
> NAK
> 
> Best regards,
> Krzysztof
Oops, I used the example-schema but apparently did something wrong. Will have a
check.

--jyh
> 

