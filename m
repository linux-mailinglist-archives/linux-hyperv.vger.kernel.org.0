Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA21613585
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJaMOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiJaMOr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:14:47 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AFE0BF
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:14:46 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id z14so15668930wrn.7
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4nq2XiirSye7qNSBzEqg5VhUlhgaWluVSbhFQl+nFU=;
        b=24cGe+++pYP6p339bwx9qVJNVLIIcLy5emp8LrjSQ0F3Q8aShC0HHmewxoIojsVnwm
         bpmOEIjLmTCyEEpZ6G6Nb6iSVZxjdjEcNN3mWCq0OZszj2h0xyt8cRRaeqSKu7QAf2Ae
         2K57FwvCuz+IjjSpGZ4T3dOVEA06ahufLzKDKkCJSDkNwcAgoUhuj4V8A8ScAvXAe6SD
         baIJaQsSx+GlOsdUj9i/wWLFG7Zt8X52rb3rQUVk9+Fghhau6vb2bKiT6JN9BwRHMjt3
         aw5n9+K/xRTwRWBNCPz8EKlitNeWrVX5EJm+FryuyXDeQ3jtbXthbO3egyHsWkuXxhyw
         WgPA==
X-Gm-Message-State: ACrzQf3Hbf0spex7umyUtjrRKjjuIXTZestMHW70vaMPxXZUQWXM/856
        ih/rXD4H52YL8QyH0R3aiUqe9j9E+Jo=
X-Google-Smtp-Source: AMsMyM5sZGD56f3mFTVAoGPV3vlvXa+NUK7z0mjb2R6QOyA+XmCUzph8Ivl93gO+T54P6wqhoKpZCQ==
X-Received: by 2002:adf:fd87:0:b0:236:7ad7:d3c4 with SMTP id d7-20020adffd87000000b002367ad7d3c4mr7810454wrr.687.1667218484182;
        Mon, 31 Oct 2022 05:14:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h11-20020adff18b000000b0023677e1157fsm7012992wro.56.2022.10.31.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:14:39 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:14:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     kys@microsoft.com, wei.lui@kernel.org,
        linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: remove sthemmin
Message-ID: <Y1+8KTyoy5FVBqG7@liuwe-devbox-debian-v2>
References: <20221028153741.25470-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028153741.25470-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 28, 2022 at 08:37:42AM -0700, Stephen Hemminger wrote:
> Leaving Microsoft, the Hyper-V drivers have lots of other maintainers.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied.

Best of luck!

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bb30c0d1cb4..aee66010bad6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9504,7 +9504,6 @@ F:	drivers/media/i2c/hi847.c
>  Hyper-V/Azure CORE AND DRIVERS
>  M:	"K. Y. Srinivasan" <kys@microsoft.com>
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
> -M:	Stephen Hemminger <sthemmin@microsoft.com>
>  M:	Wei Liu <wei.liu@kernel.org>
>  M:	Dexuan Cui <decui@microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
> -- 
> 2.35.1
> 
