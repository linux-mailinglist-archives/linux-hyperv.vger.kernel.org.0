Return-Path: <linux-hyperv+bounces-4341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE3A59BBB
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC18D3A598A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C78216392;
	Mon, 10 Mar 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaXbUIoi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEE1BD9C6;
	Mon, 10 Mar 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625678; cv=none; b=sTKd5UNbPAvPKfwV8PAVaYqkrrsWenD3Rt9hAUbCU+RiolxTry4iyNOxOsXzHJAJj3qUr43RWGYy4/sItowgS5Gy4btqn3KTS9nkQen1twMbC7GzB0ISCiMiI/uqCDBkDGiixZxxq0bmEW1i7I5aV6TWDZsNSklTef+sOGqoBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625678; c=relaxed/simple;
	bh=p/WTFwQVZWqzvwsT0pYojOfEwtLBKPo356bGqhDxAII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlhIMdLQg5kOZ5tqshgejq6kgGNQbjHPRbt/DIS5LMBoJim9uSSMNURKJNNt+JIWp8/1X7RMRc7OMU605gL5bVckb4rsgxsJx6Qrrr1TVfC2zMKeIgcHZce1xjimW2rD6lwqkK0D8ddRFP0sMtcIz39gSvOt54zKKvRRW/gwSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaXbUIoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C3C4CEEB;
	Mon, 10 Mar 2025 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625678;
	bh=p/WTFwQVZWqzvwsT0pYojOfEwtLBKPo356bGqhDxAII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaXbUIoiQBiyUyqGF58080L7cQWbflH5i2Y05U8RHv6DMnN2QgkWiATjkgwOBdH/x
	 0FS0cUqrYep3QcXXmqw8w3s11A79/GxSGC1AgM5pldYV3zIfLEh9bILlUAi4TAS1Bz
	 HXMj/CM8hkYAGgp6iDGOegNByZ9OUoqT1ZWVXSnzrSzQBBfogv0n0BWkSONDhZDGrU
	 XuMDF25IWDyNRXaTjhVcUlIEAfNkUUaeopoWe+hCtSkg2KN1NuPrCawn45dr20MgHz
	 7WA2Jm7v8T40byL5ZV3HNO1n7bWUcVec7Z0YCZlVGgvKH9i6GTduUDL5Ry/WGSe8+g
	 5ACz+RMmm5hKw==
Date: Mon, 10 Mar 2025 16:54:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, jakeo@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Don't release fb_mmio
 resource in vmbus_free_mmio()
Message-ID: <Z88ZTO88g9I6Nuqy@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250310035208.275764-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310035208.275764-1-mhklinux@outlook.com>

On Sun, Mar 09, 2025 at 08:52:08PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The VMBus driver manages the MMIO space it owns via the hyperv_mmio
> resource tree. Because the synthetic video framebuffer portion of the
> MMIO space is initially setup by the Hyper-V host for each guest, the
> VMBus driver does an early reserve of that portion of MMIO space in the
> hyperv_mmio resource tree. It saves a pointer to that resource in
> fb_mmio. When a VMBus driver requests MMIO space and passes "true"
> for the "fb_overlap_ok" argument, the reserved framebuffer space is
> used if possible. In that case it's not necessary to do another request
> against the "shadow" hyperv_mmio resource tree because that resource
> was already requested in the early reserve steps.
> 
> However, the vmbus_free_mmio() function currently does no special
> handling for the fb_mmio resource. When a framebuffer device is
> removed, or the driver is unbound, the current code for
> vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
> pointing to memory that has been freed. If the same or another
> driver is subsequently bound to the device, vmbus_allocate_mmio()
> checks against fb_mmio, and potentially gets garbage. Furthermore
> a second unbind operation produces this "nonexistent resource" error
> because of the unbalanced behavior between vmbus_allocate_mmio() and
> vmbus_free_mmio():
> 
> [   55.499643] resource: Trying to free nonexistent
> 			resource <0x00000000f0000000-0x00000000f07fffff>
> 
> Fix this by adding logic to vmbus_free_mmio() to recognize when
> MMIO space in the fb_mmio reserved area would be released, and don't
> release it. This filtering ensures the fb_mmio resource always exists,
> and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().
> 
> Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

