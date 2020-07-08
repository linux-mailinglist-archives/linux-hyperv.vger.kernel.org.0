Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49968218381
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2020 11:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGHJZR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jul 2020 05:25:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGHJZQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jul 2020 05:25:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id f18so40028466wrs.0;
        Wed, 08 Jul 2020 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHEXoSacTXtSlDKUw+15Jl9wo7TTVCqG6nV23+yAmOY=;
        b=Kq21Rv+cNcUM9uVAoTM8ZD6HzjRyj8vTo636vyZCF7CFRZvmUS52zSeCMGKtytNzQi
         9+Ahx1+VERT1Yqv6pBHLkkKcUsXrKKrt6HeIoVe/PeeKtn8+Hz/X3TXNr78XAZMHkFpy
         TEH7BJwQRI0dTRSmhozndr3ybbNuA1dY7XzN6WRTSLwtSNge/v3k8XxBw3sQ3bnZc+FN
         qU9BNxUIie9AmFzlVITpndZxHC8DGCdwrFg5ysSq/IyeVgUpMp0+Dh2dBqQH9yLJX5k/
         ZPvEaz1oujEFJxU7O1FJkPWjnzmTibxoTPnsd9m/rR2K4/1TR02AdhRtZvaHDa7dHpDe
         F56g==
X-Gm-Message-State: AOAM531zx3ZB8Tk5uqssgDONu48BXPwuUSMosOdBuApCUA4qcsiU066S
        36cnDCA4tD+EoQI5lfuEBCrNn3+X
X-Google-Smtp-Source: ABdhPJzzs/pKIjoQFtFDc1tJJR5LO6koOXolKGudMz2NmyNrXczooElRgYoirakpBhV1oDJvMtDDAQ==
X-Received: by 2002:adf:c185:: with SMTP id x5mr62928897wre.403.1594200314078;
        Wed, 08 Jul 2020 02:25:14 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k20sm5075886wmi.27.2020.07.08.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 02:25:13 -0700 (PDT)
Date:   Wed, 8 Jul 2020 09:25:12 +0000
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
Message-ID: <20200708092512.muse7szgxyihazvv@liuwe-devbox-debian-v2>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
 <20200701001221.2540-3-lkmlabelt@gmail.com>
 <20200707234700.GA218@Ryzen-9-3900X.localdomain>
 <20200708092105.7af7sf2olpaysh33@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708092105.7af7sf2olpaysh33@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 08, 2020 at 09:21:05AM +0000, Wei Liu wrote:
[...]
> > If I revert this commit, everything works fine:
> > 
> > PS C:\Users\natec> wsl --shutdown
> > PS C:\Users\natec> wsl -d ubuntu -- /bin/bash
> > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ cat /proc/version
> > Linux version 5.8.0-rc4-next-20200707-microsoft-standard+ (nathan@Ryzen-9-3900X) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP Tue Jul 7 16:35:06 MST 2020
> > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ git -C ~/src/linux-next lo -2
> > 0ff017dff922 (HEAD -> master) Revert "scsi: storvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening"
> > 5b2a702f85b3 (tag: next-20200707, origin/master, origin/HEAD) Add linux-next specific files for 20200707
> > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$
> > 
> > The kernel was built using the following commands:
> > 
> > $ mkdir -p out/x86_64
> > 
> > $ curl -LSso out/x86_64/.config https://github.com/microsoft/WSL2-Linux-Kernel/raw/linux-msft-wsl-4.19.y/Microsoft/config-wsl
> > 
> > $ scripts/config --file out/x86_64/.config -d RAID6_PQ_BENCHMARK -e NET_9P_VIRTIO
> > 
> > $ make -skj"$(nproc)" O=out/x86_64 olddefconfig bzImage
> > 
> > I don't really know how to get more information than this as WSL seems
> > rather opaque but I am happy to provide any information.
> 
> Linux kernel uses Hyper-V's crash reporting facility to spit out
> information when it dies. It is said that you can see that information
> in the "Event Viewer" program.
> 
> (I've never tried this though -- not using WSL2)
> 

If this doesn't work, another idea is to install a traditional VM on
Hyper-V and replace the kernel with your own.

With such setup, you should be able to add an emulated serial port to
the VM and grab more information.

Wei.
