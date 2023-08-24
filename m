Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A800B7865C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Aug 2023 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjHXDPc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Aug 2023 23:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbjHXDPW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Aug 2023 23:15:22 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354B10EC;
        Wed, 23 Aug 2023 20:15:20 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso42129345ad.1;
        Wed, 23 Aug 2023 20:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692846920; x=1693451720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsgDNmjwGxCfgJgb+/CFwMCWVO8j5ZaXc0UZkxeYPkU=;
        b=QRfpNhq+oDnnX+YfQh9XjnQBYR5EjOjOLYuOoQRPXWvmPZYejkk/clRJ8yQZWdarqJ
         2W5vlBaQAUKx2P5cr5Yrw/jUN64vqNSjuJ+gfudosBCUt9CKnonzIC+vvqZloslRdb9D
         jhQ2woHpB6zpjVpYfcQU49M7NlM9priot5sniXndXB4dGtcN27zGsTi3riw/+V71yhi/
         12EqEAQJ3usIqbtAIoxDWRHyQbMptHVLZYqK9YRFSKJA83z0+zfQ8O5CGhVmuIBTj4sD
         QSc8BTGOI5sVY1LqfJBhFFgdYSS+FzVJPhqvwsUnjRdnKsPTWRGOjiT5lmk1UWD2kPJ3
         P5AA==
X-Gm-Message-State: AOJu0YzeXG9y9y/WY+KlZZBpUcmRjUpcZCjJazrW48ZLV6A+J1XGnQNY
        m52hch0He4kB9FbRFnVor97T719HMX8=
X-Google-Smtp-Source: AGHT+IEyGjBiSodLeR6WptVqlOO9WXuIkJjJdxyXB4mai28PJnhcZulJ6xCijemC5YOqalvAg7PjoQ==
X-Received: by 2002:a17:902:f68a:b0:1b8:2ba0:c9c0 with SMTP id l10-20020a170902f68a00b001b82ba0c9c0mr13175115plg.59.1692846920138;
        Wed, 23 Aug 2023 20:15:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001bdb85291casm6773850plk.208.2023.08.23.20.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:15:19 -0700 (PDT)
Date:   Thu, 24 Aug 2023 03:14:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: linux-next: Tree for Aug 23 (hyperv)
Message-ID: <ZObLMtemsJap3UX+@liuwe-devbox-debian-v2>
References: <20230823161428.3af51dee@canb.auug.org.au>
 <449fdf75-6d5c-46c3-2a1e-23c55a73b62e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449fdf75-6d5c-46c3-2a1e-23c55a73b62e@infradead.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 23, 2023 at 06:45:07PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/22/23 23:14, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230822:
> > 
> 
> on x86_64:
> 
> In file included from ../arch/x86/hyperv/hv_init.c:20:
> ../arch/x86/include/asm/mshyperv.h:272:12: warning: 'hv_snp_boot_ap' defined but not used [-Wunused-function]
>   272 | static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
>       |            ^~~~~~~~~~~~~~
[...]
> 
> Full randconfig file is attached.

Thanks for the email.

I think this is already fixed in hyperv-next. In the latest code,
hv_snp_boot_ap in has `inline` attribute.

Thanks,
Wei.

> -- 
> ~Randy


