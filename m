Return-Path: <linux-hyperv+bounces-3162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A59A4C73
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551011C2205D
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B91DE3DA;
	Sat, 19 Oct 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU/Zz4Ke"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE71D7E4E;
	Sat, 19 Oct 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328766; cv=none; b=kcl61rTaWl+1/OknrQd08GUX/oYlZwfmNm8dQ8eEjOdAqi9izx+V9Rk4u9Jp32ZZA2HbhIeer4T+lSWLTh9WqU/u6Ls0D3XnEc0eo3uE1G8TFodI1ZXOKW+K93eCHVgdORLKRJhAlj8TdQvtHeQlYPi+3f8lEZbewMu0yFT4T78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328766; c=relaxed/simple;
	bh=LDuDdWztPn22Or8W5wn2r1vdPbFSPzL/s/HZvdh4Sh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUwHaPT33O9dpDuotqkYajVOHdpHRoemA8KeY792JG1SSPp0JETfUD11tsWTnZLY+VEtWfqpn84dRqz6nnaP20JbvW99jSZFbSSkMbR0wFu8q59sUi+Adp1V6An84MRJwDJ4ovEltlmovgmcHOi9JPn6WlBQBJEnyZLNU4JLcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU/Zz4Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EABAC4CEC5;
	Sat, 19 Oct 2024 09:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729328765;
	bh=LDuDdWztPn22Or8W5wn2r1vdPbFSPzL/s/HZvdh4Sh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU/Zz4KeROr9vGxnQpJ4aLpA1/hwj2K7+EccraY17PYHjGwLw+HZNu8v3uZfiu9Za
	 TSWVXn4c07xH8dMUSrsmpBrJKlL/q333skMdhEk7zaTwClyTfb6L9cTWMe95UyeiHv
	 OSxnAFSGprCZbPR7lVaHLeov9n9fQYPM+cG5g4USvstP47HM6fo+lkeXcXy7l6v9xX
	 CJORTdR+jROfzCOZzz+3MxXbyOeisdpyP9szOHnADOO8axk3xVly/stB/2ehxjOVmo
	 HD7cSoqAhFcyif76YBSUFTDp2klG1ZWE4HOqCRuqnGdgg6NmRjE2kWnr5wqvkjA7eA
	 37EmYtyqpQUkw==
Date: Sat, 19 Oct 2024 10:06:01 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, stephen@networkplumber.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v3] hv_netvsc: Fix VF namespace also in synthetic NIC
 NETDEV_REGISTER event
Message-ID: <20241019090601.GQ1697@kernel.org>
References: <1729275922-17595-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729275922-17595-1-git-send-email-haiyangz@microsoft.com>

On Fri, Oct 18, 2024 at 11:25:22AM -0700, Haiyang Zhang wrote:
> The existing code moves VF to the same namespace as the synthetic NIC
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check for synthetic
> NIC's NETDEV_REGISTER event (generated during its move), and move the VF
> if it is not in the same namespace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v3: Use RCT order as suggested by Simon.
> v2: Move my fix to synthetic NIC's NETDEV_REGISTER event as suggested by Stephen.

Thanks, this looks good to me.

