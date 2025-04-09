Return-Path: <linux-hyperv+bounces-4838-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B14A822C1
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63518A1ABD
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87A25DAE7;
	Wed,  9 Apr 2025 10:51:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186225D8E7;
	Wed,  9 Apr 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195864; cv=none; b=UmHczxBAwns+j9CMYWRiaLOB2rFd4IvMfYrKGfdrsvdUa45Cc4w0avAQLMXbtWE2SuNsGw6X4fFsjr3yHjO6H/gesQZhJfsI8p9O9YBFwkoy0KrBceKMhIiuWjoA/DHkMOcxanyJMU2mVXwe+GYL2VeK3Q9+EWlhCKyzoUfT3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195864; c=relaxed/simple;
	bh=dyH26E3PrUyWDV8GXzVKFZc7FnGFYOe7HH2gPbAp+hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRyURfe6OHNcMyRIa6G0l/p0XPf6xAQRmcYLwT+pspkWVh0hVGOOq3eMZGeWaB+JaOBXX3oU2Zhc8VEW7e8FHdGDKb/WrI2RzwMEBmMRLoPF10KfkUs9vQO8kqICCAzy8fKJ2YXY/ITlaIVIygY0SK08TFtRWdoNhaJTclHaPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B3D568BFE; Wed,  9 Apr 2025 12:50:59 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:50:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: jayalk@intworks.biz, simona@ffwll.ch, deller@gmx.de,
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, akpm@linux-foundation.org, weh@microsoft.com,
	tzimmermann@suse.de, hch@lst.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
Message-ID: <20250409105058.GB5572@lst.de>
References: <20250408183646.1410-1-mhklinux@outlook.com> <20250408183646.1410-3-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408183646.1410-3-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 11:36:45AM -0700, mhkelley58@gmail.com wrote:
> In any case, for x86 and arm64 today, commit 37b4837959cb9 is not
> sufficient to support contiguous kernel memory framebuffers. The problem
> can be seen with the hyperv_fb driver, which may allocate the framebuffer
> memory using vmalloc() or alloc_pages(), depending on the configuration
> of the Hyper-V guest VM (Gen 1 vs. Gen 2) and the size of the framebuffer.

And neither is this code.  You need to provide the functionality at
the DMA layer as users must not poke into the returned DMA coherent
memory.


