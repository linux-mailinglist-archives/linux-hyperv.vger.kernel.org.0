Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316CB593298
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Aug 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiHOP4P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiHOP4M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 11:56:12 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9536D12D32;
        Mon, 15 Aug 2022 08:56:11 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id b4so6428671wrn.4;
        Mon, 15 Aug 2022 08:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Vat6AZoY9+pk6p00nX/E13J/m0/mJwwh8QQBSGedRWI=;
        b=iYe9lM3I2HfiLa/RejGyvAT1+FOoPhMX+L577RycoUNZOyMrdGNKLhOgNUdK4nTc+/
         ardycnvQ2omH44g+pJmvHgMuxvOzBae4dffWT+REVO2e92Oj0m/Vpvar5qOeBz08jDcb
         wmgXH5Gz+mvE35GAbZRS//lvYMNjqgEG1HGYlywhDja3QQ1RL+gxtNFW+cwH9UDA6e+O
         e4jgwEsH0sGhUoB9WZw4s3Cv5mxDjUlHPoW2OVtfp0K6tB+krrxoZebEYnxUcIBNcbPc
         50QZ4sSTwWUXg7xrecMma7M9PNgiIoVxxxYVmrGCgDaswKLu451m3HH2FpCQIZ0hV5y9
         tMFg==
X-Gm-Message-State: ACgBeo3b4w04HsKUNmFY1U/tJTeYi9LjySPiZxVZR7uWz/LDOVWcc5hR
        JXoAKulDFBEhdZ6v0kTBX7s=
X-Google-Smtp-Source: AA6agR6LqwBwhr8IBNtL5BKxuU4r3Y+LjMPMFEeYwRcLmbQKw/Ljf/Ui34QWaaHHynm6D1Y8i9VY5g==
X-Received: by 2002:a05:6000:1e0e:b0:220:5c9f:a468 with SMTP id bj14-20020a0560001e0e00b002205c9fa468mr8849712wrb.587.1660578970160;
        Mon, 15 Aug 2022 08:56:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d488f000000b0022395a63153sm7800412wrq.107.2022.08.15.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:56:09 -0700 (PDT)
Date:   Mon, 15 Aug 2022 15:56:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Deepak Rawat <drawat.floss@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drm/hyperv: Fix an error handling path in
 hyperv_vmbus_probe()
Message-ID: <20220815155608.uekossy5hejqflni@liuwe-devbox-debian-v2>
References: <7dfa372af3e35fbb1d6f157183dfef2e4512d3be.1659297696.git.christophe.jaillet@wanadoo.fr>
 <PH0PR21MB3025D61C85CD6E724919A9D8D79E9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025D61C85CD6E724919A9D8D79E9@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 05, 2022 at 06:35:01PM +0000, Michael Kelley (LINUX) wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr> Sent: Sunday, July 31, 2022 1:02 PM
> > 
> > hyperv_setup_vram() calls vmbus_allocate_mmio().
> > This must be undone in the error handling path of the probe, as already
> > done in the remove function.
> > 
> > This patch depends on commit a0ab5abced55 ("drm/hyperv : Removing the
> > restruction of VRAM allocation with PCI bar size").
> > Without it, something like what is done in commit e048834c209a
> > ("drm/hyperv: Fix device removal on Gen1 VMs") should be done.
> 
> Should the above paragraph be below the '---' as a comment, rather than
> part of the commit message?  It's more about staging instructions than a
> long-term record of the actual functional/code change.
> 

I don't think this paragraph needs to be in the final commit message.

> > 
> > Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
> 
> I wonder if the Fixes: dependency should be on a0ab5abced55.  As you noted,
> this patch won't apply cleanly on stable kernel versions that lack that commit,
> so we'll need a separate patch for stable if we want to make the fix there.
> 

I think a0ab5abced55 is more appropriate.

> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> All that said, the fix looks good, so
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I made the two changes listed above and applied this patch to
hyperv-fixes.

Thanks,
Wei.
