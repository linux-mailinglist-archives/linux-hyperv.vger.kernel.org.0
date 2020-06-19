Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F8201173
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2020 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391951AbgFSPld (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Jun 2020 11:41:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393819AbgFSPj6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Jun 2020 11:39:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y20so9519428wmi.2;
        Fri, 19 Jun 2020 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPc8eqqJk6T47a2LEja72Bb5lcr8LaOSHOJSN+CJ06A=;
        b=EvfdYxXzIA7OkqjcInU/LeTjlhD9K6gXId92dmnUEd/LpHBba8bw4W85tJeDuxq6Lq
         Tbk0P8ZK6xe4oRKbpPaKSoxNH2w8GaDxQd5Gh2ekCNXgn+FqD69wtNtbgxxDyAibngtM
         zXwroLcCko0FGXl12+10Ab269/sZAeDT9deku/UK/LNMYTFSLVmWofuHh6TkplYIQS6U
         NetrUo9CHeMWQxt9I8ZXEhX+oOC6ickVWdakHRob9mA6EqYfPzvuvlLvD+Scch67cWR0
         2YAMXuhg274J64CflUt58AA/fgVqIepRVfQkbEPbiZb5YtxB7ZorpmdlvFiJDxz8J9/n
         5ABQ==
X-Gm-Message-State: AOAM531pest9W5e/E7YlJIEOQic9FGX55VWkYTqKp7WCJVUPoabJdhvM
        D0p/xUMugWDD98S5YNtth80=
X-Google-Smtp-Source: ABdhPJyCwPM2zQ8awq7YG9LDzyH/UjLZPYAq/n5BML1AWVTBjWi+ynqH2ESR/0voLs0kiEIQxwn1Fg==
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr4274874wme.27.1592581196639;
        Fri, 19 Jun 2020 08:39:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 65sm2320270wre.6.2020.06.19.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:39:56 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:39:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Drivers: hv: vmbus: Miscellaneous cleanups
Message-ID: <20200619153954.qlrsgtreboqkn7xg@liuwe-devbox-debian-v2>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617164642.37393-1-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 17, 2020 at 06:46:34PM +0200, Andrea Parri (Microsoft) wrote:
> Hi all,
> 
> I went back to my "cleanup list" recently and I wrote these patches:
> here you can find, among other things,
> 
>   1) the removal of the fields 'target_vp' and 'numa_node' from the
>      channel data structure, as suggested by Michael back in May;
> 
>   2) various cleanups for channel->lock, which is actually *removed
>      by the end of this series!  ;-)
> 
> I'm sure there is room for further "cleanups",  ;-) but let me check
> if these (relatively small) changes make sense first...
> 
> Thanks,
>   Andrea
> 
> Andrea Parri (Microsoft) (8):
>   Drivers: hv: vmbus: Remove the target_vp field from the vmbus_channel
>     struct
>   Drivers: hv: vmbus: Remove the numa_node field from the vmbus_channel
>     struct
>   Drivers: hv: vmbus: Replace cpumask_test_cpu(, cpu_online_mask) with
>     cpu_online()
>   Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
>     (sc_list readers)
>   Drivers: hv: vmbus: Use channel_mutex in channel_vp_mapping_show()
>   Drivers: hv: vmbus: Remove unnecessary channel->lock critical sections
>     (sc_list updaters)
>   scsi: storvsc: Introduce the per-storvsc_device spinlock
>   Drivers: hv: vmbus: Remove the lock field from the vmbus_channel
>     struct

I've queued these up to hyperv-next except for the scsi patch.

Thanks,
Wei.
