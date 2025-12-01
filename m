Return-Path: <linux-hyperv+bounces-7905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A8C97FA4
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 16:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE014E3455
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3A319619;
	Mon,  1 Dec 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="WV4F/rbs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7830CD92;
	Mon,  1 Dec 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601796; cv=pass; b=JAZp+RaY25evxg1xAMo0ViRwseHrq6q2OoBPX92Lc1JmyySIAHfzYoHHiQJv0/z6x+41ZXF7crb909dUHzaADYyBlKYwx3oscc0CtAcmIw8VdSHHlO6odCaS8AVDcFu1JSI7FYzSjYi7iWpuZlxLRbPpXcezr9gOSrKMRttxyUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601796; c=relaxed/simple;
	bh=b9V/HentkrydttaanK81l00qnngel32qaoNK8xQQuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2QnNDk8g0bNwcfAd5GAmbvX6XfTMpsf7xssE8WGutEZw8FNYWJ4rYwZlFLrT6X5EcmGk2pA+Xn6LweQ22VFsBsKqLb1O7a7qnfJzjyjBUIYQe6jUp4Ox7fSOfN8BY3dWbPuNiO3/aPtFQIVK4OFuOff9xEcTgruVqnVAa5cCZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=WV4F/rbs; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764601786; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KvaaHzvC49u6Du6UISzQyfq3vSa5xEkdeUeKyz8jz08FnClpQNd7LQvwW7MLq6PuhiSnelzQTyvI+eIPlTy8qizcx9jnfWaGFRZX3xGupxeanMVBWrvzLEZLqJfpBBlJe2eOAxdVLRyqnR9TcmUs5st2n8SslduGrAH+LdPB7xg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764601786; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7pco87CAyBAYizs6orM7NFNREqmVkiQ9U2l7QvkO6z8=; 
	b=T2GUCvpQE1UArvrFVO/zPbV+c6qJGNpnovbBu4wz7n780sI2BT0P7SdCgk2gxCMJ7DvfuKiG9mnhIy514joEFKHt1Zd48Pq4Nny/2QYwR5Zovh28P7J9Uxq6fw4kU7fgDL8Yx71GfdtBKhr0fT6gho+yUEbyQR2Oa+ZhatoK0/I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764601786;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=7pco87CAyBAYizs6orM7NFNREqmVkiQ9U2l7QvkO6z8=;
	b=WV4F/rbsaILqmo7ktMmjybp85uR9rmAclpbUijSzhG924KiFyfZ89MioA0bfKphU
	CO1kpC03DF/JgcBjQL1kUJm0Er5mRZsYGt2bcus5HrqceUuDr/eR0A9Yhd+SyGYS8AG
	OnJtfaIrmbybfWBs370j2AizCHCsG+s9cYSGAAP0=
Received: by mx.zohomail.com with SMTPS id 1764601783536667.4611361020376;
	Mon, 1 Dec 2025 07:09:43 -0800 (PST)
Date: Mon, 1 Dec 2025 15:09:41 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] Drivers: hv: Fix huge page handling in memory
 region traversal
Message-ID: <aS2vtXBx9uJ2U7F1@anirudh-surface.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412295155.447063.16512843211428609586.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 02:09:11AM +0000, Stanislav Kinsburskii wrote:
> The previous code assumed that if a region's first page was huge, the
> entire region consisted of huge pages and stored this in a large_pages
> flag. This premise is incorrect not only for movable regions (where
> pages can be split and merged on invalidate callbacks or page faults),
> but even for pinned regions: THPs can be split and merged during
> allocation, so a large, pinned region may contain a mix of huge and
> regular pages.
> 
> This change removes the large_pages flag and replaces region-wide
> assumptions with per-chunk inspection of the actual page size when
> mapping, unmapping, sharing, and unsharing. This makes huge page
> handling correct for mixed-page regions and avoids relying on stale
> metadata that can easily become invalid as memory is remapped.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c |  213 +++++++++++++++++++++++++++++++++++++++------
>  drivers/hv/mshv_root.h    |    3 -
>  2 files changed, 184 insertions(+), 32 deletions(-)

Except the warning reported by kernel test robot:

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


