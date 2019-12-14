Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0980111F3B2
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Dec 2019 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLNTaa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 14 Dec 2019 14:30:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43092 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNTa3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 14 Dec 2019 14:30:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so1254687pga.10
        for <linux-hyperv@vger.kernel.org>; Sat, 14 Dec 2019 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8m+mIQybzPaMhyllV8M24lvSQe2bTRL/4FeQ9BAt9Rg=;
        b=v0vv4/nevwZ0h0QI0iLwMoCOox6HCrRjTxAFAm8BiSWIn/3MoN2ymskGUUtaTooz2m
         0gt1ZZZ71ODtrhzw35UYJemvEf48PE9Y+haWK81vn1yaPy190xYMlLNevezCcXtLtZ60
         XSIN0Xe8d0BVHHfEs07NLyKQ40FUSZAIn7vLmNPlmRje+7GGvuojszNUylMFYT2LKLs3
         JUgAVZVWf/QfQU3ALCnekQJGWmCYlmSpBFKhD060l3i7ODkJ/KO9l0Vbrfpg2ZN2xEam
         5mkxYsi/iNVxlZpkVNbiMWTBKMypYDPxiNPgiSvwjp/0EYZCt2zEWOUOgsNoGyaluEqo
         5EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8m+mIQybzPaMhyllV8M24lvSQe2bTRL/4FeQ9BAt9Rg=;
        b=B/s5Eml+DwapA2YP+SlmBl/M5u1y76SzKfsLFa6z1VvoWslmKAl95WWik9XydzEZFS
         P+m5tiaDFYOfzVXisD+U/7ucwTWa81l1x+UI5PjOqMhp2ka4X0dUKiLM0v5hUWTB3RR8
         xcz+bFJ7xRvRDzGVNELlIDFAl7iUpAnT2IcO61oIhLGOsdVyMTSHUUqgm0SKMR6rIsqN
         y79kFVmTK4EGlYwCDK5NK6epybyF5C4XA5Zij9KBpNbqKmcmO4yJHvSlT1mwcZQNbk2t
         D2/6qi+jBe2QZmIC99R3TTjCaJm1w6ULV0Ki3Wz9nVmNCclQtHCZoh4f1KdOA0diUlZL
         2NJw==
X-Gm-Message-State: APjAAAXxwhdHjsvEXQtdq5YcT/KLXgUA2E8hkmYy33RhnVAQgUwFaNGg
        7qn89j2sTL/BPxHJf8eZ4IUmXA==
X-Google-Smtp-Source: APXvYqydEQC93uE9aFoQrBDU9to7Enmv6EqE1GrIh9R0bN67mX/nT11jWrIrP0Cj7flLCHUVszdIkA==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr6861440pfn.62.1576351828972;
        Sat, 14 Dec 2019 11:30:28 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id s27sm16592197pfd.88.2019.12.14.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 11:30:28 -0800 (PST)
Date:   Sat, 14 Dec 2019 11:30:25 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     sashal@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2,net] hv_netvsc: Fix tx_table init in
 rndis_set_subchannel()
Message-ID: <20191214113025.363f21e2@cakuba.netronome.com>
In-Reply-To: <1576103187-2681-1-git-send-email-haiyangz@microsoft.com>
References: <1576103187-2681-1-git-send-email-haiyangz@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 11 Dec 2019 14:26:27 -0800, Haiyang Zhang wrote:
> Host can provide send indirection table messages anytime after RSS is
> enabled by calling rndis_filter_set_rss_param(). So the host provided
> table values may be overwritten by the initialization in
> rndis_set_subchannel().
> 
> To prevent this problem, move the tx_table initialization before calling
> rndis_filter_set_rss_param().
> 
> Fixes: a6fb6aa3cfa9 ("hv_netvsc: Set tx_table to equal weight after subchannels open")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied, but there are two more problems with this code:
 - you should not reset the indirection table if it was configured by
   the user to something other than the default (use the
   netif_is_rxfh_configured() helper to check for that)
 - you should use the ethtool_rxfh_indir_default() wrapper

Please fix the former problem in the net tree, and after net is merged
into linux/master and net-next in a week or two please follow up with
the fix for the latter for net-next.

> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 206b4e7..05bc5ec8 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1171,6 +1171,9 @@ int rndis_set_subchannel(struct net_device *ndev,
>  	wait_event(nvdev->subchan_open,
>  		   atomic_read(&nvdev->open_chn) == nvdev->num_chn);
>  
> +	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
> +		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
> +
>  	/* ignore failures from setting rss parameters, still have channels */
>  	if (dev_info)
>  		rndis_filter_set_rss_param(rdev, dev_info->rss_key);
> @@ -1180,9 +1183,6 @@ int rndis_set_subchannel(struct net_device *ndev,
>  	netif_set_real_num_tx_queues(ndev, nvdev->num_chn);
>  	netif_set_real_num_rx_queues(ndev, nvdev->num_chn);
>  
> -	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
> -		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
> -
>  	return 0;
>  }
>  

