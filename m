Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AA58C2AF
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 07:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHHFHu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 01:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHFHt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 01:07:49 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5226376
        for <linux-hyperv@vger.kernel.org>; Sun,  7 Aug 2022 22:07:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id p22-20020a9d6956000000b00636a088b2aeso5803237oto.9
        for <linux-hyperv@vger.kernel.org>; Sun, 07 Aug 2022 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=Hk3W+eo6HKWQsdmG6QfS9M4TjMnr5f6FjyQracP5ocBC8obtbDAh278xmWvMKbMXqw
         e0TT4tk/bwAQUF+jbw2jPvlzV9OFPpJ21ueR1JdoGg19kInhs1flRl4UGLwWsr1z1tM1
         GNDpLdqEYpw0M4V/JXfxwlMtmRUkq1+Z/7DFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=M/24G7PzbPeCUGUC9+Rq5wQgf3nlzMTqA767pn2QVInIP6QezHD2W+XntwT62l312r
         nQtCXD/+SgwEDBZzAU7EAwDa16gBN6S3AHm1LuI7Gbnmk+xuypS9Fsv9PSY9bXDMLZww
         UJ7EHRy0A6/cOi5H8ThtB2Xh4n4tduhqvdt9HmghDp6BFb+LFikAYxXj5SxLPnFT01Eo
         eoAS1exzP4a+m+jXE8xx/v+NJm3cFWjXf5pMbIXaLi1rR4N3WInGxy9+22T4L0HmAgTB
         s8RMMd6ILLygoglIJKTXME/y7HoTHDxkWTm0/+ATRC/ber8xQNf22vxZY9C7nOdMzxYo
         Yxgg==
X-Gm-Message-State: ACgBeo3XRfWC+Evyn7fMbCwR6wQTCx25FW8wXJjqdHEgWvgyUpT1JSa2
        26BpakfpbQJhMpP3jo3/3JgTW8JT+uZ+Kg==
X-Google-Smtp-Source: AA6agR7K/x4iFOXPEHa5R7rXMEnRTDsM93Bbeuoa5V4Z2pxZdjj/rRwRWNbSoN9yZBZmgpttU/AVhw==
X-Received: by 2002:a9d:74d6:0:b0:618:edd7:3878 with SMTP id a22-20020a9d74d6000000b00618edd73878mr1539836otl.229.1659935268127;
        Sun, 07 Aug 2022 22:07:48 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id cm16-20020a056870b61000b0010200e2828fsm2097884oab.30.2022.08.07.22.07.46
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:07:46 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f2a4c51c45so9381832fac.9
        for <linux-hyperv@vger.kernel.org>; Sun, 07 Aug 2022 22:07:46 -0700 (PDT)
X-Received: by 2002:a05:6870:f593:b0:10d:887e:70fa with SMTP id
 eh19-20020a056870f59300b0010d887e70famr7477971oab.241.1659935265684; Sun, 07
 Aug 2022 22:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195325.402745-1-gpiccoli@igalia.com> <20220719195325.402745-4-gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-4-gpiccoli@igalia.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Sun, 7 Aug 2022 22:07:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to
 avoid lockups
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        halves@canonical.com, fabiomirmar@gmail.com,
        alejandro.j.jimenez@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com,
        dave.hansen@linux.intel.com, dyoung@redhat.com,
        feng.tang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
        jgross@suse.com, john.ogness@linutronix.de,
        Kees Cook <keescook@chromium.org>, luto@kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com,
        vkuznets@redhat.com, Will Deacon <will@kernel.org>,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        David Gow <davidgow@google.com>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 19, 2022 at 12:55 PM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Currently the gsmi driver registers a panic notifier as well as
> reboot and die notifiers. The callbacks registered are called in
> atomic and very limited context - for instance, panic disables
> preemption and local IRQs, also all secondary CPUs (not executing
> the panic path) are shutdown.
>
> With that said, taking a spinlock in this scenario is a dangerous
> invitation for lockup scenarios. So, fix that by checking if the
> spinlock is free to acquire in the panic notifier callback - if not,
> bail-out and avoid a potential hang.
>
> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
