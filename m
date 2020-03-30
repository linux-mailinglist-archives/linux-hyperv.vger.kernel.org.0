Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B075197C2E
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgC3MqD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 08:46:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56643 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729927AbgC3MqA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 08:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585572359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IN/OaDKC0LjXsIMM1cx8gNUwIenmpuygcOhi4qxSuJo=;
        b=dPRzmJRHIT7j1yrCm3vnUPYpUWtlIzOjHXEhAawgvncPXvCCJ/bae24tx4OwAVkx3C87ud
        iFBAAtnMB2ezIyFqti39I1QA75qnQmuD52guHp6F2SWxuKmOeI5UqyDe8fzvJKHJDQls37
        OtmrXjCPReTWsBAK6vK5w5bmLYW/jko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-kZBR4ehnPrGHELr9xWX_Xg-1; Mon, 30 Mar 2020 08:45:57 -0400
X-MC-Unique: kZBR4ehnPrGHELr9xWX_Xg-1
Received: by mail-wm1-f72.google.com with SMTP id n188so8721422wmf.0
        for <linux-hyperv@vger.kernel.org>; Mon, 30 Mar 2020 05:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IN/OaDKC0LjXsIMM1cx8gNUwIenmpuygcOhi4qxSuJo=;
        b=PdW6RcpvJk0/ouTctpZk1E2e8XaxnU0A2/PZ/ky7qIhvDvZHtpfx6Az400SiIQP6d4
         jMRD50mij17JsYd9cTbmD3BWnAJEKwWWSnwiimHic28dl7jjxu7PV8IF3NcvVHBNnZk+
         nENUHMOqyy6AnXhSZQzsdQZZk967m/NtLocNtz3DyU40mJY4GJ6o+M4sfvmF10AGyksx
         DDm5HQkZ4gKYc9mvuxfuacdbE9KcGLfmWTKybcKH8UJ3MGNRmzImsCJHLrlQmHn08TCg
         pQhK7YBZi8mXNDgFYyiKP4NfU94EGAi6XV7E1UvLgEsc08Jfq+93lpnLTIpLh/LQZ7J1
         9vXw==
X-Gm-Message-State: ANhLgQ1gkbs1HKLRpXuTHFAhNJsppQk2iNppFRh+dkqUijimI/PXK/15
        E2rZrguJ1Fq4zKFcopBQ/KdZWIgiqBrpxdzXslsLS+2vZS2jYGLimyBPALTQsMuQhrS7EbBUakS
        3uWZUmNYEwtV4rG5q9nXC+ZPW
X-Received: by 2002:a05:600c:295e:: with SMTP id n30mr12658353wmd.78.1585572356290;
        Mon, 30 Mar 2020 05:45:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vucbwK27VyyHyAZ67C5eVMYHadGG5at8YOXS2WVi1ktXO7LBeGPB3n+NxSQdpBjNypyupwuqA==
X-Received: by 2002:a05:600c:295e:: with SMTP id n30mr12658327wmd.78.1585572356025;
        Mon, 30 Mar 2020 05:45:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c189sm22014054wmd.12.2020.03.30.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 05:45:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
In-Reply-To: <20200328182148.GA11210@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com> <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea> <87pncz3tcn.fsf@vitty.brq.redhat.com> <20200328182148.GA11210@andrea>
Date:   Mon, 30 Mar 2020 14:45:54 +0200
Message-ID: <87imim2epp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

>> Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
>> per-cpu list of channels on the same CPU so we don't need a spinlock to
>> guarantee that during an interrupt we'll be able to see the update if it
>> happened before the interrupt (in chronological order). With a global
>> list of relids, who guarantees that an interrupt handler on another CPU
>> will actually see the modified list? 
>
> Thanks for pointing this out!
>
> The offer/resume path presents implicit full memory barriers, program
> -order after the array store which should guarantee the visibility of
> the store to *all* CPUs before the offer/resume can complete (c.f.,
>
>   tools/memory-model/Documentation/explanation.txt, Sect. #13
>
> and assuming that the offer/resume for a channel must complete before
> the corresponding handler, which seems to be the case considered that
> some essential channel fields are initialized only later...)
>
> IIUC, the spin lock approach you suggested will work and be "simpler";
> an obvious side effect would be, well, a global synchronization point
> in vmbus_chan_sched()...
>
> Thoughts?

This is, of course, very theoretical as if we're seeing an interrupt for
a channel at the same time we're writing its relid we're already in
trouble. I can, however, try to suggest one tiny improvement:

vmbus_chan_sched() now clean the bit in the event page and then searches
for a channel with this relid; in case we allow the search to
(temporary) fail we can reverse the logic: search for the channel and
clean the bit only if we succeed. In case we fail, next time (next IRQ)
we'll try again and likely succeed. The only purpose is to make sure no
interrupts are ever lost.  This may be an overkill, we may want to try
to count how many times (if ever) this happens. 

Just a thought though.

-- 
Vitaly

