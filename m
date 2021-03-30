Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1664934E40A
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Mar 2021 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhC3JIs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Mar 2021 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhC3JI0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Mar 2021 05:08:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E0EC061762;
        Tue, 30 Mar 2021 02:08:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so17278421edu.10;
        Tue, 30 Mar 2021 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JopkR36qP9iYAEOIFtxNujqvc003NWZkBhmUZm75cOM=;
        b=IWh+xP0+Cah9/2eZ5h8CB+WdAzjNJgF3LvZT/J69iyISkhndXPSsuck6jThJw1jDi4
         94VM4rkPcS3e/GUyawO2a8/vJvx/62n0lyD8LGJVHrhnu9AzvZLWX51BB1KxBSWmyMSY
         atfHiMRy24a/rOvymm/5vPJ1GmHja+dR8Z39wh3QVgvyWldd/Eko8iTdFvgQN/hzNAgo
         klCSuIpXU8qReX584PrLWpYBkNdqC0R507hWxNkn1scF9VI2ATUAgAX0o6sJMy4RBDq+
         CAC0B4QKexnRfss4wdOTY61iLhcbCJNfAXMIT5qxtN+26p2P08bUfNEU8EppKnvPYom2
         C86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JopkR36qP9iYAEOIFtxNujqvc003NWZkBhmUZm75cOM=;
        b=g+ZmcLwtvMvWGo6ixsLVMrE0aulbRpmjSOdzHCF6BRjgi8UVFuPgbOV/egpAsSHvBW
         BTllppiHsqGsdpJhXZMIfEJgZGRaD9iJsKZMLx7LT3uWdj+17QEvfjFCxbhbckEhcNb6
         VEir83YQcGhgYgO6FrXYzOsg3X/W/1hcO/FhYQAHFQqqSkgtf8IjrRvKXC1Fk5IHuxgn
         OoMCCL5N0tfeHZTZAvF8I8J68D8uPWB7UO5P3J+XPeVV8HtUB9eYL4Xu0Rt47K35PvTC
         DIK7PksAB8DGlOILgYiWqfzWE+T5NvTrlzVYsYV+U911uDx6zyk0sMxu81Q2spi6rR1p
         Gsyw==
X-Gm-Message-State: AOAM532wykFYq0tadoIlX3cN9vFLNfVOqIMHRZIgmpsjGsYLLKYCdIFM
        Rt4noyi52UvJMUfu1pyOkUNM4qXDcF7cqQ==
X-Google-Smtp-Source: ABdhPJzlzmpKwFgdz3z2MefSCBqgcQiLSKJVGJuycrRnBEYKxfpwiIRJ9hKB4WKLnfDCx4uGB8Zpnw==
X-Received: by 2002:a05:6402:34d5:: with SMTP id w21mr32417401edc.14.1617095304521;
        Tue, 30 Mar 2021 02:08:24 -0700 (PDT)
Received: from anparri (host-95-232-15-7.retail.telecomitalia.it. [95.232.15.7])
        by smtp.gmail.com with ESMTPSA id t6sm10362417edq.48.2021.03.30.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:08:24 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:08:15 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Message-ID: <20210330090815.GA1897@anparri>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-4-parri.andrea@gmail.com>
 <YGICQc6HaYw8+uES@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGICQc6HaYw8+uES@aepfle.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Olaf,

On Mon, Mar 29, 2021 at 06:37:21PM +0200, Olaf Hering wrote:
> On Thu, Dec 17, Andrea Parri (Microsoft) wrote:
> 
> > Check that the packet is of the expected size at least, don't copy data
> > past the packet.
> 
> > +		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> > +				stor_device->vmscsi_size_delta) {
> > +			dev_err(&device->device, "Invalid packet len\n");
> > +			continue;
> > +		}
> > +
> 
> Sorry for being late:
> 
> It might be just cosmetic, but should this check be done prior the call to vmbus_request_addr()?

TBH, I'm not immediately seeing why it 'should'; it could make sense to move
the check on the packet data length.


> Unrelated: my copy of vmbus_request_addr() can return 0, which is apparently not handled by this loop in storvsc_on_channel_callback().

Indeed, IDs of 0 are reserved for so called unsolicited messages; I think we
should check that storvsc_on_io_completion() is not called on such messages.

Thanks,
  Andrea
