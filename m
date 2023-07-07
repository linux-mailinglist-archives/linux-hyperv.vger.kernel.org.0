Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDA74AF0E
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jul 2023 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGGKv5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jul 2023 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjGGKvr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jul 2023 06:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC341FEE;
        Fri,  7 Jul 2023 03:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E9A618F4;
        Fri,  7 Jul 2023 10:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABADC433C8;
        Fri,  7 Jul 2023 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688727090;
        bh=dMjQvPWxzVC76cHGIJsn2XnTQOoQzkZMZV+Gp6SjNoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzXWq+TsLd9+UoSFGQPsmq3hgM4LcY9udSFATS9UWuXZiFNJWyB3yGhLH7RM4CS3l
         9KnIQzdut1CSiROHnyHybMwykGtwNtpvZxhABiQgFqpj9OjaVHaGo2rnD77OuC49hV
         1TRpdcEC8jDYEl6uSbrXQ3usPjzg2JnOKsHPoT34=
Date:   Fri, 7 Jul 2023 11:16:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Message-ID: <2023070734-skimming-snack-838c@gregkh>
References: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 07, 2023 at 02:45:28AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.

This really does not describe what is happening here.  Please read the
documentation for how to write a good changelog text.

> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V1 -> V2:
> * Added return check for mana_gd_query_hwc_timeout
> * Removed dev_err from mana_gd_query_hwc_timeout

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
