Return-Path: <linux-hyperv+bounces-5521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E5AB7C78
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 05:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0007A18DC
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDF1A315E;
	Thu, 15 May 2025 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkXeM763"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A81361;
	Thu, 15 May 2025 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280914; cv=none; b=KX3rRJMYFTCQXX0FgSJVYhzGrXzkV0KIiaZRcMj+OLK0KqpyFa7o75wKtJ5jLJrDmmdO405qZ39riUBQ5OIWo1s6fHdaW0N5fzZqGbdeZlSZBoFmwJJmi5u6LlhebvP+UTv5HySLjilml26CsZnkTRfbF/u8oF2oC3g4fHK3w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280914; c=relaxed/simple;
	bh=VfW3scZAPCqRyh80P4VN1dFpLkyTS0bTtFRLyXSNsas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNKaJc2yOICZz9ViLKqX83vuE9h1O6cWZJfOtizIt/HQOAOj9dVbuQ0QBBJ0klng7Lu3TKzzBk1snWqxeuK+EWiXqhhiOw9ugTujiOCnw/9f/dD8U4YhqQpbuSFJRp9SI6MeB1hjGOGb/JOEiiI9+ZQk9osOOBsyGbZtKMGaRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkXeM763; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747280913; x=1778816913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfW3scZAPCqRyh80P4VN1dFpLkyTS0bTtFRLyXSNsas=;
  b=lkXeM763AN4F9fji6G5+ZAtkAFbc0O8dPB8BsT346sA0nOgkrlSYhXRP
   Sk5Rj5FKzrejPW0jMEyO3rwpceXdjxt1YIilmJynvEKerWgLUb6a2xG5i
   dgP3pdko7FG1EKvSImOp6khpJgUgbfXi60re85JVYaBV8zE274nNeFTI2
   G8WOs0fDroqumIhGZBIXRHyVqy1jgDmDIl5aot9z7KwGcs8fHHg3GQ1ZS
   fVrfnwtJssih+9fiQaqE6OyUtHsz9J2R2Lo2zdeZrB6ANnUFSlq95TDH7
   Jp8IojhRAmKkHHnj+SvM0fAFMAbPXM8Xl/lzj+zi2vq8U3fgLN8JVJX6Q
   g==;
X-CSE-ConnectionGUID: XmuYQTK7TpWQgGG2YRsJwQ==
X-CSE-MsgGUID: U2dJAY/0R2iHnDqvDhxvzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49341189"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49341189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:48:32 -0700
X-CSE-ConnectionGUID: Wm4JfG3aQGqgXz4C5GJRJQ==
X-CSE-MsgGUID: e93CM5oCSzG07R6DcYt8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139235585"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:48:31 -0700
Date: Wed, 14 May 2025 20:53:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <20250515035338.GA4955@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
 <20250514154248.GA2375202-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514154248.GA2375202-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, May 14, 2025 at 10:42:48AM -0500, Rob Herring wrote:
> On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> > On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > > get different rules than all other bindings... or this does not have to
> > > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > > 
> > > > > > > Why do you need compatible in the first place?
> > > > > > 
> > > > > > Are you suggesting something like this?
> > > > > > 
> > > > > > reserved-memory {
> > > > > > 	# address-cells = <2>;
> > > > > > 	# size-cells = <1>;
> > > > > > 
> > > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > > 	}
> > > > > > 
> > > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > > phandle?
> > > > > 
> > > > > Yes just like every other, typical reserved memory block.
> > > > 
> > > > Thanks! I will take this approach and drop this patch.
> > > 
> > > If there is nothing else to this other than the reserved region, then 
> > > don't do this. Keep it like you had. There's no need for 2 nodes.
> > 
> > Thank you for your feedback!
> > 
> > I was planning to use one reserved-memory node and inside of it a child
> > node to with a `reg` property to specify the location and size of the
> > mailbox. I would reference to that subnode from the kernel code.
> > 
> > IIUC, the reserved-memory node is only the container and the actual memory
> > regions are expressed as child nodes.
> > 
> > I had it like that before, but with a `compatible` property that I did not
> > need.
> > 
> > Am I missing anything?
> 
> Without a compatible, how do you identify which reserved region is the 
> wakeup mailbox?

I thought using a phandle to the wakeup_mailbox. Then I realized that the
device nodes using the mailbox would be CPUs. They would need a `memory-
region` property. This does not look right to me.

> Before you say node name, those are supposed to be 
> generic though we failed to enforce anything for /reserved-memory child 
> nodes.

I see. Thanks for preventing me from doing this.

Then the `compatible` property seems the way to go after all.

This what motivated this patch in the first place. On further analysis,
IIUC, defining bindings and schema is not needed, IMO, since the mailbox
is already defined in the ACPI spec. No need to redefine.

Ricardo

