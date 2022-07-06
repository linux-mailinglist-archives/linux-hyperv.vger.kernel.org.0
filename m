Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5B568442
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiGFJzG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGFJyC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 05:54:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA58824F02;
        Wed,  6 Jul 2022 02:53:58 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 7098020DDCC6; Wed,  6 Jul 2022 02:53:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7098020DDCC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657101238;
        bh=nqWFIU1UiRFLTOpHJIOQKgm3cC14TJ1i84bjg1AGMUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBDbzW9JfJw0HvDn0Ey1qx6FMF/Bd0qdu1ll02ZueIe9HzHVzzCII+Vgxpy577IXI
         3HK6hg00b3wcconubFbLgJ2kEB2l+qnzPSOoob9N/1ryz2TfjejHyf3IW3Ze5D/t1J
         AjezB/Yg9xIYo+WBr+8xxXs+gbOB2wwx4EahYJhU=
Date:   Wed, 6 Jul 2022 02:53:58 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH] scsi: storvsc: Prevent running tasklet for long
Message-ID: <20220706095358.GA3320@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
 <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
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

On Wed, Jul 06, 2022 at 02:44:42PM +0530, Praveen Kumar wrote:
> On 05-07-2022 21:02, Saurabh Sengar wrote:
> > There can be scenarios where packets in ring buffer are continuously
> > getting queued from upper layer and dequeued from storvsc interrupt
> > handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
> > executing as a tasklet) for a long duration. Theoretically its possible
> > that this loop executes forever. Add a condition to limit execution of
> > this tasklet for finite amount of time to avoid such hazardous scenarios.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index fe000da..0c428cb 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -60,6 +60,9 @@
> >  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
> >  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
> >  
> > +/* channel callback timeout in ms */
> > +#define CALLBACK_TIMEOUT		5
> 
> If I may, it would be good if we have the CALLBACK_TIMEOUT configurable based upon user's requirement with default value to '5'.
> I assume, this value '5' fits best to the use-case which we are trying to resolve here. Thanks.

Agree, how about adding a sysfs entry for this parameter

> 
> > +
> >  /*  Packet structure describing virtual storage requests. */
> >  enum vstor_packet_operation {
> >  	VSTOR_OPERATION_COMPLETE_IO		= 1,
> > @@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *context)
> >  	struct hv_device *device;
> >  	struct storvsc_device *stor_device;
> >  	struct Scsi_Host *shost;
> > +	unsigned long expire = jiffies + msecs_to_jiffies(CALLBACK_TIMEOUT);
> >  
> >  	if (channel->primary_channel != NULL)
> >  		device = channel->primary_channel->device_obj;
> > @@ -1224,6 +1228,9 @@ static void storvsc_on_channel_callback(void *context)
> >  		u32 minlen = rqst_id ? sizeof(struct vstor_packet) :
> >  			sizeof(enum vstor_packet_operation);
> >  
> > +		if (time_after(jiffies, expire))
> > +			break;
> > +
> >  		if (pktlen < minlen) {
> >  			dev_err(&device->device,
> >  				"Invalid pkt: id=%llu, len=%u, minlen=%u\n",
> 
> Regards,
> 
> ~Praveen.
