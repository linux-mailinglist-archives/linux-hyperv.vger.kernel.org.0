Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B674365570
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDTJca (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 05:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhDTJca (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 05:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618911118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18C/p49aePuANugYrk1JFsP03OKBgzLm8htKV+f/SOM=;
        b=OLFXTo5WUsFgSF+81woMWAFyPq9AQatzj5uyIPLfk8PcfcBYkvCytqG5dTTLJ3lpDK0+AJ
        6bz5v3gDBtNEKBH7EjCLvqBjia3843uM97lgq/aeBVqHbtrHAEMHM62ue5cu+4YqkBKT33
        EUlsP8jDzKjqQXPFaKHXgsVz8Xd7L0I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-c5WTKB6aONuHkB21yhlkaA-1; Tue, 20 Apr 2021 05:31:57 -0400
X-MC-Unique: c5WTKB6aONuHkB21yhlkaA-1
Received: by mail-ed1-f70.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so5246776edu.18
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Apr 2021 02:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=18C/p49aePuANugYrk1JFsP03OKBgzLm8htKV+f/SOM=;
        b=mYjM6VTUSw1ofroEd3FfrGIvTvCUT/ZrHyt5wzOp9MGshVAA6l/Ru2F4MbWX9GxcCn
         U1dMkn9erjr/KUItPjzkXqKRcq0qiEy3rgpN5wh7mliaj2zg2D61/mXi+ZK4q8FLrkni
         KZjhETPYcuAsFur0KTT1LwEbQAkY/XUKgXSgukw1BsHUAi/eStK9lUBHSnxmk/0EZmEj
         f2uBRear4m3VX9s/Cct9WIqakyjmqbKa/8HVuCkmFSMPF/TA9DvApvEftZ5fpE441vDO
         T8pz99gN/R1rogQ+zzka4R2ykJdi0QOSVDzKY7FmW/eqT2Jz86Cb7/KYeF5oH+haBsUp
         VLUQ==
X-Gm-Message-State: AOAM531Dgfby/u0bFZolJSQgz7DQtXYGzpuYfbSlu5stMiS700ALDpPt
        Yn/mCzXXIlLv/VK7+DzXcMAplucTy3TMJNhnYVYItwVruQrsyW2GXU3+Sh/FagMDD8IaZ9REimz
        6ZBoC4OvNMelPCA9Zs++FbPto
X-Received: by 2002:aa7:c456:: with SMTP id n22mr30101157edr.255.1618911115744;
        Tue, 20 Apr 2021 02:31:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUeQq/g5WwZUbmm4yqZa8is7EVp2d+iPwnDabIxtMc72bPSvFrQpjzcIDj+MnBLsIiMdFLbA==
X-Received: by 2002:aa7:c456:: with SMTP id n22mr30101141edr.255.1618911115583;
        Tue, 20 Apr 2021 02:31:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bh14sm12070314ejb.104.2021.04.20.02.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:31:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        decui@microsoft.com
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 1/1] Drivers:
 hv: vmbus: Increase wait time for VMbus unload
In-Reply-To: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
References: <1618894089-126662-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 20 Apr 2021 11:31:54 +0200
Message-ID: <87tuo1i9o5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> When running in Azure, disks may be connected to a Linux VM with
> read/write caching enabled. If a VM panics and issues a VMbus
> UNLOAD request to Hyper-V, the response is delayed until all dirty
> data in the disk cache is flushed.  In extreme cases, this flushing
> can take 10's of seconds, depending on the disk speed and the amount
> of dirty data. If kdump is configured for the VM, the current 10 second
> timeout in vmbus_wait_for_unload() may be exceeded, and the UNLOAD
> complete message may arrive well after the kdump kernel is already
> running, causing problems.  Note that no problem occurs if kdump is
> not enabled because Hyper-V waits for the cache flush before doing
> a reboot through the BIOS/UEFI code.
>
> Fix this problem by increasing the timeout in vmbus_wait_for_unload()
> to 100 seconds. Also output periodic messages so that if anyone is
> watching the serial console, they won't think the VM is completely
> hung.
>
> Fixes: 911e1987efc8 ("Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>
> Changed in v2: Fixed silly error in the argument to mdelay()
>
> ---
>  drivers/hv/channel_mgmt.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index f3cf4af..ef4685c 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -755,6 +755,12 @@ static void init_vp_index(struct vmbus_channel *channel)
>  	free_cpumask_var(available_mask);
>  }
>  
> +#define UNLOAD_DELAY_UNIT_MS	10		/* 10 milliseconds */
> +#define UNLOAD_WAIT_MS		(100*1000)	/* 100 seconds */
> +#define UNLOAD_WAIT_LOOPS	(UNLOAD_WAIT_MS/UNLOAD_DELAY_UNIT_MS)
> +#define UNLOAD_MSG_MS		(5*1000)	/* Every 5 seconds */
> +#define UNLOAD_MSG_LOOPS	(UNLOAD_MSG_MS/UNLOAD_DELAY_UNIT_MS)
> +
>  static void vmbus_wait_for_unload(void)
>  {
>  	int cpu;
> @@ -772,12 +778,17 @@ static void vmbus_wait_for_unload(void)
>  	 * vmbus_connection.unload_event. If not, the last thing we can do is
>  	 * read message pages for all CPUs directly.
>  	 *
> -	 * Wait no more than 10 seconds so that the panic path can't get
> -	 * hung forever in case the response message isn't seen.
> +	 * Wait up to 100 seconds since an Azure host must writeback any dirty
> +	 * data in its disk cache before the VMbus UNLOAD request will
> +	 * complete. This flushing has been empirically observed to take up
> +	 * to 50 seconds in cases with a lot of dirty data, so allow additional
> +	 * leeway and for inaccuracies in mdelay(). But eventually time out so
> +	 * that the panic path can't get hung forever in case the response
> +	 * message isn't seen.

I vaguely remember debugging cases when CHANNELMSG_UNLOAD_RESPONSE never
arrives, it was kind of pointless to proceed to kexec as attempts to
reconnect Vmbus devices were failing (no devices were offered after
CHANNELMSG_REQUESTOFFERS AFAIR). Would it maybe make sense to just do
emergency reboot instead of proceeding to kexec when this happens? Just
wondering.

>  	 */
> -	for (i = 0; i < 1000; i++) {
> +	for (i = 1; i <= UNLOAD_WAIT_LOOPS; i++) {
>  		if (completion_done(&vmbus_connection.unload_event))
> -			break;
> +			goto completed;
>  
>  		for_each_online_cpu(cpu) {
>  			struct hv_per_cpu_context *hv_cpu
> @@ -800,9 +811,18 @@ static void vmbus_wait_for_unload(void)
>  			vmbus_signal_eom(msg, message_type);
>  		}
>  
> -		mdelay(10);
> +		/*
> +		 * Give a notice periodically so someone watching the
> +		 * serial output won't think it is completely hung.
> +		 */
> +		if (!(i % UNLOAD_MSG_LOOPS))
> +			pr_notice("Waiting for VMBus UNLOAD to complete\n");
> +
> +		mdelay(UNLOAD_DELAY_UNIT_MS);
>  	}
> +	pr_err("Continuing even though VMBus UNLOAD did not complete\n");
>  
> +completed:
>  	/*
>  	 * We're crashing and already got the UNLOAD_RESPONSE, cleanup all
>  	 * maybe-pending messages on all CPUs to be able to receive new

This is definitely an improvement,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

