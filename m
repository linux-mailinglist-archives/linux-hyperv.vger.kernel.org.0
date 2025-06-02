Return-Path: <linux-hyperv+bounces-5708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62505ACA811
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC53A7E89
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 01:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081F2F24;
	Mon,  2 Jun 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6GCEhyQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BB4C7C;
	Mon,  2 Jun 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748827602; cv=none; b=HO6mKGd6DK+jsPyGw+aQzVRfs9tz3ztxpzo/N2PlG0iYZLtYI4tUWJOO3qCWL0YbUHzTK48QfwP2z+oWJn+ktNGGj+QQQ0N1WJWmjVBzaedmuest8EL57RYMrG81PWd0Q+y4qqf9dAFVCS9UoJ6hTbmc6zQfQNJtto4bFa0JRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748827602; c=relaxed/simple;
	bh=KHOrI/tcUQxQ/4g8TO2DNZqo8MwNVeHh8Rb/WFAhsMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNFU8ystIFRD6+Nmfie8uOSa+2lJtAwv1S8KRQAI2cJDJqZ+2c4huWxuWUO1s9BveCh61ULY5nUs7pwZA9whfH842aNCXkwCQs0ndenPUI0BgHwT59lBI0IwPBRi74ltUpiczg/KDU7Rknpsv4G/i/akDRW363+ANMbdhtmsVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6GCEhyQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748827600; x=1780363600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KHOrI/tcUQxQ/4g8TO2DNZqo8MwNVeHh8Rb/WFAhsMY=;
  b=l6GCEhyQV7xOonqcrkFtLccw6t+nmJEkLcyCEbbEXuLqkqUpMYXOnpiU
   GPhp6A6+4PnD/kA9GhxfGJ+DmDrqDPwzV+6OycEjJXPodNAEj9Kdo7HFu
   mTkLqqyP79MzXNOj00es52cCD1zJ/YSNYzhCko836ohjW9XF23T73ldGC
   gHw2R/qO0fxiRO4LNbGyoNRtK9yFetQdWwj7ai4l8HKyvS01A1uwNPV5a
   wPPB79hh/Jq9L/7WhgMVTpRM0m7bEIi8l/X5xC9WdUELpEMIAMa9AyZ5Z
   slxmmYFzbIVVSVEBZ4kf7Ditd0OiI/HGNTWUeTeluOOwv0nH6om9dx4do
   g==;
X-CSE-ConnectionGUID: cYNFZuT/SkKCJBbMrq6fZQ==
X-CSE-MsgGUID: ViAWmTSkR8+rp49WzVuFXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50936428"
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="50936428"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 18:26:39 -0700
X-CSE-ConnectionGUID: dHD8CikpSNaf/8GLC5VgOg==
X-CSE-MsgGUID: q7DJSSPfTvanbnzLXeEggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="149695206"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 18:26:39 -0700
Date: Sun, 1 Jun 2025 18:31:44 -0700
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
Message-ID: <20250602013144.GA27991@ranerica-svr.sc.intel.com>
References: <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
 <20250514154248.GA2375202-robh@kernel.org>
 <20250515035338.GA4955@ranerica-svr.sc.intel.com>
 <20250519152937.GA2227051-robh@kernel.org>
 <20250519175606.GA9693@ranerica-svr.sc.intel.com>
 <20250524155650.GA16942@ranerica-svr.sc.intel.com>
 <20250529131634.GA2784667-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529131634.GA2784667-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, May 29, 2025 at 08:16:34AM -0500, Rob Herring wrote:
> On Sat, May 24, 2025 at 08:56:50AM -0700, Ricardo Neri wrote:
> > On Mon, May 19, 2025 at 10:56:06AM -0700, Ricardo Neri wrote:
> > > On Mon, May 19, 2025 at 10:29:37AM -0500, Rob Herring wrote:
> > > > On Wed, May 14, 2025 at 08:53:38PM -0700, Ricardo Neri wrote:
> > > > > On Wed, May 14, 2025 at 10:42:48AM -0500, Rob Herring wrote:
> > > > > > On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> > > > > > > On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > > > > > > > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > > > > > > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > > > > > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > > > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > > > > > > > get different rules than all other bindings... or this does not have to
> > > > > > > > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > > > > > > > 
> > > > > > > > > > > > Why do you need compatible in the first place?
> > > > > > > > > > > 
> > > > > > > > > > > Are you suggesting something like this?
> > > > > > > > > > > 
> > > > > > > > > > > reserved-memory {
> > > > > > > > > > > 	# address-cells = <2>;
> > > > > > > > > > > 	# size-cells = <1>;
> > > > > > > > > > > 
> > > > > > > > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > > > > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > > > > > > > 	}
> > > > > > > > > > > 
> > > > > > > > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > > > > > > > phandle?
> > > > > > > > > > 
> > > > > > > > > > Yes just like every other, typical reserved memory block.
> > > > > > > > > 
> > > > > > > > > Thanks! I will take this approach and drop this patch.
> > > > > > > > 
> > > > > > > > If there is nothing else to this other than the reserved region, then 
> > > > > > > > don't do this. Keep it like you had. There's no need for 2 nodes.
> > > > > > > 
> > > > > > > Thank you for your feedback!
> > > > > > > 
> > > > > > > I was planning to use one reserved-memory node and inside of it a child
> > > > > > > node to with a `reg` property to specify the location and size of the
> > > > > > > mailbox. I would reference to that subnode from the kernel code.
> > > > > > > 
> > > > > > > IIUC, the reserved-memory node is only the container and the actual memory
> > > > > > > regions are expressed as child nodes.
> > > > > > > 
> > > > > > > I had it like that before, but with a `compatible` property that I did not
> > > > > > > need.
> > > > > > > 
> > > > > > > Am I missing anything?
> > > > > > 
> > > > > > Without a compatible, how do you identify which reserved region is the 
> > > > > > wakeup mailbox?
> > > > > 
> > > > > I thought using a phandle to the wakeup_mailbox. Then I realized that the
> > > > > device nodes using the mailbox would be CPUs. They would need a `memory-
> > > > > region` property. This does not look right to me.
> > > > 
> > > > That doesn't really make sense unless it's a memory region per CPU.
> > > 
> > > Agreed.
> > > 
> > > > 
> > > > 
> > > > > > Before you say node name, those are supposed to be 
> > > > > > generic though we failed to enforce anything for /reserved-memory child 
> > > > > > nodes.
> > > > > 
> > > > > I see. Thanks for preventing me from doing this.
> > > > > 
> > > > > Then the `compatible` property seems the way to go after all.
> > > > > 
> > > > > This what motivated this patch in the first place. On further analysis,
> > > > > IIUC, defining bindings and schema is not needed, IMO, since the mailbox
> > > > > is already defined in the ACPI spec. No need to redefine.
> > > > 
> > > > You lost me...
> > > > 
> > > > You don't need to redefine the layout of the memory region as that's 
> > > > defined already somewhere,
> > > 
> > > Great!
> > > 
> > > > but you do need to define where it is for DT. 
> > > > And for that, you need a compatible. Do you know where it is in this 
> > > > case?
> > > 
> > > The compatible is not defined anywhere yet. Is a DT schema needed to
> > > document it? If yes, I am usure what to put in the description. We tried
> > > to not redefine the mailbox and refer to the ACPI spec. That was a NAK
> > > from Krzysztof [1].
> > > 
> > > [1]. https://lore.kernel.org/r/624e1985-7dd2-4abe-a918-78cb43556967@kernel.org
> > 
> > In summary, documenting the `compatible` property for the mailbox is
> > necessary. There is no need to redefine the malbox on a schema but
> > referring to the ACPI spec is not acceptable.
> 
> There's the whole "DT bindings in ACPI systems" where ACPI tables 
> contain compatibles and DT properties which I think is what 
> Krzysztof was objecting to (and I do too). But this is a DT based system 
> that implements a mailbox region defined in an ACPI spec. That is 
> perfectly fine to refer to.

That is correct. It is a DT-based system.

Great! I will refer to the ACPI spec in my schema in my next version.

> 
> > 
> > What about referring in the schema to the Intel TDX Virtual Firmware Design
> > Guide[2]? It describes how firmware should implement the mailbox the section
> > 4.3.5.
> > 
> > A mailbox with compatible = "intel,wakeup-mailbox" is implemented after the
> > guide that Intel published.
> 
> Use whatever you think best describes the programming model of the 
> region.

Understood.

Thanks and BR,
Ricardo

