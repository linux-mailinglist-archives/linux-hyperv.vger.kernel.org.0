Return-Path: <linux-hyperv+bounces-5507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39473AB7029
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15644A1C99
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194B221DA8;
	Wed, 14 May 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo1ZHMXs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4E17C21E;
	Wed, 14 May 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237370; cv=none; b=GBvRYeqE5RoKj0Cc9Cjtws6X3y6K8QJIR+iItA62R6u/sClSWeerfYpu/sUDhdqcHdLum7jZTEtmgI6EprQukDgFFbzmNxIbbjv6/L7BolOMb/4Dmrgz/A5Lwaeexcd3eNfV18VN7nK2I8188Wi2ZsP5DTbNxr1alYcoJFKElU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237370; c=relaxed/simple;
	bh=8Q3GS/cE2O7eBZLJtN9ohT0WUIQHA1/8U9DTHoGBJJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfySq7Qheib5LTwwET/q5fK4Pa/VRCGP9jWpQuE+nqh5AbJKpy9eSxCeS6ZsBFpf0dfZp3KHRXy1o3VS4xDSBeUQO6lfUX4qJ2Yvwsc3wmh3r6rcQnFzNAKmlr7VODHavBddFrZDRKWzl+XiD0SeTnpu6n5J0U/nCQOhyAnbdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo1ZHMXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA13C4CEE9;
	Wed, 14 May 2025 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747237370;
	bh=8Q3GS/cE2O7eBZLJtN9ohT0WUIQHA1/8U9DTHoGBJJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zo1ZHMXsl/mnIRjo1/GoEKeVZnQbzs/Px88YCiU+xh4ZOfyIlr6SuUJoep8Uig7EW
	 foBSaYrx5t5xYbveMW33lIB66H3d98EnZz+R/Ut7GgNwV8EJM5irr0/6JVfs4f1Rv2
	 9Yg6t56nf8s6vt4SfTY6lR4uR0P0DpUQAJod5KH/03denAqUOPGlUTfzZH4ssiTeI0
	 Asveuu4/hSeuyeYG6F6mejeeYzjB/BgdjQnmeVqS1NXZggxYW5v9VgxuOFjbjiUCzP
	 4DBy1HEHwgav8vB+n1tr6QTw1v9aZrLfNSx7JnUSNiK7qLJRoq/FI8aj3cRKJARNR1
	 qrFdasRN+QBDA==
Date: Wed, 14 May 2025 10:42:48 -0500
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
Message-ID: <20250514154248.GA2375202-robh@kernel.org>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
 <20250513221456.GA2794@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513221456.GA2794@ranerica-svr.sc.intel.com>

On Tue, May 13, 2025 at 03:14:56PM -0700, Ricardo Neri wrote:
> On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> > On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > > get different rules than all other bindings... or this does not have to
> > > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > > 
> > > > > > Why do you need compatible in the first place?
> > > > > 
> > > > > Are you suggesting something like this?
> > > > > 
> > > > > reserved-memory {
> > > > > 	# address-cells = <2>;
> > > > > 	# size-cells = <1>;
> > > > > 
> > > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > > 	}
> > > > > 
> > > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > > phandle?
> > > > 
> > > > Yes just like every other, typical reserved memory block.
> > > 
> > > Thanks! I will take this approach and drop this patch.
> > 
> > If there is nothing else to this other than the reserved region, then 
> > don't do this. Keep it like you had. There's no need for 2 nodes.
> 
> Thank you for your feedback!
> 
> I was planning to use one reserved-memory node and inside of it a child
> node to with a `reg` property to specify the location and size of the
> mailbox. I would reference to that subnode from the kernel code.
> 
> IIUC, the reserved-memory node is only the container and the actual memory
> regions are expressed as child nodes.
> 
> I had it like that before, but with a `compatible` property that I did not
> need.
> 
> Am I missing anything?

Without a compatible, how do you identify which reserved region is the 
wakeup mailbox? Before you say node name, those are supposed to be 
generic though we failed to enforce anything for /reserved-memory child 
nodes.

Rob

