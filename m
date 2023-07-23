Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6D75E5B3
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jul 2023 01:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGWXIK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jul 2023 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGWXIJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jul 2023 19:08:09 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092BA6;
        Sun, 23 Jul 2023 16:08:09 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bba54f7eefso1655025ad.1;
        Sun, 23 Jul 2023 16:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690153688; x=1690758488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejk+IkfG5HIe+hQjbA5510kpJD8rhXbCRXUBxtMfbVI=;
        b=hRq6HwXB+GfLKQkkMMU7dPscLDa0JJW9+hKahdl7vetT9797uZFdsdobsNDf24yXUV
         kZt/6+JwzV+iNV65CRAb6tIolayUrsheaj6GBZkn8I89SikhAAi2WdfKBF1S2LvZwbnp
         4ZTWCLT3LLkEme4zGyMzJx09sfxGrophkCESZt4oiZMRHjH8j+fuIQjjfaR5G6h9tdgs
         VVwkv+oiKHgYH00rbIva+WFeY5C7qUKx3FAiO7lr7jBhhl1Asdh9hQMQXGA1VjuKgpQp
         ne35oED5QNLmxX9qnw0SwtAjbUM1e5y0yMx38OxFTu1zWuDvBQY2MXzSdTPTaP20BdVD
         uWmQ==
X-Gm-Message-State: ABy/qLay9kUz7jG7UYcHO8wVx4ztm7e2S32teyf+O/PK8H/EW589u82e
        eZzCQkkQ9N+4FmYVYAsoDXw=
X-Google-Smtp-Source: APBJJlFr8ysZfwUQa77PynVAKsPnJE7xdexUyBkakvwffPNWKm2eJFRhP2YEapD59k+0m/Atbuc5yw==
X-Received: by 2002:a17:902:ecc9:b0:1b8:8702:1e7c with SMTP id a9-20020a170902ecc900b001b887021e7cmr13048563plh.33.1690153688428;
        Sun, 23 Jul 2023 16:08:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902b71800b001b9cea4e8a2sm7355186pls.293.2023.07.23.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 16:08:07 -0700 (PDT)
Date:   Sun, 23 Jul 2023 23:08:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Message-ID: <ZL2y1oaObNrnMHE8@liuwe-devbox-debian-v2>
References: <1690001476-98594-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690001476-98594-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 21, 2023 at 09:51:16PM -0700, Michael Kelley wrote:
> On hardware that supports Indirect Branch Tracking (IBT), Hyper-V VMs
> with ConfigVersion 9.3 or later support IBT in the guest. However,
> current versions of Hyper-V have a bug in that there's not an ENDBR64
> instruction at the beginning of the hypercall page. Since hypercalls are
> made with an indirect call to the hypercall page, all hypercall attempts
> fail with an exception and Linux panics.
> 
> A Hyper-V fix is in progress to add ENDBR64. But guard against the Linux
> panic by clearing X86_FEATURE_IBT if the hypercall page doesn't start
> with ENDBR. The VM will boot and run without IBT.
> 
> If future Linux 32-bit kernels were to support IBT, additional hypercall
> page hackery would be needed to make IBT work for such kernels in a
> Hyper-V VM.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
