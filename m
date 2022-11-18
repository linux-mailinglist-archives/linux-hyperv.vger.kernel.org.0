Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7862F7D2
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Nov 2022 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiKROhs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Nov 2022 09:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiKROhe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Nov 2022 09:37:34 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5C9AC92;
        Fri, 18 Nov 2022 06:34:55 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id w14so9534925wru.8;
        Fri, 18 Nov 2022 06:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4toaSer+DSC9C7UHmt6s1A3ErWAKiU/7f6LW1Uo6bg=;
        b=1ZAlfAcu4K5CRVXuZQX/I1/URzAIjdGNW+X8Ve0HU5G2NEmNJpvU9pZQBsx5AmSjWr
         tm5YIeyuH13t2WtCXsLQRO8XYM8+fYR3HmCEYjXgVQiDIlDLo7PqXAZPOt1PW9WD5VJw
         4AD/umlvYaZuRZK7YPsv9Yz6peLvoGqMiLQmvTkSNyhJSsHFBtOMRCKeixXA7sfhNibR
         FIvEe7pxlESZaOxBCP3yk/OTzLJTl8LuQSwBBQxyrTZrtCNRGTQFaoBxFf0BPFpOtJ9M
         5cieUubW++T5Wk3GXRCyclsTrq2zXV8wNTr23fM57LwUgwJNd39zaNKQ4897xOjH47R8
         fgiw==
X-Gm-Message-State: ANoB5pl/5T7sDdcZmNKCuau9+xJaejhqCTlVgAPJ8kbu7inJynONJ/c7
        Tfo5H3g8SLmvw0MBkwa9t78=
X-Google-Smtp-Source: AA0mqf6xd23CergG26RTQ00+DtiYnR2z8QS9+b0CEY7p5WOlXzZ5D8aEBANGloY2SpHuGJKMYI7aXg==
X-Received: by 2002:a5d:56d0:0:b0:236:59ab:cf30 with SMTP id m16-20020a5d56d0000000b0023659abcf30mr4403560wrw.485.1668782089167;
        Fri, 18 Nov 2022 06:34:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003c83465ccbfsm10372760wmq.35.2022.11.18.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:34:48 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:34:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, mikelley@microsoft.com,
        sunilmut@microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org
Subject: Re: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
Message-ID: <Y3eYAFDKhwsOyeY7@liuwe-devbox-debian-v2>
References: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 17, 2022 at 12:11:39PM -0800, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 
> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-next. Thanks.
