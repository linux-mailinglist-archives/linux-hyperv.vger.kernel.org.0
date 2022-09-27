Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517E5ECEE5
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Sep 2022 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI0Uq7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Sep 2022 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiI0Uqm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Sep 2022 16:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D5110250F;
        Tue, 27 Sep 2022 13:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFAE61BA0;
        Tue, 27 Sep 2022 20:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2F5C433D6;
        Tue, 27 Sep 2022 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664311583;
        bh=Sf7VqaaR4EHHX4vlNDI8Uh3V4OoviqEGs4OJjkuPMvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEZNNzr3KpkbCjZX/ZJvREb7swZiFyJmXl/NY8R03swHRszivrMyt8UXetSuBhtXd
         5oTFBlMOpoM0xPzKElfZiZ9HqsDOEdXMaH58puZj0ftn0AH1999qKgdglrfiMjpme6
         OlsOQXgXmF1Fgk9j/Uc81h8vjUF1GEEYgOC/jQGh6dulYlyL8D9WfRinK06JqPkSlB
         7RSlS+UXGulwqb/XN3WfsCluvdhhkx06VP3KejufHndo5WGag9Hg0Usn6FALCWBgtr
         xCt5qZaraQDWoDHrHh671GeaD5i0Uiq8rwG1rc8BtPTKfa80o0mpStizA7VaRy0iCK
         uBHYh5WuJ9KBA==
Date:   Tue, 27 Sep 2022 13:46:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <YzNhHZOLB0T8iqHE@dev-arch.thelio-3990X>
References: <20220924030741.3345349-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924030741.3345349-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 23, 2022 at 08:07:41PM -0700, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated. As it
> turns out, this appears to actually reduce the text size:
> 
> $ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
>    text    data     bss     dec     hex filename
>   22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
>   23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o
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
> Signed-off-by: Kees Cook <keescook@chromium.org>

I was waiting for another -next update to test this in WSL2; now that
said update has happened, I can see that this does resolve the runtime
warning that I saw.

Tested-by: Nathan Chancellor <nathan@kernel.org>

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
> 
