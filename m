Return-Path: <linux-hyperv+bounces-7467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CFC413D7
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A24E3767
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79842C1583;
	Fri,  7 Nov 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2pao3pM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A6212550;
	Fri,  7 Nov 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539186; cv=none; b=dIHduXG27axfzsGMvhC59YL7ZurNCqXbwYa3vxPKD2gAHgjSbmFVVqR8UXUYDHRQzc/Mx7s9ndhd2i+KJy3HySLZbmBAboH6UKvoy0oYs172x4HMIg++cpOfyCMl2svTRrWeC1l4gL1J8vTFQZy9lXXW+jfb7KpDHgHP49eJEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539186; c=relaxed/simple;
	bh=RR7lu9FJJ0ENbKhrAzIi4AVTEmJIFbWEiFz8efPdFKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMWJxxJwMDWowBOYaNV5lHgb3hX6p5pBV+R6v14bk7/XZ/Ofthl5PEluWouR/1X/lq+cUVHYKUZlzWJhXQ4DyNwyh6gL+UtjlARkbs0NUewBOGBp6LfB2lx3FkClwT4OkahjnmXPtCd9NGxqfeHLVhxd61KoI5FrJpFnEB5L6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2pao3pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F3EC4CEF5;
	Fri,  7 Nov 2025 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539186;
	bh=RR7lu9FJJ0ENbKhrAzIi4AVTEmJIFbWEiFz8efPdFKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2pao3pMAAEzPVWpnrxmndQ/tRe7vbeHsvE28U4Hc7h/B946h4R3rw5pN2pvwBt49
	 g0P72i+moNM8qronkpYzNwsmDm9SWL0U0fAROYDmJzaIQiEenoaS2WnMGjpPUX/Xwh
	 vLev8Vaa1klWvU+3NJBruKaVkYUnc/wYZvS9dgXWN2pAzG9QOd8HXd7kly3iUo6eCD
	 7eukPfkqop5mEywANx9C612X/p7nK1BQ8jik6aI43fqcHZSlcZLPH5caKb+mFXT1h6
	 wOu0onbZsHlXx5eZDjNbxr9IvSttJlZj76pm6bsCNYqQQtKO5ToM3MBEzw5ZJ6Velw
	 Az1TYTnbLgWiQ==
Date: Fri, 7 Nov 2025 18:13:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, magnuskulke@linux.microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	skinsburskii@linux.microsoft.com, prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com, muislam@microsoft.com
Subject: Re: [PATCH v2 0/2] mshv: Allow mappings that overlap in uaddr
Message-ID: <20251107181304.GB4041739@liuwe-devbox-debian-v2.local>
References: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Nov 06, 2025 at 02:13:29PM -0800, Nuno Das Neves wrote:
> Currently the MSHV driver rejects mappings that would overlap in
> userspace. Remove this limitation as it is overly restrictive and
> allowing overlap is useful for VMMs.
> 
> Before make this change, fix the region overlap checking logic
> which is broken.
> 
> ---
> Changes in v2:
> - Add a patch to fix the overlap checking [Michael Kelley]
> - Move deletion of mshv_partition_region_by_uaddr() to the fix patch
> 
> ---
> Magnus Kulke (1):
>   mshv: Allow mappings that overlap in uaddr
> 
> Nuno Das Neves (1):
>   mshv: Fix create memory region overlap check

Applied to hyperv-next. Thanks.

> 
>  drivers/hv/mshv_root_main.c | 27 +++++++--------------------
>  include/uapi/linux/mshv.h   |  2 +-
>  2 files changed, 8 insertions(+), 21 deletions(-)
> 
> -- 
> 2.34.1
> 

