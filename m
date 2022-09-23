Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D335E7806
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIWKPq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIWKPm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 06:15:42 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D92604;
        Fri, 23 Sep 2022 03:15:40 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2940037wmb.0;
        Fri, 23 Sep 2022 03:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H3k8nwYg9LM+0smtYDMfCrY2rja+gudmrYIAx1+mEps=;
        b=6/f8awuQNJ0pRmjE7SjNSRROM1eCeYPgvkSN0GPMjn/WBJh2zoeTL4X52y/aixVSss
         Gh3Gu4AtDakwpyrL4N6e9RGJGxH282rc7fBov32flqvO8NsuIkHQh1lcm3Zvyk3oOWO2
         Q1pMqEUqXKuWzb5hhckFN6qZ4NxYjSvARjA9E0ocpn2ZoaP9WQIHYSv/PGCy+PLpf8jM
         Jc5q9TS997twPCVoLul0z861BwyEdlOlq06eWF8iUQFf6+dhVQXT/eRIpnypMRznRRCU
         Ncx/K+dnJKt87AomFYiP6gK47WsCGUu+bQpk2GWflDxO8XE+N1AMZd445Z4qh7q0PUYa
         Ov/w==
X-Gm-Message-State: ACrzQf2sRJUDurHby/PhsWmfCgihioiQMGlDKDadTwyH1XdPq1hMyS7L
        o2fA60EPUeXEW9DbuplPTucfuZHbh4A=
X-Google-Smtp-Source: AMsMyM6uVc1utll1leFSA3Ob9+kmyV0+mvx+mZpkH4OV2fn7yg3XyYhCkjXBv8PD3H23g3832TOSOw==
X-Received: by 2002:a05:600c:2b88:b0:3b4:8680:165b with SMTP id j8-20020a05600c2b8800b003b48680165bmr13130181wmc.113.1663928138757;
        Fri, 23 Sep 2022 03:15:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c2ca600b003b4c40378casm2165673wmc.39.2022.09.23.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:15:38 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:15:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drm/hyperv: Don't overwrite dirt_needed value set by host
Message-ID: <Yy2HSKb4AtcF+em6@liuwe-devbox-debian-v2>
References: <1662996766-19304-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662996766-19304-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 12, 2022 at 08:32:46AM -0700, Saurabh Sengar wrote:
> Existing code is causing a race condition where dirt_needed value is
> already set by the host and gets overwritten with default value. Remove
> this default setting of dirt_needed, to avoid overwriting the value
> received in the channel callback set by vmbus_open. Removing this
> setting also means the default value for dirt_needed is changed to false
> as it's allocated by kzalloc which is similar to legacy hyperv_fb driver.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-next. Thanks.

I ended up reconstructing the patch myself since the said driver
changed. It is only a one line change so that's fine. If the committed
patch is wrong, please let me know.
