Return-Path: <linux-hyperv+bounces-5527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13475AB8458
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FA01BA74A9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D97297B88;
	Thu, 15 May 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJwz7YdU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521241E9B2F;
	Thu, 15 May 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306278; cv=none; b=D+4IV4o2K+1QMUD65KPKUK961cePBX8iGhDhYhyXVnb9nMCpxu3RBOL22fdbAhlygB9gIah+3uawFimCFXU1Xn6vaAiFLXhsJtI4dW+soIJ/kNO5hJZqH/RHowzFGsOER3xpY65EAtygupnVjSE9oHeKUSfBqrK48QLzvh+5QLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306278; c=relaxed/simple;
	bh=6JvZzrl348isGalupi5dB8TPv8vxuOjZ2pAMRfWjbqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvHTuwLM3+19UR+/Qq0PVscfn3lNS09baQaHlJlmNwkdzctQKAKNp4oz2wd7geUeva/rM30nnD5PNY7uRAMJdQc5hHp9Q3CHraueq8d3PIN3jHq0H6zMWX2Xe5WDTiMXiBWZaOZMwd3UD9Xlapcv2dKKzZQAizBKQrJUQ2NVMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJwz7YdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A785C4CEE7;
	Thu, 15 May 2025 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747306278;
	bh=6JvZzrl348isGalupi5dB8TPv8vxuOjZ2pAMRfWjbqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJwz7YdUo/VsfCpaeHvSEgYRILb0AggZLKOtkq/4vlDZfT7k6T0sJ1n59AwR72lVY
	 JC8ceHjWjf8JBOr4t9fPLvMW4n5LxSj+1TiSxcjinKXKhoEq80TVldFc77TND0jX6t
	 XL62/tugY/FAGL+v94Q8qWWoAtRbEOXD3/CBJTz1pOO3ELrETMkBtoB/5N7JXLUA4U
	 rBSHDG0B324R3tmAoNjFnw3GSqZKI1wqxY6/XqEvd+50assLYzBVvnnH36cYU+BsUN
	 BhiOdfFj1gNBC0yQwi/ojeQoK2jzanJ1gauG+ECgmXyhAU/3afis3PtCqsK30ckaFo
	 RzJyc3QzZwnKw==
Date: Thu, 15 May 2025 11:51:12 +0100
From: Simon Horman <horms@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/5] Drivers: hv: Allow vmbus_sendpacket_mpb_desc()
 to create multiple ranges
Message-ID: <20250515105112.GS3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513000604.1396-2-mhklinux@outlook.com>

On Mon, May 12, 2025 at 05:06:00PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> vmbus_sendpacket_mpb_desc() is currently used only by the storvsc driver
> and is hardcoded to create a single GPA range. To allow it to also be
> used by the netvsc driver to create multiple GPA ranges, no longer
> hardcode as having a single GPA range. Allow the calling driver to
> specify the rangecount in the supplied descriptor.
> 
> Update the storvsc driver to reflect this new approach.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Simon Horman <horms@kernel.org>


