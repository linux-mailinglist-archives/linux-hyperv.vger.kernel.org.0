Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874C45739E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Jul 2022 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiGMPTp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Jul 2022 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiGMPTo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Jul 2022 11:19:44 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0443C8CF;
        Wed, 13 Jul 2022 08:19:43 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id f2so15958576wrr.6;
        Wed, 13 Jul 2022 08:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jb4nt965TNcwr+NhIm2x9TnJU/UEz0cJsDnLaQo41aA=;
        b=M3M6IUjK5yDcXTDH8yOwKD4uA624A8lcyf1UhCRcwc2afvkJD4RGbNvp7RUvr62SDL
         9MIajchKqyBpmLOuSPQXMfr2p0rA2sBDscwRqBNCL1vZHJiJLckqzcoUDL8QEKAr+odS
         /4GOvdYOMTIakIPegQi1s1UhPLFw2+dC5rKO81+rrVVmaF9nIy+YYV5vhW47RxJCV0bD
         UXIkuRFZeIEo8wQF88wckIUieWuk0N+icR/8R9Une3FEjAq4RqAUOr7tXiMqMaB9IUJi
         UwOneG0hc5FBt5BfOSejKUWptYdZZRyEHr6YIKx1evC1XthixYaIQKb93WBumXMSoi4X
         H9Hg==
X-Gm-Message-State: AJIora8NGxEz80wKOm0xXOvH0YBjHVKt1VagPzvzM+FsP0YgNUmX/nVk
        a2IIadmWl1MqQffT/z1yNSgTwo2IxUE=
X-Google-Smtp-Source: AGRyM1vIer1iKcyJCkMxsZeIQCAvJ1RSW1ZL9x+hGsugTfHldrud3JXr9Os00Uz9Ehv9o8imfdvzOA==
X-Received: by 2002:a5d:64ce:0:b0:21d:a952:31d5 with SMTP id f14-20020a5d64ce000000b0021da95231d5mr3745169wri.667.1657725581691;
        Wed, 13 Jul 2022 08:19:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b003a2fdde48d1sm1281802wmc.25.2022.07.13.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:19:41 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:19:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Message-ID: <20220713151927.e6w5gcb67ffh4zlx@liuwe-devbox-debian-v2>
References: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
 <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 12, 2022 at 04:24:12PM +0000, Michael Kelley (LINUX) wrote:
> From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Monday, July 11, 2022 11:18 AM
> > 
> > Allow the guest to know how much it is ballooned by the host.
> > It is useful when debugging out of memory conditions.
> > 
> > When host gets back memory from the guest it is accounted
> > as used memory in the guest but the guest have no way to know
> > how much it is actually ballooned.
> > 
> > Expose current state, flags and max possible memory to the guest.
> > While at it - fix a 10+ years old typo.
> > 
> > Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> > ---
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I added "Drivers: hv:" prefix to the subject line and applied it to
hyperv-next. Thanks.
