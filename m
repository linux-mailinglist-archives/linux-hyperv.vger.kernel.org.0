Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7314E78B71
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2019 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfG2MNU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jul 2019 08:13:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfG2MNU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jul 2019 08:13:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so61562558wru.13
        for <linux-hyperv@vger.kernel.org>; Mon, 29 Jul 2019 05:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OAFiZVjNkFUKfTygRlCRfwGcUdmnJeWZ6/SJ1tkJ51o=;
        b=GxsRFx7/vrTFN/NST/MiHNsYNMk8k2sp0YfDaRlkoUzD1eK8wcM0g3lVkE+u+yoyeX
         b3T5KFK431Fb2LIaf9wGwytSzbWsWyAhi8K6nkI/7sF3yXPc4k1Wt/3AM4I4DauF9ion
         h7xiyGMEk2qc0LH+ZAjyLJyhhtrh65BExAE9tUsmtujvC0TUI2ajZjnP6BHLbHKa6Y0I
         xdVQMmTfeeeC+1P+o4sPO9QGimTCVeA/n0ZIDihEVS1adDTgagTEk50te4tfg++xQEkL
         blW8moFpKGq8e2yDicqtMBeaC1BeDesn2hy/7Aegb7HzI3ROGhZ/vBtYYu/Ur8Fo58Yi
         bZag==
X-Gm-Message-State: APjAAAWqv2DMNHLf3NM7os91WawfDhKEcTSTo9nVsJfqlzw3jBtwU8P2
        W3b/P+ayXxqztGIhn+As6FfE0A==
X-Google-Smtp-Source: APXvYqxYLwdceXu+TMC5pTK1KmiI8eJ05r+J2TyubiU3AKCGtptL9+JT+SU512H9+wia+z4GtJd3Gg==
X-Received: by 2002:adf:f450:: with SMTP id f16mr88352291wrp.335.1564402398265;
        Mon, 29 Jul 2019 05:13:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y24sm45263300wmi.10.2019.07.29.05.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:13:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <20190729110927.GC31398@hirez.programming.kicks-ass.net>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net>
Date:   Mon, 29 Jul 2019 14:13:16 +0200
Message-ID: <87wog1kpib.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
>> lantianyu1986@gmail.com writes:
>> 
>> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >
>> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
>> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
>> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
>> > to set the sched clock function appropriately.  On x86, this sets
>> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
>> > scaled and adjusted to be continuous.
>> 
>> Hypervisor can, in theory, disable TSC page and then we're forced to use
>> MSR-based clocksource but using it as sched_clock() can be very slow,
>> I'm afraid.
>> 
>> On the other hand, what we have now is probably worse: TSC can,
>> actually, jump backwards (e.g. on migration) and we're breaking the
>> requirements for sched_clock().
>
> That (obviously) also breaks the requirements for using TSC as
> clocksource.
>
> IOW, it breaks the entire purpose of having TSC in the first place.

Currently, we mark raw TSC as unstable when running on Hyper-V (see
88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
instead. The problem is that 'TSC page' can be disabled by the
hypervisor and in that case the only remaining clocksource is MSR-based
(slow).

-- 
Vitaly
