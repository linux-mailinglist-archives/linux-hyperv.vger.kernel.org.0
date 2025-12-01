Return-Path: <linux-hyperv+bounces-7910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A50C98B53
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 19:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885633A4351
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C15338590;
	Mon,  1 Dec 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ghWnJWTp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB233858A;
	Mon,  1 Dec 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613618; cv=none; b=FIx3VJr6SwTBJhHqZgB4cHv6lo53lSXQQ1sZ2uu3AatCUR9ow+sBGQ8h2S7fxu5EkwuY6Nsgiwc5BjWftMp8OBl806vSTNByk1YOSOW9L8IBJoeUD7dZOSuTtO6VJkW0faF0cPXPmfURs5tOrEGY2WqWd51SQg3fB5dTXPdkxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613618; c=relaxed/simple;
	bh=CgFJ4QUr8AaBrr9T2aC6PpKxqJJBahQ51gbfPjUxZ/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukwnWU5IZw6hSaVAXS/gN5jer+wShZEx2yyBkeHm5sXo2Rve/oWCr+fuWF21D+bdr1REfqa+cZFs48Xi5IwW43c5V1cEGVle0X6Pl7sZUHITOYIdtIjD99klgvdNbg499NXPS+3UsNLlnlwgkRbUC66/YaGmhwZGScIQFq573Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ghWnJWTp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA5AA201A7C8;
	Mon,  1 Dec 2025 10:26:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA5AA201A7C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764613616;
	bh=pt6WLygOz9yPQCW5bO4V3L0zzdG9D795/IwWETgHRwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghWnJWTpZLuwUNNviSDjPq5w4j1VVojMAZV0nq9ReljxsAp0e9RAukDyedTR7WSvd
	 fj+rGtzOXa8qHe7tpzaruExNasxHSYLZAz+mJHhnkuSpNoJ5O5c4UpYHYIxrFDQhTo
	 RhflHOCWp36BoKF53Vkid47ZcRdRI6In94h7VDAA=
Date: Mon, 1 Dec 2025 10:26:53 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Message-ID: <aS3d7Ybs2iS4qo13@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <aS2vtXBx9uJ2U7F1@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS2vtXBx9uJ2U7F1@anirudh-surface.localdomain>

On Mon, Dec 01, 2025 at 03:09:41PM +0000, Anirudh Rayabharam wrote:
> On Wed, Nov 26, 2025 at 02:09:11AM +0000, Stanislav Kinsburskii wrote:
> > The previous code assumed that if a region's first page was huge, the
> > entire region consisted of huge pages and stored this in a large_pages
> > flag. This premise is incorrect not only for movable regions (where
> > pages can be split and merged on invalidate callbacks or page faults),
> > but even for pinned regions: THPs can be split and merged during
> > allocation, so a large, pinned region may contain a mix of huge and
> > regular pages.
> > 
> > This change removes the large_pages flag and replaces region-wide
> > assumptions with per-chunk inspection of the actual page size when
> > mapping, unmapping, sharing, and unsharing. This makes huge page
> > handling correct for mixed-page regions and avoids relying on stale
> > metadata that can easily become invalid as memory is remapped.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_regions.c |  213 +++++++++++++++++++++++++++++++++++++++------
> >  drivers/hv/mshv_root.h    |    3 -
> >  2 files changed, 184 insertions(+), 32 deletions(-)
> 
> Except the warning reported by kernel test robot:
> 

This one is a good catch.
I'll fix it in the next revision.

Thanks,
Stanislav

> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

