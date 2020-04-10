Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9517F1A4312
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 09:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJHnJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 03:43:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43173 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJHnJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 03:43:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id i10so1340676wrv.10;
        Fri, 10 Apr 2020 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdhRWr7RsOKQvHwCgSBBLi8gM1dHAA9wTw27kVS8RCY=;
        b=GL11riiR6JKzgFqjfc2m6/o18aBY6UqRXHLanEuHWgJGVirm5iQ+x+pyzQSP71PfPe
         o8v8kxGZfXybXC4cDQjrHbhOUcai3GR5m9pIzIMYhZwuZWsOi3WMB44b+RC1A4tad58O
         ZWvASmxAEHDhnZrlVEnA8Ct1LzIOTL464v6A+3sXqW+h2XVoj5r2PyosiAWlyV8HQGxf
         d/+XQz2AoqgxZ+6Cy7jjFvjXEiRqJ2GxS7mWZQmD31L9Lorp3ivB6brewkAkkOFLbcss
         2OCwHHAOAcTeiJNyoee8g2OegeX+TPQFS/ZnWDd2+6DjB05kCLNhDijOwRzS77DtVia4
         4iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdhRWr7RsOKQvHwCgSBBLi8gM1dHAA9wTw27kVS8RCY=;
        b=N573hNYYj/DaQcFhCeOlSpRm7QMFu4ORGNE6UPMfq2eSd+CaYHBni37N1OW9XaFqGi
         WIbE9WWySlikzo+VZtZzGLwgtBcCNTcumfegxqv/4fnDpCjM/M/j+yaGyN6Ug5uFRv1V
         wiZaEV8Nv1E7gQ1aIXSPQEGv8b7c343sFmJAYN2yr7xFOpjF2HyQVUVwxbKZN4Vb4Dvv
         lQ0S1pWgkLurCDnK5FrPfPUNM96itWFXDrKjHAEbb8KFGv8RCprYD0iUzHEVBcCBOn7e
         xeedB4JP0adJqZ+3vWEKuzo950ksE+N9f9AUaoKcvjH9MLXjasbL9zkds+vzmvziawH1
         vJTg==
X-Gm-Message-State: AGi0PuZuaB5cJwG2aCiaScedoBhqrIeuwSAFNAxHhRBe80/0kyN3MViq
        IZYHIFPdtg57S1rLPluChGaqUdIqRgN7kXmaNlM=
X-Google-Smtp-Source: APiQypIb4DAqUusLFSZ/BUD0r1CXQqqi1SsGbfhzFHHqTDK11XaFJbyVz6mhTDSGe9DpIXAlQnb18NjPY+9uKKU5224=
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr3294961wru.317.1586504586346;
 Fri, 10 Apr 2020 00:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 10 Apr 2020 15:42:55 +0800
Message-ID: <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
Subject: Re: SCSI low level driver: how to prevent I/O upon hibernation?
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Dexuan,

On Fri, Apr 10, 2020 at 1:44 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> Hi all,
> Can you please recommend the standard way to prevent the upper layer SCSI
> driver from submitting new I/O requests when the system is doing hibernation?
>
> Actually I already asked the question on 5/30 last year:
> https://marc.info/?l=linux-scsi&m=155918927116283&w=2
> and I thought all the sdevs are suspended and resumed automatically in
> drivers/scsi/scsi_pm.c, and the low level SCSI adapter driver (i.e. hv_storvsc)
> only needs to suspend/resume the state of the adapter itself. However, it looks
> this is not true, because today I got such a panic in a v5.6 Linux VM running on
> Hyper-V: the 'suspend' part of the hibernation process finished without any
> issue, but when the VM was trying to resume back from the 'new' kernel to the
> 'old' kernel, these events happened:
>
> 1. the new kernel loaded the saved state from disk to memory.
>
> 2. the new kernel quiesced the devices, including the SCSI DVD device
> controlled by the hv_storvsc low level SCSI driver, i.e.
> drivers/scsi/storvsc_drv.c: storvsc_suspend() was called and the related vmbus
> ringbuffer was freed.
>
> 3. However, disk_events_workfn() -> ... -> cdrom_check_events() -> ...
>    -> scsi_queue_rq() -> ... -> storvsc_queuecommand() was still trying to
> submit I/O commands to the freed vmbus ringbuffer, and as a result, a NULL
> pointer dereference panic happened.

Last time I replied to you in above link:

"scsi_device_quiesce() has been called by scsi_dev_type_suspend() to prevent
any non-pm request from entering queue."

That meant no any normal FS request can enter scsi queue after suspend, however
request with BLK_MQ_REQ_PREEMPT is still allowed to be queued to LLD
after suspend.

So you can't free related vmbus ringbuffer cause  BLK_MQ_REQ_PREEMPT request
is still to be handled.

Thanks,
Ming Lei
