Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33DB1A6B00
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2020 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgDMRHw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Apr 2020 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732482AbgDMRHv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Apr 2020 13:07:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9FC0A3BDC;
        Mon, 13 Apr 2020 10:07:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so10865184wrm.13;
        Mon, 13 Apr 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cPp1KyZf/lmOsFiy9zdMoMIN4AP8ao5Ga2p4X+esbbo=;
        b=ODN8uGXY9MjhcbVeYG4bRd9JJzIU3gZlXe/bp/G195Lyf/H4koZ43Qr1gAucL9SiRa
         abBo1ucbP7IyrS/YZhELu11UI8jRtNkPrzfnnDlrfvvfbYRZzDJ3OWnAjwoK5k0ysZOl
         G4kiu46X+r0tmetlrJJ7zqQe31bSD6AnjXXw0741UqnTMtAOQ0OQlQ8kBt40CG72Ahv1
         3BCK86dUsMciNvFlR8EwNqreYTNDjRL8IL0HNU/6jeOKtgiRUmSZqckheIfsdB3SWnDT
         rpzeIXqjIG21PMG0EH0TYLszpeGdj8OeLDC92Z3052Ixq2VkOW987xHWfmdgrNlWocMM
         gQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cPp1KyZf/lmOsFiy9zdMoMIN4AP8ao5Ga2p4X+esbbo=;
        b=aq3G9xRdgxXAm/he+PbHzLC8duOco4CwnjfaQLDN9HbVlwE17DzKaq0FErwMjpP1wg
         AAw9CvZv/VcKdzcgyHdFicd9fvVxDfM8zEai+gBmBpJicslGUCWyJvDU4bcNXkdxveYi
         TCkl57PXpmTtmivxr6ijthF8FP5fRis2aJ+izz/H3yXAzu56axVKtAGB4PT/VZ2omjOj
         iOEDAceUA/T5zUzAU0lHQNCAQJGZ/91mw2HfQUh2dfH/mwpuHL4G8BQB3ir5Iij33Dlt
         AxhRHsLn4IeGyW/kep6bK2t2ctoKS2DiyxWG3PIHhHY9gecoZifTDomdtWn873JC8lJX
         GupA==
X-Gm-Message-State: AGi0PuY7wl0JTWc1fnib1y5v67ufg8k5j6CnfFAEa+pGO8lgUt417N2x
        wcQJ0fbKqXpqCXCe9deeR80=
X-Google-Smtp-Source: APiQypIYTXMDlbbadKCR2So0u2zqsQZ78M0RQqvQJVW3owAmKNqBMcl9cd6Cmjnzji5CHysLJ4LzXQ==
X-Received: by 2002:adf:afe4:: with SMTP id y36mr20068052wrd.205.1586797669906;
        Mon, 13 Apr 2020 10:07:49 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id b4sm10640960wrv.42.2020.04.13.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:07:49 -0700 (PDT)
Date:   Mon, 13 Apr 2020 19:07:39 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 00/11] VMBus channel interrupt reassignment
Message-ID: <20200413170739.GA28863@andrea>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200413154836.rfvkbcg654pc5t5n@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413154836.rfvkbcg654pc5t5n@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 13, 2020 at 04:48:36PM +0100, Wei Liu wrote:
> On Mon, Apr 06, 2020 at 02:15:03AM +0200, Andrea Parri (Microsoft) wrote:
> > Hi all,
> > 
> > This is a follow-up on the RFC submission [1].  The series introduces
> > changes in the VMBus drivers to reassign the CPU that a VMbus channel
> > will interrupt.  This feature can be used for load balancing or other
> > purposes (e.g. CPU offlining).  The submission integrates feedback in
> > the RFC to amend the handling of the 'array of channels' (patch #3).
> > 
> > Thanks,
> >   Andrea
> > 
> > [1] https://lkml.kernel.org/r/20200325225505.23998-1-parri.andrea@gmail.com
> > 
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> > 
> > Andrea Parri (Microsoft) (11):
> >   Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
> >   Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific
> >     CPU
> >   Drivers: hv: vmbus: Replace the per-CPU channel lists with a global
> >     array of channels
> >   hv_netvsc: Disable NAPI before closing the VMBus channel
> >   hv_utils: Always execute the fcopy and vss callbacks in a tasklet
> >   Drivers: hv: vmbus: Use a spin lock for synchronizing channel
> >     scheduling vs. channel removal
> >   PCI: hv: Prepare hv_compose_msi_msg() for the
> >     VMBus-channel-interrupt-to-vCPU reassignment functionality
> >   Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
> >     logic
> >   Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
> >   Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message
> >     type
> >   scsi: storvsc: Re-init stor_chns when a channel interrupt is
> >     re-assigned
> > 
> 
> Applied to hyperv-next. Thanks.
> 
> This hunk in patch 10 doesn't apply cleanly because it conflicts with
> Vitaly's patch.
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 3785beead503d..1058c814ab06e 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1377,7 +1377,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
>         { CHANNELMSG_19,                        0, NULL },
>         { CHANNELMSG_20,                        0, NULL },
>         { CHANNELMSG_TL_CONNECT_REQUEST,        0, NULL },
> -       { CHANNELMSG_22,                        0, NULL },
> +       { CHANNELMSG_MODIFYCHANNEL,             0, NULL },
>         { CHANNELMSG_TL_CONNECT_RESULT,         0, NULL },
>  };
> 
> I have fixed it up. New hunk looks like:
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index a6b21838e2de..9c62eb5e4135 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1380,7 +1380,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
>         { CHANNELMSG_19,                        0, NULL, 0},
>         { CHANNELMSG_20,                        0, NULL, 0},
>         { CHANNELMSG_TL_CONNECT_REQUEST,        0, NULL, 0},
> -       { CHANNELMSG_22,                        0, NULL, 0},
> +       { CHANNELMSG_MODIFYCHANNEL,             0, NULL, 0},
>         { CHANNELMSG_TL_CONNECT_RESULT,         0, NULL, 0},
>  };

The fix looks good to me.  Thank you Wei!

Thanks,
  Andrea
