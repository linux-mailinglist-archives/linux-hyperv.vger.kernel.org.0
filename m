Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27962AEF0F
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Nov 2020 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKK7W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Nov 2020 05:59:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46455 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKK7W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Nov 2020 05:59:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id d12so2048930wrr.13;
        Wed, 11 Nov 2020 02:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XQWFODdSo0naMCVtSFLByNNU8KoljLbxE0JRj0+kP0=;
        b=QJ7TEBdQE++HS3CzcfyoOEVtiGxS4f1Z1T70p2oeeSGmZo5737LcE1o2WjuY3kw/2V
         AnzyvBCiH8UZdfgnRNBk9avAbyA4pWqQzrsh8Ct8MDkYq/hW4Q+TLzVEaU6VASECSs8W
         /GOgI9QD1IIPDfJ1As4a/Be1y8Fe3vraEAQf+OwI7/hzCCoTmJDEyIob5x9ZE53WFcEK
         HNIYJoemk0mwNpYLHh8ZfKuFH0HqlnAXrav375wRMkxt1BihMe9ZFSU6Pj3id7ebmkQx
         aP1ZEMJa+MeBW/loRsmrXfHfDopX0kmfDXxWwPcKLQHXN6lJQFSGtiyvYMP0fAXSival
         zcCg==
X-Gm-Message-State: AOAM531AvjAVOysMOFDqH8iW8v3XUj+0sfPPnJyuDIzDydU4cWUzq+uV
        wpUwidK2noHwxx4D1e2W5WA=
X-Google-Smtp-Source: ABdhPJzoi/sAZSisCC2lzzxVfkKW9O459uLpFso26a/Pre6ON0DsT99UH0YpEcc+G8QNgZfASpyIXg==
X-Received: by 2002:adf:8143:: with SMTP id 61mr21154700wrm.318.1605092360414;
        Wed, 11 Nov 2020 02:59:20 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c62sm2140186wme.22.2020.11.11.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:59:19 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:59:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Chris Co <chrco@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, chrco@microsoft.com, mikelley@microsoft.com,
        andrea.parri@microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU
 if disconnected
Message-ID: <20201111105918.veq42r7oj45hhjv3@liuwe-devbox-debian-v2>
References: <20201110190118.15596-1-chrco@linux.microsoft.com>
 <20201110201833.GA3550@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110201833.GA3550@andrea>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 10, 2020 at 09:18:33PM +0100, Andrea Parri wrote:
> On Tue, Nov 10, 2020 at 07:01:18PM +0000, Chris Co wrote:
> > From: Chris Co <chrco@microsoft.com>
> > 
> > When invoking kexec() on a Linux guest running on a Hyper-V host, the
> > kernel panics.
> > 
> >     RIP: 0010:cpuhp_issue_call+0x137/0x140
> >     Call Trace:
> >     __cpuhp_remove_state_cpuslocked+0x99/0x100
> >     __cpuhp_remove_state+0x1c/0x30
> >     hv_kexec_handler+0x23/0x30 [hv_vmbus]
> >     hv_machine_shutdown+0x1e/0x30
> >     machine_shutdown+0x10/0x20
> >     kernel_kexec+0x6d/0x96
> >     __do_sys_reboot+0x1ef/0x230
> >     __x64_sys_reboot+0x1d/0x20
> >     do_syscall_64+0x6b/0x3d8
> >     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > This was due to hv_synic_cleanup() callback returning -EBUSY to
> > cpuhp_issue_call() when tearing down the VMBUS_CONNECT_CPU, even
> > if the vmbus_connection.conn_state = DISCONNECTED. hv_synic_cleanup()
> > should succeed in the case where vmbus_connection.conn_state
> > is DISCONNECTED.
> > 
> > Fix is to add an extra condition to test for
> > vmbus_connection.conn_state == CONNECTED on the VMBUS_CONNECT_CPU and
> > only return early if true. This way the kexec() path can still shut
> > everything down while preserving the initial behavior of preventing
> > CPU offlining on the VMBUS_CONNECT_CPU while the VM is running.
> > 
> > Fixes: 8a857c55420f29 ("Drivers: hv: vmbus: Always handle the VMBus messages on CPU0")
> > Signed-off-by: Chris Co <chrco@microsoft.com>
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Applied to hyperv-fixes. Thanks Chris and Andrea.

Wei.
