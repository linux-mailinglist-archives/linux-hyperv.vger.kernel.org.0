Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A337C5235DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiEKOmm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbiEKOml (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 10:42:41 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65516633AF;
        Wed, 11 May 2022 07:42:40 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id b19so3285756wrh.11;
        Wed, 11 May 2022 07:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3ECBXOv9TPsZorCQUAYdKhEMvOJ3BbhSyHoPIPu0dM=;
        b=vkLFwF+T3Q09anjPmE7QIWDw1YZ3y19fSGfMDrmRnpTkjYUPBm4wOhvBcZbvd0e0rV
         WRYC3QcWrhHrx4wDIXX1S8r3SYYBvFArxdjmWjBGOxHC2nl6s3okAH9b0ioiNIZCBa/o
         4OrR67gmxuxC8BLEKJpwXfTFmA+RkIs9NZXokXlRBwucnCaHPjrcTDvKWf3KOH7QR3In
         jbd0XGSppTrVVNjEuGqr0o8h7XR7q1oQ2RBUMQ1zY1zc76ScIryRwbD6NcKT6xFbN5eg
         je5YXmlPf8oikl+Kkv7WmzSmnK8ZYIlgAgtXKKrW9DKfN/YnHY91ehIcQocgWSdbGNpO
         5rbA==
X-Gm-Message-State: AOAM5323r8XKyUPqA9dxRkBt8PWOQ59mJAUxKUIAqtamUr+WlFi9P29h
        TsBb8GIj20cwN8RqhYQgJhs=
X-Google-Smtp-Source: ABdhPJz4t8EsNezbUYgl6lBMfjkBaCxRPxtnPooLC/unxJgMpoEsL4MYFI5+iyQW0xfeCbqrzbLZMw==
X-Received: by 2002:adf:9dcc:0:b0:20a:ed44:fd48 with SMTP id q12-20020adf9dcc000000b0020aed44fd48mr23070524wre.120.1652280158939;
        Wed, 11 May 2022 07:42:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0020c5253d900sm1658861wrb.76.2022.05.11.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:42:38 -0700 (PDT)
Date:   Wed, 11 May 2022 14:42:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Disable hardlockup detector by default
 in Hyper-V guests
Message-ID: <20220511144237.dp4gcj4zn6kof5re@liuwe-devbox-debian-v2>
References: <1652111063-6535-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652111063-6535-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 09, 2022 at 08:44:23AM -0700, Michael Kelley wrote:
> In newer versions of Hyper-V, the x86/x64 PMU can be virtualized
> into guest VMs by explicitly enabling it. Linux kernels are typically
> built to automatically enable the hardlockup detector if the PMU is
> found. To prevent the possibility of false positives due to the
> vagaries of VM scheduling, disable the PMU-based hardlockup detector
> by default in a VM on Hyper-V.  The hardlockup detector can still be
> enabled by overriding the default with the nmi_watchdog=1 option on
> the kernel boot line or via sysctl at runtime.
> 
> This change mimics the approach taken with KVM guests in
> commit 692297d8f968 ("watchdog: introduce the hardlockup_detector_disable()
> function").
> 
> Linux on ARM64 does not provide a PMU-based hardlockup detector, so
> there's no corresponding disable in the Hyper-V init code on ARM64.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
