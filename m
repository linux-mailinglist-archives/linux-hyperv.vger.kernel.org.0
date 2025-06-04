Return-Path: <linux-hyperv+bounces-5765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB5ACDCD3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7865188CA9E
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AFF28ECD0;
	Wed,  4 Jun 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTg/qEZm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455328E594;
	Wed,  4 Jun 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037420; cv=none; b=L/k761MH84E3ruaYXzVEhjvT03O0HGGdieNX9/0sxEabtQ97nn3gRRHbdjjfVj0VgqirafA2LD/SP+vDMQq3Lc890+ICPkMBjE6WdXnrz2pD8gRWu8xx2s0l+wKycSFbezBe8REB3ky/SXgpfRd7bOcBF3xRTmzEO4RrHvs1NAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037420; c=relaxed/simple;
	bh=asMHIzflbcbz5dL3ZARFHy96ClpJy1yEA64sCCpM5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB1QbflN6DhyN5w57+yTZ3YVGc8dtYxZ0F6i4U/cfmBqblzPVPtXaTgRHhUoljZxIBK5EIJJgmLqyQZOw/mG10Wp3OItSu0xWwojByKpit/Ntc0f1b6erDLiWO8a4gHbRYa4bFeHnJJm4b1uxBS0f5dF2mFxVGp6uqzB9vTYvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTg/qEZm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749037418; x=1780573418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=asMHIzflbcbz5dL3ZARFHy96ClpJy1yEA64sCCpM5xU=;
  b=DTg/qEZm0kTGsEVzzgd4trzzF0mssnT7+MYZcB+AHukkQe2WEeRQuQgU
   XZXKLdgymB/JDH5zJPT0I/hIJH+ei/nQkNT1y0N0dU99AXZwI+BlFuw/Y
   GymFujLH2uKVQIpRklQGk4kmzP/Jr6uehrxXeORe4DLh+/eVOfPGqq184
   1K9RitcqOHCy7ywRacPXvhFAZyUm/2RPPcG4upTkKAdOI4CpF27vLEGZ6
   MhMeS0hQ6oFfLN/oj4KPdoLdCzw5sH78PQduVOM0Aee4fC5eJw7+raoIR
   rV4d3PchBjqUx5MAzzGPIvBXweJ1xkqxQ4Mm9URYm/IZzX0rBYJWuNml4
   Q==;
X-CSE-ConnectionGUID: wY1w0lG4QbCyTBn+WdbS2Q==
X-CSE-MsgGUID: e4KjUlkSRnKe9omGbzSdaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54913282"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54913282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 04:43:37 -0700
X-CSE-ConnectionGUID: JDWoo7ccR5mHN4d5bYcyCg==
X-CSE-MsgGUID: CR0mYPAESp61B0UmWrL5Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145182204"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 04:43:37 -0700
Date: Wed, 4 Jun 2025 04:48:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250604114844.GB29325@ranerica-svr.sc.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
 <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
 <CAJZ5v0i6Ej6Tg-4aS_B3Gg2Z5Bk0g_AA9wdG0FQmuq0ZqdP1og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i6Ej6Tg-4aS_B3Gg2Z5Bk0g_AA9wdG0FQmuq0ZqdP1og@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jun 04, 2025 at 11:18:15AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 2:18 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> > firmware for Intel processors.
> >
> > x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> > followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> > mechanism is unavailable.
> >
> > The wakeup mailbox offers more control to the operating system to boot
> > secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> > for all CPUs while maintaining control over which CPUs to boot and when.
> > While it is possible to achieve the same level of control using a spin-
> > table, it would require to specify a separate `cpu-release-addr` for each
> > secondary CPU.
> >
> > The operation and structure of the mailbox is described in the
> > Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> > that this structure does not specify how to publish the mailbox to the
> > operating system (ACPI-based platform firmware uses a separate table). No
> > ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.
> >
> > Add a `compatible` property that the operating system can use to discover
> > the mailbox. Nodes wanting to refer to the reserved memory usually define a
> > `memory-region` property. /cpus/cpu* nodes would want to refer to the
> > mailbox, but they do not have such property defined in the DeviceTree
> > specification. Moreover, it would imply that there is a memory region per
> > CPU.
> >
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  - Removed redefinitions of the mailbox and instead referred to ACPI
> >    specification as per discussion on LKML.
> >  - Clarified that DeviceTree-based firmware do not require the use of
> >    ACPI tables to enumerate the mailbox. (Rob)
> >  - Described the need of using a `compatible` property.
> >  - Dropped the `alignment` property. (Krzysztof, Rafael)
> >  - Used a real address for the mailbox node. (Krzysztof)
> >
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
> >  .../reserved-memory/intel,wakeup-mailbox.yaml      | 48 ++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > new file mode 100644
> > index 000000000000..f18643805866
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
> > @@ -0,0 +1,48 @@
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
> > +  The structure and operation of the mailbox is described in the Multiprocessor
> > +  Wakeup Structure of the ACPI specification.
> 
> Please make this more specific: Which specification version and what section.
> 
> You may as well add a URL here too.

Sure Rafael. I will refer to the ACPI specification v6.6 secton 5.2.12.19.
It is the latest version at the time of writing this schema.

