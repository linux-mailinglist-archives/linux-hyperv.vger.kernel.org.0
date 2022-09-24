Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3AA5E8B7F
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Sep 2022 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIXKeX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Sep 2022 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIXKeW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Sep 2022 06:34:22 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E24128A31;
        Sat, 24 Sep 2022 03:34:16 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id cc5so3439433wrb.6;
        Sat, 24 Sep 2022 03:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lWWSF5r7ARtTOClsK9sXEb7aJbRhNSyG93pnZwDgR5I=;
        b=KSyEDPTrERDbPHgI3yKjQwFOuoePdyYavdVYJm/tY+ThFTOwq8HOCNLpP89t/EYIBK
         tavLNvSlBhj9s5L4jrDB85fgqtLdE4Fstx/MZZIw4niSkjG7OKFraYC5KBarHHydAwcr
         2apbgZDmNREUwKQ++sYU8ZyWG43oTIZ+D/z7NRvSdfu8rFV0wJrrlgsIXnS2UofV+DnK
         +MbLVv5WMRkB/JOpRBhdwmnD4CVcq1cr7yBnxFTt9gvzkboFsCKTO8nG5L5CIssPLK49
         69U/B0Ke03Fdu33v0nZ56wlueeMJBdW6K/7zDIF0sutm2scnrGqu7lXViebI+8omHlv8
         GWkQ==
X-Gm-Message-State: ACrzQf0vxyCPkvz0qVKMuduANVNNgK7qLH/9Tk+YpbVGfruvdMbD7WYk
        xmQ2hFg0lF+oyGtl1/mcWhDEniv2rRI=
X-Google-Smtp-Source: AMsMyM5wNBvhEnQyq1UtD7jkcm6hZPvgsbB9LvwMs+u55ik/lB3hZLEDCOipgXROVhNjvYZFhZT5zw==
X-Received: by 2002:a05:6000:912:b0:229:9bc1:27ed with SMTP id bz18-20020a056000091200b002299bc127edmr7554875wrb.546.1664015655105;
        Sat, 24 Sep 2022 03:34:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b003a5ca627333sm4961389wmq.8.2022.09.24.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 03:34:14 -0700 (PDT)
Date:   Sat, 24 Sep 2022 10:34:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Split memcpy of flex-array
Message-ID: <Yy7dJP4p0FMQfPl5@liuwe-devbox-debian-v2>
References: <20220924030741.3345349-1-keescook@chromium.org>
 <Yy58rt9N0+dHrNtt@work>
 <202209232119.E32C14857@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209232119.E32C14857@keescook>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Kees

On Fri, Sep 23, 2022 at 09:22:55PM -0700, Kees Cook wrote:
> On Fri, Sep 23, 2022 at 10:42:38PM -0500, Gustavo A. R. Silva wrote:
> > On Fri, Sep 23, 2022 at 08:07:41PM -0700, Kees Cook wrote:
> > > To work around a misbehavior of the compiler's ability to see into
> > > composite flexible array structs (as detailed in the coming memcpy()
> > > hardening series[1]), split the memcpy() of the header and the payload
> > > so no false positive run-time overflow warning will be generated. As it
> > > turns out, this appears to actually reduce the text size:
> 
> Er, actually, I can't read/math. ;) It _does_ grow the text size. (That's
> 2_3_ not 22 at the start of the text size...) On examination, it appears
> to unroll the already inlined memcpy further.

Can you provide an updated commit message? No need to resend.

Thanks,
Wei.

> 
> > > 
> > > $ size drivers/hv/vmbus_drv.o.before drivers/hv/vmbus_drv.o
> > >    text    data     bss     dec     hex filename
> > >   22968    5239     232   28439    6f17 drivers/hv/vmbus_drv.o.before
> > >   23032    5239     232   28503    6f57 drivers/hv/vmbus_drv.o
>        ^
> 
> -Kees
> 
> -- 
> Kees Cook
