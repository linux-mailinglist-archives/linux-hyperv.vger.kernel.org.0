Return-Path: <linux-hyperv+bounces-2972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC196CE47
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14A2287F63
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192B1494D9;
	Thu,  5 Sep 2024 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lmUuJyPK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77030149013;
	Thu,  5 Sep 2024 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725512581; cv=none; b=NtwTv9VEgkNqxuuZ0ZAzDRoxZTPMPMeX5SSGrcV96YS75bZDxq7MGDmYJRmAshlVrYfTS0N4SVObNAuJM4qcpkiD/iFfHWczgYfaI7m+GPEXClexoiX2II3GQd+rsFYV16JSmhRxDwNSNsuj1qMvEKo4vu2C2kYa0zeBpVhETrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725512581; c=relaxed/simple;
	bh=L3qUMwvA3KWGAqDnm6wh0SHRRBa8vXjJemfzc6fNwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJribz3UCg2f5f1ck5NeQ2RV62IUo5qqTczF/sMm3kp+teuLOuHOKOldVDQA+DuMODcx6ZLLdRAG8OT1jZGPScmV9On9bXA2OSJukcK3nNT65IDOxXp9Jz/Tmm8m9rUX2gk/WnTO8S9vD4sPPweXkJIC07iB3koO9r50VAFjk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lmUuJyPK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DED8B20B740D; Wed,  4 Sep 2024 22:02:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DED8B20B740D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725512573;
	bh=ach9qMfKtP33v/w5Spjx/P7JOXueUpTltpnyDAzTFk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmUuJyPKu1VM1DWAPiRNjlFEZhsXmGx/V9apFBjEI9N+ExvDCvH1TxYlFsHqbuikG
	 qZ3wpFAEXc0kw0SZ5BbInkrvk/BJJuCCwk7BSjuAxsTCf0+AkI0Vuxwsg/6bBtjFA7
	 eoDbgLiRFpTNgzLqQqvW++b6/VrXdBvBRWrRr7rM=
Date: Wed, 4 Sep 2024 22:02:53 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: hv: rm .*.cmd when make clean
Message-ID: <20240905050253.GA29491@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902042103.5867-1-zhangjiao2@cmss.chinamobile.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 02, 2024 at 12:21:03PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> rm .*.cmd when make clean
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/hv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 2e60e2c212cd..34ffcec264ab 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
>  
>  clean:
>  	rm -f $(ALL_PROGRAMS)
> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
>  
>  install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(sbindir); \
> -- 
> 2.33.0
> 
> 

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

