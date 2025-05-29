Return-Path: <linux-hyperv+bounces-5695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5072AC7E7E
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 15:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15153A621B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C62222C0;
	Thu, 29 May 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCNZ1FAy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC9647;
	Thu, 29 May 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524597; cv=none; b=hpu+7/UmjPV4YoHuHpSPV0Q4pscXmpS/+XGmelQnuNWoF9kz2bzI6uLP1uaU16VVrXZoe4D5So6rEHXiu9XbXwTd8tv/LeM75lj5/3pgyGLDnxJtl8WF4jXkrPMq+kiNp9Z87Bfuzx4Y5XGbHClG+Acnd0p1J/DYYz/H/tsYQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524597; c=relaxed/simple;
	bh=xkKd2cHk1cf4Qy841VN5k/WKdVh7gnj+gaE9jytpkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayS6K1xhX/Zv8pBTXg5vSRGLv5suUO9c2eZ86fSM0TuNM7Q7Wq0czmzIyhA4ro+5my1AqbAEsNZq29ZJB4LWquAWz3w0Smmt5NteS752VHBg+bnidxUg2Rav3PWyQl9PdIPCenIHGoOfRaacJj+hQsLpyzF9vzf5NUxxqw4k5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCNZ1FAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D1C4CEE7;
	Thu, 29 May 2025 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748524596;
	bh=xkKd2cHk1cf4Qy841VN5k/WKdVh7gnj+gaE9jytpkNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCNZ1FAy8MUohtLLaV44gqwnrFik752j5osN5fjTHMGtT9qHFSEAi83KPe3RpUshN
	 nqfFRZzwJz1Je65+SS6T6hflk5GngvPcSWDOhxQaUjM6LvaezVxef8FWH6Bd8slDoL
	 0nuvceJWfXPXcLKfQj98TB0Bp+LdpO2mNpQjzHh/bRHTXrvX8DV10atLopNj3EJGvd
	 /+7pJSL9tKH2tzRk8AzeP7jTNKjJvCUBPUygGPZK4HCjZwxi8C9OjXZSNMoQjnnv1w
	 YoYvENXwjznj2VL1hs2ktvaCX1adX1VPwZPokaDZz8pKQNMEgizqTsuDtjeIaj4JiE
	 ol3UYYZDaangQ==
Date: Thu, 29 May 2025 08:16:34 -0500
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
Message-ID: <20250529131634.GA2784667-robh@kernel.org>
References: <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
 <20250514154248.GA2375202-robh@kernel.org>
 <20250515035338.GA4955@ranerica-svr.sc.intel.com>
 <20250519152937.GA2227051-robh@kernel.org>
 <20250519175606.GA9693@ranerica-svr.sc.intel.com>
 <20250524155650.GA16942@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524155650.GA16942@ranerica-svr.sc.intel.com>

On Sat, May 24, 2025 at 08:56:50AM -0700, Ricardo Neri wrote:
> On Mon, May 19, 2025 at 10:56:06AM -0700, Ricardo Neri wrote:
> > On Mon, May 19, 2025 at 10:29:37AM -0500, Rob Herring wrote:
> > > On Wed, May 14, 2025 at 08:53:38PM -0700, Ricardo Neri wrote:
> > > > On Wed, May 14, 2025 at 10:42:48AM -0500, Rob Herring wrote:
> > > > > On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> > > > > > On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > > > > > > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > > > > > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > > > > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > > > > > > get different rules than all other bindings... or this does not have to
> > > > > > > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > > > > > > 
> > > > > > > > > > > Why do you need compatible in the first place?
> > > > > > > > > > 
> > > > > > > > > > Are you suggesting something like this?
> > > > > > > > > > 
> > > > > > > > > > reserved-memory {
> > > > > > > > > > 	# address-cells = <2>;
> > > > > > > > > > 	# size-cells = <1>;
> > > > > > > > > > 
> > > > > > > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > > > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > > > > > > 	}
> > > > > > > > > > 
> > > > > > > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > > > > > > phandle?
> > > > > > > > > 
> > > > > > > > > Yes just like every other, typical reserved memory block.
> > > > > > > > 
> > > > > > > > Thanks! I will take this approach and drop this patch.
> > > > > > > 
> > > > > > > If there is nothing else to this other than the reserved region, then 
> > > > > > > don't do this. Keep it like you had. There's no need for 2 nodes.
> > > > > > 
> > > > > > Thank you for your feedback!
> > > > > > 
> > > > > > I was planning to use one reserved-memory node and inside of it a child
> > > > > > node to with a `reg` property to specify the location and size of the
> > > > > > mailbox. I would reference to that subnode from the kernel code.
> > > > > > 
> > > > > > IIUC, the reserved-memory node is only the container and the actual memory
> > > > > > regions are expressed as child nodes.
> > > > > > 
> > > > > > I had it like that before, but with a `compatible` property that I did not
> > > > > > need.
> > > > > > 
> > > > > > Am I missing anything?
> > > > > 
> > > > > Without a compatible, how do you identify which reserved region is the 
> > > > > wakeup mailbox?
> > > > 
> > > > I thought using a phandle to the wakeup_mailbox. Then I realized that the
> > > > device nodes using the mailbox would be CPUs. They would need a `memory-
> > > > region` property. This does not look right to me.
> > > 
> > > That doesn't really make sense unless it's a memory region per CPU.
> > 
> > Agreed.
> > 
> > > 
> > > 
> > > > > Before you say node name, those are supposed to be 
> > > > > generic though we failed to enforce anything for /reserved-memory child 
> > > > > nodes.
> > > > 
> > > > I see. Thanks for preventing me from doing this.
> > > > 
> > > > Then the `compatible` property seems the way to go after all.
> > > > 
> > > > This what motivated this patch in the first place. On further analysis,
> > > > IIUC, defining bindings and schema is not needed, IMO, since the mailbox
> > > > is already defined in the ACPI spec. No need to redefine.
> > > 
> > > You lost me...
> > > 
> > > You don't need to redefine the layout of the memory region as that's 
> > > defined already somewhere,
> > 
> > Great!
> > 
> > > but you do need to define where it is for DT. 
> > > And for that, you need a compatible. Do you know where it is in this 
> > > case?
> > 
> > The compatible is not defined anywhere yet. Is a DT schema needed to
> > document it? If yes, I am usure what to put in the description. We tried
> > to not redefine the mailbox and refer to the ACPI spec. That was a NAK
> > from Krzysztof [1].
> > 
> > [1]. https://lore.kernel.org/r/624e1985-7dd2-4abe-a918-78cb43556967@kernel.org
> 
> In summary, documenting the `compatible` property for the mailbox is
> necessary. There is no need to redefine the malbox on a schema but
> referring to the ACPI spec is not acceptable.

There's the whole "DT bindings in ACPI systems" where ACPI tables 
contain compatibles and DT properties which I think is what 
Krzysztof was objecting to (and I do too). But this is a DT based system 
that implements a mailbox region defined in an ACPI spec. That is 
perfectly fine to refer to.

> 
> What about referring in the schema to the Intel TDX Virtual Firmware Design
> Guide[2]? It describes how firmware should implement the mailbox the section
> 4.3.5.
> 
> A mailbox with compatible = "intel,wakeup-mailbox" is implemented after the
> guide that Intel published.

Use whatever you think best describes the programming model of the 
region.

Rob

