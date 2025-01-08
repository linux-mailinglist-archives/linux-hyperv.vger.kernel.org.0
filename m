Return-Path: <linux-hyperv+bounces-3607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF94A0548B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14133A5D96
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF015B984;
	Wed,  8 Jan 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOBtfvLA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE3A59;
	Wed,  8 Jan 2025 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321436; cv=none; b=PAK6uu1VfK9AZPlI6qVjDKqM6TQRacumnQcas5u+LxZttMGbnK2AR0/6AWAOeh7rIPC0OjH5AtR3BJml6a67j/ni8T+FvilusW/vbZqTSxPrqhRlr5BEyk8fFfvmQ+ffzVzNWu/gpWofg7ngu/8qqz5wM6JmR6sAUSLko5INIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321436; c=relaxed/simple;
	bh=u/jEAFnXKDymjYxtnext8VpVNBswvLPGbcdFeC6eEYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk2LSpA1XQ099WOHYbnbo5TJT28qfW8y+nTDHqrGTOlLfaJEcQdLveyc8q/Fw8EmxNn0TG8dnFJSZ5lfXLDAvozD4+xAHgBTR41KgaXC2g4XU7HdDyiKWE08ch2sYDakuneQPHNU8i6MHmLV6cSeG5rEFjnUhWDIQZeVcRK3WaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOBtfvLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B39C4CEE0;
	Wed,  8 Jan 2025 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736321435;
	bh=u/jEAFnXKDymjYxtnext8VpVNBswvLPGbcdFeC6eEYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOBtfvLAzYjLfgUlBvpryyAGB1LJbzBvt6jeL+tneOGLvC8PhSrRGExJ1KjD3h6Xq
	 McAWws/dFdaTZm+GEFDluRVlaMBpzy4EKvFaA3cCQk671vyNANmvmKI4eV8WRJtERC
	 9Webp2CnOASfEXff6sSh824spi8BuaHMfvyjUYP3IngyjqnKtfG0Gd/3ZFz02nYdX/
	 jTBxEzUNZ75CP6Mj+PHVraT4wTE1tBC0sC+hPWkTMVTyl+wWXIVArgxBe7X1WyYLlX
	 7s4rDNqJqNiEmQ/xDIuSbaFz2lP+EJyTLAFQQEPGhyDD9Zr1Jo8Ok6w28lX0Kww0dR
	 M4nFmxgcVuSow==
Date: Wed, 8 Jan 2025 07:30:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Michael Frohlich <mfrohlich@microsoft.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v2] hv_balloon: Fallback to generic_online_page() for
 non-HV hot added mem
Message-ID: <Z34pmlFwPYwWJS-C@liuwe-devbox-debian-v2>
References: <20250107180918.1053933-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107180918.1053933-1-jacob.pan@linux.microsoft.com>

On Tue, Jan 07, 2025 at 10:09:18AM -0800, Jacob Pan wrote:
> The Hyper-V balloon driver installs a custom callback for handling page
> onlining operations performed by the memory hotplug subsystem. This
> custom callback is global, and overrides the default callback
> (generic_online_page) that Linux otherwise uses. The custom callback
> properly handles memory that is hot-added by the balloon driver as part
> of a Hyper-V hot-add region.
> 
> But memory can also be hot-added directly by a device driver for a vPCI
> device, particularly GPUs. In such a case, the custom callback installed by
> the balloon driver runs, but won't find the page in its hot-add region list
> and doesn't online it, which could cause driver initialization failures.
> 
> Fix this by having the balloon custom callback run generic_online_page()
> when the page isn't part of a Hyper-V hot-add region, thereby doing the
> default Linux behavior. This allows device driver hot-adds to work
> properly. Similar cases are handled the same way in the virtio-mem driver.
> 
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Tested-by: Michael Frohlich <mfrohlich@microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Applied to hyperv-next. Thanks!

