Return-Path: <linux-hyperv+bounces-4657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99653A6B003
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365223A5BAD
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 21:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198A215171;
	Thu, 20 Mar 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pce6A3hW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F62AE6A;
	Thu, 20 Mar 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506808; cv=none; b=neMyEFrIrvli9Gz6y32+JWsCPpA5mA572p0dXDg/DOc9qpj6hIsV489IpLkjsA4nNeuV5gq2IL59jmkaFEcrpkwsrlfEFA78LPF9YU9Xnvx1qCDaaY5XsXQ+NHVvbHbdZ/bPnTJIv0ZiKtTYfsvYFe3g9SLLSjIQjPR8haHfZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506808; c=relaxed/simple;
	bh=WHV0+xLhNNBk2yS3YlO7vsfFfNbFoq8Y8smv0FadZ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIIvk3XQjtJ1zn0Z1Mp8XhpYIUorP0XR8V1R7zYf7/TvIrls7wUv+QOKNR9Mh2z9lts9UsL9UrgN+rI/vmKIbxNN9/bMdP6u3dnCWOu0NhjjCdshTMnUJpYdqfsxFTGlWpcAr1Y0r3eAdgU1exiz4GOFBrFWBntV2d2oIyR3lE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pce6A3hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E73C4CEDD;
	Thu, 20 Mar 2025 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506807;
	bh=WHV0+xLhNNBk2yS3YlO7vsfFfNbFoq8Y8smv0FadZ1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pce6A3hWOQR21UfWQWSa+T5gpHs+muP4dQLFYBUzjB5z8DQ9XOQ9wUFC6z2UIFnYU
	 +EVy+12LOe0IbovHxnSsBR3Iw8CnETDJn0p7pwaNIicEpB43cPkpTVoN2VM7XjtI44
	 mFkX6mj7UqTcg+F8PocRGmTxnld4BK9/jcEcoAYzwZYU8i+uUomcU4JCr72ZyDUhGp
	 3bby3uJ9kkPggMrLA8EOD35x7gjliKkF7KBkALMMLozEXb/prAd3Lk91XU5Dfj/qDC
	 9y72WtIjt5wJbOODpxHEgzpD9UWRdXHoVT7gqMzneTrvvTQ4gc3R5IaDoVnXuuqnX+
	 o9ocEA3d4aL9Q==
Date: Thu, 20 Mar 2025 21:40:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Add comments about hv_vpset and var size
 hypercall input args
Message-ID: <Z9yLNUEEutvjD6HZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250318214919.958953-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318214919.958953-1-mhklinux@outlook.com>

On Tue, Mar 18, 2025 at 02:49:19PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current code varies in how the size of the variable size input header
> for hypercalls is calculated when the input contains struct hv_vpset.
> Surprisingly, this variation is correct, as different hypercalls make
> different choices for what portion of struct hv_vpset is treated as part
> of the variable size input header. The Hyper-V TLFS is silent on these
> details, but the behavior has been confirmed with Hyper-V developers.
> 
> To avoid future confusion about these differences, add comments to
> struct hv_vpset, and to hypercall call sites with input that contains
> a struct hv_vpset. The comments describe the overall situation and
> the calculation that should be used at each particular call site.
> 
> No functional change as only comments are updated.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next.	Thanks.

