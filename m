Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B951AE9F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiEDUFQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 May 2022 16:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiEDUFP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 May 2022 16:05:15 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CFF1F612;
        Wed,  4 May 2022 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aBNOEK5JmznFe788VWdmCxb/E0ad0SoBOicyxzidG4M=; b=hU6ZvLQLzt+mU2QbDsSwJAwG2K
        30DuoWSMuIj8aO9pQO7xIlf0hPGS0L5OuRlGxcQJiRKoYSMAtroKV1MFv+B5r0Bpvx1Arl4UGvGgd
        KROrXNajwRwCgHJ6jdWZXZhRjoqYLiDyfNJ9pzlkh+9MgrMg3FSXUHo8A1m88XchRWcj5eugxuNVc
        +hZD4GEF0LfrUEaXFnM1KOSFiEZsuzMrcuhqMNV9yLhNNuljEXsV8sjTLMHgus+VC7fIB6uXkeBmx
        yTxrb17XAdg8JXbasw9OhBvqp88JRzHZk65H39flrqd2hbf2yt4OPFFvDY8rjlPzERcK9AWXYOlQw
        grP2V7AQ==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nmLBC-000BAC-K7; Wed, 04 May 2022 22:00:59 +0200
Message-ID: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
Date:   Wed, 4 May 2022 17:00:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marc Zyngier <maz@kernel.org>, mark.rutland@arm.com,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Should arm64 have a custom crash shutdown handler?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi folks, this email is to ask feedback / trigger a discussion about the
concept of custom crash shutdown handler, that is "missing" in arm64
while it's present in many architectures [mips, powerpc, x86, sh (!)].

Currently, when we kexec in arm64, the function machine_crash_shutdown()
is called as a handler to disable CPUs and (potentially) do extra
quiesce work. In the aforementioned architectures, there's a way to
override this function, if for example an hypervisor wish to have its
guests running their own custom shutdown machinery.

For powerpc/mips, the approach is a generic shutdown function that might
call other handler-registered functions, whereas x86/sh relies in the
"machine_ops" structure, having the crash shutdown as a callback in such
struct.

The usage for that is very broad, but heavy users are hypervisors like
Hyper-V / KVM (CCed Michael and Vitaly here for this reason). The
discussion about the need for that in arm64 is from another thread [0],
so before start implementing/playing with that, I'd like to ask ARM64
community if there is any feedback and in case it's positive, what is
the best implementation strategy (struct callback vs. handler call), etc.

I've CCed ARM64/ARM32 maintainers plus extra people I found as really
involved with ARM architecture - sorry if I added people I shouldn't or
if I forgot somebody (though the ARM mailing-list is CC).
Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/2787b476-6366-1c83-db80-0393da417497@igalia.com/
See the proposed option (b)
