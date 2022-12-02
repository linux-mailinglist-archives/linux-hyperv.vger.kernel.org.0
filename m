Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18BC640CDF
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Dec 2022 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiLBSOz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Dec 2022 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiLBSOy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Dec 2022 13:14:54 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E05E8035;
        Fri,  2 Dec 2022 10:14:53 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso4945095wmb.2;
        Fri, 02 Dec 2022 10:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t5abKsTpKqgREaQhXCGjROpUVw3tlvXQ+X6G/BuMsw=;
        b=OkCFw94tfw104Feoiiwjib2moOr5F2SQFUizEIUE+uExNEA41T/4wdbD1c8++0Csdt
         4fhQHp5us8Fh+KuM1ii/9vgMOaW9gnAHEfmuuwo7N6FnYrP0A+ei/LnJGOyrFAI9E5CJ
         6+HGyfzxhvicqgEQXV5tfTost2lrCtSKJE9fAZ8R6YbcjIpxra+Bqkd5H2lCYQJWwRRj
         5w5SGjnexg+qqy2VjwW5zxvdw7vGwv7Oc1/mFY8r7fTKvvN7Tg/DaU9p0KuFxU8k6q12
         STkP5t8Sz7r3ZS0MIlSfov9/DIzGOthvPkYV0nf/VsJM/zAPKsuWB1YzFr4hiboL9kVe
         gBSw==
X-Gm-Message-State: ANoB5plaBJlpvUPDCRg7p4+tmrSUFc1IABQWJAwjl85mb6rGrGvVShV1
        HOJhh9BFR5avQQxXsNVpVlg=
X-Google-Smtp-Source: AA0mqf5Un+XibMAB03hU0daYbZ1uI1ijYaDjvNf8tXvR0wxo5R2Y6uMG0rkC1MRApKdKoeZ5TMwYsw==
X-Received: by 2002:a05:600c:358c:b0:3c6:c089:9810 with SMTP id p12-20020a05600c358c00b003c6c0899810mr54908739wmq.60.1670004891715;
        Fri, 02 Dec 2022 10:14:51 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x11-20020adfec0b000000b00241f029e672sm7432081wrn.107.2022.12.02.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:14:50 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:14:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Message-ID: <Y4pAmUQZuSP9MMiu@liuwe-devbox-debian-v2>
References: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y2PiyAEJZitd3LS8@liuwe-devbox-debian-v2>
 <ab0e318d-0840-a76f-bf34-73db659eef63@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0e318d-0840-a76f-bf34-73db659eef63@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Dec 02, 2022 at 01:33:17PM +0100, Daniel Lezcano wrote:
> 
> Hi,
> 
> On 03/11/2022 16:48, Wei Liu wrote:
> 
> [ ... ]
> 
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > Thank you both for the quick turnaround. I will just squash this patch
> > into the previous one.
> 
> Can you point to the mailing list the squashed version ?

The squashed patch is this one:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ad1aa571214e8d6468a1806794d987b374b5a08

Thanks,
Wei.
