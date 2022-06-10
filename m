Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DF545F78
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jun 2022 10:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbiFJIki (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Jun 2022 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbiFJIki (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jun 2022 04:40:38 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E341A5;
        Fri, 10 Jun 2022 01:40:37 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so803940wmq.0;
        Fri, 10 Jun 2022 01:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztq4k3KUPkKf4HUs/0KYVoq6RFzFscI/AU5d2/079VY=;
        b=0Z/HATVtdJxGJ4Fd4/G/QwZILxgDvo86fBR/vnqIrUkKCki5H3ma+9nQPJxAks0OK5
         WRy7yL3br6970z+NBFo+uYCsAGbY/ndtgWnNhwBTUalcE1M9mGqQhEBHH29XAOmP/qez
         x8UJrtQ62zSgzRnSmZmnd0b+vkl5QX+FATScGm98RH3ncUEyA1z//EFzF08DtFeLwDdk
         m6kE6HIUkJwvETF7Zz3IkJ9Zz4erLaLvyeKEK3S3tYDQhcgobAxSfHxH/67jGXhON+2s
         +4oOuWPNxeb46X1o9cPcbC7jpYIr3Ge2wz4rpTQWshpo17HvMWReEyledcSnalbXhtWb
         zq7g==
X-Gm-Message-State: AOAM5335dW+en9sKVFy214ndBvMXvCGE1gLBk4t1mzuYQnD7+i+SpDTj
        FH0zxHCP61LudLCkE5S48Fg=
X-Google-Smtp-Source: ABdhPJyQtOeBG1bBmUjSZGZ8BW8JYMPPtMA6gpFagh2WNHrMfZnGM2P6qHsHBdknbAwB+oOQ/gdRFA==
X-Received: by 2002:a05:600c:190b:b0:39c:7704:74a4 with SMTP id j11-20020a05600c190b00b0039c770474a4mr4333763wmq.92.1654850435757;
        Fri, 10 Jun 2022 01:40:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003975c7058bfsm2172199wmz.12.2022.06.10.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:40:35 -0700 (PDT)
Date:   Fri, 10 Jun 2022 08:40:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Release cpu lock in error case
Message-ID: <20220610084033.r6llz4dadlw6gyoz@liuwe-devbox-debian-v2>
References: <1654794996-13244-1-git-send-email-ssengar@linux.microsoft.com>
 <PH0PR21MB30259484AB91D8EA2DEBD3E7D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30259484AB91D8EA2DEBD3E7D7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 09, 2022 at 05:39:06PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, June 9, 2022 10:17 AM
> > 
> > In case of invalid sub channel, release cpu lock before returning.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 280b529..5b12040 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -639,6 +639,7 @@ static void vmbus_process_offer(struct vmbus_channel
> > *newchannel)
> >  		 */
> >  		if (newchannel->offermsg.offer.sub_channel_index == 0) {
> >  			mutex_unlock(&vmbus_connection.channel_mutex);
> > +			cpus_read_unlock();
> >  			/*
> >  			 * Don't call free_channel(), because newchannel->kobj
> >  			 * is not initialized yet.
> > --
> > 1.8.3.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

The bug comes from a949e86c0d780.

Added a Fixes tag and applied to hyperv-fixes. Thanks.
