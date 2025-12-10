Return-Path: <linux-hyperv+bounces-8014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7340CCB4280
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 23:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE2ED300EBEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 22:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29EA2FFF92;
	Wed, 10 Dec 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUOSTISS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899602FB0BC;
	Wed, 10 Dec 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765406600; cv=none; b=Ur4mDBEBKjDHs9WVd40n0D0l1+hMMs8/S6t+6gNhF4u7tKBbC1mXGYENb9Vf/YyWlE8swMXmL486WwXOXIZehUA6dRmABp1jd2QyyUJWojlPWz30BZnQYVL40/1MrZ9XKT/vwIfbMBmg56y7zS7MPtMpRQ8G30uQjyZhIp92Iis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765406600; c=relaxed/simple;
	bh=Ipn5cxY5cei+Q4GH00P7zaK4hOlbh40n4vuhjD8EIfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN9+4Q1tqMPsq+LQ3CD/jWDFc5WlyMameQ7g5anhIBYzvsPXi6kpO43a7MvCDkMKu8321dILAf+FOR5AatMltPs4OuLIdjeUOBFjrKzf7ghs5h/9xQ7/vb/cqHKXDLsG/KCXHgmXrW/m1DHtY18DuH/Hotac202TgTbkr6sa0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUOSTISS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F045EC4CEF1;
	Wed, 10 Dec 2025 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765406600;
	bh=Ipn5cxY5cei+Q4GH00P7zaK4hOlbh40n4vuhjD8EIfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUOSTISSSIEVWlePyHDZhY5ai292x7x5N1jGnszmuu+pKwSYTBkbgrS1kfFmQnUlt
	 WmlYbxYhXm8FCLJWjS7MQpQpVdTGN0nkeBIYpWIHxPmCtrHv2p7oWWADoaTo9cpUi7
	 j249ThmZ3GGjvo47tfovsgQVeklqf5Hqkfn+H32LxCjj0b8TuVCCuCMJQAmaIj1KgA
	 qqYwnnGPw4RMXXhu3IvAQbI/Ouq6pzM/K5WnlTXoxwpYXU0KOVRNcfvf8SvcRViFDL
	 WMPvQTR4PybkkTg+Dk81P0jRF5GkyP116qqZrp/6Tp9nE83Qx5MvLItTWVoluMUCDb
	 ELlUI0veWRw9w==
Date: Wed, 10 Dec 2025 22:43:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Initialize local variables early upon region
 invalidation
Message-ID: <20251210224318.GB3121622@liuwe-devbox-debian-v2.local>
References: <176538934140.22759.15324831745272282048.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176538934140.22759.15324831745272282048.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Dec 10, 2025 at 05:55:47PM +0000, Stanislav Kinsburskii wrote:
> Ensure local variables are initialized before use so that the warning can
> print the right values if locking the region to invalidate fails due to
> inability to lock the region.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Queued.

