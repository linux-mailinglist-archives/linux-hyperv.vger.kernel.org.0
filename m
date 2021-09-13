Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6C4088DD
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Sep 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhIMKUc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Sep 2021 06:20:32 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55014 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbhIMKU2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Sep 2021 06:20:28 -0400
Received: by mail-wm1-f47.google.com with SMTP id s24so6222075wmh.4
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Sep 2021 03:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dryCZ9IoNLQR+g8npGl2G3XKES0MTb2xPM5/gA3dXeI=;
        b=rjTErnRR3TVqgUJGOhDORGT6sAg+RzWhAsaPzsvL9ZJFnjcDYUNyzzKhpTKb8IYvP8
         /6p6CiFC6emDxDX9xX9xbTeeN31v4Baa4jExianxNSaDxAKeZBxAjDhK7h2O4Me//NLX
         NMNVCQs6/ZkRIi/RVBLgVhGeGvvKflI/Gspqpvzy8SQN9uRghpLHWwrrnWC5/9WJ5Pm4
         LYqceUNB4mFJBQHoIdk/oW3UzShcnQ8ybPDuo/KXCQyZuStLOxZYTRScjiMFPnjQf3im
         oCLoWbiL8xZ07Z7TiYGzGvP0jmIPHgrswukb1bVNXsxjHq4bV+imnp4wutcgyCQuMKS2
         HvRw==
X-Gm-Message-State: AOAM532I1er8gk4T4fVoftbh3aNZgIICL5wJcs9uOtRqFgMGegn/7jya
        n/bSqRJQTRJnJK/yh8mlpK/PObJP5r8=
X-Google-Smtp-Source: ABdhPJyJwsX2HjHc1WzYurk/E+8O6KBO1FaqSsrawjZzEtxtb1/gOAvWx7tZEx22XgESZLY62xg/5w==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr10136504wme.160.1631528352316;
        Mon, 13 Sep 2021 03:19:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k1sm6935417wrz.61.2021.09.13.03.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 03:19:11 -0700 (PDT)
Date:   Mon, 13 Sep 2021 10:19:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 0/2] Remove on-stack cpumask in hv_apic.c
Message-ID: <20210913101910.nowqadsbuqc6dvao@liuwe-devbox-debian-v2>
References: <20210910185714.299411-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910185714.299411-1-wei.liu@kernel.org>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 10, 2021 at 06:57:12PM +0000, Wei Liu wrote:
> Wei Liu (2):
>   asm-generic/hyperv: provide cpumask_to_vpset_noself
>   x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself
> 
>  arch/x86/hyperv/hv_apic.c      | 43 ++++++++++++++++++++--------------
>  include/asm-generic/mshyperv.h | 21 +++++++++++++++--
>  2 files changed, 45 insertions(+), 19 deletions(-)

Pushed to hyperv-fixes.
