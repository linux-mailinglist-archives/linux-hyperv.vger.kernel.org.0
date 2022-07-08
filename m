Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265DD56B75E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiGHKmF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGHKmF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 532AA7E03F;
        Fri,  8 Jul 2022 03:42:04 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id E2009204C3FD; Fri,  8 Jul 2022 03:42:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2009204C3FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657276923;
        bh=99rSQeHafgbRxHWOu2JfmcwUCoy/HYb3bmvsaH7S9FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLkMcQxAZBSwRbXNKgs3/0CKQ6oWSWLzxkK0eKZvuWEOWzZQVeif/ruEFgFmSr7MD
         1wxtYq4/hFNDHvVSIXHgVrUmx5gLzYt80ni6nGbxD5wYTKTHh9pnP4jPTah4Tfu8R8
         XEAHWyx0dkArbQ8nlLQcE8oQ5d6LZL9U1NHKD6xk=
Date:   Fri, 8 Jul 2022 03:42:03 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Praveen Kumar' <kumarpraveen@linux.microsoft.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ssengar@microsoft.com" <ssengar@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Prevent running tasklet for long
Message-ID: <20220708104203.GA10366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
 <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
 <a9af8d8d5ee24d19a87c3353a4e8941d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9af8d8d5ee24d19a87c3353a4e8941d@AcuMS.aculab.com>
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

On Wed, Jul 06, 2022 at 11:09:43AM +0000, David Laight wrote:
> From: Praveen Kumar
> > Sent: 06 July 2022 10:15
> > 
> > On 05-07-2022 21:02, Saurabh Sengar wrote:
> > > There can be scenarios where packets in ring buffer are continuously
> > > getting queued from upper layer and dequeued from storvsc interrupt
> > > handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
> > > executing as a tasklet) for a long duration. Theoretically its possible
> > > that this loop executes forever. Add a condition to limit execution of
> > > this tasklet for finite amount of time to avoid such hazardous scenarios.
> 
> Does this really make much difference?
> 
> I'd guess the tasklet gets immediately rescheduled as soon as
> the upper layer queues another packet?
> 
> Or do you get a different 'bug' where it is never woken again
> because the ring is stuck full?
> 
> 	David

My initial understanding was that staying in a tasklet for "too long" may not be a
good idea, however I was not sure what the "too long" value be, thus we are thinking
to provide this parameter as a configurable sysfs entry. I couldn't find any linux
doc justifying this, so please correct me here if I am mistaken.
We have also considered the networking drivers NAPI budget feature while deciding
this approach, where softirq exits once the budget is crossed. This budget feature
act as a performance tuning parameter for driver, and also can help with ring buffer
overflow. I believe similar reasons are true for scsi softirq as well.

NAPI budget Ref : https://wiki.linuxfoundation.org/networking/napi.

- Saurabh


> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
