Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C5534CE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 May 2022 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiEZKB3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 May 2022 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEZKB3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 May 2022 06:01:29 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF885AF337;
        Thu, 26 May 2022 03:01:27 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id j25so1496757wrb.6;
        Thu, 26 May 2022 03:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lx3v91MKvNWw13VryX1BqqQ6vGw8LXT68T6Hr6cGD/U=;
        b=wdL7JbaZbyBKl/3Aq036klTHs0Ox+aIiNlXy3n8zjiL3Srcumz5kpBCgVHcvfIP7Vs
         U459arqbw067Ib0UTJneGKbxQTdYfXWK3pUL2k6yD4VgHxBXkVBSGFAxeviVAgG9RXLE
         2D2Qy6OmagpPd44gMZuyksJCmImZkpSt6s9M+yO9+Z1scM6sSHfTE831Bjwdp5L/AkpN
         SYIyJDCz6swY80c2DMdTGBcnFX8+RfdUzepjWZgxpKHdFtTD+ghdXaXSBPopGJvnkqk+
         GFa1SO0bJ5ZRd9qKpiK3L1WoIvsLWoaS/7deqTs+pzc8KRIK3UpKa/wB1H0bB+/qeqyR
         EQBw==
X-Gm-Message-State: AOAM533PKU0x4CkKFIShTyW1p7yaU1DqhgtR9kMFLjT4FnW2LNonPRBI
        hiEaKYavOGoh7thbvfGp+4A=
X-Google-Smtp-Source: ABdhPJw6nZtBMTl2VZyXuSX2JE0sT/DXGau2hXPz7tFQ09pul8FdKLkJNBKjvjDTn20p9KIeHuB3Xw==
X-Received: by 2002:adf:f889:0:b0:210:3c2:2be3 with SMTP id u9-20020adff889000000b0021003c22be3mr4647874wrp.147.1653559286392;
        Thu, 26 May 2022 03:01:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p14-20020a056000018e00b0020fe7f7129fsm1237717wrx.100.2022.05.26.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:01:25 -0700 (PDT)
Date:   Thu, 26 May 2022 10:01:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        kernel-janitors@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: fix typo in comment
Message-ID: <20220526100123.427zdetsv4n2pirc@liuwe-devbox-debian-v2>
References: <20220521111145.81697-60-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-60-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 21, 2022 at 01:11:10PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Applied to hyperv-next. Thanks.

> ---
>  drivers/hv/channel_mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 97d8f5646778..b60f13481bdc 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -443,7 +443,7 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
>  	/*
>  	 * Upon suspend, an in-use hv_sock channel is removed from the array of
>  	 * channels and the relid is invalidated.  After hibernation, when the
> -	 * user-space appplication destroys the channel, it's unnecessary and
> +	 * user-space application destroys the channel, it's unnecessary and
>  	 * unsafe to remove the channel from the array of channels.  See also
>  	 * the inline comments before the call of vmbus_release_relid() below.
>  	 */
> 
