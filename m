Return-Path: <linux-hyperv+bounces-7898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD982C91041
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 08:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F44D4E2093
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AC2D6608;
	Fri, 28 Nov 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N62zK7Rc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058B2C2376;
	Fri, 28 Nov 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314264; cv=none; b=s51aSGBIE4R2fSNJ667yzcRnfiR4RPkDWi2bH3w8fJqAe9ASCFbzWxiYz7M9HhIQ9ZjHLB44orKgxDhFLqTbwRGD4HWHxuCbHZUd3ZAF1L5IHkTDm5iqz0qerdqK+lWT1jjUvurM6mju+DW0SbXd8Qn9Bv/OUyR684jnQTsC8es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314264; c=relaxed/simple;
	bh=/KvJYLTJ7XcnIfUJpKGNYUAjasCf/T2iVBwX2XXZ4ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYEa8/zBmKYz+wdWCREm3NbjHYQ84zTmq3QIzwvxZUoLvzTMVAYxpks1i8B/59AwLRYCu7Zb/Mbtd8X5SriZcQjzXzzVWSyaDkHxHj4t3bHxuqrYfZEUNnqYYKwC9NaI0IjMQ8GAp4igmQTBX7FPsLfnidkFTJtokJ2jmetRzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N62zK7Rc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519E7C4CEF1;
	Fri, 28 Nov 2025 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764314263;
	bh=/KvJYLTJ7XcnIfUJpKGNYUAjasCf/T2iVBwX2XXZ4ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N62zK7RcSdn9Oesmv86FBqpUA27AS9o4b2yUqrdNejNcIGJ4UflIxnpa9Z4bWgSE7
	 V/gzUzmJZTUjRATL62WS2eW5LcuwUrXafA/y6jcdfPc/YIqeneQxToh/ThsD+CRqat
	 EKKBFrpzEfEPIyCENOFkUvqrZbB26sS0yJOi6J18XkH7rLz98DfUywYFYJhA8BJhgR
	 56Q9wxXNHgdIjgjLAJRvXUyLanBFp+I3a0OkVFYAn3KaXuy7Idh47wN4Hq5Wr4f1l5
	 2FVJgSA8OgaZkUUpXAH+VnoqdSA+X1Hfz5hEYlH3HHMH04wgitb6VBwmLtKCntUoar
	 CTqbBMSGiW2ag==
Date: Fri, 28 Nov 2025 07:17:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] Drivers: hv: adjust interrupt control structure
 for ARM64
Message-ID: <20251128071742.GB69390@liuwe-devbox-debian-v2.local>
References: <20251124142600.2112608-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124142600.2112608-1-anirudh@anirudhrb.com>

On Mon, Nov 24, 2025 at 02:25:59PM +0000, Anirudh Rayabharam wrote:
> From: Jinank Jain <jinankjain@microsoft.com>
> 
> Interrupt control structure (union hv_interupt_control) has different
> fields when it comes to x86 vs ARM64. Bring in the correct structure
> from HyperV header files and adjust the existing interrupt routing
> code accordingly.
> 
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Applied.

