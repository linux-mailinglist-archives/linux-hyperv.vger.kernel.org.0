Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B90562653E
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiKKXRX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKXRV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:17:21 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3E1006D;
        Fri, 11 Nov 2022 15:17:20 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id k8so8228453wrh.1;
        Fri, 11 Nov 2022 15:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0BEWmljdVc1jaeWqaQcxKhZH7fFwG4obhBseQ4PCsM=;
        b=Pie6RyHKxd4zA6DxstagDGyEUho+vCUSNsCohzOLHie6toYyst0FmDf3JX1IBu93Pl
         IcV+B9Bx0Oh/eg1R9zwuWnDLUe/zf2rTGCFYY1Ls/4cfBbeCeUjMEwdNiAucaMcnl8qS
         z+x+ShJ+wHSt1Hm5mI/6czvsLSLdbB+D0HWZfqm5UzXYpcEUkZEm/tQ1ojm5o4XPdcMu
         20MTOoREEpEmEXNjgjL0Kb2lWHyCFGK0zLGNsAkijLDhKeSC2UxBK6W833ynKkIUx0SA
         hT5AW7o56YORakxbCxDYoV2WW9nICdgBneduQAQTgWf2W4nmxMRraKsUA4pC0Tnoavvp
         w8cQ==
X-Gm-Message-State: ANoB5pnkdksZuPUIF5dWypmFt7HjOf8bVXWbDv7+NKFOGkq9UNl1wQg9
        6UTQ4cVzlgqWn4KurG+Y2uc=
X-Google-Smtp-Source: AA0mqf6SL3jQX6n5ihsTqJkfK9gi7ejk39Bm0kr8+FBD/ghZXQOqfZ7WZb1bIFsrvcprqraca8K48g==
X-Received: by 2002:adf:e344:0:b0:238:3dc7:2adc with SMTP id n4-20020adfe344000000b002383dc72adcmr2385457wrj.160.1668208639218;
        Fri, 11 Nov 2022 15:17:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q13-20020adfea0d000000b0023677fd2657sm2926782wrm.52.2022.11.11.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:17:18 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:17:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] hv: fix comment typo in vmbus_channel/low_latency
Message-ID: <Y27X/BCqiVtRrt2o@liuwe-devbox-debian-v2>
References: <20221105115401.21592-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105115401.21592-1-olaf@aepfle.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 05, 2022 at 11:54:01AM +0000, Olaf Hering wrote:
> morev vs. more.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Queued to hyperv-next. Thanks.
