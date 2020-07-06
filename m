Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50792155B9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgGFKk5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 06:40:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgGFKk5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 06:40:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id z2so17992945wrp.2;
        Mon, 06 Jul 2020 03:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXbYME0w6wo1ywRbD8zJP/dk/w6azoTUgUnE1Fm/WOQ=;
        b=a0VlsCfgKwfQbx+VwilhOVGRli4MKVKbJ6d11QRiXqVElNuYSZShW9p1KO+p2sySG0
         skFAtxkr6m3cTqATklDlQLQlyzQgjELxT6CBT8WLEVbm3BXtW8OqChlPGAtLOhKtQ6Zj
         la/vTdHODq7BLPR9Rw6g3RVDZ7nXTVugRjwxUoUgdtGkOyZYU7QnFGkPuox609DGPpTv
         b+/nsiN0U4FpuusT++qpNBME7Mzc1KXSU2456MAgRAUJmJ64gzNz8Hp5dEqnmiW7qbIZ
         oPPmRXHy6xg2IwJnZ46XlF6kp3024LHAALy+G7/5G+H7kL89qAMx5kJzv6LTBaGxjf7W
         Mbtw==
X-Gm-Message-State: AOAM533vDl/qlGuTlMxhyjRYWdFSJMpwHtjHIsRX2TFnhFs3Hi3e3YrP
        5dTC0n08gSMF5UCq9V8U2UVlRF/+
X-Google-Smtp-Source: ABdhPJyaTTacfY19alYylsAPF//5GC76pvTVNMe9CH3/3gACJygP1MuC39DqHbYUHYnn1WQUK+yU/g==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr47123552wrw.405.1594032055439;
        Mon, 06 Jul 2020 03:40:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e5sm24067935wrs.33.2020.07.06.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:40:54 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:40:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Hyper-V core and
 drivers
Message-ID: <20200706104053.3kx6dg76n3bw4jro@liuwe-devbox-debian-v2>
References: <20200705214457.28433-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705214457.28433-1-grandmaster@al2klimov.de>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jul 05, 2020 at 11:44:57PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Thanks for the patch.

I will reword the subject line to be more specific to:

 tools: hv: change http to https in hv_kvp_daemon.c

.

> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  tools/hv/hv_kvp_daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index ee9c1bb2293e..1e6fd6ca513b 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -437,7 +437,7 @@ void kvp_get_os_info(void)
>  
>  	/*
>  	 * Parse the /etc/os-release file if present:
> -	 * http://www.freedesktop.org/software/systemd/man/os-release.html
> +	 * https://www.freedesktop.org/software/systemd/man/os-release.html
>  	 */
>  	file = fopen("/etc/os-release", "r");
>  	if (file != NULL) {
> -- 
> 2.27.0
> 
