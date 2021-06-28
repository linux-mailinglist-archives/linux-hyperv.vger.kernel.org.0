Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE33B67C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jun 2021 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhF1Rlb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Jun 2021 13:41:31 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37725 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhF1Rla (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Jun 2021 13:41:30 -0400
Received: by mail-wr1-f47.google.com with SMTP id i94so22280470wri.4;
        Mon, 28 Jun 2021 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x1KLh0OYEF3ex6ks4cGytJzCjqrl5yb7/zSlprVlZ9E=;
        b=ow+OuMEXMARv3vGv4h5FMsIRVFBk+ifeuhbUVUWRFRxiZBiIqb1PZBsAX0R3fy5GHm
         IxkNYEHz4t4U6VZeH7vxAn6tUfY1UouesHQl1iOxhDakUyURPr4LX7mIfRAVtOOauqZf
         wLt5MsP6TzufI5bDWztd9YeZNh1Or9UR9y/NKCW9CDhxjrOwGpOkU/oGdvRGSfKYWq44
         Bg+Ip4nesgdq3fbieTrHwufDZ7V30hBdmshzxZM8mV10QKTe26kJXnW5PyEcS3wHzm7l
         TKCLYpKeDy8mFzI8W+aSzRPeYFSNPF4MD4oTWlhCFQkhddBUsJYwESY2JG5AVqGzZU5x
         024A==
X-Gm-Message-State: AOAM531uVFETJCNldOZb2ELzdodji45JXAF2PvFTou1xRqsu8CX3PKLz
        CPbFoEWafkXT+viJIpJJOik=
X-Google-Smtp-Source: ABdhPJy8sUmcsCDQYEl9DOnlkHfDZbMvrgtz16KwsCG84MBS1mY8T+kwNuvosWWiPDoeK+PHVLtoPg==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr9632102wrx.177.1624901943832;
        Mon, 28 Jun 2021 10:39:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t16sm176520wmi.2.2021.06.28.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:39:03 -0700 (PDT)
Date:   Mon, 28 Jun 2021 17:39:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     longli@linuxonhyperv.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <20210628173901.mwo4ydfdmf3zd2zt@liuwe-devbox-debian-v2>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <ff05bb0d-bcad-8445-d410-7756e7502352@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff05bb0d-bcad-8445-d410-7756e7502352@metux.net>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 28, 2021 at 07:12:40PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 26.06.21 08:30, longli@linuxonhyperv.com wrote:
> 
> Hi,
> 
> > From: Long Li <longli@microsoft.com>
> > 
> > Azure Blob storage provides scalable and durable data storage for Azure.
> > (https://azure.microsoft.com/en-us/services/storage/blobs/)
> 
> It's a bit hard to quickly find out the exact semantics of that (w/o fully
> reading the library code ...).  :(
> 
> > This driver adds support for accelerated access to Azure Blob storage. As an
> > alternative to REST APIs, it provides a fast data path that uses host native
> > network stack and secure direct data link for storage server access.
> 
> I don't think that yet another misc device with some very specific API
> is a good thing. We should have a more generic userland interface.
> 
> Maybe a file system ?

This can already be done if I'm not mistaken:

https://docs.microsoft.com/en-us/azure/storage/blobs/storage-how-to-mount-container-linux
https://docs.microsoft.com/en-us/azure/storage/blobs/network-file-system-protocol-support-how-to

> 
> OTOH, I've been considering adding other kind of blob stores (eg. venti
> and similar things) and inventing an own subsys for that, so we'd have
> some more universal interface. Unfortunately always been busy with other
> things.
> 
> Maybe we should go that route instead of introducing yet another device
> specific uapi.

This work of course does not preclude anyone from going that route.

Wei.

> 
> 
> --mtx
> 
> -- 
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
