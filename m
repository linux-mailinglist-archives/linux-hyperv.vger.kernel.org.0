Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69820BFEA
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jun 2020 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgF0H6G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Jun 2020 03:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0H6C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Jun 2020 03:58:02 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790372081A;
        Sat, 27 Jun 2020 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593244682;
        bh=2/cm0M8v0eEtEFJEA8Dif5Ov9yE8KEk2CBe8/6XUXWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gOEMIbZQ5LnRjtui26c5ZekgfuHOCD/wNPRfzXO6NWYj/K5k+yrpmPjt+ueSyxrAn
         tEnXIgGvVa2aqhClJei5hf31zLUuRBVV83FLOBPRf22h1GtSTSZc0BH1827KlPArAA
         MWBf3/6LUrTmk7lo7nr0XO4PNnhrTQVIrLR3UbQI=
Received: by mail-ot1-f45.google.com with SMTP id n24so8539226otr.13;
        Sat, 27 Jun 2020 00:58:02 -0700 (PDT)
X-Gm-Message-State: AOAM533nUW2tFVoOjWQl4OW9xExZL1o36xwtmzgvnFCqe2b2eMZmOKVl
        xmUSmSp9ru+32jyfN2W1Jn/V8wMhi/DJj7jOwDY=
X-Google-Smtp-Source: ABdhPJyvEZ4ya/6GghXmbfDKYZlNzJQbzAIIUY/SlUz7bnD/Np9o6UmM8NkCsnN45BvB9WbnoZS7OhBRZNX9Vc6iEnA=
X-Received: by 2002:a4a:9210:: with SMTP id f16mr5775705ooh.13.1593244681878;
 Sat, 27 Jun 2020 00:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200618064307.32739-1-hch@lst.de> <20200618064307.32739-3-hch@lst.de>
 <CAMj1kXH985Aqma47yf96N45CYkTGePVpvihrc_TmOAp2f0vN-g@mail.gmail.com> <20200627075659.GA12509@lst.de>
In-Reply-To: <20200627075659.GA12509@lst.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Jun 2020 09:57:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFByt1QB224pCPEhAEi801cY9+ZQRFpvirtUBGBDOq8qQ@mail.gmail.com>
Message-ID: <CAMj1kXFByt1QB224pCPEhAEi801cY9+ZQRFpvirtUBGBDOq8qQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hyperv@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Jessica Yu <jeyu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, 27 Jun 2020 at 09:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Jun 27, 2020 at 09:34:42AM +0200, Ard Biesheuvel wrote:
> > > +       return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > +                       GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > +                       NUMA_NO_NODE, __func__);
> >
> > Why is this passing a string for the 'caller' argument, and not the
> > address of the caller?
>
> Dementia.  Fix sent.

:-)
