Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229205EFA7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Sep 2022 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiI2QaX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Sep 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiI2Q3c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 12:29:32 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CDD135057;
        Thu, 29 Sep 2022 09:28:58 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id o5so1330628wms.1;
        Thu, 29 Sep 2022 09:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QYOc+OHLL6KTLMFJnSaBlHOJKuyxaHY1IrKcRU6FlxE=;
        b=CWRRvBk7e6CRy+HWfhbVqQBhfq7vHbBhR3wLtt0iFVoC7McAoLtFTGBSXOlVSW24/2
         TFMTMrsrFdEkibFX+Bp9vkxV6M9TOvxvMcpeePLx2dqqEtyh/6TSNGGCj+JCpQm2G+ia
         mAvL38nkXYRIJXLMa4LcH8EujtvXA/lWt8aLzVhBeXzH9LkMiu2uAiruY8dmrCwq9VaU
         AsOPRXto0XNPkt0V+bBvJw7VY1+Zlnm+OGEeRxKwZ7lWP/v4XajMg78ncbhnntmP31HQ
         F3cxb5Kl8Y2VMp0apHWRHOk09VKXsuq0s71kkPagBvhvHQlgPDcptqxypU5NrtD34zkO
         qD3Q==
X-Gm-Message-State: ACrzQf0Rburto51+srZIVNcUZVBAzPAtauIJZZBSIVUep7TvQfnizvDn
        urA/3oBxVS6lhBXJ0l5POLU=
X-Google-Smtp-Source: AMsMyM5b/OYKlGx3DqtnOYo7cHOWYylUcTVvTbFZnkntH3B86vTEuk1JHoRmIuzJA2Zq7X3vY5YMPw==
X-Received: by 2002:a05:600c:a14e:b0:3b4:7ff1:299b with SMTP id ib14-20020a05600ca14e00b003b47ff1299bmr11387647wmb.18.1664468935378;
        Thu, 29 Sep 2022 09:28:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b00228d7078c4esm7232054wrm.4.2022.09.29.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:28:54 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:28:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, ssengar@microsoft.com,
        drawat.floss@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drm/hyperv: Add ratelimit on error message
Message-ID: <YzXHxf/5WaiIrqMi@liuwe-devbox-debian-v2>
References: <1662736193-31379-1-git-send-email-ssengar@linux.microsoft.com>
 <88fab56a-f6e5-bae0-5ed7-1e01c070d136@suse.de>
 <20220911161142.GA7754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911161142.GA7754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Sep 11, 2022 at 09:11:42AM -0700, Saurabh Singh Sengar wrote:
> On Sat, Sep 10, 2022 at 08:06:05PM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 09.09.22 um 17:09 schrieb Saurabh Sengar:
> > >Due to a full ring buffer, the driver may be unable to send updates to
> > >the Hyper-V host.  But outputing the error message can make the problem
> > >worse because console output is also typically written to the frame
> > >buffer.
> > >Rate limiting the error message, also output the error code for additional
> > >diagnosability.
> > >
> > >Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > >---
> > >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > >index 76a182a..013a782 100644
> > >--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > >+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > >@@ -208,7 +208,7 @@ static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg
> > >  			       VM_PKT_DATA_INBAND, 0);
> > >  	if (ret)
> > >-		drm_err(&hv->dev, "Unable to send packet via vmbus\n");
> > >+		drm_err_ratelimited(&hv->dev, "Unable to send packet via vmbus; error %d\n", ret);
> > 
> > I better option would probably be drm_err_once(). Then you'd get the
> > first error message and skip all others.
> 
> Thanks for your comment however the intention here is to limit the printk messages and break the chain
> rather then printing only once. There can be cases where at different point of time we again get a
> ring buffer full condition and we don't want to miss that. We should get the message for each of these
> errror which are widely-separated in time not just the first time.

Applied to hyperv-next. Thanks.
