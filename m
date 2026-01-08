Return-Path: <linux-hyperv+bounces-8189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCB3D00F3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 08 Jan 2026 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2587E30185EB
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jan 2026 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676B22A1E1;
	Thu,  8 Jan 2026 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9St3MjR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22026BA21;
	Thu,  8 Jan 2026 04:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767845228; cv=none; b=HbmxEL+p5ikH8U1DunIhGxU6AkWvkKDnSXZulVi3XtspAqxaksHfNaiKj1aQh2PViOE1ZpXWmc6xes7qx+AuDED8xuk/GEwe8PMlaAZv0chnmkxjc72GC0bItA6mN2EruUhCUscoqvfnrHZ0Nr4DwLu98fRt1jl67deH+m+W48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767845228; c=relaxed/simple;
	bh=9SMcQcVKDqK4arLsjjtZ9E8UQHUt37+fKvIrTdc9Ijw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU4ZnF+zI7uzSu/c2qUA4BZegdRzdGal8yy8CNHNkrsEhGAUlcQKd/L93sjYd2J3MEojJg/LN9SPSBYn0jW/2/3pHnRIoWBOBdcy0eTXts4rF0cemfJK5nWVlsKKaSE+yWdxRiTBXrQ2kWbyB12GZ/WN7Dpxmci1HJxQXGrJjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9St3MjR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767845226; x=1799381226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9SMcQcVKDqK4arLsjjtZ9E8UQHUt37+fKvIrTdc9Ijw=;
  b=C9St3MjRuw81VT0GAIBtTM2JjjXFC46gmMdFEJCbpp4DEpZ4PkP99jPK
   i8ZR8XBKvb5SLGOi0Qh5eVRmSWEnhBKCaDVI1ZSEzmp3sTF2W/63vC8S4
   aOHqxqIFqk00xf7d3UYgTZdihgIk758VT5Ytf8fw2DRqCPt38qF4dT1nQ
   j2dRDaQq9DBtX1G9nXLs4W5qaa3+zLnTzvnjb65PaV7cMM29Vvfoust37
   bFHGh1AXD9Xv1b+4+o8Zum7esrWZWTbh6GDBKvBsBAXjU7CCO+z+66Vh/
   d3UcODpqaUF2o3+UVNeenGUAJPTeql0aTXuI+xxOKeu/4vqoC5P2mbkfV
   A==;
X-CSE-ConnectionGUID: z0ANQf6bRHaXV/HFwwqVNg==
X-CSE-MsgGUID: EptWV4pqQymViviztQ127Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80672305"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="80672305"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 20:07:05 -0800
X-CSE-ConnectionGUID: isuqpZW6Rfad1A8Ia+gdhQ==
X-CSE-MsgGUID: dQ1ygzaJQqO7IIojS0WvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207577195"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 20:07:05 -0800
Date: Wed, 7 Jan 2026 20:13:32 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-acpi@vger.kernel.org, Chris Oo <cho@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Ricardo Neri <ricardo.neri@intel.com>, Wei Liu <wei.liu@kernel.org>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20260108041332.GA3378@ranerica-svr.sc.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
 <20260107-rneri-wakeup-mailbox-v8-3-2f5b6785f2f5@linux.intel.com>
 <176782823140.2300431.3081932954431387872.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176782823140.2300431.3081932954431387872.robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 07, 2026 at 05:23:51PM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 07 Jan 2026 13:44:39 -0800, Ricardo Neri wrote:
> > Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> > firmware for Intel processors.
> > 
> > x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> > followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> > mechanism is unavailable.
> > 
> > The wakeup mailbox offers more control to the operating system to boot
> > secondary CPUs than a spin-table. It allows the reuse of the same wakeup
> > vector for all CPUs while maintaining control over which CPUs to boot and
> > when. While it is possible to achieve the same level of control using a
> > spin-table, it would require specifying a separate `cpu-release-addr` for
> > each secondary CPU.
> > 
> > The operation and structure of the mailbox are described in the
> > Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> > that this structure does not specify how to publish the mailbox to the
> > operating system (ACPI-based platform firmware uses a separate table). No
> > ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.
> > 
> > Nodes that want to refer to the reserved memory usually define
> > a `memory-region` property. /cpus/cpu* nodes would want to refer to the
> > mailbox, but they do not have such property defined in the DeviceTree
> > specification. Moreover, it would imply that there is a memory region per
> > CPU. Instead, add a `compatible` property that the operating system can use
> > to discover the mailbox.
> > 
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes in v8:
> >  - None
> > 
> > Changes in v7:
> >  - Fixed Acked-by tag from Rafael to include the "(Intel)" suffix.
> > 
> > Changes in v6:
> >  - Reworded the changelog for clarity.
> >  - Added Acked-by tag from Rafael. Thanks!
> >  - Added Reviewed-by tag from Rob. Thanks!
> >  - Added Reviewed-by tag from Dexuan. Thanks!
> > 
> > Changes in v5:
> >  - Specified the version and section of the ACPI spec in which the
> >    wakeup mailbox is defined. (Rafael)
> >  - Fixed a warning from yamllint about line lengths of URLs.
> > 
> > Changes in v4:
> >  - Removed redefinitions of the mailbox and instead referred to ACPI
> >    specification as per discussion on LKML.
> >  - Clarified that DeviceTree-based firmware do not require the use of
> >    ACPI tables to enumerate the mailbox. (Rob)
> >  - Described the need of using a `compatible` property.
> >  - Dropped the `alignment` property. (Krzysztof, Rafael)
> >  - Used a real address for the mailbox node. (Krzysztof)
> > 
> > Changes in v3:
> >  - Implemented the mailbox as a reserved-memory node. Add to it a
> >    `compatible` property. (Krzysztof)
> >  - Explained the relationship between the mailbox and the `enable-mehod`
> >    property of the CPU nodes.
> >  - Expanded the documentation of the binding.
> > 
> > Changes in v2:
> >  - Added more details to the description of the binding.
> >  - Added requirement a new requirement for cpu@N nodes to add an
> >    `enable-method`.
> > ---
> >  .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml:23:1: [warning] too many blank lines (2 > 1) (empty-lines)

This got triggered by an empty line in an patch already reviewed by the DT
binding maintainers. Previous versions did not trigger this warning since
the check to allow at most 1 empty line is rather recent.

Would it be possible for the review proceed? I am happy to post a new version
fixing this after the rest of the patches have been reviewed.

Thanks and BR,
Ricardo

