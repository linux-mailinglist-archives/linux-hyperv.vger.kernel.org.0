Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767F52F002
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 May 2022 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiETQFC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 May 2022 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbiETQFB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 May 2022 12:05:01 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF4179961;
        Fri, 20 May 2022 09:05:00 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id t6so12100877wra.4;
        Fri, 20 May 2022 09:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znA8cfMsy9necYNeW0un5CDeTQYcG+NaGrcgbE7Qc9U=;
        b=If+puf/v/sWHGEFMN7gLHRJi/sF17ZR+6vhHST7lPeZpCI7yOsgHM5hQf4E9UXfAnr
         ZnxXeIv5CFZEh7ZmbjOy2FPNyKyhnYJXN+zW5Sce8HPuyABGBxDaRz0CGVo2nrjVV4Qu
         weuy57OzA9nNWYbW/0SjSFb1FtVjElTy6PwW9OTq+rDZGcM4cYsC9gdNugDcuOhPZRwC
         BpBRgyhIY7Eo83N8WNcOUsDOhjYx1aXCEsbNh2nCRQXPJPM8wXAAPpgOW2gr5MfGyilc
         9zA200SZ9IASuV4s2I2GF2viAIxokgmitUmhxO3uiy4kwfbHjygG0V8hW1qF01LvArkF
         KV2Q==
X-Gm-Message-State: AOAM5338IRq/EyxBvhQ044Rcf3iLrIxqIzV/UukCo/z2zOw78QobpvAw
        RkK+Biik4jZ8mcPIY7F+/t8=
X-Google-Smtp-Source: ABdhPJzVBU9OT5V2aJFBxPSjcscT22BehkQdcY4NBwEls+uES4fYLVTSlw50QD9SuzILMGH2C/O7fA==
X-Received: by 2002:adf:dd81:0:b0:20e:5853:1762 with SMTP id x1-20020adfdd81000000b0020e58531762mr8993811wrl.447.1653062698678;
        Fri, 20 May 2022 09:04:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17-20020adfa151000000b0020d00174eabsm2781202wrr.94.2022.05.20.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:04:58 -0700 (PDT)
Date:   Fri, 20 May 2022 16:04:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, haiyangz@microsoft.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drm/hyperv : Removing the restruction of VRAM allocation
 with PCI bar size
Message-ID: <20220520160456.3ibns7xyx7jv236d@liuwe-devbox-debian-v2>
References: <1653031240-13623-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653031240-13623-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 20, 2022 at 12:20:40AM -0700, Saurabh Sengar wrote:
> There were two different approaches getting used in this driver to
> allocate vram:
> 	1. VRAM allocation from PCI region for Gen1
> 	2. VRAM alloaction from MMIO region for Gen2
> First approach limilts the vram to PCI BAR size, which is 64 MB in most
> legacy systems. This limits the maximum resolution to be restricted to
> 64 MB size, and with recent conclusion on fbdev issue its concluded to have
> similar allocation strategy for both Gen1 and Gen2. This patch unifies
> the Gen1 and Gen2 vram allocation strategy.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> FBdev patch Ref :
> https://lore.kernel.org/lkml/20220428143746.sya775ro5zi3kgm3@liuwe-devbox-debian-v2/T/
> 
[...]
> -static int hyperv_setup_gen2(struct hyperv_drm_device *hv,
> -			     struct hv_device *hdev)
> +static int hyperv_setup_gen(struct hyperv_drm_device *hv,
> +			    struct hv_device *hdev)

There is no need to have "_gen" suffix anymore.

I don't know much about the rest so cannot really make any meaningful
comment here.

Thanks,
Wei.
