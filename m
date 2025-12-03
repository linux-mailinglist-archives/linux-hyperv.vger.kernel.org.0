Return-Path: <linux-hyperv+bounces-7956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D2CA1C30
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 23:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B430D3004526
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B582C11DB;
	Wed,  3 Dec 2025 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VjIKDdAU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904262DEA8E;
	Wed,  3 Dec 2025 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799299; cv=none; b=MzvabeKbydYzyQDIZjsBhIFZPwQsl9nNDz+rmHCeR1C9BANnhm2tXlWLmNK+3l7rSdCAd+U5S3OE3X7xqOZ1pM8FoEYq3UrDnJ/DARNcefLsk2ejQ5uGiJl2ANWhkYivNQee10bvQpsIdnEk3AbNqODbaOF9su7/V2kklLlOY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799299; c=relaxed/simple;
	bh=ChlI78Y8DsJurMwbO2PzqzEM53mlr8Y1tpkFfGnJwM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZtlkIOD/gHcKttS7owuSnC375PRnFX5xYqCVA1QPpfqRCCO3Zh/PgA2pstJcxPU2u2Luvs3eqJDzmmGiH6adU9SnwRuDZ50bC5BU3DwT7S3DPh8qtI7y86or9awljkbgoLbtzFZUh2e2fVGWRbssBJZoS9RGlJ3RKnrO7B6vro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VjIKDdAU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id B47282120E8D;
	Wed,  3 Dec 2025 14:01:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B47282120E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764799298;
	bh=w607UIgbasPVaDFHzCIOQluQGi6L0xK00Q1qG3s10Q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VjIKDdAUAwxklYID2KebJ0dOeNFBbWUMW/hTd0+9e/UNZOqi6p1FeP/OPwlsQG+13
	 6ThVYkmgVdUctHqv+cWCIHHpCUBziQK0Yfhrltybi8ZK3vwSIgdnrZe883qKJU8NQF
	 cLCouvIvmBx+R7fXXxog34Cc2l6dVBPS3hkCdttI=
Message-ID: <dbf09a6c-4ac6-489e-92f5-7a52b2907d20@linux.microsoft.com>
Date: Wed, 3 Dec 2025 14:01:36 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] Drivers: hv: Fix huge page handling in memory
 region traversal
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176479805682.304819.16453923977474855999.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176479805682.304819.16453923977474855999.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 1:40 PM, Stanislav Kinsburskii wrote:
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
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_regions.c |  219 +++++++++++++++++++++++++++++++++++++++------
>  drivers/hv/mshv_root.h    |    3 -
>  2 files changed, 191 insertions(+), 31 deletions(-)
> 
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

