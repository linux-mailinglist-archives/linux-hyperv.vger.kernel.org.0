Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8919D999
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbgDCO4t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 10:56:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403971AbgDCO4t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loH0Iyc8DztXgdE0IC0vivynYULzbS4RKiT0U2Rn5EM=;
        b=iFsOYKi5cabq8pgibtmgo1maTft6vIvSQQaMR8fxjs+/HqCn0ohItDy5TzJN8T69504VLA
        edwXwL5xHafly4IUDBnMkfrBPhqLCX7aypAHngCLTFAhyRzZ2ODQ9mAHqsLqMLaHy78M0+
        QgwxToYSqGOzTbbpFhGODo9TIKQYGqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-roaLTZj8Ng2QIGA3xbaFbg-1; Fri, 03 Apr 2020 10:56:46 -0400
X-MC-Unique: roaLTZj8Ng2QIGA3xbaFbg-1
Received: by mail-wr1-f71.google.com with SMTP id r15so3162302wrm.22
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Apr 2020 07:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=loH0Iyc8DztXgdE0IC0vivynYULzbS4RKiT0U2Rn5EM=;
        b=aU/pKQhTjhZL7HihqnbEvM7PHCwF7E/7PMfomQ7l+YJRfaTTZCsLzxDiTI8ZStf775
         baOmTcRDXqnKgALiIaJxE1GNlPR+PPCCUOrg4pJaY+1n1XFY8ij0yh2qjj5CGkpGmKYH
         KbzJYKDIYTTpXegpkdi+wQRQUXnzZa8dd9d/1JlDarSPYEUuXZQ0paCydES1Zd9IbdLO
         iQ/lKT11o5KwP2mxMQweeLo64AuXcmbgY0G/f79+usQfo2YqZx/4NRit4KrwhQzb56+a
         evjFVdnP64d+o8keS1RyuSpwGrws5Bz/JdtFbMI2r7QLPFrm0aEdvY4fbNa8J3siaDox
         88Og==
X-Gm-Message-State: AGi0PuZq8m0DFG/pv45XGV+XYpcveQpbj7IdpVDnhUrYcXCcyS5r6a+l
        z/AcWYMv61C/nPhr+HIL4olxd/nwdCxBS4+MXLKZcQwTZTKpZjmBl5IBZ0Z5lGobG7sCWG+phrV
        EqB0adGGX+Cp34oVPyiOX9V2i
X-Received: by 2002:a5d:484b:: with SMTP id n11mr285272wrs.110.1585925805553;
        Fri, 03 Apr 2020 07:56:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLl4t8+RAIQho3Ho0qyn5QfOhB6yEWA3y5ASECeRQQOMztrN2sciZlYtWlkW2IjLS9OOwFfIQ==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr285255wrs.110.1585925805311;
        Fri, 03 Apr 2020 07:56:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o129sm3783691wma.20.2020.04.03.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:56:44 -0700 (PDT)
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
In-Reply-To: <20200403133826.GA25401@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com> <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea> <87pncz3tcn.fsf@vitty.brq.redhat.com> <20200328182148.GA11210@andrea> <87imim2epp.fsf@vitty.brq.redhat.com> <20200403133826.GA25401@andrea>
Date:   Fri, 03 Apr 2020 16:56:43 +0200
Message-ID: <87wo6wy5w4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Mon, Mar 30, 2020 at 02:45:54PM +0200, Vitaly Kuznetsov wrote:
>> Andrea Parri <parri.andrea@gmail.com> writes:
>> 
>> >> Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
>> >> per-cpu list of channels on the same CPU so we don't need a spinlock to
>> >> guarantee that during an interrupt we'll be able to see the update if it
>> >> happened before the interrupt (in chronological order). With a global
>> >> list of relids, who guarantees that an interrupt handler on another CPU
>> >> will actually see the modified list? 
>> >
>> > Thanks for pointing this out!
>> >
>> > The offer/resume path presents implicit full memory barriers, program
>> > -order after the array store which should guarantee the visibility of
>> > the store to *all* CPUs before the offer/resume can complete (c.f.,
>> >
>> >   tools/memory-model/Documentation/explanation.txt, Sect. #13
>> >
>> > and assuming that the offer/resume for a channel must complete before
>> > the corresponding handler, which seems to be the case considered that
>> > some essential channel fields are initialized only later...)
>> >
>> > IIUC, the spin lock approach you suggested will work and be "simpler";
>> > an obvious side effect would be, well, a global synchronization point
>> > in vmbus_chan_sched()...
>> >
>> > Thoughts?
>> 
>> This is, of course, very theoretical as if we're seeing an interrupt for
>> a channel at the same time we're writing its relid we're already in
>> trouble. I can, however, try to suggest one tiny improvement:
>
> Indeed.  I think the idea (still quite informal) is that:
>
>   1) the mapping of the channel relid is propagated to (visible from)
>      all CPUs before add_channel_work is queued (full barrier in
>      queue_work()),
>
>   2) add_channel_work is queued before the channel is opened (aka,
>      before the channel ring buffer is allocate/initalized and the
>      OPENCHANNEL msg is sent and acked from Hyper-V, cf. OPEN_STATE),
>
>   3) the channel is opened before Hyper-V can start sending interrupts
>      for the channel, and hence before vmbus_chan_sched() can find the
>      channel relid in recv_int_page set,
>
>   4) vmbus_chan_sched() finds the channel's relid in recv_int_page
>      set before it search/load from the channel array (full barrier
>      in sync_test_and_clear_bit()).
>
> This is for the "normal"/not resuming from hibernation case; for the
> latter, notice that:
>
>   a) vmbus_isr() (and vmbus_chan_sched()) can not run until when
>      vmbus_bus_resume() has finished (@resume_noirq callback),
>
>   b) vmbus_bus_resume() can not complete before nr_chan_fixup_on_resume
>      equals 0 in check_ready_for_resume_event().
>      
> (and check_ready_for_resume_event() does also provides a full barrier).
>
> If makes sense to you, I'll try to add some of the above in comments.
>

It does, thank you!

-- 
Vitaly

