Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173D5EDDCA
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Sep 2022 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiI1NgN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Sep 2022 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiI1NgM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Sep 2022 09:36:12 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9828F94F;
        Wed, 28 Sep 2022 06:36:10 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id e18so8534611wmq.3;
        Wed, 28 Sep 2022 06:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+upmZyPR8pGaGWg3qGrftmKuUaoiKJ3WqmjmIjDKj5A=;
        b=bxYWQhxUAA+cMpbiJJiaAzimhOrUQs9oQGvBQaN+HEPJ3+fOHZA7hDfC4M/srApOSW
         +/5svgfd8WAgTqCm+d/IyK/W0x3P6A7cAVYlW1bjmpsXKAI3WYMU21T0Y4I6lWik4hdG
         4XEQ+JNY40+RbljsjdGhXfZxMAQjPOG9O5pZpe+psvkVJkMZvaF2jsClbZQBVgbdYPS+
         tGFMB8+fCvSrzauJTvDqZr9SuLq08vrLyy+MLJEN4PqOxp/ru+/ZlDiWZC/am4/iUuRd
         tTE9wrPjVg3hQR+23X2MkEN0GIQFKHD91gjujIncmWebo11gM15vCkVvs3QjAGMG795E
         rbyA==
X-Gm-Message-State: ACrzQf0En1t4hwwhlbAO/twGl60acwXylO30bRo+EKDMsRIAxX/+uwLa
        qOUXC7qVvY01t/AW3kgBJ/N+dNuFp6k=
X-Google-Smtp-Source: AMsMyM5ovkU45Hb+UhdT9G4vPLHy2nketpUXDU/UlqlM/OAJFNTmeY50h/wIWr4zAo4geMlNy7Anyg==
X-Received: by 2002:a05:600c:3c8a:b0:3b4:eff4:a94f with SMTP id bg10-20020a05600c3c8a00b003b4eff4a94fmr6698611wmb.105.1664372169187;
        Wed, 28 Sep 2022 06:36:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b003b31c560a0csm1818654wmq.12.2022.09.28.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:36:08 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:36:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <YzRNxs6bVtNZdtNH@liuwe-devbox-debian-v2>
References: <20220927211736.3241175-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927211736.3241175-1-keescook@chromium.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

Applied to hyperv-next. Thanks.
