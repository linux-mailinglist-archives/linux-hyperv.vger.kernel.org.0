Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE91D2239A9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jul 2020 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGQKqB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 06:46:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39659 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQKqA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 06:46:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id w3so16348932wmi.4;
        Fri, 17 Jul 2020 03:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YY3ppYqGw7E84eMLDXJRCrVaF4QNTh9fLWccSr6uIiU=;
        b=q6vAVxzxV9v9Hc1VUylqc3MpqQA/2f0ffFMvjlCtDJBseVmPgBamutlxqC1j9QUcEG
         Pl38ceaZ3aM/+gVtIS94k2GKvOpML+BIHVZsB9VSehAeuc3Y0ifAmudu1X4xh2N7eUy7
         Lfm4c+QopFTdS3CZQ7Gm8r6k9R1pWGRb6bYXdglBUpPgrTg5vzhWzDlcBnnVhC5I6r7s
         qD0DkgApDdLC4NlOqF/YkWA2dJXp0OCMnWjxG0Z/wNgpb0TlhO8P+Iwl9v7AhEey8LP8
         XYcyrKs75aZYAp+kRCcEgZXGI+5aUNQS1V1Tcfk7onOhO7Kzw9MRx1ZI8Y6qYYhZ1mt/
         tqCA==
X-Gm-Message-State: AOAM533a+6OdoMURg40PDcvCC0+JGHF69GobB0iPRASZBKEIpCD41i4U
        BKWMGRYprNdUxC6sGgAoVK8=
X-Google-Smtp-Source: ABdhPJyhkmGPpU8Pjdo+zQaFtP5F2glKmnDGK4/R8D94Ro/V3FiLZzWM3hGJtJ1M/nt5LnzZf8f/Ww==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr8270458wmc.76.1594982758313;
        Fri, 17 Jul 2020 03:45:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u2sm12011620wml.16.2020.07.17.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:45:57 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:45:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     t-mabelt@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Message-ID: <20200717104556.ul5s6hmtlerjpi3g@liuwe-devbox-debian-v2>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
 <20200701001221.2540-3-lkmlabelt@gmail.com>
 <20200707234700.GA218@Ryzen-9-3900X.localdomain>
 <20200708092105.7af7sf2olpaysh33@liuwe-devbox-debian-v2>
 <20200708092512.muse7szgxyihazvv@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708092512.muse7szgxyihazvv@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 08, 2020 at 09:25:12AM +0000, Wei Liu wrote:
> On Wed, Jul 08, 2020 at 09:21:05AM +0000, Wei Liu wrote:
> [...]
> > > If I revert this commit, everything works fine:
> > > 
> > > PS C:\Users\natec> wsl --shutdown
> > > PS C:\Users\natec> wsl -d ubuntu -- /bin/bash
> > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ cat /proc/version
> > > Linux version 5.8.0-rc4-next-20200707-microsoft-standard+ (nathan@Ryzen-9-3900X) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP Tue Jul 7 16:35:06 MST 2020
> > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ git -C ~/src/linux-next lo -2
> > > 0ff017dff922 (HEAD -> master) Revert "scsi: storvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening"
> > > 5b2a702f85b3 (tag: next-20200707, origin/master, origin/HEAD) Add linux-next specific files for 20200707
> > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$
> > > 
> > > The kernel was built using the following commands:
> > > 
> > > $ mkdir -p out/x86_64
> > > 
> > > $ curl -LSso out/x86_64/.config https://github.com/microsoft/WSL2-Linux-Kernel/raw/linux-msft-wsl-4.19.y/Microsoft/config-wsl
> > > 
> > > $ scripts/config --file out/x86_64/.config -d RAID6_PQ_BENCHMARK -e NET_9P_VIRTIO
> > > 
> > > $ make -skj"$(nproc)" O=out/x86_64 olddefconfig bzImage
> > > 
> > > I don't really know how to get more information than this as WSL seems
> > > rather opaque but I am happy to provide any information.
> > 
> > Linux kernel uses Hyper-V's crash reporting facility to spit out
> > information when it dies. It is said that you can see that information
> > in the "Event Viewer" program.
> > 
> > (I've never tried this though -- not using WSL2)
> > 
> 
> If this doesn't work, another idea is to install a traditional VM on
> Hyper-V and replace the kernel with your own.
> 
> With such setup, you should be able to add an emulated serial port to
> the VM and grab more information.

Hi Nathan, do you need more help on this?

MSFT is also working on reproducing this internally.

We're ~2 weeks away from the next merge window so it would be good if we
can get to the bottom of this as quickly as possible.

Wei.

> 
> Wei.
