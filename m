Return-Path: <linux-hyperv+bounces-5422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C6AAEF13
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 01:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9EE1BC4434
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87449291174;
	Wed,  7 May 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr6U282C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC871ACEC8;
	Wed,  7 May 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659502; cv=none; b=ZxpOYfRKouaSOFcFrN/lo0XCbdmDi3QASX8QumjjDVDWWhMxYVaJt5n5EkMvM3TpHP/25ecpnY8IRtS0V3+JwEfs6Y+VSdYrkCK2GR2s7NP5g3eYAW/CuP3yUZ28fmrnMrSlrd69bXPkYQukjQQV2UpfWN14kaVo7811vr8LyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659502; c=relaxed/simple;
	bh=RGS6xqwf+eAFdkFQCJRyKL1JWrMRM7+MAR2zJd5Lnyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuyjMIMXHIUZysZ0Qxym8/omqBmgiNLX4qXUvv6z8ey0zF7hU3QS1f4D6ZaaN+EEHa+CsF6NkpASes7cOF6B/l90orNgYtXvwwscZCvzR+CGvtYALSNbMQwYEaKbl2s/L9ZvRC4c1FqSO7wzeviQcRlhUgI8CHvaKYV38pMBj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr6U282C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746659502; x=1778195502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RGS6xqwf+eAFdkFQCJRyKL1JWrMRM7+MAR2zJd5Lnyw=;
  b=Lr6U282Cl5q18ymFBHgPqR/bb2ExnxDV+pjgkWlMyhJ+ESQ49vzmfTAo
   ApXLQ9H1OXu5qbWaRA5kWOKzsjfWNtyCvInSWonCdBhHzCkjFConu/SVk
   BSJqa32Pwmsf0AjI2hoA0WqX3a3smOeCsBqd8SMPLhe5IEXZAXEZsuXKv
   z1cCNDc47OXvlUJq1+1Xn2dgAK8Jt6C+BccHHwNL6ohye+C1QyRs/qhWE
   9mFsHQAU/JQ7rcANSf+9vrSLlUc5hQVyNWjsY/tD35oTfdgZ3pIP1Q4CV
   Syg36cG5hMXe8mPIClsoax4IzqSNiIE+79NctEcd5H3o/1oDxSp7NMea+
   A==;
X-CSE-ConnectionGUID: 9cGpP0jrS+KNldGkpP5KhQ==
X-CSE-MsgGUID: 2IoEb77HRE6Ryy6YmEVCsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52073731"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="52073731"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 16:11:40 -0700
X-CSE-ConnectionGUID: n53kvqjfRue9GsXfCUf8fg==
X-CSE-MsgGUID: A89NqrmXRgahO1BXhRqWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="136042291"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 16:11:38 -0700
Date: Wed, 7 May 2025 16:16:45 -0700
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
Message-ID: <20250507231644.GB28763@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
 <20250504-happy-spoonbill-of-radiance-3b9fec@kuoka>
 <20250506045235.GB25533@ranerica-svr.sc.intel.com>
 <20250506-alluring-beaver-of-modernism-65ff8a@kuoka>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-alluring-beaver-of-modernism-65ff8a@kuoka>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, May 06, 2025 at 09:25:59AM +0200, Krzysztof Kozlowski wrote:
> On Mon, May 05, 2025 at 09:52:35PM GMT, Ricardo Neri wrote:
> > On Sun, May 04, 2025 at 06:45:59PM +0200, Krzysztof Kozlowski wrote:
> > > On Sat, May 03, 2025 at 12:15:06PM GMT, Ricardo Neri wrote:
> > > > Add bindings for CPUs in x86 architecture. Start by defining the `reg` and
> > > 
> > > What for?
> > 
> > Thank you for your quick feedback, Krzysztof!
> > 
> > Do you mean for what reason I want to start bindings for x86 CPUs? Or only
> 
> Yes. For which devices, what purpose.

Sure, I could expand on this.

> 
> > the `reg` property? If the former, it is to add an enable-method property to
> > x86 CPUs. If the latter, is to show the relationship between APIC and `reg`.
> > 
> > > 
> > > > `enable-method` properties and their relationship to x86 APIC ID and the
> > > > available mechanisms to boot secondary CPUs.
> > > > 
> > > > Start defining bindings for Intel processors. Bindings for other vendors
> > > > can be added later as needed.
> > > > 
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > 
> > > Not really tested so only limited review follows.
> > 
> > Sorry, I ran make dt_binding_check but only on this schema. I missed the
> > reported error.
> > 
> > > 
> > > >  .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
> > > >  1 file changed, 80 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/x86/cpus.yaml b/Documentation/devicetree/bindings/x86/cpus.yaml
> > > > new file mode 100644
> > > > index 000000000000..108b3ad64aea
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/x86/cpus.yaml
> > > > @@ -0,0 +1,80 @@
> > > > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/x86/cpus.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: x86 CPUs
> > > > +
> > > > +maintainers:
> > > > +  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > +
> > > > +description: |
> > > > +  Description of x86 CPUs in a system through the "cpus" node.
> > > > +
> > > > +  Detailed information about the CPU architecture can be found in the Intel
> > > > +  Software Developer's Manual:
> > > > +    https://intel.com/sdm
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - intel,x86
> > > 
> > > That's architecture, not a CPU. CPUs are like 80286, 80386, so that's
> > > not even specific instruction set. I don't get what you need it for.
> > 
> > Am I to understand the the `compatible` property is not needed if the
> > bindings apply to any x86 CPU?
> 
> Every device needs compatible. Its meaning is explained:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#compatible
> 
> If you add here a device representing CPU, then look at existing
> bindings for CPUs how they do it.
> 
> It again feels like you add DT for platform which is not a real thing.

That is correct. I struggle to enumerate specific CPUs because the `intel,
wakeup-mailbox` enable method is implemented in the platform firmware and
is not tied to a given processor model as required by the rules of the
`compatible` property.

> If you use DT, you do not get different rules, therefore read all
> standard guides and tutorials (there were many, quite comprehensive).

I went through various materials. Perhaps I needed to understand the rules
better.

I realize now the DeviceTree is about describing hardware not firmware and
DT bindings are a suitable vehicle for this.

Thanks for the time you spent reviewing this patchset!

BR,
Ricardo

