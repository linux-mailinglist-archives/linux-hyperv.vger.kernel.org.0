Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356F596D41
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Aug 2022 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiHQLC0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Aug 2022 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiHQLCX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Aug 2022 07:02:23 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839826AC8;
        Wed, 17 Aug 2022 04:02:22 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id n7so4577986wrv.4;
        Wed, 17 Aug 2022 04:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aU/Z8BYNJcVbl+KViRniteM3e0PBEUPJ/YwncIhBo54=;
        b=DuaTBZ+qVn9X8wzfhGzkuY/rVuhGW8sTm6LHfTkbm4a1lWgl1FJrpqYMvygTNDypYx
         6uFgZAULVUBfPBV3ZraTyFKjrY+pgIXTI56eIa9lQkAnZ4t7Ptil9W3I8V25uExHHAQK
         I3RQXm9Qk+94dB8FvLDHtemPgCQikLNB4441Sl2PUmWMQ+MsxsOFa6UgbENpDZGysFNj
         UY5uuQuF6LnelsF6lZy55gE9BWF8EqhnlD8PmIC3/uiX1g7aaOB3uixmpGE4vb6Qpq3Y
         Zltr84MJxjmTpaSDHqLgBic9alzYLbJKwwYqQHR6XfMBDSA1jgqqLW+s60Zh6b2nVog2
         KN3w==
X-Gm-Message-State: ACgBeo2n9rJuXh3o4V7i/JnNizA6KIlpLNWq0ZzWNZ+/D/o7G0IfuP4c
        Ys+8q2BWcQMqqHiG/cEVXsg=
X-Google-Smtp-Source: AA6agR5rLF2r/cfPnJjPm12y7EN+dDOnYfJcDvCF9DD+YK9+7gHbkU+IV6j65dWYtzcdJ18GvooL2g==
X-Received: by 2002:a05:6000:61c:b0:220:6425:c113 with SMTP id bn28-20020a056000061c00b002206425c113mr14577361wrb.612.1660734140485;
        Wed, 17 Aug 2022 04:02:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p63-20020a1c2942000000b003a60f0f34b7sm1681631wmp.40.2022.08.17.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:02:20 -0700 (PDT)
Date:   Wed, 17 Aug 2022 11:02:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: hv: Fix comment typo
Message-ID: <20220817110218.d5t4v6zpvo2jpxqc@liuwe-devbox-debian-v2>
References: <20220816172309.7072-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816172309.7072-1-gaoxin@cdjrlc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 17, 2022 at 01:23:09AM +0800, Xin Gao wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

I got a patch with the exact content and commit message. It was applied
some days ago.

Is Jason Wang your colleague? He used the same email domain.

If so, please coordinate among your team for future patch submission.

Thanks,
Wei.

> ---
>  tools/hv/hv_kvp_daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 1e6fd6ca513b..d5ddab830b6b 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -43,7 +43,7 @@
>  #include <getopt.h>
>  
>  /*
> - * KVP protocol: The user mode component first registers with the
> + * KVP protocol: The user mode component first registers with
>   * the kernel component. Subsequently, the kernel component requests, data
>   * for the specified keys. In response to this message the user mode component
>   * fills in the value corresponding to the specified key. We overload the
> -- 
> 2.30.2
> 
