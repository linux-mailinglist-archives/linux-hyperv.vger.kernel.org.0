Return-Path: <linux-hyperv+bounces-5399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F2AAD5F2
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632B4983963
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66B205E3B;
	Wed,  7 May 2025 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE08zf1V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E711D63C0;
	Wed,  7 May 2025 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599026; cv=none; b=N9PRRgJnjZtPdaGyMB2HKXIwj8la6AJ8Wn41gsGyLV0N1ofHxarRUj3fBqED7n/B/Xnwq/kMcbBmXyk6zbYLB7nTxOsUCy62cPPKB77cPwDTSaa6JYMPSVyByMwtCQaRvdORoNSuQzGneNNg9fAnX48Yx6o1j7XB7ksehFvl2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599026; c=relaxed/simple;
	bh=dgrSBqibv6ETKNx9aChIVq4jh5ZGpoK9U31PwqgzO9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsrFRUwPB8xH/r/UQ1G/+qCkUOVeqV90Xm1Kp537Dt14L9s2wTcSvqoAFBkmsH34aQLC41nipb4J8tnhKIW9O5+YGLHw8lHCTlYdkwz7WKXaT9/C6locuXns2GlxqjGtKEErWDNt5j74xI7CnoPVsoav/N3rHLmgHeE2FdSA450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE08zf1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED01C4CEE7;
	Wed,  7 May 2025 06:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746599026;
	bh=dgrSBqibv6ETKNx9aChIVq4jh5ZGpoK9U31PwqgzO9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jE08zf1VJ4EVbUvVJ+gf3yOK+QnBOnbBa7dNVSRpg4tCuf3mjYUXeu6qZ/AfV3edJ
	 EEGw4XJLJdr4M9eb6UGL21Ojt0vCGfk0E/4R5+UbfOXcsi1UEuu8i7pLT4DNMgaL6h
	 v4LuXrqKJPQCargXmLkWmYSt2CNP+TOAHEVNSLth1gjdP8lt/S89FZLLzeH+s8Pv8+
	 QSfJ7VogA1iN0uB4T6NzEz5c0bLLwiP9+YzyIAgCCikYLRKbkZr5qROLBTPwvkIPVd
	 iC1yEu4TJRaWxg3eYKpAo7FRCPbUe468+E7XG6VYjZgK9bDyGoRQnedWzJCA1AyNn9
	 mp2bnYzU+gcBw==
Date: Wed, 7 May 2025 06:23:44 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jgross@suse.com,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
	nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com,
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com, tony.luck@intel.com, wei.liu@kernel.org,
	xin@zytor.com, yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBr8cNXD630JbIxP@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>

On Tue, May 06, 2025 at 02:58:34AM +0000, Wei Liu wrote:
> On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
> > When starting APs, confidential guests and paravisor guests
> > need to know the CPU number, and the pattern of using the linear
> > search has emerged in several places. With N processors that leads
> > to the O(N^2) time complexity.
> > 
> > Provide the CPU number in the AP wake up callback so that one can
> > get the CPU number in constant time.
> > 
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Queued to hyperv-next. Thanks.

This patch broke linux-next. I have dropped it. Please change
numachip_wakeup_secondary.

Wei.

