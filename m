Return-Path: <linux-hyperv+bounces-7390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF5C268D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2D5189D317
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617D350A20;
	Fri, 31 Oct 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQbns3Ly"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A671C2334;
	Fri, 31 Oct 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935179; cv=none; b=ESLQvUNPormD1uStJBQvWgIR7dRMfFWMn5r64hPkJIUC9bscxsQvHYZrCG394RcPSCmPByrK6PO0/7nal0BW3cFMuhckeIF2BhL5QOfKDVE43GEUmMZgJ1VWpG5F1ouZjgDlnl1mmZ/CcKOMaPnP+/7lQ+k4YJDrgKzLCQ5Pk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935179; c=relaxed/simple;
	bh=Pk081o57dJZhm1aEaz4NULentX1zhVnZuQypQf/b3nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JevvlrCOuFTPXSAbId7PfboXRm5iGNRq9u25jrAGBL/jX4ntjUtaU5AjVcCFqDTkfpoa7D8vcsWzbcT6wlPxRcLiox3LwTwUSR6IZboJ5LxVCI5L3VqaxeBldJBm8jbEwfbBNfcKaqsL77HbzQrr426Aa9VhH5cTzJMEmVeWopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQbns3Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C7CC4CEE7;
	Fri, 31 Oct 2025 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935178;
	bh=Pk081o57dJZhm1aEaz4NULentX1zhVnZuQypQf/b3nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQbns3LybnHYygwa7X3hMSFAJI8GLzJvKZBlRFlbbXNmyoCln6c2kjAFEj+SAf8wL
	 b6IXFCKyfnaYQpVKyreE6n7QhAVRjxcbC2qipklUQVe94d7PvqWYtFKNOycDVIxNSm
	 C4Bd1yiJxsdPK7pfIXzbBWiBxbAxjU/ufQeBbdvaNZ7uxZJM+x706C2S4XDYQnKuzn
	 S8vEpii7MCp8Y40Bk5UZ8YAG55hz1wOQlrGpNKj1h74DNEFRXU4gq/X7KOmCUZ4qrI
	 GPyExMhbEGLj7LOF8twf6Fww8vx35mzgFUvzDRKaP/tVxjlj9wKRvVXn6ecvXrmPWh
	 R7eHG076VWBIg==
Date: Fri, 31 Oct 2025 18:26:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] x86/hyperv: Use pointer from memcpy() call for
 assignment in hv_crash_setup_trampdata()
Message-ID: <20251031182615.GB2612078@liuwe-devbox-debian-v2.local>
References: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>

On Fri, Oct 31, 2025 at 09:33:17AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 09:24:31 +0100
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/x86/hyperv/hv_crash.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> index c0e22921ace1..745d02066308 100644
> --- a/arch/x86/hyperv/hv_crash.c
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_va)
>  		return -1;
>  	}
>  
> -	dest = (void *)trampoline_va;
> -	memcpy(dest, &hv_crash_asm32, size);
> -
> +	dest = memcpy((void *)trampoline_va, &hv_crash_asm32, size);

I don't think this change is needed.

There aren't that many places in the kernel tree that use this pattern.
The pattern used by the original code is far more pervasive.

Wei

>  	dest += size;
>  	dest = (void *)round_up((ulong)dest, 16);
>  	tramp = (struct hv_crash_tramp_data *)dest;
> -- 
> 2.51.1
> 

