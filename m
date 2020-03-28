Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553C5196857
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2020 19:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC1SV5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Mar 2020 14:21:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38866 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1SV5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 14:21:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id f6so9719152wmj.3;
        Sat, 28 Mar 2020 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=36XBR0ayoO3LyynzyStu6CZ4NUVnEty/c/VbR1WfpFE=;
        b=UZI3X69mmnGAQ4hP4hkW1mgGCYCITVCQURFygZtw2TWAyg0MQ8EGxK/fHjjH2C3TE+
         CYNFLLzjFUUi2YD/MTFP3Go+LHnrJf3Gl/tchMzoxlpNJae+hrfHDwDIb6OnZuNGvv9H
         tvhDzlT0x67MmI0bQbBlcUhoxMs1f0BHnIp7U2y9mBjHaOrdxRNr6iR0wldcUl7NZdDC
         89DsQryK/rpivmB/W+JTKk4jt+w8wZUYxmMk3A+uAkW0uDXWcRwKfdZwOlYXZcRzkFem
         lk73E37fFg/bJa9sms3l3sa510MQhTo5WZgcisG/aGY66KeMcg97DpMCwjjxOUA1kq/7
         wNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=36XBR0ayoO3LyynzyStu6CZ4NUVnEty/c/VbR1WfpFE=;
        b=Uu0Ivy1BgwHq0I9pPJtuUEU8lKFwOuilh/RQf68rx1E+6x1jK9yyCLGHb1rflIa0Rg
         t+/L2So07jRFG2c6dNn2n0sNg5/EFo+xsh6mhXBMpgd96RALN93U0khzmbXDFEDxsMKx
         t3BaHr7wK+jU8fKE6wzDVPNbQQYNWg4i6Ff78AptouEhBKL9+qPDdmSpP2LMd7J25QvI
         uYNIQIcKVDjACClXlJu8XcV4fYE48+6TMk0oi5who3h+7bxUlucU8tYoc+SHjD2Fktxi
         DGYXl+v01cSGDJS+66KgjEBsCujRjrfiKXGtFR47Ha705OVQVoKuk08TzBA16DKgIc0P
         aXdw==
X-Gm-Message-State: ANhLgQ3KjgFW9jp9EBPdJPbj/VV0jf1Ve2Ln+o4CIPUCzfJ29IdBuGM0
        pyMchGmf5Fss35v7c7WJIQc=
X-Google-Smtp-Source: ADFU+vscLyKBnpRVmMVlrMguDDiQaM764E/7p0jcjKXkbzvYdw1ftiq2ch6FXj/TlQu9bo43ttL/Zg==
X-Received: by 2002:a1c:dc55:: with SMTP id t82mr4702415wmg.6.1585419715066;
        Sat, 28 Mar 2020 11:21:55 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id v21sm5309967wmh.26.2020.03.28.11.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:21:54 -0700 (PDT)
Date:   Sat, 28 Mar 2020 19:21:48 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU
 channel lists with a global array of channels
Message-ID: <20200328182148.GA11210@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-4-parri.andrea@gmail.com>
 <87y2rn4287.fsf@vitty.brq.redhat.com>
 <20200326170518.GA14314@andrea>
 <87pncz3tcn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pncz3tcn.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
> per-cpu list of channels on the same CPU so we don't need a spinlock to
> guarantee that during an interrupt we'll be able to see the update if it
> happened before the interrupt (in chronological order). With a global
> list of relids, who guarantees that an interrupt handler on another CPU
> will actually see the modified list? 

Thanks for pointing this out!

The offer/resume path presents implicit full memory barriers, program
-order after the array store which should guarantee the visibility of
the store to *all* CPUs before the offer/resume can complete (c.f.,

  tools/memory-model/Documentation/explanation.txt, Sect. #13

and assuming that the offer/resume for a channel must complete before
the corresponding handler, which seems to be the case considered that
some essential channel fields are initialized only later...)

IIUC, the spin lock approach you suggested will work and be "simpler";
an obvious side effect would be, well, a global synchronization point
in vmbus_chan_sched()...

Thoughts?

Thanks,
  Andrea
