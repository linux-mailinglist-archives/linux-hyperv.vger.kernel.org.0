Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759960E452
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Oct 2022 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiJZPRY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Oct 2022 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiJZPRX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Oct 2022 11:17:23 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DDED73DE;
        Wed, 26 Oct 2022 08:17:22 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id t4so10411056wmj.5;
        Wed, 26 Oct 2022 08:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Msz1Hi1rkqv/MvBfwUlMMaceK8tAszlcvr0acT4kho=;
        b=gmEaH0UJJpT416EJu1+DjALxolSDRIp85kCN0bDM4tRhF5f/F1V17q/dSivqjpv7Z1
         SA5ffcvVr786dPJpRt1UxQEFBFCOuRHC3zuhh3mRRCzuT/3L8kmmm150y021LaAUghYM
         TtxXKyeaee5q03C8TlLPTJILaWRxE2u1HM0BhH1I+IU06vLXsc4+SmB5sNqQyqevVfdD
         XP229ub8VUjmLoQhh3CIEb45ay91a/2CJtUbL6/Cogt7zdww2yod/3pQp9ra3SjUybFX
         QyPxs+r5NWnv+DN3tE3cUTZfzU/QxJd+6yhVKO0zTw0+q08yKnPNw3PRdteHn01vu46n
         6V3w==
X-Gm-Message-State: ACrzQf0AS2JFFFZcU85ld8tZYeDDDNlZzfU4oci2o0ExmRxH2JYVTxhW
        WaVSR2hsX6Ze4xvaE6Ln8n4=
X-Google-Smtp-Source: AMsMyM5E4QofG55+k8sHt/sTfY3vGTyn0y7u2UAQ/U4Bxq84KgQJzPPLu9oKoQ7zPN117pwnv57/GA==
X-Received: by 2002:a05:600c:35c8:b0:3c8:33dc:c262 with SMTP id r8-20020a05600c35c800b003c833dcc262mr2807585wmq.206.1666797440607;
        Wed, 26 Oct 2022 08:17:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003a5537bb2besm2164405wmq.25.2022.10.26.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:17:20 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:17:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Message-ID: <Y1lPfphHVRn2e4I5@liuwe-devbox-debian-v2>
References: <20221020083820.2341088-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020083820.2341088-1-zhao1.liu@linux.intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 20, 2022 at 04:38:20PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
> kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
> fails.
> 
> But in fact, kmap_local_page() always returns a valid kernel address
> and won't return NULL here. It will BUG on its own if it fails. [1]
> 
> So directly use memcpy_to_page() which creates local mapping to copy.
> 
> [1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/
> 
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Applied to hyperv-fixes. Thanks.
