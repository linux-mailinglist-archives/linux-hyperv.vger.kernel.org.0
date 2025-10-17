Return-Path: <linux-hyperv+bounces-7257-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A40BEBE1A
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1814E1C87
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37D427B32C;
	Fri, 17 Oct 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx0CLPbG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F426F292;
	Fri, 17 Oct 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738817; cv=none; b=A8KMw61DU8o+ZgaarUua0Of+Byyga6drXjwPNPTbd3WW68XNJB1Of8kflKtMRqwlFA3kuMNceZXEdmOWmzs4eBD43UI9LAK+kbCcgPkRKdYm8b90eU8pQKi3+Q4ylsth/WIsvSHCXr/iOAm7qXtugq4Y0UwQB7z8R+hFwr8ddFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738817; c=relaxed/simple;
	bh=sBo22m3xgldrGGhfaVuEpAz060ueuFfpTbGxj1xOTCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqGWcuIS8MsuPXvPEZHee2k5NfPWv4tOhJnhCiOzSahrFxbA0HOb1Queg7036pg8maDdQWK/OwINWs0XtMRfJwMj9R/S+VcY0e7/Kd3Me8fguzmXI6XM0w5zuEYIZWbsLmflInSl3lITd70MUSMcEMlMEAq8VtT+5dFTwmIhN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx0CLPbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20705C4CEE7;
	Fri, 17 Oct 2025 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760738817;
	bh=sBo22m3xgldrGGhfaVuEpAz060ueuFfpTbGxj1xOTCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sx0CLPbGrA5PKjpKvbXKGgay5OazFT1aBvYQlMhkbIuEIjBht1CtU4xAj4edmD0El
	 8IQLybdoq+vJOVzaCToroRBBxdQbimWofoon0VKiRjYCIY6ErlRSv5D5V8esnjCFYq
	 qV10sagchCOGZyG2RAY1KHjYhgtSeKsQ/D10CzBoozCsnPSW8VVcrywwlNtcmUHMWH
	 0TS14uUCb2lDnTyIlLsouMFv8wMC6M1xkzO7IhpiXQfRSRsvfQQZUYATPLv0sf8wqL
	 YRhtCUeFEpvaAmfK7UaqZ+YCjraKwdhqbCzGShHpleUkwj7ljXBFb+gWMo2XC3K4y4
	 Lvfbz1vWqkBAw==
Date: Fri, 17 Oct 2025 22:06:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
	mrathor@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Message-ID: <20251017220655.GA614927@liuwe-devbox-debian-v2.local>
References: <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Oct 17, 2025 at 11:58:17AM -0700, Nuno Das Neves wrote:
> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
> -EAGAIN to userspace. The expectation is that the VMM will retry.
> 
> However, some VMM code in the wild doesn't do this and simply fails.
> Rather than force the VMM to retry, change the ioctl to deposit
> memory on demand and immediately retry the hypercall as is done with
> all the other hypercall helper functions.
> 
> In addition to making the ioctl easier to use, removing the need for
> multiple syscalls improves performance.
> 
> There is a complication: unlike the other hypercall helper functions,
> in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
> problematic for rep hypercalls, because the next part of the input
> list can't be copied on each loop after depositing pages (this was
> the original reason for returning -EAGAIN in this case).
> 
> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
> parameter. This solves the issue, allowing the deposit loop in
> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
> partway through.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

In v1 you said you will add a "Fixes" tag. Where is it?

Wei

