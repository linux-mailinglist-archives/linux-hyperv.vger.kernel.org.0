Return-Path: <linux-hyperv+bounces-2008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE308AB3CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 18:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F2B214C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D50136E0F;
	Fri, 19 Apr 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nlQyy1jL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FA13848D;
	Fri, 19 Apr 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545675; cv=none; b=AjZlOJJoTLCgdxIhQaWBJCafIusrVxnzA7gPHtvr9qnSOmOQonDkTXB1ZZO+9FT0A6Kd80JP+Rz0dAG6tK5teTGl5/Jl93uHZpiMGdCe4q6lXWwbG6fEJh8WiBaPj90ZNI5MQ8O7bXhW2ZW1QjDImJzVCGXwAMZq1CTFRnsbPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545675; c=relaxed/simple;
	bh=p+AhksF9UH47nFYw6ev3EzJCJllx/nP7dwMICYgHVhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJMx33vh6tjR5L3lvLcpOOg8FU5NIzCeIUOyiW4jS/gysNciDq3Rlu6OYyab5WcHEqBz2wNDiyVNnCDP7tXXmwIPQ0obyJ8X/F26ySjgiobD9IgTjVnzYxg+v2iIXEP79seb3GRXDP09nu0Gn1y0sn281UzSwFepjEp/Oi7n+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nlQyy1jL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C187420FDC2A; Fri, 19 Apr 2024 09:54:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C187420FDC2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713545673;
	bh=s8RrX6fyZ456/LIZpdM4fzLm/GVjoSvdhiXZUDPzgVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlQyy1jLlnLNQEOEIA6b4Dplj9u0w+B4PIHV3L2viFaJ2aZ5OSTWUzTSqqj+4qpry
	 IDYXooy6rJ8rlXqB/QHWJGq5JjXyxShX7iionnfftDz/7k25mfjwABak38PwiJYIlw
	 NBHoSvS17ygympnMnxLbeJdB+tO/bNtlQhB+4PTM=
Date: Fri, 19 Apr 2024 09:54:33 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	eahariha@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the
 owner of the files
Message-ID: <20240419165433.GB506@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240418120549.59018-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418120549.59018-1-anisinha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 18, 2024 at 05:35:49PM +0530, Ani Sinha wrote:
> A comment describing the source of writing the contents of the ifcfg and
> network manager keyfiles (hyperv kvp daemon) is useful. It is valuable both
> for debugging as well as for preventing users from modifying them.
> 
> CC: shradhagupta@linux.microsoft.com
> CC: eahariha@linux.microsoft.com
> CC: wei.liu@kernel.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> changelog:
> v2: simplify and fix issues with error handling.
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index ae57bf69ad4a..014e45be6981 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -94,6 +94,8 @@ static char *lic_version = "Unknown version";
>  static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
>  static struct utsname uts_buf;
>  
> +#define CFG_HEADER "# Generated by hyperv key-value pair daemon. Please do not modify.\n"
> +
>  /*
>   * The location of the interface configuration file.
>   */
> @@ -1435,6 +1437,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  		return HV_E_FAIL;
>  	}
>  
> +	/* Write the config file headers */
> +	error = fprintf(ifcfg_file, CFG_HEADER);
> +	if (error < 0) {
> +		error = HV_E_FAIL;
> +		goto setval_error;
> +	}
> +	error = fprintf(nmfile, CFG_HEADER);
> +	if (error < 0) {
> +		error = HV_E_FAIL;
> +		goto setval_error;
> +	}
> +
>  	/*
>  	 * First write out the MAC address.
>  	 */
> -- 
> 2.42.0
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

