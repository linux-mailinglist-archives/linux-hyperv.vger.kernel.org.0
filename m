Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF432AE097
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Nov 2020 21:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJUSq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Nov 2020 15:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJUSq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Nov 2020 15:18:46 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E403BC0613D1;
        Tue, 10 Nov 2020 12:18:45 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so19513530ejg.1;
        Tue, 10 Nov 2020 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64+t+UBWo2xP91Mvr3bd74FOkA8Gwa8aKm3A2/NKqr0=;
        b=vdBqnotgLg9z7e+W0Aty2sFn19tql1Q8Wx92Pv+ePM6y9E1YYyIbs+gtddM+Dane7N
         FtT1UufIJouV0mnoRhr4ZpCu9tenn0/no5Fv04LtfrpPzHdWrVKG3kKGHv2Tnx2oiJFA
         t9Kdew5dIq6D492W7a9ChN2zsFexQ+OcJZKtIEZnmAj7p4xj0diOhQp6n0lzOVoVAjXy
         5DkEThBpyiwgqto+k/7yz+RJMdr9t68Bq0qZu8+qXndk1OeLSIVBXH0/gf9nkxIz0u82
         GVdus/QTiImhe2BE/z/BYNw8QxIHykRYU8O9T165W/2RTk956A5K2p3TYYZMazWurLAU
         ToKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64+t+UBWo2xP91Mvr3bd74FOkA8Gwa8aKm3A2/NKqr0=;
        b=pQCwp33I61Gvav+QJdgKeWaAkqMYy75ufUrg/jcp53oKx7eJzC5w2yUIbe4U54oMtn
         QXlWesB/jv8TVjeFJKx3XbBBH+ciL3PGqqtnaW4psk0r3jy9AL8ZBPcmqwUTJLHa1kf0
         ZMkOBp3oweDD+yZN8ulJmkFkndZxYh8BJD3HTkl1GCDLq6gM6lJzUFBIvvBc3jXrm/oj
         +veH77d6a6au5KPjo3e1lY7iMIBQNu9Y/BZHU+YpGLbJWBWPoqt+49Rk1p5QSiLTU3A7
         IGHRGOAMk6bAms0/jatlX1ACx3Wp2HOb0TEeLRMIXnacX/gaZvcH4cQ8Y94WerYhYlBA
         zqFA==
X-Gm-Message-State: AOAM533OBs/wS/io+G4OtFNdXlZyA+xe7wfYLHuHNvGi+i2cXYYVhCYn
        hhAEuXfCYa+0ax5g0K2ySCg=
X-Google-Smtp-Source: ABdhPJw/zJaBtYYkNO6FjUeFTUn4DS+8kgedo801OuPASpf9Lga0Ag9RQGZItyR2PSVOpVB7VYCNSQ==
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr21008153ejb.126.1605039524380;
        Tue, 10 Nov 2020 12:18:44 -0800 (PST)
Received: from andrea (host-95-245-157-54.retail.telecomitalia.it. [95.245.157.54])
        by smtp.gmail.com with ESMTPSA id y2sm11279256edu.48.2020.11.10.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:18:43 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:18:33 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Chris Co <chrco@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        chrco@microsoft.com, mikelley@microsoft.com,
        andrea.parri@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU
 if disconnected
Message-ID: <20201110201833.GA3550@andrea>
References: <20201110190118.15596-1-chrco@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110190118.15596-1-chrco@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 10, 2020 at 07:01:18PM +0000, Chris Co wrote:
> From: Chris Co <chrco@microsoft.com>
> 
> When invoking kexec() on a Linux guest running on a Hyper-V host, the
> kernel panics.
> 
>     RIP: 0010:cpuhp_issue_call+0x137/0x140
>     Call Trace:
>     __cpuhp_remove_state_cpuslocked+0x99/0x100
>     __cpuhp_remove_state+0x1c/0x30
>     hv_kexec_handler+0x23/0x30 [hv_vmbus]
>     hv_machine_shutdown+0x1e/0x30
>     machine_shutdown+0x10/0x20
>     kernel_kexec+0x6d/0x96
>     __do_sys_reboot+0x1ef/0x230
>     __x64_sys_reboot+0x1d/0x20
>     do_syscall_64+0x6b/0x3d8
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This was due to hv_synic_cleanup() callback returning -EBUSY to
> cpuhp_issue_call() when tearing down the VMBUS_CONNECT_CPU, even
> if the vmbus_connection.conn_state = DISCONNECTED. hv_synic_cleanup()
> should succeed in the case where vmbus_connection.conn_state
> is DISCONNECTED.
> 
> Fix is to add an extra condition to test for
> vmbus_connection.conn_state == CONNECTED on the VMBUS_CONNECT_CPU and
> only return early if true. This way the kexec() path can still shut
> everything down while preserving the initial behavior of preventing
> CPU offlining on the VMBUS_CONNECT_CPU while the VM is running.
> 
> Fixes: 8a857c55420f29 ("Drivers: hv: vmbus: Always handle the VMBus messages on CPU0")
> Signed-off-by: Chris Co <chrco@microsoft.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Thanks,
  Andrea


> ---
>  drivers/hv/hv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 0cde10fe0e71..f202ac7f4b3d 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -244,9 +244,13 @@ int hv_synic_cleanup(unsigned int cpu)
>  
>  	/*
>  	 * Hyper-V does not provide a way to change the connect CPU once
> -	 * it is set; we must prevent the connect CPU from going offline.
> +	 * it is set; we must prevent the connect CPU from going offline
> +	 * while the VM is running normally. But in the panic or kexec()
> +	 * path where the vmbus is already disconnected, the CPU must be
> +	 * allowed to shut down.
>  	 */
> -	if (cpu == VMBUS_CONNECT_CPU)
> +	if (cpu == VMBUS_CONNECT_CPU &&
> +	    vmbus_connection.conn_state == CONNECTED)
>  		return -EBUSY;
>  
>  	/*
> -- 
> 2.17.1
> 
