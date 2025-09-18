Return-Path: <linux-hyperv+bounces-6934-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FEB832FB
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 08:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C2722177
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163B2D781B;
	Thu, 18 Sep 2025 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sEzj5eZ4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA21C2DB2;
	Thu, 18 Sep 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178055; cv=none; b=QEm4EkPWWwvXtA6zuGzikfAAc5cU/+mw8Tw82/g1KDNrek2H+huRZVQRLAi2B44y/AIWF68pog75vEAtmZEEptdRw99xXrLlEzo1CyFj6xfXR0/vAU6O7vpXfabIbimzyJr8YDvmpWL+PiEfz9hjX3i4bvYKi8OHl+zmf6/TpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178055; c=relaxed/simple;
	bh=YaKhVgDvwr9JPKuc3hZI+6/bsb98qd15/IffmqaG3iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7mmqi7x45vh6PPwJjIuFOm0Ytld7P1RyUzo0M7/0AwkfYebIJjkCjW8isz5J/BxcjaRCm5kup3aHnSddPeF0avNJtCpllPpuMb4ZSeO/X3v+J5j0oqvUryhZ3v5IwN/RC2I8F9Dkjz8zH0yfSlklcLoorTsRfMGVBdSZJtZ5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sEzj5eZ4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CposgJXI3x1arAtU/+MtP6/ScCDf4pgQyvJTMsCWetg=; b=sEzj5eZ4Iq66+wDHvCOa2ezHNN
	dhUt98bwlhiW6QUoD9o4YtIAUFGMOySJGjHxhvubm8EFeo+mTq7QZMdFUvmkaVCUV1EaIGFwb8AOr
	ve2prDuso+70mzmB/Ap4IefSiwQeMuwFcU16plrRtu04DE3XDcWM9y8yINtaW1mnR3d4H2UgYlSFH
	tzZDFJM0brYaTYaZ5VZXzQFyXEMQM2/b7DqzDeCTWFFYoYLSlAizydE843z0aoA/V6X1mzpL1uqJH
	ZU8wLW4HDRwdI/YPP/1unbW2AVFvI4r3COf1VHC4J9LaEy/VnaBFT0QOve3B3l9srKwCPNPsWFjea
	VQEpuBJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz8QE-0000000EAZv-1kLv;
	Thu, 18 Sep 2025 06:47:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2EC0300328; Thu, 18 Sep 2025 08:47:13 +0200 (CEST)
Date: Thu, 18 Sep 2025 08:47:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Message-ID: <20250918064713.GW3419281@noisy.programming.kicks-ass.net>
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
 <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
 <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com>
 <aMl5ulY1K7cKcMfo@google.com>
 <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>

On Thu, Sep 18, 2025 at 11:33:18AM +0530, Naman Jain wrote:

> Thank you so much Sean and Paolo for your valuable inputs. I will try
> out these things. Summarizing the suggestions here:
> * Use noinstr (no instrumentation)
> * Have separate .S file
> * Don't use "register asm".
> * Use static calls for solving IBT problems
> * RAX:RCX is probably ok to be used, considering ABI. Whether we would still
> need to use STACK_FRAME_NON_STANDARD, I am not sure, but I will see based on
> how it goes.
> 
> I hope this addresses the concerns Peter raised. If there's anything I might
> have missed, I'm happy to make further adjustments if needed.

It would be a definite improvement. I'm just *really* sad people still
create interfaces like this, even though we've known for years how bad
they are.

At some point we've really have to push back and say enough is enough.

