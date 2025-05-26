Return-Path: <linux-hyperv+bounces-5660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8AAC3A3F
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B55167889
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFDD1DE8A8;
	Mon, 26 May 2025 06:54:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1A148832;
	Mon, 26 May 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242496; cv=none; b=NZIv3hpA+3lfzgrdkSSSbHjFBzypZL0x4o2PL3u1l0hGD21EIFkVeX4CyLrIej3ZBOACRTwqDQRTTSWIdW4d8+QMWvM5RC0dbFl2a8y7vZIgUWpSbcd7Uv/HIlE5AloGJJeGWE9CmEMtXC08Whcd0W3IazuSzkHbI5vHBLJYctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242496; c=relaxed/simple;
	bh=MdTOaq3posLXtFIw77bYtXg1zoLZtm5ps1W3lVWfd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEvsSJWLclh6Zm43vdoS6NG2KES6TY94ZUKtn/MmoLKO9pDhe8jCA3Nh/tGAtNnlPh6V0hyvUg/hlgIxLZcvLzQZcuJSM1Jey//B618kx53T3+g3VlH1z8jXtBTsxPs9banvsHQhQYZkooZxvXFnXqNic8FeOzftzno3cruyI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9583068AFE; Mon, 26 May 2025 08:54:48 +0200 (CEST)
Date: Mon, 26 May 2025 08:54:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: simona@ffwll.ch, deller@gmx.de, haiyangz@microsoft.com,
	kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	akpm@linux-foundation.org, weh@microsoft.com, tzimmermann@suse.de,
	hch@lst.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
Message-ID: <20250526065448.GB13065@lst.de>
References: <20250523161522.409504-1-mhklinux@outlook.com> <20250523161522.409504-4-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523161522.409504-4-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 09:15:21AM -0700, mhkelley58@gmail.com wrote:
> Commit 37b4837959cb ("video: deferred io with physically contiguous
> memory") from the year 2008 purported to add support for contiguous
> kernel memory framebuffers. The motivating device, sh_mobile_lcdcfb, uses
> dma_alloc_coherent() to allocate framebuffer memory, which is likely to
> use alloc_pages(). It's unclear to me how this commit actually worked at
> the time, unless dma_alloc_coherent() was pulling from a CMA pool instead
> of alloc_pages(). Or perhaps alloc_pages() worked differently or on the
> arm32 architecture on which sh_mobile_lcdcfb is used.
> 
> In any case, for x86 and arm64 today, commit 37b4837959cb9 is not
> sufficient to support contiguous kernel memory framebuffers. The problem
> can be seen with the hyperv_fb driver, which may allocate the framebuffer
> memory using vmalloc() or alloc_pages(), depending on the configuration
> of the Hyper-V guest VM (Gen 1 vs. Gen 2) and the size of the framebuffer.

That langugage is far too nice.  The existing users of fb_defio are
all gravely broken because they violate the dma API restriction to
not poke into the memory.  You can't speculate what you get from
dma_alloc_coherent and it can change behind you all the time.

> Fix this limitation by adding defio support for contiguous kernel memory
> framebuffers. A driver with a framebuffer allocated from contiguous
> kernel memory must set the FBINFO_KMEMFB flag to indicate such.

Honestly, the right thing is to invert the flag.  What hypervs is doing
here - take kernel memory in the direct mapping or from vmalloc is fine.

What others drivers do it completely broken crap.  So add a flag
FBINFO_BROKEN_CRAP to maybe keep the guessing.  Or just disable it
because it's dangerous.


