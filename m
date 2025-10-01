Return-Path: <linux-hyperv+bounces-7038-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6FBAF12D
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C9C194137B
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 04:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FA2D0C76;
	Wed,  1 Oct 2025 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wel6HjMr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E0267AF2;
	Wed,  1 Oct 2025 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759291437; cv=none; b=iMQ7bGT3sef25jnzaQMeLKZCccuPyZn5CqSOGKn9UECjj1tmP5iCl7BKZ2ejV5x4DOU8P/xcXkbDC2TIJG6UMA98otmwbls1/C7ORQcsTd8Ccv9binw50uZc+zS98druHOTqZkph9jvhcCEVhfqRZgKsNWlO6PFXjY4wT6XK2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759291437; c=relaxed/simple;
	bh=ESlTFPkgB0EPTMgq9Aq54wNBh5oiQSb+LzLFed1dL0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLjUJZhE+sp/zW43kfYwI5IdVDSO0YthN3T/kPPBtsyHkAZNBIxhi3hoPdTzCTP574xEE3EwsgWYBfC/OtfwmxBu7GlF7EqyawUrMQm5M+7XPXxs+bMaIAVJWkQ2SJBQ8yhdj7Z4fx+0+CP8shMcIk7rMiDOeMfoqYFslLLjmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wel6HjMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F63C4CEF4;
	Wed,  1 Oct 2025 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759291437;
	bh=ESlTFPkgB0EPTMgq9Aq54wNBh5oiQSb+LzLFed1dL0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wel6HjMrAbZVoTb1+N/gwvGgV7SKI/vCw6vSgyY7O5MwR5bhprTS+Jb5K7TIacsGN
	 +L+E1Usf2SHL+LtVp9Numa7Hzcy3APUh1Kd5uJoCtcPkDdzNWx4dtjdnQmoNd3KB1c
	 20kvB4KrCTtzisB6WnBceMkJ0YJwZxYuDwQISswLnw7OtcKP6pDKa/7+MXaQ21q6rJ
	 ODSaz7tBDB+z/broViFXGa2kxIc82GYzRqPhMnI52nJh4TerjV/F2/o3GkPih5VRv9
	 M5PjYFostUCEywcrpfZIvW3WvJyXONWx+FEr6If9QbYjboos53faFCYGPjh7TKDPBK
	 FGuwb3AVBYR0A==
Date: Wed, 1 Oct 2025 04:03:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce movable pages for Hyper-V guests
Message-ID: <aNyoK8xfgy2zpKCf@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175916156212.55038.16727147489322393965.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Mon, Sep 29, 2025 at 04:02:59PM +0000, Stanislav Kinsburskii wrote:
> From the start, the root-partition driver allocates, pins, and maps all
> guest memory into the hypervisor at guest creation. This is simple: Linux
> cannot move the pages, so the guest’s view in Linux and in Microsoft
> Hypervisor never diverges.
> 
> However, this approach has major drawbacks:
> - NUMA: affinity can’t be changed at runtime, so you can’t migrate guest memory closer to the CPUs running it → performance hit.
> - Memory management: unused guest memory can’t be swapped out, compacted, or merged.
> - Provisioning time: upfront allocation/pinning slows guest create/destroy.
> - Overcommit: no memory overcommit on hosts with pinned-guest memory.
> 
> This series adds movable memory pages for Hyper-V child partitions. Guest
> pages are no longer allocated upfront; they’re allocated and mapped into
> the hypervisor on demand (i.e., when the guest touches a GFN that isn’t yet
> backed by a host PFN).
> When a page is moved, Linux no longer holds it and it is unmapped from the hypervisor.
> As a result, Hyper-V guests behave like regular Linux processes, enabling standard Linux memory features to apply to guests.
> 
> Exceptions (still pinned):
>   1. Encrypted guests (explicit).
>   2 Guests with passthrough devices (implicitly pinned by the VFIO framework).
> 
> v2:
> - Split unmap batching into a separate patch.
> - Fixed commit messages from v1 review.
> - Renamed a few functions for clarity.
> 
> ---
> 
> Stanislav Kinsburskii (4):
>       Drivers: hv: Refactor and rename memory region handling functions
>       Drivers: hv: Centralize guest memory region destruction
>       Drivers: hv: Batch GPA unmap operations to improve large region performance
>       Drivers: hv: Add support for movable memory regions
> 

Our internal test discovered an issue which caused a kernel panic. Has
that been fixed in this series?

Without fixing that bug or ruling out problems in the code I don't think
I can merge this. Once this feature goes into other people's systems it
will be extremely difficult to debug.

Wei


> 
>  drivers/hv/Kconfig             |    1 
>  drivers/hv/mshv_root.h         |   10 +
>  drivers/hv/mshv_root_hv_call.c |    2 
>  drivers/hv/mshv_root_main.c    |  472 +++++++++++++++++++++++++++++++++-------
>  4 files changed, 403 insertions(+), 82 deletions(-)
> 

