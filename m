Return-Path: <linux-hyperv+bounces-7558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35635C59D5E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 612E14E426B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A72DEA78;
	Thu, 13 Nov 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSrWwUuZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F3265620;
	Thu, 13 Nov 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063276; cv=none; b=KaaZhXXR2d3lI6d5FBS8peHn19TviQo8GVAXbl3qIT/RCsladWg3HU8hxQdAtUfAtSSPgANOfZGKsHxF0GcWW/IKOdqmO7noHpNY/O2cy9h3dqkntljIwVSmvx03MztPsXM+qM2mORLvjaSmJcoqX7+Lwrv5xraWrttb1TSE690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063276; c=relaxed/simple;
	bh=euy9zMyLLe4CdVw/eDc1K6UzQGFWvJQ8GaNfwERU0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAluoNGtD90dYa+t1cvir1AOkGqeLiDVmxRiGhyvw3CrhqUsLdu07bsQuFeWzMSb3lgLvrLo9OOk33HT80xYyjRK1uVLCKDCE0wIP+8T9ZQa4TWAK3rIcLulEGCZO/fw0HkePrDwSegbfn7ChSdrpf3WY3J3y2QxhNUanIz6f0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSrWwUuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974FAC4CEF1;
	Thu, 13 Nov 2025 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063275;
	bh=euy9zMyLLe4CdVw/eDc1K6UzQGFWvJQ8GaNfwERU0Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSrWwUuZ79KIZjagIk96NIN+/lFNy6mRMe8OPmL4dNGfHyLKv4A8/X9fnBSJrZKSI
	 JKhkE8JCGZBR+fb1rPIJZqLrQ5b2d7IMW7fkGU965s9Sn5QehtHubUIjZ/23LhrCnh
	 kgBaJnCy2oebtlSs+PERIm+6BVbpL9mq0T+aVsQZLxM49mUttAkSqHlcgUwmu7o8JR
	 ke+Y8WulY/bb8rGr6jmvPEBapXGNXVpN8AHR+5HBlYBM3mC9b3jeBtFcvoS+8mQPS1
	 3Brbkqf0wasPvcXT/kaxYGcnj7zkheNM3d6jCvdy4bj6tSaeWW9ExBP+iST5xN33T8
	 ru+j6CGwMWZTw==
Date: Thu, 13 Nov 2025 19:47:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	skinsburskii@linux.microsoft.com, prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v5] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <20251113194754.GC1175882@liuwe-devbox-debian-v2.local>
References: <1763063133-3878-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763063133-3878-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Nov 13, 2025 at 11:45:33AM -0800, Nuno Das Neves wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. Instead, it
> attempts to enable all features and those that are not supported are
> silently disabled by the hypervisor.
> 
> This was done to reduce unnecessary complexity and is sufficient for
> many cases. However, new scenarios require fine-grained control over
> these features.
> 
> Define a new mshv_create_partition_v2 structure which supports
> passing the disabled processor and xsave feature bits through to the
> create partition hypercall directly.
> 
> Introduce a new flag MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables
> the new structure. If unset, the original mshv_create_partition struct
> is used, with the old behavior of enabling all features.
> 
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Queued to hyperv-next. Thanks!

Wei

