Return-Path: <linux-hyperv+bounces-3170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BF9A9B88
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 09:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0732838A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Oct 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6A132120;
	Tue, 22 Oct 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Vqpgd8vd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625E1547C5;
	Tue, 22 Oct 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583642; cv=none; b=V6q2+ifuPKF6YcrFGPVlSei6egkDAMHVlvl7yzvW4kK+Hd1EA2sdO0NhL31B9upDkuvEUzz0SwbHwhRP8BUrjC1YKPGlaEWhtQaQj/5Hggnr3T1YN3pMVA2H9IHg6E0xqNVV2wd31MwIALfb1/HcbTa/tNdAz/S0AKYMyLa2YRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583642; c=relaxed/simple;
	bh=iu+DhHBd0zq5FKnWsjjiE0NaFOCLjpWujUo6i9xdk/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1ifvc9sPFyGYPbnhkDPaYxW+sf1IdbiTgyMNuJWnLBtGqtBzbYyshjYiRd4xn/nLsSiSp5pQJSSNk7hD2Ty00c6SCYJ/s7Vk9IJuWgDmTVKamSNSWWAP+cGEvKBDlLWST5X/mgkAg9KFocyxvmm0c5NM/yAV2fQFx7GoLRHccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Vqpgd8vd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 204A1210DDA8; Tue, 22 Oct 2024 00:53:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 204A1210DDA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729583635;
	bh=4L77gztwzz00U5G8OdEJtyQS3PdWXnyH1XMo628KQVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vqpgd8vd5uS0G00d9j3WwB7QLcGe1P5bTAECgwDVugYlkymacxomhquvZKVqVybWH
	 GRqiiExx8JcshS/Ge0g2LDREq99yDAjPWMw6KcYTtcLPJTZ6PoNErv1RaaVGxhRBzP
	 S/h0gW1gEanpzWoeKJRw42C9+DEHdkwMsEl0O5p8=
Date: Tue, 22 Oct 2024 00:53:55 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Wei Liu <wei.liu@kernel.org>, Ani Sinha <anisinha@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools: hv: change permissions of NetworkManager
 configuration file
Message-ID: <20241022075355.GA15089@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241016143521.3735-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016143521.3735-1-olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 16, 2024 at 04:35:10PM +0200, Olaf Hering wrote:
> Align permissions of the resulting .nmconnection file, instead of
> the input file from hv_kvp_daemon. To avoid the tiny time frame
> where the output file is world-readable, use umask instead of chmod.
> 
> Fixes: 42999c90 ("Support for keyfile based connection profile")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  tools/hv/hv_set_ifconfig.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
> index 440a91b35823..2f8baed2b8f7 100755
> --- a/tools/hv/hv_set_ifconfig.sh
> +++ b/tools/hv/hv_set_ifconfig.sh
> @@ -81,7 +81,7 @@ echo "ONBOOT=yes" >> $1
>  
>  cp $1 /etc/sysconfig/network-scripts/
>  
> -chmod 600 $2
> +umask 0177
>  interface=$(echo $2 | awk -F - '{ print $2 }')
>  filename="${2##*/}"
> 
Thanks Olaf, the changes look good to me.
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com> 

