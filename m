Return-Path: <linux-hyperv+bounces-7389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C1C267D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A40A189CF91
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF7258EC3;
	Fri, 31 Oct 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlpxGiSZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074EB640;
	Fri, 31 Oct 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933282; cv=none; b=U+ELipq2mPTO9Wmdxqcqduw66wzdvtQQDlcflXc6kt55WNTHecAz6FhitM/BoEBns5qnlhaoFwpNxlIJn0ccnvO1LcGQhqF9ahvt5TqMJA5t6zDRQFnVRpbzCDkdp9l2qUI39zO5PfWX7dJmKxWud0SYq9rcSuguVDhVeI3xoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933282; c=relaxed/simple;
	bh=hcIInGVL2gaB3IEcStsAKiIlTSD+K/EVklziL5I++Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv5Ve0k/EVcVMWEbXEd86NBd/cPaxnMDrXTJePoPAIeUcqvq1HfjJHed/hzp4McHelqc/41yDMGKbPIhwCyv/uLXGtwbfGqx59wgI2aLwhIZDgbvu3PavJFUXIhXUw9Dh43OtgsGks8fdRrrZOsWfvlnieL/53dclqd8fXHmVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlpxGiSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8A9C4CEE7;
	Fri, 31 Oct 2025 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761933281;
	bh=hcIInGVL2gaB3IEcStsAKiIlTSD+K/EVklziL5I++Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlpxGiSZ5MDUMk1Ran4DukG8E0vWDa7GquJwuOUGGW67wNeCiDFJOsEP6EW5hxKFW
	 xZ1/3oSwXQOkJjJE/C9gbN4HNqGmtXAidvq7GgUMdHummsQ2gCk5mlvEnvtvIUiqZa
	 UHZaEsZAXp/u31nJriKTZSMVmOfV1la5CPEb3yn4K2aJutA3yvnYT6VZ3MTOJYG4te
	 Ph/sZCt5LNUrtQ8KIkriOAHuDNnHUueeVuTo5r8K6LtPIUfkirXBnmB/e6qkEvW4FI
	 vWEv9zzEjkp2HvZ8b7mLYee+OnaxTuVXwgG33S1ff2ufynjhccx6beSne6cu5OoNjE
	 fvipk7niS3xTA==
Date: Fri, 31 Oct 2025 17:54:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: kriish.sharma2006@gmail.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] hv: fix missing kernel-doc description for 'size' in
 request_arr_init()
Message-ID: <20251031175440.GA2612078@liuwe-devbox-debian-v2.local>
References: <20251025120707.686825-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025120707.686825-1-kriish.sharma2006@gmail.com>

On Sat, Oct 25, 2025 at 12:07:07PM +0000, kriish.sharma2006@gmail.com wrote:
> From: Kriish Sharma <kriish.sharma2006@gmail.com>
> 
> Add missing kernel-doc entry for the @size parameter in
> request_arr_init(), fixing the following documentation warning
> reported by the kernel test robot and detected via kernel-doc:
> 
> Warning: drivers/hv/channel.c:595 function parameter 'size' not described in 'request_arr_init'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503021934.wH1BERla-lkp@intel.com
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Applied to hyperv-next.

I changed the subject line to match the existing pattern.

> ---
>  drivers/hv/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 88485d255a42..6821f225248b 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -590,7 +590,7 @@ EXPORT_SYMBOL_GPL(vmbus_establish_gpadl);
>   * keeps track of the next available slot in the array. Initially, each
>   * slot points to the next one (as in a Linked List). The last slot
>   * does not point to anything, so its value is U64_MAX by default.
> - * @size The size of the array
> + * @size: The size of the array
>   */
>  static u64 *request_arr_init(u32 size)
>  {
> -- 
> 2.34.1
> 

