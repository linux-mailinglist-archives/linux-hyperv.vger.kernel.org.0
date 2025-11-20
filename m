Return-Path: <linux-hyperv+bounces-7712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A9C727E5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 08:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A778E3489A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE942FE578;
	Thu, 20 Nov 2025 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jheqyqtX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099E2E9EDD;
	Thu, 20 Nov 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621762; cv=none; b=uYx5z404/7hP7eR+dj+FHJEgluUetuWV0hOtiH5taljuxHHGPqxG60ssMvnUAw39Npz7GdBBMsv3wRNeWFRYzU+/YSXIzYbaFBkjx8TpdKx9zY5U0PL1h2v10NMY1J7zojHb8LWUUIJrWQaK84NhOSpwx/jUuf6RXdjJU4/4iy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621762; c=relaxed/simple;
	bh=+lvnEklKnSLTIx7JrWe301oxsfpdMELzKZ7TUOzlRYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6PHyo0lOdDGMa+2Yln8XGa1NR3IunseFdDLBHZmiuNeRpvwuoOlSQlysTQuUB0OApaptIVM3nQ/Hpz2cBVTxwM2PZ+E2Xi16xaEASfp0bEEwdEgXZtlqwi9n00D7MU0Qg++xAYzB1gOJqQ7WbqTKn4ZwWY71i/LBq2NPD4pEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jheqyqtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8551EC4CEF1;
	Thu, 20 Nov 2025 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763621760;
	bh=+lvnEklKnSLTIx7JrWe301oxsfpdMELzKZ7TUOzlRYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jheqyqtXRRlyyHSkc056TblGWj/od9/r/ttkvThb79aTl12GD03hvkbEzDe/h9/L9
	 gMzBDEaFf6dWFuc9Kq67XhFutDXxleXvZJeoDLIop/DZPNsxEelQUv1hrcH25twFDn
	 o+XVh60zX9mkoou1LEN3/Qy8/t1Tcf9XendfOJgTzIXloV2kNWf1glAhEiWT14owSm
	 TEeYJK+fmFITMh6Zbkm0UOUPxgLGXyk2rmsBJNJH8V1Z9gOQ09AhdP0sB0Paz6+las
	 hY/fAxkWpRkRwxIu2ofN+cOQJthe2q84VpPAIH1WPIXZbBO5ApbshJgBSsZCDH1qoQ
	 oSE2wZYdZCetQ==
Date: Thu, 20 Nov 2025 06:55:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <20251120065559.GA2858107@liuwe-devbox-debian-v2.local>
References: <20251119171708.819072-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119171708.819072-1-anirudh@anirudhrb.com>

On Wed, Nov 19, 2025 at 05:17:08PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> execute a passthrough hypercall targeting the root/parent partition
> i.e. HV_PARTITION_ID_SELF.
> 
> This will be useful for the VMM to query things like supported
> synthetic processor features, supported VMM capabiliites etc.
> 
> Since hypercalls targeting the host partition could potentially perform
> privileged operations, allow only a limited set of hypercalls. To begin
> with, allow only:
> 
> 	HVCALL_GET_PARTITION_PROPERTY
> 	HVCALL_GET_PARTITION_PROPERTY_EX
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Applied to hyperv-next.

I dropped one "inline" keyword that was not needed and modified the
subject prefix to be "mshv".

Wei

