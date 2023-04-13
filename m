Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912906E0395
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDMBRy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMBRu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:17:50 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85047684;
        Wed, 12 Apr 2023 18:17:48 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso12217354wmr.0;
        Wed, 12 Apr 2023 18:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348667; x=1683940667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2Et2YcVTo5xUyvh2X7Aphr8Wh2NR6RLykrvrM2pcjc=;
        b=cGCJjhtGJVSx09NE6gyLgjQ7O8WDy9OCQ091Fcj1VFfkk3rolxbZw66uLxDbGVztV8
         9IQbW2cNWSRC/JC5ubZqU0vQcWKlSiBQ+Mf9gy4Ek5WB9ZUMRg2Ea8Dhlrn4WNDD58bV
         njdQRF0TMpBQUfCaUt3caqZd0ID1ekwruaWfC1S5c8Gbo4GBqxEMuWBwirnxLkqlEBS/
         pjs+lFZ2vutxHGkcsVeSgalWiBUnJqDI9VarErF/WTqPAZKDSRL3lPBPImLFJVdjro0g
         3v9kpO4I0BoZcztL9M9zpewgkootBvbiI8gyg6mvzeeXWq/O27xSEz048ecSEC6ZMLLo
         4Frw==
X-Gm-Message-State: AAQBX9ep7xSoqrg9UUwZ5Dr33FG9E61youGsScu2jEXMuBF0Q1koI1tf
        2rY+HRuhc6VdB+3udfDmP5U=
X-Google-Smtp-Source: AKy350asQiATAwQQ3ffHggu6sM4MK7QMNIzV+BulfMMwvTqHEtexI00wBeUdpLl4aSQ/b2ws+m9z1w==
X-Received: by 2002:a7b:cc84:0:b0:3f0:46d4:b391 with SMTP id p4-20020a7bcc84000000b003f046d4b391mr429644wma.6.1681348667103;
        Wed, 12 Apr 2023 18:17:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e6-20020adff346000000b002efac42ff35sm120131wrp.37.2023.04.12.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:17:46 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:17:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: hyper-v: make sure Invariant-TSC is used if
 it is available
Message-ID: <ZDdYNgPxdkXScB+C@liuwe-devbox-debian-v2>
References: <20230408210339.15085-1-decui@microsoft.com>
 <BYAPR21MB16884AD46D83DB91CECB34EED79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16884AD46D83DB91CECB34EED79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 11, 2023 at 05:28:39PM +0000, Michael Kelley (LINUX) wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 2:04 PM
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
