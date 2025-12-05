Return-Path: <linux-hyperv+bounces-7985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD15CA995C
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Dec 2025 00:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1E13019B52
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F07A21D3C0;
	Fri,  5 Dec 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHn4HStH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA73B8D70;
	Fri,  5 Dec 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976312; cv=none; b=r3gwWfiQHhdDMgt+oc1bFqik1Zn8lNtM1ULWUhqYTqwl4f0P6lUjbdxhZyr8uXK5QQt/Xnu1GGS9bMLU4bMrB9dfnqh2TlRQmbdZofkvFpNg1qdVD898wUUHbGPQEgm/DwHLRmN0xq1vRsSuWexhzenFayiJPCD/CLZ0rwFnsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976312; c=relaxed/simple;
	bh=XW0inPF1Lz6EWg1s96WLsGJCu3j/oPQ1I7OUorWxrWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trYLDxNwXfX2FuB4Q3tTePB5Eor/NGZi8jVuam/H2obqCrCTWpVsxjt/ftTJXgBxEW9P54kDSrJPQgwJiyTtltweDjgQhSoSDF3p5OwXamWG0EB4rcOwh9oBm5Um+5WQuSrjjcXWk/A9nsuvFWYq4Qhyf5UupMvAnp+bmKDkRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHn4HStH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89611C4CEF1;
	Fri,  5 Dec 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764976311;
	bh=XW0inPF1Lz6EWg1s96WLsGJCu3j/oPQ1I7OUorWxrWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHn4HStHYxZsqvBsA+Y1ppy1+C+g+mTU4j2GoPEG7RQEBzr751AXKHRxO1MyfQqmE
	 eEVICbUeO2gh+2cNL7NT6OXyo/8zf9SodACROpOwRHAScvUsfSwduHbGFRSRs56krg
	 t/T5HJjRyby9BTUTMmFmP1CMaYhAK10JO+1OLK4kQXbOEnjLYpmKPoc6dFsTFAyH1j
	 CRPkRTD68xOtFl7DCJzZjY7aeZ0NG5UnD4BVbX/m02l/4J4ZoENtsvSNtlBXcMA4i/
	 HsGN1uYkYZCgvHNiKxsXD5UlSg+mWRtBybbldJuFqazh70gPy2czxew98Ving8wC86
	 pY/c6ubdXkG/w==
Date: Fri, 5 Dec 2025 23:11:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v7 1/4] fixup! Drivers: hv: Introduce mshv_vtl driver
Message-ID: <20251205231150.GC1942423@liuwe-devbox-debian-v2.local>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
 <20251205201721.7253-2-prapal@linux.microsoft.com>
 <20251205230624.GA1942423@liuwe-devbox-debian-v2.local>
 <20251205230806.GB1942423@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205230806.GB1942423@liuwe-devbox-debian-v2.local>

On Fri, Dec 05, 2025 at 11:08:06PM +0000, Wei Liu wrote:
> On Fri, Dec 05, 2025 at 11:06:24PM +0000, Wei Liu wrote:
> > Please provide a proper commit subject.
> > 
> > On Fri, Dec 05, 2025 at 02:17:05PM -0600, Praveen K Paladugu wrote:
> > > Drop the spurios "space" character in Makefile condition check
> > > that causes mshv_common.o to be built regardless of the CONFIG settings.
> > > 
> > > Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> > > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > 
> > This should come with a Fixes: tag.
> 
> Since the bug is not in any released kernel, so it is not needed.
> 
> I don't want to squash this though. So the request to have a proper
> subject line still stands.

Never mind. I can fix this myself. There is no need to have another
round.

Wei

