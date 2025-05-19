Return-Path: <linux-hyperv+bounces-5554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BBABC26E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C0617C3CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A12857DB;
	Mon, 19 May 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9wV45dK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B1280001;
	Mon, 19 May 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668579; cv=none; b=CfMHZz3VEG3os75RFchmuW6OADmEtzMQK+xRPzpu4D/co+RoooDXukznrRMXr+hqk+2hzxfr0BcukexhJoJipq3VOXfXpyBH6OYeidkXS/QvT7ipoTNwdwCUHz0TL7s/FwAuuNUPbWUDYnnzzVD5TuQKUAqkouJihxT9l5CkWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668579; c=relaxed/simple;
	bh=uCCRHVYmLHnVIHIfW2LIcrxaWMtn8F9W0Bsnsn29gCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKF0+0GYpimng6+QM95dvM+sTAcaatfWjQjWEepO/Zmms9s/pKubhFE28s+uz6FXWUjG9KAozohMerSNQ3EIn/Ejut1AxufIhD6nG61o9oxyXmtA5weMuv60xztnhAfsSotRoFJKXCCDnC3q+2zirDxLbUZggLZM3sS3vtfdY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9wV45dK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CD7C4CEE4;
	Mon, 19 May 2025 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747668579;
	bh=uCCRHVYmLHnVIHIfW2LIcrxaWMtn8F9W0Bsnsn29gCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9wV45dKUYE6L1fQRHxtUR36FqYI06U10ckeN/TAvNwUd8uL55aN/sYGth9BlQ1tz
	 iCdSue1+RZ3TESlRVsbhkKWJegIKlrslAFKyU/1k+B2HDWwP8Tndvb52/6B85MY5Mp
	 iI1JXaNewFI51TbuMGDEiKsVg4ZmEhMUm16UUVbTPACYdk+meH+ZnhSl6hK7B4ibow
	 aTn6P53qMqqX0h5bDY9WpdDlTEcNaNE7uLHhuVNUJkm3EHqWWzupB42/4diyz4BIgz
	 uVqgReW0I4qRcguFbhstsFBGOhymzWeEhe5nv2Sz6Wx1HbdtHISmI2nRuZ0EGPX70y
	 n6TluvsQ00wPg==
Date: Mon, 19 May 2025 10:29:37 -0500
From: Rob Herring <robh@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <20250519152937.GA2227051-robh@kernel.org>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
 <20250514154248.GA2375202-robh@kernel.org>
 <20250515035338.GA4955@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515035338.GA4955@ranerica-svr.sc.intel.com>

On Wed, May 14, 2025 at 08:53:38PM -0700, Ricardo Neri wrote:
> On Wed, May 14, 2025 at 10:42:48AM -0500, Rob Herring wrote:
> > On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> > > On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > > > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > > > get different rules than all other bindings... or this does not have to
> > > > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > > > 
> > > > > > > > Why do you need compatible in the first place?
> > > > > > > 
> > > > > > > Are you suggesting something like this?
> > > > > > > 
> > > > > > > reserved-memory {
> > > > > > > 	# address-cells = <2>;
> > > > > > > 	# size-cells = <1>;
> > > > > > > 
> > > > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > > > 	}
> > > > > > > 
> > > > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > > > phandle?
> > > > > > 
> > > > > > Yes just like every other, typical reserved memory block.
> > > > > 
> > > > > Thanks! I will take this approach and drop this patch.
> > > > 
> > > > If there is nothing else to this other than the reserved region, then 
> > > > don't do this. Keep it like you had. There's no need for 2 nodes.
> > > 
> > > Thank you for your feedback!
> > > 
> > > I was planning to use one reserved-memory node and inside of it a child
> > > node to with a `reg` property to specify the location and size of the
> > > mailbox. I would reference to that subnode from the kernel code.
> > > 
> > > IIUC, the reserved-memory node is only the container and the actual memory
> > > regions are expressed as child nodes.
> > > 
> > > I had it like that before, but with a `compatible` property that I did not
> > > need.
> > > 
> > > Am I missing anything?
> > 
> > Without a compatible, how do you identify which reserved region is the 
> > wakeup mailbox?
> 
> I thought using a phandle to the wakeup_mailbox. Then I realized that the
> device nodes using the mailbox would be CPUs. They would need a `memory-
> region` property. This does not look right to me.

That doesn't really make sense unless it's a memory region per CPU.


> > Before you say node name, those are supposed to be 
> > generic though we failed to enforce anything for /reserved-memory child 
> > nodes.
> 
> I see. Thanks for preventing me from doing this.
> 
> Then the `compatible` property seems the way to go after all.
> 
> This what motivated this patch in the first place. On further analysis,
> IIUC, defining bindings and schema is not needed, IMO, since the mailbox
> is already defined in the ACPI spec. No need to redefine.

You lost me...

You don't need to redefine the layout of the memory region as that's 
defined already somewhere, but you do need to define where it is for DT. 
And for that, you need a compatible. Do you know where it is in this 
case? 

Rob

