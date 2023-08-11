Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CEB778988
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjHKJO6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjHKJO5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 05:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F80E68
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Aug 2023 02:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9875566CC7
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Aug 2023 09:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF909C433C7;
        Fri, 11 Aug 2023 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691745296;
        bh=ymeofN/mQflkFKxsxeSW0AByntlJMVKRyAxL76P/EVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jT0KT0Qnk7yACQvD6fCIFku6GUhOzZNU6i0qn31cIyuTlbD0k+IHO3Wb30VR0N8C+
         gn6w4pWojEy2moHYoiLfj/kKJrccenZAEisj079RuoNsgbdlMRLy4lFvw2t/SIaV2T
         BNnkGNOdGqHwZvkw0wtZxUieNLfEl4WDd3guvcV+hjqA+d9R8xJUJ1zaDC1atuExGz
         Rl5Vim4/K3Kfpj8w9WOCqKfYtchVG30RtDA+ZcgCeT9HOMjvwD1Yy+cKQ6Uw4TnFzz
         szr3rQW166ypMPOrh6rzQOoSTL0oOZY/GksdpsllSyCZ3Xd7/8Nt+pC1Ffx//8JPG5
         ydNQuYxKRxm5g==
Date:   Fri, 11 Aug 2023 11:14:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH -next] hv_netvsc: Remove duplicated include
Message-ID: <ZNX8CyvnsP0zhmbA@vergenet.net>
References: <20230810115148.21332-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810115148.21332-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 10, 2023 at 07:51:48PM +0800, GUO Zihua wrote:
> Remove duplicated include of linux/slab.h.  Resolves checkincludes message.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

The patch looks fine, but for reference, I do have some feedback
from a process point of view. It's probably not necessary to
repost because of these. But do keep them in mind if you have
to post a v2 for some other reason, and for future patch submissions.

* As a non bugfix for Networking code this should likely be targeted
  at the net-next tree - the net tree is used for bug fixes.
  And the target tree should be noted in the subject.

  Subject: [PATCH net-next] ...

* Please use the following command to generate the
  CC list for Networking patches

  ./scripts/get_maintainer.pl --git-min-percent 2 this.patch

  In this case, the following, now CCed, should be included:

  - Jakub Kicinski <kuba@kernel.org>
  - Eric Dumazet <edumazet@google.com>
  - "David S. Miller" <davem@davemloft.net>
  - Paolo Abeni <pabeni@redhat.com>

* Please do read the process guide

  https://kernel.org/doc/html/latest/process/maintainer-netdev.html

The above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/hyperv/rndis_filter.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index af95947a87c5..ecc2128ca9b7 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -21,7 +21,6 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/string.h>
> -#include <linux/slab.h>
>  
>  #include "hyperv_net.h"
>  #include "netvsc_trace.h"
> -- 
> 2.17.1
> 
> 
