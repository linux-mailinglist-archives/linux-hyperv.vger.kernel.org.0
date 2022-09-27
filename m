Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D265ECF46
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Sep 2022 23:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiI0V0q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Sep 2022 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiI0V0n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Sep 2022 17:26:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240F1E76B7;
        Tue, 27 Sep 2022 14:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7CF61B9D;
        Tue, 27 Sep 2022 21:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A142C433C1;
        Tue, 27 Sep 2022 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664313999;
        bh=xsHcZmQ5k2fouDljXp77NUkSQtGkptLx+KZKrFyMkVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWPV6fPvwau/brQJo1jcJrYLI/PzgmGw3fPY7sWSFOfBq2TqCRVGiLBgKGtPrQqqW
         dhDsWN4Eu842mdtbU1ipgIoZ9Xtq2z956kGZvTz0lviaKFTu0FvdJDPNngCBHDvZes
         UZU/OKtXCayCe+J2QnePigu59JVJhk4KFwg5ZAhXWI12Q3g8Rky6FevPJUdBJyC7Fc
         AMp6OlUMqjauaz1vT74piycJD6rEV/LhfI/Zs6M7yP9/kI0V7y3nB5SWF4RwTOxThI
         xa7T0SqV+RSRYdxJDnoEpUkcHCNuwpwKEYW+45jqg+1wBEME4xmsxyKUXn5ey6gqaF
         SCfBNv4K2h3fA==
Date:   Tue, 27 Sep 2022 16:26:32 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <YzNqiLag6NyRMdh+@work>
References: <20220927211736.3241175-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927211736.3241175-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 27, 2022 at 02:17:36PM -0700, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated. This
> results in the already inlined memcpy getting unrolled a little more,
> which very slightly increases text size:
> 
> $ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
>    text    data     bss     dec     hex filename
>   22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
>   23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o
> 
> Avoids the run-time false-positive warning:
> 
>   memcpy: detected field-spanning write (size 212) of single field "&ctx->msg" at drivers/hv/vmbus_drv.c:1133 (size 16)
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> v2: - fix commit log, add tags and exact warning test from Nathan
> v1: https://lore.kernel.org/lkml/20220924030741.3345349-1-keescook@chromium.org
> ---
>  drivers/hv/vmbus_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 23c680d1a0f5..9b111a8262e3 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1131,7 +1131,8 @@ void vmbus_on_msg_dpc(unsigned long data)
>  			return;
>  
>  		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> -		memcpy(&ctx->msg, &msg_copy, sizeof(msg->header) + payload_size);
> +		ctx->msg.header = msg_copy.header;
> +		memcpy(&ctx->msg.payload, msg_copy.u.payload, payload_size);
>  
>  		/*
>  		 * The host can generate a rescind message while we
> -- 
> 2.34.1
> 
