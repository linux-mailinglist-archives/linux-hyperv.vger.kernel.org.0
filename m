Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863A11968AA
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2020 19:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1Ssa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Mar 2020 14:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32925 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1Ssa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 14:48:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id w25so9811569wmi.0;
        Sat, 28 Mar 2020 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tOei2YQniXuHVvMeLn98ZdGRwvsGFEJYezja8ozJozM=;
        b=FAnNodzh68ETUiCajl/JsdQraytI4kITdAV+85hXmyoqiqCr8T78k+3oGKJ6unQ5zV
         Q7eUwe88KJsoYQ4Xeyu+Qc7E2aXPZEar10Zuvxm30vC8PvxSHdJsRCAIEWW/FMtVCUKF
         2xxCpSSr+sVEe+5LCWw1KiHCYBIrLV7Su6rsg296RyuDxeIpnR53lA5D0qR3zyXwIdDN
         YrHbQAr7xfiUwW0Tc1vbViXohlbUWYMm+dNShjaSB3w6cpP/LPXnnruiQMrw/o0irnSR
         Lp0dneIUvEv5fz7wbJ2jb//0iWFZplNo9CvkrLnB5c7KOeDgqT7fbK3rWBagPE5Zdvd2
         OaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOei2YQniXuHVvMeLn98ZdGRwvsGFEJYezja8ozJozM=;
        b=mkCbQ00R0Z21TGNE4W88zdR/bXo3d483n/0paccjOr9JpsaxUjqj9fYt//wzoA+FMo
         M9+d5i21i67QILSKQ36nJTX8nb20MZ/bAqCjL9y8tdLc1I5eTZtxSJek560C4J0CeRJ+
         LCx4j3PSmOf1PGlCz3dK3N2t8OyKe2GZzgFEUSkPvOX4Hzr6Ns64EXf9krW5r/fS9hLr
         EKt6UfqdXVLCSLK1FseSlVyfM/saarNPS4GusDnE8QMX0sfJw7vr7uhDISXj9GWeR/+X
         DVwD2WvaDsa0ToTpib/XZBjJgwT5TgjByWfXjf3t8hhjFshprqn0WEBxjZOgV35EQLUF
         03rQ==
X-Gm-Message-State: ANhLgQ3ZCVukY3ku3S/6zD2R49rp7y74GTh3suV6e65GaLb5hk6esqWF
        BFYtpek7OCPtMzVtQj9cT24=
X-Google-Smtp-Source: ADFU+vv2qwkmDjkusKl24Gkfw777pvkdWdovaDV/iONenbQ65Y4yKRkcpSRdtoA4HtWrFi/lCS7yPQ==
X-Received: by 2002:a1c:3241:: with SMTP id y62mr5125014wmy.66.1585421307800;
        Sat, 28 Mar 2020 11:48:27 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id w9sm15221280wrk.18.2020.03.28.11.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:48:27 -0700 (PDT)
Date:   Sat, 28 Mar 2020 19:48:21 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 10/11] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL message type
Message-ID: <20200328184821.GA12184@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-11-parri.andrea@gmail.com>
 <87v9mr41j4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9mr41j4.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 26, 2020 at 03:46:23PM +0100, Vitaly Kuznetsov wrote:
> "Andrea Parri (Microsoft)" <parri.andrea@gmail.com> writes:
> 
> > VMBus version 4.1 and later support the CHANNELMSG_MODIFYCHANNEL(22)
> > message type which can be used to request Hyper-V to change the vCPU
> > that a channel will interrupt.
> >
> > Introduce the CHANNELMSG_MODIFYCHANNEL message type, and define the
> > vmbus_send_modifychannel() function to send CHANNELMSG_MODIFYCHANNEL
> > requests to the host via a hypercall.  The function is then used to
> > define a sysfs "store" operation, which allows to change the (v)CPU
> > the channel will interrupt by using the sysfs interface.  The feature
> > can be used for load balancing or other purposes.
> >
> > One interesting catch here is that Hyper-V can *not* currently ACK
> > CHANNELMSG_MODIFYCHANNEL messages with the promise that (after the ACK
> > is sent) the channel won't send any more interrupts to the "old" CPU.
> >
> > The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is problematic
> > if the user want to take a CPU offline, since we don't want to take a
> > CPU offline (and, potentially, "lose" channel interrupts on such CPU)
> > if the host is still processing a CHANNELMSG_MODIFYCHANNEL message
> > associated to that CPU.
> >
> > It is worth mentioning, however, that we have been unable to observe
> > the above mentioned "race": in all our tests, CHANNELMSG_MODIFYCHANNEL
> > requests appeared *as if* they were processed synchronously by the
> > host.
> 
> Hyper-V engineers never want to make our lifes easier :-)

Haha.  I'd say more exciting!  ;-) ;-)


> I can only think of a 'lazy' approach to setting channel CPU affinity:
> we actually re-assign it to the target CPU when we receive first
> interrupt there - but it's not very different from re-assigning it there
> but still handling interrupts on the old CPU like you do.

Interesting!  I'm wondering whether it'd make sense to use a similar
approach to (lazily) "unblock" the "old" CPUs; let me think more...


> One more thing: it was already discussed several times but we never get
> to it. I think this question was even raised on Michael's latest
> 'Hyper-V on ARM' submission. What about implmenting a Hyper-V specific
> IRQ chip which would now support setting CPU affinity? The greatest
> benefit is that we don't need new tools to do e.g. load balancing,
> irqbalance will just work.

Thank you for the suggestions; TBH, I haven't considered such approach
so far (and I'd need more time to come up with an informed comment...)

OTOH, I had some initial investigations about the current (in-kernel)
balancing scheme/init_vp_index() and possible improvements/extensions
there...  Hopefully another, follow-up series to come soon!

Thanks,
  Andrea
