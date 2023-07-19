Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7000758E5A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGSHIe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jul 2023 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGSHId (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jul 2023 03:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C1E43;
        Wed, 19 Jul 2023 00:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04AB0612B4;
        Wed, 19 Jul 2023 07:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754CAC433C8;
        Wed, 19 Jul 2023 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689750511;
        bh=vIgxjK1nHjyKdJKx7z3ZJwiHL/Y2wz1xQKW4KNcqGFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWf4xPGaf+BJQulEhvX5yAcfYPvpcX3HTkBIO4fTnH77cWUXLyCFnSjtvTCHPluLx
         fmrRXeVrjueyMjNq9oov+mQJSQwYXNa7TgU3Gg4GCm6DvqCIUHtAyE3pDqVNjjOfNK
         QUL4T05lH3g4t7UHkYEDLzEvXJ7pFeqgrbQa2qzul15xRJU5WeV85siwCCJWDDvdq1
         DcmvPL3Sm9y9Tnm0Km+9qXkc6SckFbxVN26LUL2u4QcvMWH30CriGmtiHxA62p02bj
         BOLjc/DliDwhyq0jlQ/2yyrH5w1wK1Ph3e8QEj4G5MrmsLvbOBKZj0UujrYsVSVSYX
         sjnRFdl57nnNg==
Date:   Wed, 19 Jul 2023 10:08:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V4 net-next] net: mana: Configure hwc timeout from
 hardware
Message-ID: <20230719070826.GF8808@unreal>
References: <1689703232-24858-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689703232-24858-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 18, 2023 at 11:00:32AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value. This patch sets the hwc
> timeout from the hardware. It now uses a new hardware capability
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> in hwc_timeout.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V3 -> V4:
> * Changing branch to net-next.
> * Changed the commit message to 75 chars per line.
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 30 ++++++++++++++++++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 25 +++++++++++++++-
>  include/net/mana/gdma.h                       | 20 ++++++++++++-
>  include/net/mana/hw_channel.h                 |  5 ++++
>  4 files changed, 77 insertions(+), 3 deletions(-)

<...>

>  	gc->hwc.driver_data = NULL;
>  	gc->hwc.gdma_context = NULL;
> @@ -818,6 +839,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  		dest_vrq = hwc->pf_dest_vrq_id;
>  		dest_vrcq = hwc->pf_dest_vrcq_id;
>  	}
> +	dev_err(hwc->dev, "HWC: timeout %u ms\n", hwc->hwc_timeout);

Why do you print this message every time and with error level?
Probably you should delete it.

Thanks
