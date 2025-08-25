Return-Path: <linux-hyperv+bounces-6583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36559B33B5C
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 11:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080A82031D6
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F72C21E8;
	Mon, 25 Aug 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWnmwHZ2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11764296BD5;
	Mon, 25 Aug 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114981; cv=none; b=RB2t+8+dYobfbaucJ5OC/0SvVBbx7rawHuJDCq+k0tySd+LRK3mu9rIMKfXh49mCpJM0YTAlKmJvjsmz0kfBw9lQoj8mZM7wGk8d3NzTnNOUB8E4WkdsFPMDMPI9FAAshU53y7suL5nenXmcLRTgdrEEcxiezwQV7hHaRiBJ/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114981; c=relaxed/simple;
	bh=1+qQB7fZg7XQL+78CuvZpDdk7j/rRf9BQo5bXxvOZV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYV8bcUOWtvAvsQd/MwfeizJwFlYBwdYmf+fLq6O+N8fOGruB6nt6rQdY6wc+fiYkPZ/tfHDujVXbcMWXoDsHMPOBZeumoA58QTpJStlvDm4lCWFeZOQexZbA2WP2HNNe6u7309s+Rqo3492sFsMG8WelZDIjXh8GTzDdnRCesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qWnmwHZ2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K6XMW61FIybEcJEXCSEYPaeDTcCOt8GzzEaQYgnNaKk=; b=qWnmwHZ2ja5mNfo6SvGrQYbttz
	3LrJsityDf3dEv75U9wbBiylENUvG8Few30vzzyfiz2Ekp2HlUy8JVs03R4FID1D3YNCIR6FuIVQ8
	MynRLG7I3pwXY1jwLk1VSPwwyM5mOiuJS/P+DIYrrDq9l4QS/mHhc0gfJ/3sXCM6VKEnN1qkbYFUC
	rx/++j+c46MSjQRwncsbZ9kkXZKn9PhvmBmwTNXBGV9rx7dPNVovZSSOJap0dr5QeXJ329r+h1mtI
	yTfLleBlqa6vDmFf2CHj9jjg8oY2l514ef7aRNPrbwqxc76J1e83kCpfzZtjxZDHI0xqs2qCSOlLn
	bvSe47LQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTix-0000000AOX9-0wei;
	Mon, 25 Aug 2025 09:42:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 69B613002ED; Mon, 25 Aug 2025 11:42:47 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:42:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Message-ID: <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825055208.238729-1-namjain@linux.microsoft.com>

On Mon, Aug 25, 2025 at 11:22:08AM +0530, Naman Jain wrote:
> With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
> config checks were added to conditionally restrict export
> of hv_hypercall_pg symbol at the same time when a usage of that symbol
> was added in mshv_vtl_main.c driver. This results in missing symbol
> warning when mshv_vtl_main is compiled. Change the logic to
> export it unconditionally.
> 
> Fixes: 96a1d2495c2f ("Drivers: hv: Introduce mshv_vtl driver")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Oh gawd, that commit is terrible and adds yet another hypercall
interface.

I would argue the proper fix is moving the whole of mshv_vtl_return()
into the kernel proper and doing it like hv_std_hypercall() on x86_64.

Additionally, how is that function not utterly broken? What happens if
an interrupt or NMI comes in after native_write_cr2() and before the
actual hypercall does VMEXIT and trips a #PF?

And an rax:rcx return, I though the canonical pair was AX,DX !?!?

Also, that STACK_FRAME_NON_STANDARD() annotation is broken, this must
not be used for anything that can end up in vmlinux.o -- that is, the
moment you built-in this driver (=y) this comes unstuck.

The reason you're getting warnings is because you're violating the
normal calling convention and scribbling BP, we yelled at the TDX guys
for doing this, now you're getting yelled at. WTF !?!

Please explain how just shutting up objtool makes the unwind work when
the NMI hits your BP scribble?

All in all, I would suggest fixing this by reverting that patch and
trying again after fixing the calling convention of that hypercall.


Yours grumpy..

