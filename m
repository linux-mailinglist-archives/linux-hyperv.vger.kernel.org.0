Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C74F64A0
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Apr 2022 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiDFQCQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Apr 2022 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiDFQCC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Apr 2022 12:02:02 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85980348A71;
        Wed,  6 Apr 2022 06:32:17 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w21so3269401wra.2;
        Wed, 06 Apr 2022 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n45/GQllZHpLsSoIaHGeu++4C66jNNYdi31f28sovEQ=;
        b=UnoNUO9eVWdgTG9eVN4np9BxMZg1jsbMXnLDOaGHtjK10AlaV3nZvAYU1umYLoqopD
         EBi9jjiYCEfNhmhaY/FQ0Q0YosFk6W2ekX9dstigxQVlTJZ7grOT/NnHNPVtl6fFMXky
         Qc+kMKqEg9jX04NEAv6uQSiIMb3c+T/qXYoi58ZBpOzlbM3Te40/Rm6XDP6iG9zYlAqG
         8ufjj5m7Xzg15kPpTSiQv5RT+c3LmUHKzDI0EezReJsH+Yo80k0pCap6jqrU97ey673d
         jjNn1ZaALwwfI56c0RvafewmnJriiHPEOJPHlccXkUVR4BwTX1n+KvfBOl8/T4SCNQQ+
         xfKg==
X-Gm-Message-State: AOAM532X5dMG41IGgtzlmHoaLLffFC04MQwjSoImcokyBF3U1jXkAK0P
        9O49yC/HgINvpVW2s0CN/yfNjI+8rjM=
X-Google-Smtp-Source: ABdhPJxcxIpy7JDc5Ls7wU3C37/axtuG+ZXQuIBn6gy/2cz3FWJ5prdc0Yn9bD5aVCVgvmjrVvxOQw==
X-Received: by 2002:a5d:6cc1:0:b0:206:116e:f9c2 with SMTP id c1-20020a5d6cc1000000b00206116ef9c2mr6769900wrc.376.1649251936022;
        Wed, 06 Apr 2022 06:32:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b00205918bd86esm14510902wru.78.2022.04.06.06.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:32:15 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:32:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Replace smp_store_mb() with
 virt_store_mb()
Message-ID: <20220406133213.4ngvbhducifjxval@liuwe-devbox-debian-v2>
References: <20220328154457.100872-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328154457.100872-1-parri.andrea@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 28, 2022 at 05:44:57PM +0200, Andrea Parri (Microsoft) wrote:
> Following the recommendation in Documentation/memory-barriers.txt for
> virtual machine guests.
> 
> Fixes: 8b6a877c060ed ("Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels")
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Applied to hyperv-fixes. Thanks.
