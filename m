Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F3785000
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Aug 2023 07:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHWFmK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Aug 2023 01:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjHWFmJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Aug 2023 01:42:09 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAECCD2;
        Tue, 22 Aug 2023 22:42:08 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bc0d39b52cso35058455ad.2;
        Tue, 22 Aug 2023 22:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692769328; x=1693374128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXFrwzCPZpjmPe0jGsBW0zhL8FGGi+rHIxlG2RCSp3M=;
        b=Ms31qEFuQl9uTvAbizJ2kesyPBtubDRBNJTrQzC0nc3DOyA8vE3K2dZ36x9/euikY/
         cFVBPNv/O2JvL5rrB7SgOeEWe9FquDkEaRzoDSBHWC8GJiPi3zxnBfVM5RgiFexNhgFX
         eAdz6EqhDacJmQF4rk37bK2c3IvphODX4Vl+oApUpPtyXd14Jq6Ml49fayRpry1iI0Pj
         K379yfgP4C19ry2BGrqUbSuqXRxS3ayA/8ng77YvmXKqheUyBKETV8xhcxSlkhsVSRgy
         eqo2vkYP6OKPrahfhvLFu2y3hHRuQgCoKh59rm47eKcCt4Lfc8b/cr6xpvD8gXjykoZ5
         1yww==
X-Gm-Message-State: AOJu0YwuZkgDFeU77mOwlipDKISHbKXNPRjAfQh304juWRkjM/MuAP+t
        W4csSvjpS/vwtc5UDe0BE8EoV0cKsls=
X-Google-Smtp-Source: AGHT+IHwWwyNqcwGFCJcai2/Zp8Qf19N7YHZ3EX/92MJSUq1BAhBTsJMXS48VcMQTbv2Y9ewFWaqQg==
X-Received: by 2002:a17:902:6b47:b0:1b8:b3f0:3d57 with SMTP id g7-20020a1709026b4700b001b8b3f03d57mr8432370plt.31.1692769327722;
        Tue, 22 Aug 2023 22:42:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170903278f00b001b9d7c8f44dsm9962498plb.182.2023.08.22.22.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:42:07 -0700 (PDT)
Date:   Wed, 23 Aug 2023 05:41:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH] x86/hyperv: Add missing 'inline' to hv_snp_boot_ap() stub
Message-ID: <ZOWcGnu7pqA4m2Ar@liuwe-devbox-debian-v2>
References: <20230822-hv_snp_boot_ap-missing-inline-v1-1-e712dcb2da0f@kernel.org>
 <SA1PR21MB1335C1D74D05A582D90EA1A9BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335C1D74D05A582D90EA1A9BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 23, 2023 at 01:00:55AM +0000, Dexuan Cui wrote:
> > From: Nathan Chancellor <nathan@kernel.org>
> > Sent: Tuesday, August 22, 2023 11:26 AM
> > [...]
> > When building without CONFIG_AMD_MEM_ENCRYPT, there are several
> > repeated instances of -Wunused-function due to missing 'inline' on
> > the stub of hy_snp_boot_ap():
> > 
> >   In file included from drivers/hv/hv_common.c:29:
> >   ./arch/x86/include/asm/mshyperv.h:272:12: error: 'hv_snp_boot_ap'
> > defined but not used [-Werror=unused-function]
> >     272 | static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return
> > 0; }
> >         |            ^~~~~~~~~~~~~~
> >   cc1: all warnings being treated as errors
> > 
> > Add 'inline' to fix the warnings.
> > 
> > Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Applied. Thanks.
