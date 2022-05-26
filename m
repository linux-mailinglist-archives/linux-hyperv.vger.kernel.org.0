Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E53534CF4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 May 2022 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbiEZKGA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 May 2022 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiEZKF7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 May 2022 06:05:59 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8EC9ED3;
        Thu, 26 May 2022 03:05:57 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e2so1540087wrc.1;
        Thu, 26 May 2022 03:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vXt8qkDQP1DJLJkrPjKKKNlLSx9RNHSsvQbVs7pLFqQ=;
        b=Rt1CX4WSy1Rc3RJ8MpSGHXD16pSfrS9I8JhIyxXh6dX1R0xXZH1DJ3cnpk3Z3MiD7a
         I0UsoeeqRHpsOx6hvEgyAeNeydsUdt8JWM5hjrcNcwhtsXGQ+KsgSoYuKVbc0LiTSVN8
         U8ycPhEFCWf/u7KiwqADeKBgeJtQr8erM9qWEEpylqPUGMiLZtvySpzZEJ4FneLV534x
         aOF1gBxh/08uURtenMX1+11KvChJGwikRM2uoYDks6p1jRmjGZMIDg4VC+Kb0g9bRKsj
         yEjmmakVkw8BF5vgY4308zKj7LBYm8C2ajA3mp0LjR7fFEpwKXbsA6mZ4vxU2efNZ/4y
         egqw==
X-Gm-Message-State: AOAM5314CNG+wOruWl1YaffrbMH7RcY3xyIGaWMazFi7SrOQubZO28sM
        qC3w+FlYTYGQqg8+1bf8AXz2BB6X68c=
X-Google-Smtp-Source: ABdhPJygtj7Rh2U2sOz/ru967x/dHEgixHfSvSoWLNyH8TTooupvc/kB9HAi8HuueVqOY0C7LF7T8g==
X-Received: by 2002:a05:6000:162b:b0:20f:fb06:ba97 with SMTP id v11-20020a056000162b00b0020ffb06ba97mr8048732wrb.158.1653559555814;
        Thu, 26 May 2022 03:05:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0039746638d6esm1489440wmq.33.2022.05.26.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:05:55 -0700 (PDT)
Date:   Thu, 26 May 2022 10:05:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_balloon: Fix balloon_probe() and balloon_remove()
 error handling
Message-ID: <20220526100553.mmdulkk4qalwrxcw@liuwe-devbox-debian-v2>
References: <20220516045058.GA7933@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PH0PR21MB3025868F7B32571C7D009BBFD7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025868F7B32571C7D009BBFD7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 24, 2022 at 12:29:18AM +0000, Michael Kelley (LINUX) wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > 
> > Add missing cleanup in balloon_probe() if the call to
> > balloon_connect_vsp() fails.  Also correctly handle cleanup in
> > balloon_remove() when dm_state is DM_INIT_ERROR because
> > balloon_resume() failed.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
> > 
[...]
> > --
> > 2.17.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
