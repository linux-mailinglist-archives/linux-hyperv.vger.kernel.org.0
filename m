Return-Path: <linux-hyperv+bounces-5557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3129ABC5E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9E8161CD2
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C8210F65;
	Mon, 19 May 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2vW3R9q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C56189F3B;
	Mon, 19 May 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677066; cv=none; b=o/h6M5nnZsC/WD9pALvm4wWWrr4JOhTbqSRnL+/iOTJ5rUi+c8QUE/BT3Ckj9fl0h6naXqXEJtxxOp6XC0pv0inRjT//2TbUiVr7IFo6sOq7eWeL3Xc5S13gJJKWUz27Qlhp8vHuXhn0/pQV6za5dZOLjcB8fK4tZpQJgIOEkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677066; c=relaxed/simple;
	bh=nKa4bHZyPQdUF/i6uNjxZLF1LDuKJHocPAQdDgqVICc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZNSgLhrsXEVntGTzEGeWtI1+olX9L2WR1vhG6SFRfxii6y3yAPjSTMkaiWrD406YPQwBgK0fe2KixXuMMxNsPqjJMX6tiomxgFTlmgHM68ixmMttp3ld179bmxg9tulbrse8ZWiF39VAhil0MKiRDyb1+GBHrTjJromPjxEgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2vW3R9q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747677064; x=1779213064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKa4bHZyPQdUF/i6uNjxZLF1LDuKJHocPAQdDgqVICc=;
  b=c2vW3R9q3OVSmv9NpuNm7etcX9c5Qg/YrfWQqdZcJVT5TT3QN3I2wiFZ
   9NCD9ZqauKYP654TNDkPCAMI6OApe0WPAVf5z3uceDEBOZRmU5LmmYEkb
   Tr3XGvV6Qp9qRoSmMvK+1VbmbAesLs3csPHwpQ98kakBSMAdk3oaKSOmW
   I62/Q9QI94F1SUAtMGnVTycAIooq5jhKKnjxgnNxlrNcHFqYs9XiDCQVt
   sx+vR1j6fBQ798y8H8nUVpJaN5Haj6RoFCnVTy8+eSdGsjfcj7uV/8p+3
   9+i32vT8iGDJAG/eDyIDQ4TJJzwvF/T0OynYtSgu/bHX4i7g32F0aC2hY
   Q==;
X-CSE-ConnectionGUID: RBbbY0eRRQyuyz7V38bRiQ==
X-CSE-MsgGUID: uetXqAtRTkay86FK0Q0I8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49493458"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49493458"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:51:03 -0700
X-CSE-ConnectionGUID: glWSRu+/T1+fFYiMbL4DLA==
X-CSE-MsgGUID: FwYFkZhNQ1+Ss/Cy0nueLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="170471752"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:51:03 -0700
Date: Mon, 19 May 2025 10:56:06 -0700
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
Message-ID: <20250519175606.GA9693@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
 <20250514154248.GA2375202-robh@kernel.org>
 <20250515035338.GA4955@ranerica-svr.sc.intel.com>
 <20250519152937.GA2227051-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519152937.GA2227051-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 19, 2025 at 10:29:37AM -0500, Rob Herring wrote:
> On Wed, May 14, 2025 at 08:53:38PM -0700, Ricardo Neri wrote:
> > On Wed, May 14, 2025 at 10:42:48AM -0500, Rob Herring wrote:
> > > On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> > > > On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > > > > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > > > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > > > > get different rules than all other bindings... or this does not have to
> > > > > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > > > > 
> > > > > > > > > Why do you need compatible in the first place?
> > > > > > > > 
> > > > > > > > Are you suggesting something like this?
> > > > > > > > 
> > > > > > > > reserved-memory {
> > > > > > > > 	# address-cells = <2>;
> > > > > > > > 	# size-cells = <1>;
> > > > > > > > 
> > > > > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > > > > 	}
> > > > > > > > 
> > > > > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > > > > phandle?
> > > > > > > 
> > > > > > > Yes just like every other, typical reserved memory block.
> > > > > > 
> > > > > > Thanks! I will take this approach and drop this patch.
> > > > > 
> > > > > If there is nothing else to this other than the reserved region, then 
> > > > > don't do this. Keep it like you had. There's no need for 2 nodes.
> > > > 
> > > > Thank you for your feedback!
> > > > 
> > > > I was planning to use one reserved-memory node and inside of it a child
> > > > node to with a `reg` property to specify the location and size of the
> > > > mailbox. I would reference to that subnode from the kernel code.
> > > > 
> > > > IIUC, the reserved-memory node is only the container and the actual memory
> > > > regions are expressed as child nodes.
> > > > 
> > > > I had it like that before, but with a `compatible` property that I did not
> > > > need.
> > > > 
> > > > Am I missing anything?
> > > 
> > > Without a compatible, how do you identify which reserved region is the 
> > > wakeup mailbox?
> > 
> > I thought using a phandle to the wakeup_mailbox. Then I realized that the
> > device nodes using the mailbox would be CPUs. They would need a `memory-
> > region` property. This does not look right to me.
> 
> That doesn't really make sense unless it's a memory region per CPU.

Agreed.

> 
> 
> > > Before you say node name, those are supposed to be 
> > > generic though we failed to enforce anything for /reserved-memory child 
> > > nodes.
> > 
> > I see. Thanks for preventing me from doing this.
> > 
> > Then the `compatible` property seems the way to go after all.
> > 
> > This what motivated this patch in the first place. On further analysis,
> > IIUC, defining bindings and schema is not needed, IMO, since the mailbox
> > is already defined in the ACPI spec. No need to redefine.
> 
> You lost me...
> 
> You don't need to redefine the layout of the memory region as that's 
> defined already somewhere,

Great!

> but you do need to define where it is for DT. 
> And for that, you need a compatible. Do you know where it is in this 
> case?

The compatible is not defined anywhere yet. Is a DT schema needed to
document it? If yes, I am usure what to put in the description. We tried
to not redefine the mailbox and refer to the ACPI spec. That was a NAK
from Krzysztof [1].

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/r/624e1985-7dd2-4abe-a918-78cb43556967@kernel.org

