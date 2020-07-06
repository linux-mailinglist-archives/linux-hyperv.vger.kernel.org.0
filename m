Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE6215CB9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgGFRLO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 13:11:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39965 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGFRLO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 13:11:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id f139so42930579wmf.5;
        Mon, 06 Jul 2020 10:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FxwGWQMcLORFbX3FtYwfpy+gCcGxaQVQcEFoLrnat08=;
        b=YA1glZ2VIxWv/SwHXrJEvLrNZ1etDoX1wM2leoWlhTB5Ti0Jgo1OZgXa6KHw6lw1wt
         lNrybA6D9INi7MI+pEe+WZ2GBe/W7bcVCqKhLxs9BTgFPHvbDPxoxWOkWQcrWUNGiVeD
         66canYWlproHFY8enabVylGWqDhODRweHDc+GO+vhlcLHXpetkHZ5mfgV4R7FbHKBsn5
         v8b+n82sRFZM+e3XN2FEcETYaEuse145HHz+ZucCz1aeK1cYLunpDMXwH/HOvYpy45U9
         tUeAfhLI6m4H9yUj203F4FPJ9SyzMKAM9hK1S8WVZzQcXGg+eYirRlQP2bCu8GLIecda
         /YWw==
X-Gm-Message-State: AOAM532hbs1/hqjXdl1lCn4ifdCGWFeNM7wDwlsrd3G8iUlDOxfZ7Lk8
        6aypf/y+Mm/rQMJtl4eDDZk=
X-Google-Smtp-Source: ABdhPJzXKrdFon+80124TCMwCgNgQMLvdFNCTaVoP4PeQYBGjOmaliZ/ifCvEf2mbU4ivsbJal6eag==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr173369wmi.74.1594055472137;
        Mon, 06 Jul 2020 10:11:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u1sm18079994wrb.78.2020.07.06.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:11:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 17:11:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     t-mabelt@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com, Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 0/3] Drivers: hv: vmbus: vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200706171110.ti5cfhmaoufi3zt6@liuwe-devbox-debian-v2>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701001221.2540-1-lkmlabelt@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 30, 2020 at 08:12:18PM -0400, Andres Beltran wrote:
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

Series applied to hyperv-next. Thanks.
