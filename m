Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C62012C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2020 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393311AbgFSP4S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Jun 2020 11:56:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393170AbgFSP4R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Jun 2020 11:56:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id a6so8219811wrm.4;
        Fri, 19 Jun 2020 08:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3W6SSoO6CKPlvUrfyexRSlKrk88KG98RtQu5JyQ+q7k=;
        b=FansKkmMPFIVnZ+n/6Q8vlIsBQ425pvmqFTx4lVigyvW6L/vROkf/f4d5Vvg08iULb
         M3cZk9xWQjUjbtIX05pSLaWMZtpVY94imESlhqaCUqXseVhykYxjZSlZhyvhoLxDkY0I
         qIxMBjYy1Jpa/UtD4yS8Y64OnUEoB/c+9Zz3DtFZIOMPUhJ2zZmpOUxurjvO4S2iF8IM
         eGEcZOBYWJHwNuoFcilo+8rikNyBFCgrUvgth9Mj3mQShnVnzZ2jIJkWAa1br7L9wi3P
         ebBuDzLKu19GtW73Z0cDaSpdVfBoFBoq8sL6yAIJdK1sFsElel4lS340wZfBGN6pzd8O
         Bgfw==
X-Gm-Message-State: AOAM533k1tE2Nx2AmA/ZhjVvkddCaczI2ivGA5/XKOcPYOsyzZ+A4Od9
        vNKSeM6iAdlJpWyfYNpAtG8=
X-Google-Smtp-Source: ABdhPJyKa1QAQUtezUx4NgBSLsHGgQjuO/3Ts4BdtwxR81UHwDzngfylOa0kmRJi+WGJroPasFWZPw==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr5194071wra.340.1592582175691;
        Fri, 19 Jun 2020 08:56:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c143sm13202495wmd.1.2020.06.19.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:56:15 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:56:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Drivers: hv: vmbus: Miscellaneous cleanups
Message-ID: <20200619155613.uc3lvcpfz3lb5lzf@liuwe-devbox-debian-v2>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200619153954.qlrsgtreboqkn7xg@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619153954.qlrsgtreboqkn7xg@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 19, 2020 at 03:39:54PM +0000, Wei Liu wrote:
> On Wed, Jun 17, 2020 at 06:46:34PM +0200, Andrea Parri (Microsoft) wrote:
> > Hi all,
> > 
> > I went back to my "cleanup list" recently and I wrote these patches:
> > here you can find, among other things,
> > 
> >   1) the removal of the fields 'target_vp' and 'numa_node' from the
> >      channel data structure, as suggested by Michael back in May;
> > 
> >   2) various cleanups for channel->lock, which is actually *removed
> >      by the end of this series!  ;-)
> > 
> > I'm sure there is room for further "cleanups",  ;-) but let me check
> > if these (relatively small) changes make sense first...
> > 
> > Thanks,
> >   Andrea
> > 
> > Andrea Parri (Microsoft) (8):
> >   Drivers: hv: vmbus: Remove the target_vp field from the vmbus_channel
> >     struct
> >   Drivers: hv: vmbus: Remove the numa_node field from the vmbus_channel
> >     struct
> >   Drivers: hv: vmbus: Replace cpumask_test_cpu(, cpu_online_mask) with
> >     cpu_online()
> >   Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
> >     (sc_list readers)
> >   Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
> >   Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
> >     (sc_list updaters)
> >   scsi: storvsc: Introduce the per-storvsc_device spinlock
> >   Drivers: hv: vmbus: Remove the lock field from the vmbus_channel
> >     struct
> 
> I've queued these up to hyperv-next except for the scsi patch.
> 

Andrea just pointed out that the last patch can't build without the scsi
patch, so I've only applied only the first 6 patches for now.

Wei.

> Thanks,
> Wei.
