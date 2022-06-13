Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFB547E56
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 06:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiFMEGC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiFMEF6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 00:05:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B089C33E2A;
        Sun, 12 Jun 2022 21:05:57 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 5C13120C14B6; Sun, 12 Jun 2022 21:05:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C13120C14B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655093157;
        bh=OL4J6G5DoKiCFjbJIJdnY6JEGUYMVeDJ3rWYo0ANvVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5lseU7fiK463tZHyUT6vmNnpI8H3p6IxjwPgid5F9VtRUUh9RhNb4V/Oms27MNbi
         aJIacWYehPfQPd++sYNYBnb1J9pENx9o9ueKbSbU4RWOD8Zt/o4p83bGjppXeehmov
         NNhHy6uHu/P8sNoAK5+Hi7uKVxGd9WrRR/b+6rCg=
Date:   Sun, 12 Jun 2022 21:05:57 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: storvsc: Correct sysfs parameters as per Hyper-V
 storvsc requirement
Message-ID: <20220613040557.GA5467@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1654878824-25691-1-git-send-email-ssengar@linux.microsoft.com>
 <20220610163714.GA25982@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PH0PR21MB3025818CA2E6D9641B878A7AD7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025818CA2E6D9641B878A7AD7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks Michael for review, please find my comments inline

On Mon, Jun 13, 2022 at 02:49:09AM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Friday, June 10, 2022 9:37 AM
> > 
> > CC : linux-scsi@vger.kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com
> > 
> > On Fri, Jun 10, 2022 at 09:33:44AM -0700, Saurabh Sengar wrote:
> > > This patch corrects 3 parameters:
> > > 1. Correct the sysfs entry for maximum hardware transfer limit of single
> > >    transfer (max_hw_sectors_kb) by setting max_sectors, this was set to
> > >    default value 512kb before.
> > > 2. Correct SGL memory offset alignment as per Hyper-V page size.
> > > 3. Correct sg_tablesize which accounts for max SGL segments entries in a
> > >    single SGL.
> 
> I think a richer explanation in the commit message is warranted.
> Something like:
> 
>   Current code is based on the idea that the max number of SGL entries also
>   determines the max size of an I/O request.  While this idea was true in older
>   versions of the storvsc driver when SGL entry length was limited to 4 Kbytes,
>   commit 3d9c3dcc58e9 ("scsi: storvsc: Enable scatter list entry lengths > 4Kbytes")
>   removed that limitation.  It's now theoretically possible for the block
>   layer to send requests that exceed the maximum size supported by Hyper-V.
>   This problem doesn't currently happen in practice because the block layer
>   defaults to a 512 Kbyte maximum, while Hyper-V in Azure supports 2 Mbyte
>   I/O sizes.  But some future configuration of Hyper-V could have a smaller
>   max I/O size, and the block layer could exceed that max.
> 
>   Fix this by correctly setting max_sectors as well as sg_tablesize to reflect
>   the maximum I/O size that Hyper-V reports.  While allowing larger I/O sizes
>   larger than the block layer default of 512 Kbytes doesn't provide any
>   noticeable performance benefit in the tests we ran, it's still appropriate
>   to report the correct underlying Hyper-V capabilities to the Linux block layer.
> 
>   Also tweak the virt_boundary_mask to reflect that the needed alignment
>   derives from Hyper-V communication using a 4 Kbyte page size, and not
>   on the guest page size, which might be bigger (on ARM64, for example).
> 
> I don't think the title of the commit should focus on sysfs.  This
> commit is about correctly reporting Hyper-V I/O size limits; the sysfs
> entries just provide visibility into the values.
> 
> And given that the problem was introduced by the above mentioned
> commit, it would be appropriate to add a "Fixes:" tag.

[SS] : Thanks, will fix this
> 
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  drivers/scsi/storvsc_drv.c | 28 ++++++++++++++++++++++++----
> > >  1 file changed, 24 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > > index ca3530982e52..3e032660ae36 100644
> > > --- a/drivers/scsi/storvsc_drv.c
> > > +++ b/drivers/scsi/storvsc_drv.c
> > > @@ -1844,7 +1844,7 @@ static struct scsi_host_template scsi_driver = {
> > >  	.cmd_per_lun =		2048,
> > >  	.this_id =		-1,
> > >  	/* Ensure there are no gaps in presented sgls */
> > > -	.virt_boundary_mask =	PAGE_SIZE-1,
> > > +	.virt_boundary_mask =	HV_HYP_PAGE_SIZE - 1,
> > >  	.no_write_same =	1,
> > >  	.track_queue_depth =	1,
> > >  	.change_queue_depth =	storvsc_change_queue_depth,
> > > @@ -1969,11 +1969,31 @@ static int storvsc_probe(struct hv_device *device,
> > >  	/* max cmd length */
> > >  	host->max_cmd_len = STORVSC_MAX_CMD_LEN;
> > >
> > > +	/* max_hw_sectors_kb */
> > > +	host->max_sectors = (stor_device->max_transfer_bytes) >> 9;
> > >  	/*
> > > -	 * set the table size based on the info we got
> > > -	 * from the host.
> > > +	 * There are 2 requirements for Hyper-V storvsc sgl segments,
> > > +	 * based on which the below calculation for max segments is
> > > +	 * done:
> > > +	 *
> > > +	 * 1. Except for the first and last sgl segment, all sgl segments
> > > +	 *    should be align to HV_HYP_PAGE_SIZE, that also means the
> > > +	 *    maximum number of segments in a sgl can be calculated by
> > > +	 *    dividing the total max transfer length by HV_HYP_PAGE_SIZE.
> > > +	 *
> > > +	 * 2. Except for the first and last, each entry in the SGL must
> > > +	 *    have an offset that is a multiple of HV_HYP_PAGE_SIZE,
> > > +	 *    whereas the complete length of transfer may not be aligned
> > > +	 *    to HV_HYP_PAGE_SIZE always. This can result in 2 cases:
> > > +	 *    Example for unaligned case: Let's say the total transfer
> > > +	 *    length is 6 KB, the max segments will be 3 (1,4,1).
> > > +	 *    Example for aligned case: Let's say the total transfer length
> > > +	 *    is 8KB, then max segments will still be 3(2,4,2) and not 4.
> > > +	 *    4 (read next higher value) segments will only be required
> > > +	 *    once the length is at least 2 bytes more then 8KB (read any
> > > +	 *    HV_HYP_PAGE_SIZE aligned length).
> > >  	 */
> > > -	host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
> > > +	host->sg_tablesize = ((stor_device->max_transfer_bytes - 2) >> HV_HYP_PAGE_SHIFT) + 2;
> 
> This calculation covers all possible I/O request sizes up to and including
> the value of max_transfer_bytes, even if max_transfer_bytes is some
> weird number that's not a multiple of 512.   So I think it works as
> intended.
> 
> But setting host->max_sectors means that storvsc won't see an I/O request
> with a weird size, and some of the cases handled by the calculation don't
> actually occur.  You could use a simpler calculation that's a bit easier to
> understand:
> 
> host->sg_tablesize = (stor_device->max_transfer_bytes >> HV_HYP_PAGE_SIZE) + 1;
> 
> The "+1" handles the unaligned case you mention above.

[SS] : As per my understanding this may give incorrect result for unaligned cases. Lets take an
example of 6KB, "stor_device->max_transfer_bytes >> HV_HYP_PAGE_SIZE" will give only 1, and then
host->sq_tablesize will get final value as 2. Where as there is a possibility of 3 segments
1. 1KB
2. 4KB
3. 1KB

Please correct me if this scenario is not possible.

- Saurabh

> 
> Michael
> 
> > >  	/*
> > >  	 * For non-IDE disks, the host supports multiple channels.
> > >  	 * Set the number of HW queues we are supporting.
> > > --
> > > 2.25.1
