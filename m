Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968484AF42E
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiBIOgQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 09:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBIOgP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 09:36:15 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20FC06157B;
        Wed,  9 Feb 2022 06:36:17 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id h6so4382849wrb.9;
        Wed, 09 Feb 2022 06:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDy4Lk2MySKM/19GlYVgEh5OHE3c2OCP46qjCmjP6RM=;
        b=S2iqiM+kvuLs365jLzt3ttOYo2IbRoE7q1ooEm9Ysik8WfCJZ222utkTJpk0B6155X
         gQZkweH2m7YAmn4+rV/gyEEjGkCS7/yg8CO3XSlnf3RvF61QP1o/rqlcJIkEha0Nblg2
         SxQL7NwJIVLbnF+0ROXqw5a1jGxBXM8Fm78/PSOdrJMesPWHbhHMkCv7ClCvMxNKds2u
         0siMrKF3tuWKr1wm8UsbYNLdVYaVIhixFu/2UC55zLmjLd34zLnyBEuru1cRqPDM7R+p
         Vb/61V5RygaodUa0GzFHNMIbGNgBD8s4XD2hcH8Wt4ZJYCC2KDl08kyOeHVvc9r9Onby
         Z+SQ==
X-Gm-Message-State: AOAM531WQEEM55+OeXyHlCio/yq4Lm5S5vLS2y3CZJnZvR01rBFzTsCG
        VsrbLL4bnMgfZ/M/YWaryiM=
X-Google-Smtp-Source: ABdhPJyzXomL2e2GnxknTm6AymQm5QOKRSELuhMabDu8wCrFDn8JV93QitSUNCXlwRdtzWzY+Y/19w==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr2329619wrb.87.1644417376099;
        Wed, 09 Feb 2022 06:36:16 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o16sm3610042wmc.25.2022.02.09.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:36:15 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:36:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: utils: Make use of the helper macro
 LIST_HEAD()
Message-ID: <20220209143613.forbf5chbexnfad5@liuwe-devbox-debian-v2>
References: <20220209032251.37362-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209032251.37362-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 09, 2022 at 11:22:51AM +0800, Cai Huoqing wrote:
> Replace "struct list_head head = LIST_HEAD_INIT(head)" with
> "LIST_HEAD(head)" to simplify the code.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

Applied to hyperv-fixes. Thanks.

> ---
>  drivers/hv/hv_utils_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
> index eb2833d2b5d0..832885198643 100644
> --- a/drivers/hv/hv_utils_transport.c
> +++ b/drivers/hv/hv_utils_transport.c
> @@ -13,7 +13,7 @@
>  #include "hv_utils_transport.h"
>  
>  static DEFINE_SPINLOCK(hvt_list_lock);
> -static struct list_head hvt_list = LIST_HEAD_INIT(hvt_list);
> +static LIST_HEAD(hvt_list);
>  
>  static void hvt_reset(struct hvutil_transport *hvt)
>  {
> -- 
> 2.25.1
> 
