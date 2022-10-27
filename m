Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418860F60E
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiJ0LTL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiJ0LTJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 07:19:09 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F5FAE7B;
        Thu, 27 Oct 2022 04:19:07 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so909120wmq.4;
        Thu, 27 Oct 2022 04:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdbMuT3q07TnuTjnPHzXSgdwPpbsUbQP8N9i6MigE9M=;
        b=w/6wNwcmiEp/qssK4vaV46YIqJRUgadXZa9m9o14Q1W6ob0AB5T/tRjf/4MK2YYcwE
         03YQcKUi59jYXiQgykzPrwMAdXdvCbMpOcSluqnXyiudXrQLq/P6ZNsfKKyb53vHt+cc
         hs34AWoxEWqgGItX3JltchVIOwDwSjM5fWdzEcvsKNh3COclFImWf0xXhR53t3iq36dn
         oA+NQ6TlrqgruQd3fA0gRH1pA21eKU2DSJownR1hAd7dGnYPsrQJJyskF/WnlaLhA58K
         uNcpNF0wcGBU5wb7gT9Uql1Co9mRIJ1IpYzUMxKgolG9nQVjQdRMLQ49U9aLAoM5PPhi
         RsRQ==
X-Gm-Message-State: ACrzQf2lgupf6uPl7aA/nbS3gFNvblDt4mU+8l0PvFBmqOjfN+xJ3n1T
        y3EWGgmGUdLVObEeLBYhoTE=
X-Google-Smtp-Source: AMsMyM4e6onb5FXA/XWAWabbp/IBV6y+QsqvnhW0CYaMslGRR6aUGU1yLaCxxwOOpKpYMHTcMjvPXA==
X-Received: by 2002:a05:600c:502c:b0:3ce:794f:d664 with SMTP id n44-20020a05600c502c00b003ce794fd664mr5492164wmr.33.1666869546056;
        Thu, 27 Oct 2022 04:19:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a342933727sm4917798wms.3.2022.10.27.04.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:19:05 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:19:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        =?iso-8859-1?Q?Dexuan=A0Cui?= <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ira=A0Weiny=A0?= <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Message-ID: <Y1ppJ/6VFhba1MEX@liuwe-devbox-debian-v2>
References: <20221020083820.2341088-1-zhao1.liu@linux.intel.com>
 <Y1lPfphHVRn2e4I5@liuwe-devbox-debian-v2>
 <Y1pX/BGRgceJcEE9@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pX/BGRgceJcEE9@liuzhao-OptiPlex-7080>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 27, 2022 at 06:05:48PM +0800, Zhao Liu wrote:
> On Wed, Oct 26, 2022 at 03:17:18PM +0000, Wei Liu wrote:
> > Date: Wed, 26 Oct 2022 15:17:18 +0000
> > From: Wei Liu <wei.liu@kernel.org>
> > Subject: Re: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
> > 
> > On Thu, Oct 20, 2022 at 04:38:20PM +0800, Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
> > > kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
> > > fails.
> > > 
> > > But in fact, kmap_local_page() always returns a valid kernel address
> > > and won't return NULL here. It will BUG on its own if it fails. [1]
> > > 
> > > So directly use memcpy_to_page() which creates local mapping to copy.
> > > 
> > > [1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/
> > > 
> > > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Applied to hyperv-fixes. Thanks.
> 
> Sorry Wei, I appology for not deleting unused variables, which caused
> the next tree break. Do I need to send another v3 to make up for my
> carelessness?

There is no need to send v3. I've dealt with it.

Thanks,
Wei.
