Return-Path: <linux-hyperv+bounces-3409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11049E7E9A
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C942828D8
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28217BD5;
	Sat,  7 Dec 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQn8t6Qq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072522C6D4;
	Sat,  7 Dec 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733554977; cv=none; b=asxBi5dGdOigHgtA1Uv3ywaYKrn7m3qzDTjuNy3EFxahXIIGdMvccQjX8BvSknWAWhEjEkWC5hLfjeuCe/e+PK0/nzsiCi122J0OjGTZfRUuxoF8o0NSruvI9L/lT6SxuU/dPSwtCQ1zNcLHyDXTlwLtCHI09VLWlglyjIeJkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733554977; c=relaxed/simple;
	bh=DIVw0duziCihwu69FqoeUc9mmHMPobwZaUalUDF9dqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP3wUvIFRf5sADK9KY1+XXo7DeAJbKq9J+rxoDbqwd/2XvlxoQcG+pvCFT6y0Pd/3keBDu/fPbNj3M30a0Y+XiqAryIZ3uS/KSB9ENKVvVHVHwYjEKeol9GNbH7VrzWzpCxCOAA2Xs9sGIdBHBlBZERePrVL1ZjJE2er15k9PVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQn8t6Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB10AC4CECD;
	Sat,  7 Dec 2024 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733554977;
	bh=DIVw0duziCihwu69FqoeUc9mmHMPobwZaUalUDF9dqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQn8t6Qq+KSREKzbpRE1s9VKsITaKgmphnVGsyPp2HMrsgb1UkH/VYavZu02o6GFG
	 pNiFEi2gM8YSFFWCj9xUmooU+IT6lHG5QDrgQl3i7vti7sxqnVOGUWhadjWCNvH44l
	 uOojOeuL+T0BHrT25K2SxmsWLszd7ujaWeGCOBXp/cRwlnERU9mY/AQ8kcOi1nhwVA
	 OM5UhlP9i9Zx9wIuhrLwhBeAKOUjQdfOFZ07pN1vkBFO1yom6brlITyr3vq0Ns/73B
	 MrFggEAmlmF23IVavpGTXIztKymYldl9I/fIYsL7fMTpFA+AanGlmUraKqn8gE815H
	 sKg8p+fwP8+MQ==
Date: Sat, 7 Dec 2024 07:02:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, gregkh@linuxfoundation.org,
	vkuznets@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Drivers: hv: util: Two fixes in util_probe()
Message-ID: <Z1PzH0F-3BAXpuBU@liuwe-devbox-debian-v2>
References: <20241106154247.2271-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106154247.2271-1-mhklinux@outlook.com>

On Wed, Nov 06, 2024 at 07:42:45AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Patch 1 fixes util_probe() to not force the error return value to
> ENODEV when the util_init function fails -- just return the error
> code from util_init so the real error code is displayed in messages.
> 
> Patch 2 fixes a more serious race condition between initialization
> of the VMBus channel and initial operations of the user space
> daemons for KVP and VSS. The fix reorders the initialization in
> util_probe() so the race condition can't happen.
> 
> The two fixes are functionally independent, but Patch 2 introduces
> the util_init_transport function that parallels the existing code
> for the util_init function. Doing Patch 1 first avoids an
> inconsistency in the error handling in similar code for these two
> parts of util_probe().
> 
> This series is v2 of a single patch first posted by Dexuan Cui
> to fix the race condition.[1] I've taken over the patch per
> discussion with Dexuan.
> 
> [1] https://lore.kernel.org/linux-hyperv/20240909164719.41000-1-decui@microsoft.com/
> 
> Michael Kelley (2):
>   Drivers: hv: util: Don't force error code to ENODEV in util_probe()
>   Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Acked-by: Wei Liu <wei.liu@kernel.org>

