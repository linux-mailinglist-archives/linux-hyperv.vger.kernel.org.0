Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF920FA50
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgF3RQh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 13:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390145AbgF3RQc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 13:16:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C286C03E97A
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Jun 2020 10:16:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so9757601pjf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Jun 2020 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCoSlvYpwE4xm9GGAZDoA+vu8+wYaZp5AwN6JLLP7E0=;
        b=VER2Btoh3kFyWbOJUwuHhFAoku5RHQcrAHEgHlOk2KpdI1XvAIM5WmdjrU0AqDlWqV
         cXRVRGgot1W90G6PZMfN5BDxuSIDQl8MTqI/8+dMZQsCcorEhBUz6nRzZGQ2w+668kLj
         CJ5s+9A2ezgfmv8iVqwPSynrgjvnMFrooa8jq2GiXiYP4E5FaFn9rygxFAc15MSEFtit
         UBjZ2UPOlDuvEZuD8Fo7fbwMCABJ5xvPRmOK3i3a+SBFILX4ESV1RRqyIuz8Y9tQ2kVu
         P/mUcdGRxs7hqpTOX2H96AyTfgHEZaApf+8zBn2tFCoxE8GToE0Yay1O3vIV6hOLRh7m
         fY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCoSlvYpwE4xm9GGAZDoA+vu8+wYaZp5AwN6JLLP7E0=;
        b=sj3N/jmj04tnzrVey+v03w85VILdpTlYuB9H02P8ydQKNFRrkAn3bXu9O5fbh+YIBk
         9uDoEH31ZfjH/7vdLxzLmG2ClcKLMHi0gX2wccu4tD1A2Eb0zxa1sQ6uCIH90jPxNOVz
         6S5RBHOUyRmVX5yugvgRXAhRw0wlw32qQpE86x0a8RM3Ua3lHXwGh++lcYlaioSEQK6r
         Pk9WxlYIAwjWARzoy6cjzcIm3P2Ixt0I2K5fgfr1NxYCnauvI0rl6fCTF5kkQ8fiaPZu
         UYsldjW74nRwiTgsIXf6MP/G0Q5HILLHeWqbqg8xNVlUT5j3GfP29LfHC3PEFMd2KfDt
         3wBA==
X-Gm-Message-State: AOAM531sf3UTLS3G0fF0srRjxOSoOesTYe5QPWfGzflUWEs/M6Yy/Pz2
        x2dHXDSJT1sAsmAffEKoiUhd2w==
X-Google-Smtp-Source: ABdhPJwTQKG+yNabwbiBqTlw7Ts5bhbBBqIBDsA+fvfKLo/ggAj6ZDNQuOqsHxH+g9mLpbTcyYOwgw==
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr6903719pjb.177.1593537391735;
        Tue, 30 Jun 2020 10:16:31 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id q39sm2885094pja.30.2020.06.30.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:16:31 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:16:21 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andres Beltran <lkmlabelt@gmail.com>
Cc:     t-mabelt@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200630101621.0f4d9dba@hermes.lan>
In-Reply-To: <20200630153200.1537105-1-lkmlabelt@gmail.com>
References: <20200630153200.1537105-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 30 Jun 2020 11:31:57 -0400
Andres Beltran <lkmlabelt@gmail.com> wrote:

> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
> 
> The first patch creates the definitions for the data structure, provides
> helper methods to generate new IDs and retrieve data, and
> allocates/frees the memory needed for vmbus_requestor.
> 
> The second and third patches make use of vmbus_requestor to send request
> IDs to Hyper-V in storvsc and netvsc respectively.
> 
> Thanks.
> Andres Beltran
> 
> Tested-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Cc: linux-scsi@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: David S. Miller <davem@davemloft.net>
> 
> Andres Beltran (3):
>   Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
>     hardening
>   scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
>     VMBus hardening
>   hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
>     hardening
> 
>  drivers/hv/channel.c              | 154 ++++++++++++++++++++++++++++++
>  drivers/net/hyperv/hyperv_net.h   |  13 +++
>  drivers/net/hyperv/netvsc.c       |  79 ++++++++++++---
>  drivers/net/hyperv/rndis_filter.c |   1 +
>  drivers/scsi/storvsc_drv.c        |  85 ++++++++++++++---
>  include/linux/hyperv.h            |  22 +++++
>  6 files changed, 329 insertions(+), 25 deletions(-)
> 

How does this interact with use of the vmbus in usermode by DPDK through hv_uio_generic?
Will it still work?
