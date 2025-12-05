Return-Path: <linux-hyperv+bounces-7987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16337CA9A64
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Dec 2025 00:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79525300718C
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DD302758;
	Fri,  5 Dec 2025 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyGSMO7z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CAC2F4A06;
	Fri,  5 Dec 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977165; cv=none; b=eOShmrQJvDPfETzaWuDFNcQq9eOUi5eOInvNqvwlRAm4NBDVlyM81i/ASyHYFzcZc7ELszWbGo+bn4c6CgiqGagUUCHnXXGULTxiQdvta5B9ElQF9l4dMz39qN0YMH5wA35pqEj2DYScs57Q94yk8EWmA7sRjEssEcqyy5ygRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977165; c=relaxed/simple;
	bh=wkza0MRpZhAv/BySynC1jOTfKBQiVoxi8lmAqkvEPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZApdTWWtrkiMj9c09JT1+KGJTVNt+IyCxSip33kY/Y2RDAgfHyyG9pQtMFYPARHg4KuKXM2SglqXEn2zedUuV14+5ogp+XA6ZLBJnVHkM32QBU7Qg1/Dc5zVx6yO/eUHLLGUAqC72YZxNMlfJ1klYvhlSArhJUl7Cv2UCcaIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyGSMO7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB444C4CEF1;
	Fri,  5 Dec 2025 23:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764977163;
	bh=wkza0MRpZhAv/BySynC1jOTfKBQiVoxi8lmAqkvEPgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyGSMO7zWowlaGPxFuR161GXQitIOUjLyt6uSehmRDHyHswZaYX7vl/m3lOnpsrAe
	 LRwwATyZ7Wr1BUgEJdWIXuQSBKwIHBhoS2YuX+ykYxldmcGrmOFSJJvoPc0KOIOl5T
	 IfHk9oeddE1Eje2nJBsPGYCJhehdwxDiXLy2zo+xXg04CQjZpUDqhIgh3z0PZsG9R7
	 w0nDQQFHRbVMprh9D7m4Y0ZV9c/wBHaMj2D+hjbas35Duj7+fQaxpg8vVnQ4P5Tqns
	 URnRnlVNx81S0aEnFQ8XX9oaGtaO8PsiVqGw3ES2pyArPIv13BW9C/ytKXpYFUl81Y
	 ly/qFadJZ4Dkw==
Date: Fri, 5 Dec 2025 23:26:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v7 0/4] Add support for clean shutdown with MSHV
Message-ID: <20251205232602.GE1942423@liuwe-devbox-debian-v2.local>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205201721.7253-1-prapal@linux.microsoft.com>

On Fri, Dec 05, 2025 at 02:17:04PM -0600, Praveen K Paladugu wrote:
> Add support for clean shutdown of the root partition when running on
> MSHV Hypervisor.
> 
> Praveen K Paladugu (4):
[...]
>   hyperv: Add definitions for MSHV sleep state configuration
>   hyperv: Use reboot notifier to configure sleep state
>   hyperv: Cleanly shutdown root partition with MSHV

I queued these patches to hyperv-next.

Wei

