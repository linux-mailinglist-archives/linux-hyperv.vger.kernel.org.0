Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385102022C4
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Jun 2020 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFTJPG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Jun 2020 05:15:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45724 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFTJPG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Jun 2020 05:15:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so11824126wru.12;
        Sat, 20 Jun 2020 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzFjEN5WQeTFn6eDfk2ZtH3jOKbrR8YK6PgAEtpx2DE=;
        b=U7bvDkFcKojUGdJKkFgCovMt1f9IGbKl8OTwn3Ectbi7nJYfWgDRjSBJVl5k805rOB
         ACJ8gl7Zwz1CFyiHmTVvmW/r4DYU8vHXHJvOgdISHOKyrCTP9OEq6mC20dGYNq/WoCsa
         PMXgOk0l7QVXVzG/57BjELEb3Vwpxkl+sxsdIFS/+QyypxELcRBZc8U8rKjO4sNCk/tq
         rdS7OWiAKq+0xvG+FKVUUnElwjczf6E2tQ7jSLhZD+t06XCZmNrs0z2eTq/bpQRvWVUl
         UDovg6+PlC8bSIEWrnQxxYfEJAjZGUpPpoHUiCzs7Trh3ajS2AToNRAe/+1+HQq9us2o
         kxHA==
X-Gm-Message-State: AOAM531Fd/Yk4Op8qfC/5/HKbzZ/I7eGc0Jw3nFLwbRnlmtc5Xp1j6gT
        Dl0Cxe6aPPOB/TgLTLo9GyZgT+it
X-Google-Smtp-Source: ABdhPJyhT/YmYd5AhBBhnAMG5Umm83gtLvjtftDHNMobFRuzWdbeWcTgQugc8AaPJj2TZGe6hUm4gQ==
X-Received: by 2002:adf:aad8:: with SMTP id i24mr7608213wrc.102.1592644504185;
        Sat, 20 Jun 2020 02:15:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i17sm2625697wrc.34.2020.06.20.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 02:15:03 -0700 (PDT)
Date:   Sat, 20 Jun 2020 09:15:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
Message-ID: <20200620091502.jhocdd34oewgim7p@liuwe-devbox-debian-v2>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-8-parri.andrea@gmail.com>
 <20200619160136.2r34bdu26hxixv7l@liuwe-devbox-debian-v2>
 <20200619161813.GA1596681@andrea>
 <yq1tuz6h29e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tuz6h29e.fsf@ca-mkp.ca.oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 19, 2020 at 10:58:40PM -0400, Martin K. Petersen wrote:
> 
> Andrea,
> 
> >> This patch should go via the hyperv tree because a later patch is
> >> dependent on it. It requires and ack from SCSI maintainers though.
> 
> Looks OK to me.
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks Martin.

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
