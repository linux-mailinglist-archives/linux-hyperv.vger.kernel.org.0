Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF65570A41
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiGKTBg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiGKTBf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 15:01:35 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1127172;
        Mon, 11 Jul 2022 12:01:34 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id q9so8213447wrd.8;
        Mon, 11 Jul 2022 12:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCvXsFqmGcG182YLyR0NaWgqK0wvYaWydrJj/u6gK+k=;
        b=pgRErxg1JOZ1QLvAi/T1PcH6l5eVssilD+YNVxIqU458lWtudVXP6W9F/rgfGcjKDE
         yvw/VCNJ9AHG+anH33N9LAz55tont7U3+zoIMW/Y3Q15UNctUlZR3E6QSHsGv+lWZSpj
         c0M7b+Yi0jwgJksXULkDoIwPAvGKaRVWlPi0ddbpMCon1g3xjOeF4pgBcR1blwY+ct/0
         qhTxRwGpdWbbVlq7mN9FB4BjetEN8IE/84xqRU6dLgpvvzK8HmeqzZCjqvwJI/sw2PuM
         +gy7WNR3baDFcLhi53gJhw1DE6cHE4HD7oGBqLlte2hgleu70GKZbUW9y46SplVape92
         870w==
X-Gm-Message-State: AJIora9H7r6N61lp1WmshYTHJsEbnHZ1Y/SqmEH7UVMIEHvOHRTMCCNX
        Sbp7D6wRunANP2iQuLAZx0A=
X-Google-Smtp-Source: AGRyM1scmNY4S0Xl2+XqeMETn5g9lEyU8dbM9QTy11CtbUUt2Tl01RBApZpORr/SubhUuaWXk1Ujcw==
X-Received: by 2002:adf:979b:0:b0:21d:868a:7f3b with SMTP id s27-20020adf979b000000b0021d868a7f3bmr17948046wrb.451.1657566092969;
        Mon, 11 Jul 2022 12:01:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j5-20020adff545000000b0021d864d4461sm6364819wrp.83.2022.07.11.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:01:32 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:01:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, haiyangz@microsoft.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] drm/hyperv : Removing the restruction of VRAM
 allocation with PCI bar size
Message-ID: <20220711190120.jbbbwmp5rhlopuoh@liuwe-devbox-debian-v2>
References: <1653143019-20032-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653143019-20032-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 21, 2022 at 07:23:39AM -0700, Saurabh Sengar wrote:
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
> Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

Applied to hyperv-next. Thanks.
