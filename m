Return-Path: <linux-hyperv+bounces-7396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3CC27297
	for <lists+linux-hyperv@lfdr.de>; Sat, 01 Nov 2025 00:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70AB1885408
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4E328B50;
	Fri, 31 Oct 2025 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRhYtVql"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497983254A7;
	Fri, 31 Oct 2025 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951995; cv=none; b=VNaFzCdDFq2QK9m2n569B/GmI+EK1+UWNeGZbEWyzlD2gRXeP0OUZ9NoxZNPTDOZQRnnhaZ8exXtyU3vOtrHm9+Vz3Nyt7gPDzB9/S3a20aOfJbfScRRTaDmYfh262k7+lIYX5jx2bxE93zk11LgLRYa5dzneRXXJNR/Ma47rN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951995; c=relaxed/simple;
	bh=W30gxcU26HoYoi9+GzZbnuluexx6qMzSBo5idMNWlZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFX0LfACao2EGRMKnZxl1P3VJMUzq4zW65Mj5PTSNE2Ddeo5kwr6pVggvZbvRNcjpthLhHGTuHopDXcR7WvsUJmYFC0+ObtC5F/7oFpPBv5BSCxzoRW7eSDRKV/TiSpDnfTYvqGRn3sz6gndvCTZbTrdGdBidZEGEu5rJXP0aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRhYtVql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA2AC4CEE7;
	Fri, 31 Oct 2025 23:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761951994;
	bh=W30gxcU26HoYoi9+GzZbnuluexx6qMzSBo5idMNWlZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRhYtVqlU8YDNjIFHGOkCNn/qlWx2ams+oLrw5U3+R/TeK/d54wSmI7JUO/eSvejp
	 lxfwQw29UT2jeyVxlFjsLsjhLWFiCvJ+l9tvjaw4LxhiM4zpbI17+XgT9+DicVxWRp
	 XWmC5mvzAZOe0MSbu5B+8MKo6d5SjOW7JGtYzs2Olro9MdpDzw+xVYMRxQ61O77ljw
	 a0/KRO3mD4yc9RVU5iR9Dq8zIpvUKbDNDiI5TVa6jUGcvK3tVCx48UNInS3UM8hRwU
	 FgsXMypLzxJsowdJfPMY+PU797wmrijRjerVqRaFywS5M+2qS0mHsKZ6xJ81pdC8u7
	 bFy9a9pT5U9qw==
Date: Fri, 31 Oct 2025 16:06:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: mana: Refactor GF stats to use
 global mana_context
Message-ID: <20251031160632.41c1167f@kernel.org>
In-Reply-To: <1761734272-32055-2-git-send-email-ernis@linux.microsoft.com>
References: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
	<1761734272-32055-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 03:37:51 -0700 Erni Sri Satya Vennela wrote:
> Refactor mana_query_gf_stats() to use mana_context instead of per-port,
> enabling single query for all VFs.

What does "single query for all VFs" mean?
All types? All within the host?

Coincidentally I don't know what HC and GF stand for.
Please explain things in more detail, all atypical acronyms 
(for *Linux* networking).

> Isolate hardware counter stats by introducing mana_ethtool_hc_stats
> in mana_context and update the code to ensure all stats are properly
> reported via ethtool -S <interface>, maintaining consistency with
> previous behavior.

> -void mana_query_gf_stats(struct mana_port_context *apc)
> +void mana_query_gf_stats(struct mana_context *ac)
>  {
>  	struct mana_query_gf_stat_resp resp = {};
>  	struct mana_query_gf_stat_req req = {};
> -	struct net_device *ndev = apc->ndev;
> +	struct gdma_context *gc = ac->gdma_dev->gdma_context;

reverse xmas tree, please

> +	struct device *dev = gc->dev;
>  	int err;


