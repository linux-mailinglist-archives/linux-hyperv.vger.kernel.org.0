Return-Path: <linux-hyperv+bounces-8054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D8CCD73D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 21:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4531B302B880
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B02248A4;
	Thu, 18 Dec 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra3sbNLz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94CE3A1E66;
	Thu, 18 Dec 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088085; cv=none; b=YzUg7gDFDp7CRprWSRtc3BpvC3hvQP9eH43NIMj2ZrXSgNleOxZehQ6wgENzvWtPBYenFA1U8H55L5pQEIslpRmOcPSfemvEkFTdTZbfTNAlwP9zS8ipCIcXtfANBkQRBd623CArLrTk47Yr7I5Ip1rkvu1CSSX0alJWi2HnwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088085; c=relaxed/simple;
	bh=3sZsaayIRQJxNgH1ZXe8dbgI5EPSjgYfp7TuiTdnLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehcfy2wmTpaj9T+qIzfagbEUeeGCSVdqnvYrJ5+XsQTAI2zdDcGqUGNLwmBfSjykttwpwpDTZjBvDk1/5QNnec/7O5JM3PtGCa0KWXXY9lI1TnINNI9sciFoE0WZnKdpZbqQYhbZRTj0J/bG0CCCOzg8ukJ2iV7F9I4Y9xsO60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra3sbNLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012F7C4CEFB;
	Thu, 18 Dec 2025 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088085;
	bh=3sZsaayIRQJxNgH1ZXe8dbgI5EPSjgYfp7TuiTdnLvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ra3sbNLza3WZYiSieaTPP78NhZnmWpTEfkApAvCG2XlpdUh4+cNN87wR9mTIETpWf
	 8yAuPU0+I1J9TVjXo//xmDsZKQfTVT8+C34+ngQKAzZQSN4a97Q8+WGalvNOKHJDmF
	 dfen9sSt2VoW6KwdynULLpJLIhuLNgE1GWkFJ2kjmSXDSnaMomTziyZyrttAu8KQQ6
	 78lVtET1SlWuMwpANdqHFLlYuGGC6aBFNWsI1qchucxD7ipnAtAZoPK8GffYpJMy+3
	 aiQz0lQyQCQb2AhucqEmjqCawvOvu7AcuO+7Et60Rf99oNuRMZqvt/cd+lup8oU3Vn
	 QXrpZa05L8KqQ==
Date: Thu, 18 Dec 2025 20:01:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mshv: release mutex on region invalidation failure
Message-ID: <20251218200123.GE1749918@liuwe-devbox-debian-v2.local>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-4-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216142030.4095527-4-anirudh@anirudhrb.com>

On Tue, Dec 16, 2025 at 02:20:30PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> In the region invalidation failure path in
> mshv_region_interval_invalidate(), the region mutex is not released. Fix
> it by releasing the mutex in the failure path.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

I applied this patch to hyperv-fixes.

Wei

