Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95A6E039A
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDMBU7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMBU7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:20:59 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE993;
        Wed, 12 Apr 2023 18:20:58 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so15091331wmb.3;
        Wed, 12 Apr 2023 18:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348857; x=1683940857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyI2FpVQ01PfKikXOVamojIWEV+c+YSNr8zEy6KOoLo=;
        b=A06klOASiR6p1bZJwWrCOibkEW49MxX07s894tewLPr71XxZOSByxCVKkAstd2K0A6
         7lyDtfZj9KVS5jwPuIfnHVerTcZvX7vHhpVK/WjJVu8y9IzAIxyKVCWV5vmvI7O7PAp3
         LtMqyF0V5BJ+P3SUZ6DxZFjYxZQu9fA7oHQMKWinoQz0Gj8LNuRcLegmhwhQ9JgA9zob
         sS4DkK+ECHk2ZyWgLJlOj6zPYWO8z90EctZ8xuyBBdFPgdEcCyAKzjwLoFWu2KGfnjDz
         83fmrbGPZLuO57TMX77h3NMdNFojbFqkEAvZ/l5eTYScvV9gcTJB1RzM3cSsMpp8d2Oz
         jb3g==
X-Gm-Message-State: AAQBX9eRs5jPFrp4yiPqFtRThO44M1Ou9hsFgVPY2/Rzl3q88SQpnFzs
        6PsBfNprl25eFT8cuDF6gdE=
X-Google-Smtp-Source: AKy350aW+EfU5p/EtArNOcjzW8vsR7J6KNpFMN2bAhyojxO5y13KCcNLI2p6gU92VyaOKAg8wiT5Dw==
X-Received: by 2002:a1c:4b05:0:b0:3ef:68d5:9573 with SMTP id y5-20020a1c4b05000000b003ef68d59573mr426722wma.19.1681348856811;
        Wed, 12 Apr 2023 18:20:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003ef5db16176sm404814wmj.32.2023.04.12.18.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:20:56 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:20:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Message-ID: <ZDdY9CkUcLiNcuFQ@liuwe-devbox-debian-v2>
References: <20230408213441.15472-1-decui@microsoft.com>
 <BYAPR21MB16888F6A2FAB4C47B4010DB4D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16888F6A2FAB4C47B4010DB4D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 11, 2023 at 05:24:31PM +0000, Michael Kelley (LINUX) wrote:
> > --
> > 2.25.1
> 
> This looks good.  Glad to have this simplification done!
> 
> FWIW, this patch will cause conflicts with your TDX patch series.  If this
> patch goes first, then you'll have merge errors with the TDX patches.
> If the TDX series goes first, then this patch will have merge errors.  And
> per my comments on Patch 5 of your TDX series, eliminating the
> post_msg_page will simplify the error cleanup code in hv_synic_alloc().
> It seems like making this patch part of the TDX series would be helpful
> all around.

Seeing that there are pending comments in the TDX series, I've applied
this patch. TDX series can be rebased.

Thanks,
Wei.
