Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF671A691E
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2020 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgDMPsn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Apr 2020 11:48:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43662 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgDMPsm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Apr 2020 11:48:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id i10so10598446wrv.10;
        Mon, 13 Apr 2020 08:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x0rLPq9Sns/BwRC2jB2YeCFw6+44rIg8cqCHCP4ZKv4=;
        b=P1DqmbkBVRo3ZI9pMcOySFPvziR41fzgeZAKpBqwfYZne65orcvScKZ366nGgZxkiu
         W9QGQM9o57kmSwH7VEc0QcjLbjzGS6adR8ENbg0qNPVniY2fw+T0Aazs6+T8vzqu5skc
         ej5oCZMPg3RT5ko1d3wvrOgImAvw3yZc4fYiaGhSalo8fDc3VqAz+gBb97jQD+6OoUG6
         detjOqXoGe3nyYfMKuDzcOdxRXo8l57/j6LZwj+UOLA2s9S6OcPdPg8Hbb/U1kN7/g13
         MwbF4IyfcW4o9Ha6t7i3RVgKpxqiEOxoOT90qE0wl+ZXeVL9wK3x0kN7fgezzqKWqu7X
         UASQ==
X-Gm-Message-State: AGi0Pubm5XS9xvobHZuadhVUPYMH+r46ka0p0kLcRaI6SuUEBLVW5Tjf
        MwuuRjxV5+IvuBlyxyrL13I=
X-Google-Smtp-Source: APiQypIcYFzp+gNqqmZaeDC/cuip2gCYp7iGWnioOOPuaU8yex7GGlH8Wt1RpaACXZgneadvGKl2qA==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr12205070wru.153.1586792920517;
        Mon, 13 Apr 2020 08:48:40 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id k133sm15851710wma.0.2020.04.13.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:48:39 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:48:36 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
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
Message-ID: <20200413154836.rfvkbcg654pc5t5n@debian>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Apr 06, 2020 at 02:15:03AM +0200, Andrea Parri (Microsoft) wrote:
> Hi all,
> 
> This is a follow-up on the RFC submission [1].  The series introduces
> changes in the VMBus drivers to reassign the CPU that a VMbus channel
> will interrupt.  This feature can be used for load balancing or other
> purposes (e.g. CPU offlining).  The submission integrates feedback in
> the RFC to amend the handling of the 'array of channels' (patch #3).
> 
> Thanks,
>   Andrea
> 
> [1] https://lkml.kernel.org/r/20200325225505.23998-1-parri.andrea@gmail.com
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> 
> Andrea Parri (Microsoft) (11):
>   Drivers: hv: vmbus: Always handle the VMBus messages on CPU0
>   Drivers: hv: vmbus: Don't bind the offer&rescind works to a specific
>     CPU
>   Drivers: hv: vmbus: Replace the per-CPU channel lists with a global
>     array of channels
>   hv_netvsc: Disable NAPI before closing the VMBus channel
>   hv_utils: Always execute the fcopy and vss callbacks in a tasklet
>   Drivers: hv: vmbus: Use a spin lock for synchronizing channel
>     scheduling vs. channel removal
>   PCI: hv: Prepare hv_compose_msi_msg() for the
>     VMBus-channel-interrupt-to-vCPU reassignment functionality
>   Drivers: hv: vmbus: Remove the unused HV_LOCALIZED channel affinity
>     logic
>   Drivers: hv: vmbus: Synchronize init_vp_index() vs. CPU hotplug
>   Drivers: hv: vmbus: Introduce the CHANNELMSG_MODIFYCHANNEL message
>     type
>   scsi: storvsc: Re-init stor_chns when a channel interrupt is
>     re-assigned
> 

Applied to hyperv-next. Thanks.

This hunk in patch 10 doesn't apply cleanly because it conflicts with
Vitaly's patch.

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3785beead503d..1058c814ab06e 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1377,7 +1377,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
        { CHANNELMSG_19,                        0, NULL },
        { CHANNELMSG_20,                        0, NULL },
        { CHANNELMSG_TL_CONNECT_REQUEST,        0, NULL },
-       { CHANNELMSG_22,                        0, NULL },
+       { CHANNELMSG_MODIFYCHANNEL,             0, NULL },
        { CHANNELMSG_TL_CONNECT_RESULT,         0, NULL },
 };

I have fixed it up. New hunk looks like:

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index a6b21838e2de..9c62eb5e4135 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1380,7 +1380,7 @@ channel_message_table[CHANNELMSG_COUNT] = {
        { CHANNELMSG_19,                        0, NULL, 0},
        { CHANNELMSG_20,                        0, NULL, 0},
        { CHANNELMSG_TL_CONNECT_REQUEST,        0, NULL, 0},
-       { CHANNELMSG_22,                        0, NULL, 0},
+       { CHANNELMSG_MODIFYCHANNEL,             0, NULL, 0},
        { CHANNELMSG_TL_CONNECT_RESULT,         0, NULL, 0},
 };

Let me know if I messed it up.

Wei.
