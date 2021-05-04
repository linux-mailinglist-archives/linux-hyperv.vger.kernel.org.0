Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B168372A71
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 May 2021 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEDMzp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 May 2021 08:55:45 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:40565 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhEDMzp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 May 2021 08:55:45 -0400
Received: by mail-wm1-f46.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1183576wmy.5;
        Tue, 04 May 2021 05:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkUegmja1FKjuP0c7sUd8bat+jU+NTb1GMupZJiKSxc=;
        b=D2fM/LtQXyPh5x0+o/d5KYZY5krIxlH6npG2o/qWYnNl6C0QC1AeNMZvWArLZvco9C
         IQIgB6p4OJi/VqOEeFU39PvyI0Vr5q7ouyHTqQGg5D5UGlDfnc3xODHc9LBX8pc97GE/
         UhkqT2gUW0UPfF2fRrJwxMOCVKbL6mkzfvcZdZomb6FeOFaw+2Nccm4yNw+O9mJTIHS5
         b1H24ClwamXO5vfSmmNQJkO3UzojZKgVa0b3gLOsWmGyr2FJwJ9WK7PtyTeZm3QVhn6X
         vJeoUpJW8nT131N85V4CaoYg7bQC9RHozHuoMBrYuTbp/HmNwCMFur3UTmdRswvLAx5q
         UuJA==
X-Gm-Message-State: AOAM5314UWz+yaI5UWv2pe3gq/ko69uKpCl7TV6DiC6Ev3XZQOo2iZEC
        2lu53sE6+gawpsDcsY2rabeC40m2ju4=
X-Google-Smtp-Source: ABdhPJxlOT+ycrdZJKypaKQy4xnhTKlaFf6PLFcKrpdgbTT0t/pKkYyJyUKCn2p6YVKPL4StwyoXkA==
X-Received: by 2002:a1c:2285:: with SMTP id i127mr26931400wmi.27.1620132889400;
        Tue, 04 May 2021 05:54:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v18sm18998983wro.18.2021.05.04.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:54:48 -0700 (PDT)
Date:   Tue, 4 May 2021 12:54:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_balloon: Remove redundant assignment to region_start
Message-ID: <20210504125447.wy5e6kar7u5kvc2v@liuwe-devbox-debian-v2>
References: <1619691681-86256-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619691681-86256-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 29, 2021 at 06:21:21PM +0800, Jiapeng Chong wrote:
> Variable region_start is set to pg_start but this value is never
> read as it is overwritten later on, hence it is a redundant
> assignment and can be removed.

Indeed. It is overwritten a few lines below.

> 
> Cleans up the following clang-analyzer warning:
> 
> drivers/hv/hv_balloon.c:1013:3: warning: Value stored to 'region_start'
> is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to hyperv-next. Thanks.

Wei.

> ---
>  drivers/hv/hv_balloon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 58af84e..7f11ea0 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1010,7 +1010,6 @@ static void hot_add_req(struct work_struct *dummy)
>  		 * that need to be hot-added while ensuring the alignment
>  		 * and size requirements of Linux as it relates to hot-add.
>  		 */
> -		region_start = pg_start;
>  		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
>  		if (pfn_cnt % HA_CHUNK)
>  			region_size += HA_CHUNK;
> -- 
> 1.8.3.1
> 
