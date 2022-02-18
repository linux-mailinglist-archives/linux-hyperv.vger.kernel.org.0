Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB64BB9D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Feb 2022 14:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiBRNJL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Feb 2022 08:09:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiBRNJL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Feb 2022 08:09:11 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6926AE0;
        Fri, 18 Feb 2022 05:08:54 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so6409038wmb.0;
        Fri, 18 Feb 2022 05:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLRoYYItaRFSQb7v3ZtTL1xufEneAUj0e5cG7bAyUuA=;
        b=wqHsF/PWcocQX6+RaHL0mzGk5seYnziFDeHEvciGktqYUooFHKnZYZhPcj0GEL+oBv
         Y5asFXjI2aum4yM3JtSkghnnqlv4Pj1B7XRO8nHQI5Q0U9nXkrwDvSkvW6T/CsTjzJSv
         XGSkNjiiht/57sLu5ksNVuxlk0f9+BvzxCOBpkx4gCgM8sITIpAB0XlkgR6wPTH2wm73
         vmWsnQWF0E+gGNjM+XD8bAiKaGRuy63fNWj5nhgRGnjovF9RPJ7x0lYErRgBGTJR9/Mi
         urcqI9Yy/rYHBtkjMVy8ejvsiDRjQgTu2ZSIi2UYHZizn5/2iUjG4JTP4anIBwXFKAew
         SzeA==
X-Gm-Message-State: AOAM531k5zUOXWcSjtu8DDgBkss245IbXP0IgwpXKGRl5G95mWriqLXU
        wK4gKok47nnnX8C6v9KUuvNrT4meowM=
X-Google-Smtp-Source: ABdhPJy43cjFwZwEPYGnQ7ZaOIr5GqRfVOfSEPQH1GbnFQ/wJbIW4wgG1PAn2KA/xfC+zEIBNO0P5A==
X-Received: by 2002:a7b:c3d3:0:b0:37b:ea2b:55a4 with SMTP id t19-20020a7bc3d3000000b0037bea2b55a4mr7119758wmj.85.1645189733419;
        Fri, 18 Feb 2022 05:08:53 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f25sm4027574wml.16.2022.02.18.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:08:52 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:08:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com
Subject: Re: [PATCH 1/1] hv_utils: Add comment about max VMbus packet size in
 VSS driver
Message-ID: <20220218130851.2afjdrmhov2qzlu3@liuwe-devbox-debian-v2>
References: <1644423070-75125-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644423070-75125-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 09, 2022 at 08:11:10AM -0800, Michael Kelley wrote:
> The VSS driver allocates a VMbus receive buffer significantly
> larger than sizeof(hv_vss_msg), with no explanation. To help
> prevent future mistakes, add a #define and comment about why
> this is done.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
