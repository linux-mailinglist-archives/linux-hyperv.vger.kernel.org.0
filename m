Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9133B2C3D99
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 11:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgKYKZY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Nov 2020 05:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgKYKZX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Nov 2020 05:25:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC366C0613D4;
        Wed, 25 Nov 2020 02:25:23 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 81so2087474pgf.0;
        Wed, 25 Nov 2020 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8KWwZXjo+ebfysMFihw4Nq0NqQCdpcD4ow0OUA1KW4=;
        b=DpGjTGcbKs/0CQJBWrroVcD6FjXCf2LxZJTLiE/33p3a1xJtylQsUi/ijQKyYoSMyR
         CX48GAFaeIUTvp+IJUMMCyiryasym19bIX8w4Q2pkkTLCAA3ej2YLz/PVdHZ4t8TSLSL
         fXTxX4V0rnqDe0fqEDn9+2oCcCIkk0ZlhGSgxLgCO+vVWAVke8yRmsLAWgY1ZqYaTTGL
         jV9lOIoj7DBROZZU2My468qUuPfJkCmtHS9yAv+CzuWVtlV66JLUDEnBwclu+63sRldb
         7k7yvllj1Ie7NAtGZScSoP3eomQOAOj6h9y9LRrLe3d2BU9l5UQAxLyTHjO72m2UFE+H
         YYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8KWwZXjo+ebfysMFihw4Nq0NqQCdpcD4ow0OUA1KW4=;
        b=K+ICHjZ3liWXIwCxFfQPaaTUG2x1Pi78+1hU8iHi8O0c205GzKnkEfcrwODkQ8PcFg
         DqzywWxA6ISNwFbf2PlQ3jsqa6npPbpn7PloCVF6736KbT6oF0eVo1vlBfMZRCuIeU/W
         PMrtmjTHwsxjH9NZx2rGc8RM26ZGI6IHrvEWAhUOpc6KfgwqOj1B6kg56ydYqroqF6/4
         UtnOwXkZYq6Cwv2lki0wHcPxterCqkdiLv6OsF+OCllvB7fRtM6wMC6bH5dNW9kCyHTh
         dRmbK36QMwTqRUpQGrO4tDiu28e/iu+eStgAIb47JCrLvuS7UK0kjjJF2hFeAcb1abmd
         1Hxg==
X-Gm-Message-State: AOAM533fu45svd9LS/NERui6rdf4D1fdj82Fx+R/dzu1fP5IT3oRyZiF
        v3iOd8mbmWMGD2zBpzkLmw4pIlIf/936OmMFOQg=
X-Google-Smtp-Source: ABdhPJztDYKFeiNJoCZRoJswecvAifKS4CNRAYgSUYCvFDnZC10zVxlGuKWwFPpkps/QTlATHUXrZ2BwVgZlAtQ9LZI=
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr3350899pjv.129.1606299923331;
 Wed, 25 Nov 2020 02:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20201124170744.112180-1-wei.liu@kernel.org> <20201124170744.112180-17-wei.liu@kernel.org>
In-Reply-To: <20201124170744.112180-17-wei.liu@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 12:26:12 +0200
Message-ID: <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 25, 2020 at 1:46 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> We are about to implement an irqchip for IO-APIC when Linux runs as root
> on Microsoft Hypervisor. At the same time we would like to reuse
> existing code as much as possible.
>
> Move mp_chip_data to io_apic.h and make a few helper functions
> non-static.

> +struct mp_chip_data {
> +       struct list_head irq_2_pin;
> +       struct IO_APIC_route_entry entry;
> +       int trigger;
> +       int polarity;
> +       u32 count;
> +       bool isa_irq;
> +};

Since I see only this patch I am puzzled why you need to have this in
the header?
Maybe a couple of words in the commit message to elaborate?

-- 
With Best Regards,
Andy Shevchenko
