Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B142EAB51
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbhAEM6t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 07:58:49 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51263 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAEM6s (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 07:58:48 -0500
Received: by mail-wm1-f41.google.com with SMTP id v14so2948403wml.1;
        Tue, 05 Jan 2021 04:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=836qpMt3CNg5/h01x1jVl4EStobkNHavjjRKKOo1oHA=;
        b=r0o4qq85L/DX7NMT8jxm2sq+LfX3Dv7G5vsiTNtw5ggVpH+u/RE1vicqZLYtZw8znP
         w1oQx+87He8pIFbtigQLjDDpdctiy79JOkCYH1EQ1xzUq/uZOHMefQWZ+SNz2fSukkrZ
         NFnJXSWrcH4ILzz4u29t7qfIDi/XM43KEP0pxO3kvMS5M3wX7xGwM/V+5HovKXwTyj0t
         klE7jv1wTM2j+8HLisO/geCNJ2AWeOeBrSClfpT1mbmMJSMi6uMNEOfqLtjo3MrBToGV
         k6e2FgR8/4RIZuqajhl5WA4YsU3W8BdQ2BQCG394chRbAsFY5WsLW05Bget3wavXgtQ5
         B1wg==
X-Gm-Message-State: AOAM532Wcaz8ljdnn9sXm+XT8t8DPOioTnPSQDPE8k5xfE9kCYhyVBtZ
        JWgeik6wRtBXIR9zaVNNEC6nVL3nOwY=
X-Google-Smtp-Source: ABdhPJw07hcLlLDflKTEHckRCl8TiLu4ghZ+pqyA8N4DfcJlex2g/C6uTXWl5XeAB0DQ84TxH5R2Ew==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr3517461wmi.153.1609851486993;
        Tue, 05 Jan 2021 04:58:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b14sm93556485wrx.77.2021.01.05.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:58:06 -0800 (PST)
Date:   Tue, 5 Jan 2021 12:58:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Message-ID: <20210105125805.7yypaghcpgafsrcs@liuwe-devbox-debian-v2>
References: <20201223001222.30242-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223001222.30242-1-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 22, 2020 at 04:12:22PM -0800, Dexuan Cui wrote:
> When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> hibernation for the VM (this happens on old Hyper-V hosts like Windows
> Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> the hibernation intent for the VM), the VM is discouraged from trying
> hibernation (because the host doesn't guarantee that the VM's virtual
> hardware configuration will remain exactly the same across hibernation),
> i.e. the VM should not try to set up the swap partition/file for
> hibernation, etc.
> 
> x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> indication of the host toolstack support for a VM. Currently there is
> no easy and reliable way for the userspace to detect the presence of
> the state (see https://lkml.org/lkml/2020/12/11/1097).  Add
> /sys/bus/vmbus/supported_features for this purpose.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
>  drivers/hv/vmbus_drv.c                   | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> index c27b7b89477c..3ba765ae6695 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -1,3 +1,10 @@
> +What:		/sys/bus/vmbus/supported_features
> +Date:		Dec 2020
> +KernelVersion:	5.11

Too late for 5.11 now.

Given this is a list of strings, do you want to enumerate them in a
Values section or the Description section?

Wei.
