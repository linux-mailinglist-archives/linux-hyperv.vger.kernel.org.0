Return-Path: <linux-hyperv+bounces-8310-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0BED22E0A
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C9330A2100
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379E327BFA;
	Thu, 15 Jan 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni0Kk3l7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E32DEA98;
	Thu, 15 Jan 2026 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462283; cv=none; b=m2q4T33QU6p2BO738JTHZ/dH/KEh2EgB8clNS/BhqTh8W3XMmBFUpLPsLDemuJ3okGUa92xZbwAezikAF0h3c6HgpX23MCR9IwfZm8wzrVSZHRpt3EKwGAVf4KF3jEQlhPQlhNDpVw3deun+vmAL0BK7SsKfxrx6SdZA0YW6emQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462283; c=relaxed/simple;
	bh=p+rzgF8vYiIvx3oVIPFWySXLdDdzawnxsLd8gVjZdxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEBmeHTruCypEQHt9VudKPgofsmE+lneyKY8RbDMtZ0Jkz1uaxE87d6taHwv60Unc/vBShDjkZJFJPHUVE8oQZMccUfpG/JO7AdtdbDpifGlVwhVdzljLWg/QjXcHmUis/C7pzAiJY1XHPjuILSwkZ3EoXtoHqPgNp/HKOebnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni0Kk3l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D129C116D0;
	Thu, 15 Jan 2026 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462282;
	bh=p+rzgF8vYiIvx3oVIPFWySXLdDdzawnxsLd8gVjZdxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni0Kk3l7/jIwTqJ0JFO6b5ta3GDMadxDwG/wmjhg4/dLj+5dRwyGxbNZlOcZXAMyS
	 ggcWBkL+AxzvD8yX0HW7w2mTp6IOdD1O4EmvKS5Tmt3qJ+zBPaU+CKWI+OAcGp3dNj
	 wruhyUr4P9JWBXNm/qTuJxnhaQ1kvC81bvM/OZeCFzyqyX8QWgLdroAYzbVcMLadbD
	 klXv8Kno9lH9npgTh//x5vt+roTPxwC5x/T5gQyMuYnC6zuBNhUf3UlRagg7Akj4wS
	 I6uMZ5CxQcKO8dVe5KHtKphZ8LOb97u7YGfNUYcFARonrp9cneEMB1oj/XC/ghJiFY
	 /t2ELwfcApXnQ==
Date: Thu, 15 Jan 2026 07:31:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fixes for movable pages
Message-ID: <20260115073121.GG3557088@liuwe-devbox-debian-v2.local>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105122837.1083896-1-anirudh@anirudhrb.com>

On Mon, Jan 05, 2026 at 12:28:35PM +0000, Anirudh Rayabharam wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Fix movable pages for arm64 guests by implementing a GPA intercept
> handler.
> 
> v2:
>   - Added "Fixes:" tag
>   - Got rid of the utility function to get intercept GPA and instead
>     integrated the rather small logic into the GPA intercept handling
>     function.
>   - Dropped patch 3 since it was applied to the fixes tree.
> 
> Anirudh Rayabharam (Microsoft) (2):
>   hyperv: add definitions for arm64 gpa intercepts
>   mshv: handle gpa intercepts for arm64
> 

The code looks fine. I have queued both patches.

I massaged the first subject line a bit.

Wei

>  drivers/hv/mshv_root_main.c | 15 ++++++------
>  include/hyperv/hvhdk.h      | 47 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 7 deletions(-)
> 
> -- 
> 2.34.1
> 

