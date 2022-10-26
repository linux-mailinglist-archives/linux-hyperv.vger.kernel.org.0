Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DB960E457
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Oct 2022 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiJZPSZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiJZPSY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 11:18:24 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977E127BC9;
        Wed, 26 Oct 2022 08:18:22 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id y16so16451776wrt.12;
        Wed, 26 Oct 2022 08:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqs9LODvusyxzeQy4mNtd1vsryLD8O0dAcHksfGNQrc=;
        b=ofdMdXp1mlMwx5kGFP5Rqt5zhnzfLu5R5kfhduNdMPxfCmOPss22wMhitMyPARgY59
         WkCudKflE8YTqDIbij8SBpmXTwB7MoiL9XXLu4PWq/EpBUix8lcOS7Azjje64HMdgz/v
         8S5Het0KBGpEj6JGmVej6XecLIeUwkJl+aWps8K5qfCfmr7WDtDHbMXk9nSxBbzsoBQt
         IU9rXNrsOOkHE+xf4WsR/OmF20U+PJhxMHxZq9ZLFCwrvg210O+uqcY0z18oYVUKY0vc
         B6Ys5dt6RPg6W2wKoQbi2dYGI5D+v6yAx4C/Yt6tqXpbhOp/LYr3myThO3nnRhT6KK0Z
         g5NA==
X-Gm-Message-State: ACrzQf1KWLlm3em3VE2zjRLktqY1J5GWJhXVbvxmJ+/9pdht89uztcau
        GwLsMs1uNAq6vUGXxUS6q5kNcvEfNpc=
X-Google-Smtp-Source: AMsMyM566g2uBtQgqmY/UFF6VWok10/8roEU0X8jNJdr5NXsG+HOawNEuW0alUENGAJDgaxszqgFbg==
X-Received: by 2002:a5d:4bcd:0:b0:236:6b67:a5be with SMTP id l13-20020a5d4bcd000000b002366b67a5bemr12456685wrt.81.1666797501147;
        Wed, 26 Oct 2022 08:18:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003c43dc42b4dsm2382390wmq.16.2022.10.26.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:18:20 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:18:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: fix repeated words in comments
Message-ID: <Y1lPu06G/1e63WJ/@liuwe-devbox-debian-v2>
References: <20221019125604.52999-1-yuanjilin@cdjrlc.com>
 <BYAPR21MB168811F3B497B61177324F94D72E9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168811F3B497B61177324F94D72E9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 24, 2022 at 05:10:31PM +0000, Michael Kelley (LINUX) wrote:
> From: Jilin Yuan <yuanjilin@cdjrlc.com> Sent: Wednesday, October 19, 2022 5:56 AM
> > 
> > Delete the redundant word 'of'.
> > 
> > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> > ---
> >  drivers/hv/hv_balloon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index fdf6decacf06..6c127f061f06 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -905,7 +905,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
> >  			 * We have some residual hot add range
> >  			 * that needs to be hot added; hot add
> >  			 * it now. Hot add a multiple of
> > -			 * of HA_CHUNK that fully covers the pages
> > +			 * HA_CHUNK that fully covers the pages
> >  			 * we have.
> >  			 */
> >  			size = (has->end_pfn - has->ha_end_pfn);
> > --
> > 2.36.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
