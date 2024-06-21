Return-Path: <linux-hyperv+bounces-2471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB6912122
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 11:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC531C21110
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FFE16F29F;
	Fri, 21 Jun 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XpNDUMs9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9616EB59;
	Fri, 21 Jun 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963291; cv=none; b=GlY5IBq87F7J3vKWvuyZEH2Zs/LvkSOeu5FEeBYPcyXO/YlFp/apr2ckYSA7gXKAhvGLLQ9YQBOBCehi3Qb+pLB5c8Er64/mLqWKl8L03rMfIYI+A+tXDW8m4kjdgDXyu1xDNEUVNmUmYZMpL0FThNolUlf561UycLPhoXiTNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963291; c=relaxed/simple;
	bh=pTK2uk7dTedHpm+HT2VnhvW2RAAVd5OtodFRrb2p3Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpHwAoZLH4EY+a0461a50Kog4iGXOxxXGe3XXj4LNQZaZm5Qu/21H/72ARYSyjigRovn2w+8frv8BA3akorD8p2810uXB/gX1tn44bwHXXFQU1w3Lf7hky3SF+okb1oyNPwif3+8ECWMJFfa7Lnd2N4ZqNpg/IywpD0h2vbpnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XpNDUMs9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2F02920B7001; Fri, 21 Jun 2024 02:48:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F02920B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718963287;
	bh=jOQ1R1Gu/tsvIRuTjwZzd2lF8ZLheCSPiAPtGPLzvtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpNDUMs9RVdxqIxdhNCmuIS3E04RplHmZSj6RJHgloqBfagTATLBZK2hja3rz1JOZ
	 rTu3bPc811gGAKZmW7w12YO+7lRPqHzlPtS8bTXbJQNDbhio1nFygGIDkzFC4DA8qN
	 U9+HwPWc57kbpYSx1B2G5Ln0kioN9TcJVnnAw6gQ=
Date: Fri, 21 Jun 2024 02:48:07 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	chrco@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: Remove deprecated hv_fcopy declarations
Message-ID: <20240621094807.GA12314@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jun 20, 2024 at 06:50:40PM -0400, Rachel Menge wrote:
> There are lingering hv_fcopy declarations which do not have definitions.
> The fcopy driver was removed in commit ec314f61e4fc ("Drivers: hv: Remove
> fcopy driver").
> 
> Therefore, remove the hv_fcopy declarations which are no longer needed
> or defined.
> 
> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
> Signed-off-by: Rachel Menge <rachelmenge@linux.microsoft.com>
> ---
>  drivers/hv/hyperv_vmbus.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 76ac5185a01a..d2856023d53c 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -380,12 +380,6 @@ void hv_vss_deinit(void);
>  int hv_vss_pre_suspend(void);
>  int hv_vss_pre_resume(void);
>  void hv_vss_onchannelcallback(void *context);
> -
> -int hv_fcopy_init(struct hv_util_service *srv);
> -void hv_fcopy_deinit(void);
> -int hv_fcopy_pre_suspend(void);
> -int hv_fcopy_pre_resume(void);
> -void hv_fcopy_onchannelcallback(void *context);
>  void vmbus_initiate_unload(bool crash);
>  
>  static inline void hv_poll_channel(struct vmbus_channel *channel,
> -- 
> 2.34.1
>
Thanks for the patch,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

