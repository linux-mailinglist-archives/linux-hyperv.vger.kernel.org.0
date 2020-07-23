Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF73722B54B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgGWR6M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jul 2020 13:58:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39214 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgGWR6M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jul 2020 13:58:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id w3so6006716wmi.4;
        Thu, 23 Jul 2020 10:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8soSYgsaAYOhV3WNUy48B0E8DiVUFjxylvV0kiF2FU=;
        b=JGtv+MvtTerRupfCKKBtjZC+AsoPR3lAQRznvUt/z3eej8p+tBthm5nJgzfW0n/uRl
         EtHtn91CpPi/1roxGXWkjjzcsltxENVCxLEJhmlnKTsQGQ4f2YF3ePWGYNANBp//foAG
         1cGWvZzadkOr6ZO1h7FqLj04w0H7OSMunCcM3mjtWmX2jqnlb7t1JQ5Dch1mXfUbfIzT
         2r47IJxXCGdjY59qsFuh0cpoGC1C54OVvgR91XzVnNRu2YBo+yUO/riuIi17T+IRVmor
         ZdRkuzb2qT69kqMDrdR18TApA+uA4yM9mVqFekqCBy9a01mAOyNPrs7E6vLLJY9WvE0j
         vcfQ==
X-Gm-Message-State: AOAM530ex7rO5+Yuj/2ZmHNpU1aAAHphsTHqh+J9bfbu6s2h/fI+aMIP
        rZyUNCa40hehMf1n/klCC8k=
X-Google-Smtp-Source: ABdhPJz5J90Mi3tX2DV/Zc4IP5NnjxlAA+R4DpIr+TNrQ6eRFVGsQeZPRNFKE7asOWdKwWTjooUZRA==
X-Received: by 2002:a1c:4185:: with SMTP id o127mr5125354wma.8.1595527090358;
        Thu, 23 Jul 2020 10:58:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x18sm4642270wrq.13.2020.07.23.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:58:09 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:58:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Andres Beltran <lkmlabelt@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: Re: [PATCH v6 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200723175808.kypvzwp27xk6ccjb@liuwe-devbox-debian-v2>
References: <20200722223904.2801-1-lkmlabelt@gmail.com>
 <20200722223904.2801-2-lkmlabelt@gmail.com>
 <MW2PR2101MB1052AD4F70F592E57AA20DEAD7760@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052AD4F70F592E57AA20DEAD7760@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 23, 2020 at 01:24:03AM +0000, Michael Kelley wrote:
> From: Andres Beltran <lkmlabelt@gmail.com> Sent: Wednesday, July 22, 2020 3:39 PM
> > 
> > Currently, VMbus drivers use pointers into guest memory as request IDs
> > for interactions with Hyper-V. To be more robust in the face of errors
> > or malicious behavior from a compromised Hyper-V, avoid exposing
> > guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> > bad request ID that is then treated as the address of a guest data
> > structure with no validation. Instead, encapsulate these memory
> > addresses and provide small integers as request IDs.
> > 
> > Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> > ---
> > Changes in v6:
> > 	- Offset request IDs by 1 keeping the original initialization
> > 	  code.
> > Changes in v5:
> >         - Add support for unsolicited messages sent by the host with a
> >           request ID of 0.
> > Changes in v4:
> >         - Use channel->rqstor_size to check if rqstor has been
> >           initialized.
> > Changes in v3:
> >         - Check that requestor has been initialized in
> >           vmbus_next_request_id() and vmbus_request_addr().
> > Changes in v2:
> >         - Get rid of "rqstor" variable in __vmbus_open().
> > 
> >  drivers/hv/channel.c   | 170 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/hyperv.h |  21 +++++
> >  2 files changed, 191 insertions(+)
> 
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
