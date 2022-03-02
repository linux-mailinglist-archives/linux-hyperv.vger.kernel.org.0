Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3564CA071
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 10:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiCBJTX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 04:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiCBJTW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 04:19:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999ECB6D20;
        Wed,  2 Mar 2022 01:18:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk11so2349937ejb.2;
        Wed, 02 Mar 2022 01:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LuLQynsRS5ZDdiypHmCRhWOSK0fPQgMoxmBubsA8FA=;
        b=YwA2Tp9/WRHVf+AhpCscraLQ5YZMBIbTnjRD9qXALixvArniZHwws+D5eKFYJ4w9RG
         r5YPECm/lP0oAUKfe9WRJhv6+FML2S+XIXHKeVDBXWzTRzpq8V5VyDtMBBLt+RgC4uif
         rGbJjiYJ+RaebcdTWE+lgavU2sjB3KE2oYMSI2g0SnLEMM8BFRLk6tjS00Xev2qK5BZV
         5Ssf9EZ0tsmaxYSBGN+JYRBhKcBJnRtyUIj9fj+nmKF1+vj7CNwKABPlCEiIkg4HqhVl
         prjve+Nrt6ySEZf00Hzlz9gQ4nrt4ykYynGeggVTPypi2WOB4Q0/x8pbTwKWJmRWzNiw
         F8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LuLQynsRS5ZDdiypHmCRhWOSK0fPQgMoxmBubsA8FA=;
        b=huBWu5EfTXUybsEGeZcgjWlNixNwNuiJY+tXItpJvTbgIvXDwHaA8LW1jK79qxM0Ko
         HQ82YSXzGmGMoGCfCxHwDxRa2XvYxavNBMpT/s8kZ4JNqEiiXy2lqFlFJKGWIdb9YEzZ
         mef5GVnKkzx9R9SoLDu0f5uIQdqswIbrWZHEkoZgIF5Y57aKG4ZkJMlKBh/AZtWFPzrZ
         Qk89y0beyZDKTKS+STa8QMM/b0XJ5NMq7fyV8zir/E+9Fq4m5D+ylk3Q+fGizqxZOGPF
         mRFh5iZWif7A1DBfvFrR7vSfLCtItzX6U8BBwNZiuLc9qWFGFBJrljj1ivI8uIV1wi8R
         Gktg==
X-Gm-Message-State: AOAM531pTxpCoKHcpA4yvwZBU9gzFoUlhLHMMYs6JMIhlJk05M1p1XCj
        uC4JsojZj0vtgKO7PObqUumtjZHgY7QXNAeUe0E=
X-Google-Smtp-Source: ABdhPJxefZcxfzkkMgbjOK8FTIKDUrSjhwIhlbq76ukZRP/HPSQoF7TsleylqvSIE+LRhSKcwrjAT6lGtFvgDJjKhNk=
X-Received: by 2002:a17:906:9f06:b0:6ce:36da:8247 with SMTP id
 fy6-20020a1709069f0600b006ce36da8247mr21813101ejc.651.1646212718008; Wed, 02
 Mar 2022 01:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20220227143055.335596-1-hch@lst.de> <20220227143055.335596-8-hch@lst.de>
In-Reply-To: <20220227143055.335596-8-hch@lst.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 2 Mar 2022 12:18:26 +0300
Message-ID: <CADxRZqxrjp4erFNorH+XqubZWLRNjw2E14z7vOW537no1eKnhw@mail.gmail.com>
Subject: Re: [PATCH 07/11] x86: remove the IOMMU table infrastructure
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Feb 27, 2022 at 7:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The IOMMU table tries to separate the different IOMMUs into different
> backends, but actually requires various cross calls.
>
> Rewrite the code to do the generic swiotlb/swiotlb-xen setup directly
> in pci-dma.c and then just call into the IOMMU drivers.
...
> --- a/arch/x86/include/asm/iommu_table.h
> +++ /dev/null
> @@ -1,102 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_IOMMU_TABLE_H
> -#define _ASM_X86_IOMMU_TABLE_H
> -
> -#include <asm/swiotlb.h>
> -
> -/*
> - * History lesson:
> - * The execution chain of IOMMUs in 2.6.36 looks as so:
> - *
> - *            [xen-swiotlb]
> - *                 |
> - *         +----[swiotlb *]--+
> - *        /         |         \
> - *       /          |          \
> - *    [GART]     [Calgary]  [Intel VT-d]
> - *     /
> - *    /
> - * [AMD-Vi]
> - *
> - * *: if SWIOTLB detected 'iommu=soft'/'swiotlb=force' it would skip
> - * over the rest of IOMMUs and unconditionally initialize the SWIOTLB.
> - * Also it would surreptitiously initialize set the swiotlb=1 if there were
> - * more than 4GB and if the user did not pass in 'iommu=off'. The swiotlb
> - * flag would be turned off by all IOMMUs except the Calgary one.
> - *
> - * The IOMMU_INIT* macros allow a similar tree (or more complex if desired)
> - * to be built by defining who we depend on.
> - *
> - * And all that needs to be done is to use one of the macros in the IOMMU
> - * and the pci-dma.c will take care of the rest.
> - */

Christoph,

Is it possible to keep documentation comments in source files? Or are
they completely irrelevant now?

Thanks.
