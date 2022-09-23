Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335685E7880
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIWKjH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiIWKjH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 06:39:07 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202B12166F;
        Fri, 23 Sep 2022 03:39:06 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r7so19810195wrm.2;
        Fri, 23 Sep 2022 03:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lI9ioZ6SWSu0Hxa5+iiWA6dEbOyb2TvEjFcgrjURf/E=;
        b=UmIGXv72PLu0kdsEyl+XT/X0S83sGX0ee5PYcZUPhtJ+kVlaHmBPYzKzwhS4PV5/EB
         0tPhG+cxOGBbrGJCcZxSQBgHAXojZ2M/AGPs9GOJmT3NUabfIPOiB/FClMlS3TcVDUmw
         8jpWePinBnhlg80NTNIZts+PR1Hhm2W8g8DLNuKGXIkQtx+6YG4CCpm8f1pm7nmg/CsN
         I5sTDcXzdTBFUpoyYYoB1kvkWBXqb3K883za9nG+o7p7plhjguivsOJLOq0GW7zFk3Si
         cYj+GBaUZYL+OLo0L1z1PuRBCFdKYk1PUW91ZFJ+BOhdtuoLHO1QFMZM2fH+wTnxMt1h
         CVJg==
X-Gm-Message-State: ACrzQf2G6nTwRZp86NQkyYWZbNo5cajfzvwHPGWuKbNfvOJEI5vWopvG
        vn1nu0qsT7vgvlY+8ggs5HQ=
X-Google-Smtp-Source: AMsMyM55lRbLnC1czVS8SyVylW1rsSJ/WUjJb9uCF6PQ/zDJAfHoIzo+ZB4i8v/TUaNkokHpvTPBqg==
X-Received: by 2002:a5d:47a9:0:b0:22a:4746:cfa7 with SMTP id 9-20020a5d47a9000000b0022a4746cfa7mr4656192wrb.368.1663929544888;
        Fri, 23 Sep 2022 03:39:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c434100b003b3401f1e24sm2019480wme.28.2022.09.23.03.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:39:04 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:39:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     skinsburskii@microsoft.com,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Message-ID: <Yy2MxoLHV99jreGK@liuwe-devbox-debian-v2>
References: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 21, 2022 at 06:39:05PM +0000, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> 
> Waiting to 5 seconds in case of missing VMBUS ACPI device is redundant as the
> device is either present already or won't be available at all.
> This patch enforces synchronous probing to make sure the bus traversal,
> happening upon driver registering will either find the device (if present) or
> not spend any additional time if device is absent.
> 
> Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Stephen Hemminger <sthemmin@microsoft.com>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Dexuan Cui <decui@microsoft.com>
> CC: linux-hyperv@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Applied to hyperv-next. I changed vmbus to VMBus in the first paragraph
and added a line break.
