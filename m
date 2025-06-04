Return-Path: <linux-hyperv+bounces-5775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EDACE102
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D683A809C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401429114B;
	Wed,  4 Jun 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfCl6ftF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9734AEE0;
	Wed,  4 Jun 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049935; cv=none; b=CxFy6jiHk5gtECKqAc1+HUo6lmxzYfdKabaq88O4xRYENZMGhhIbp2WF4g2qdSUJskY9ehRdlQFeF5Q71+Pd8sfoScAHWN6TPKHsrLDVu/I3wUqaQX9fcXX39keATDRXlLTFtvJ/OFW9sfdaP2j1I7yoca/dwqVcrkfn1eYuOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049935; c=relaxed/simple;
	bh=kq+m0QIAuhIHtYetcNnPRrO7LimxMJSYLr9rALJScj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHbdQKkuAx9rxe+vhJ9clJvubUGIpTs3XjmIEm9QhLdM2DbRFvfuQXzC+8UpjSummpFKG57UXpLnV3jDyMr/sWDCvQL4T5FcZeqwiQMd5hrKWg0UaOzTgV4bwsMgBHm8FvSk8BwpUikHY9HYJ3bFzVIy2nzt14DkFwP8CLnXwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfCl6ftF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749049934; x=1780585934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kq+m0QIAuhIHtYetcNnPRrO7LimxMJSYLr9rALJScj4=;
  b=OfCl6ftFd+Cp/dI08G0qG8txLoZl9dLE9Ob6HeuwHvG0FvZpa1y1p8AD
   qbBrgQylWSZXN83/RNqbi/XcdQhDzhRjuqeE87WkgEO7i20VmCceu4PMT
   dff6d99vTmoRBQJdEJ6rkRBm4auyyVGEga62ZnJLShaEZgoohk3mKXlyE
   p49+SUqo7a2RKPRPmlRJ3RXSffMsxnsgTonQgOplKoB0tEWxnKXNUNWeC
   xZ9/rIm2ijPYfZbKJbROFkfI3PFpmo1E2FsK96r5fylopXrWNA2wvb8uS
   KgNczbPnh1NvZU3oEws5x1M5KpdGfYpUm7wL9n9UGt+tPUPR8x+Mznw2h
   Q==;
X-CSE-ConnectionGUID: 3z+f9kVoRN2NQLtcvbiy3w==
X-CSE-MsgGUID: R18cy9dWSHWtl4R3z8UwMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61801497"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="61801497"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:12:13 -0700
X-CSE-ConnectionGUID: CcnZPyNVRBCEQq/AqSlGAQ==
X-CSE-MsgGUID: lW6TtIWQSMmXLN2UgyyDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145179148"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:12:14 -0700
Date: Wed, 4 Jun 2025 08:17:20 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-acpi@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Chris Oo <cho@microsoft.com>, Ricardo Neri <ricardo.neri@intel.com>,
	linux-hyperv@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250604151720.GC29325@ranerica-svr.sc.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
 <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
 <174900070284.2624702.4580450009482590306.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174900070284.2624702.4580450009482590306.robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jun 03, 2025 at 08:31:42PM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 03 Jun 2025 17:15:15 -0700, Ricardo Neri wrote:
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
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml:20:111: [warning] line too long (113 > 110 characters) (line-length)


I did see this warning. I also see that none of the existing schema with
links break them into multiple lines.

Now I see that the yamllint configuration has allow-non-breakable-words: true

I will put the link in separate line.

