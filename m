Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52856B9DF
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiGHMlY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Fri, 8 Jul 2022 08:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiGHMlX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 08:41:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59C9A82398
        for <linux-hyperv@vger.kernel.org>; Fri,  8 Jul 2022 05:41:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15-e2xvJ3RBP5GiHGYgfSzsTQ-1; Fri, 08 Jul 2022 13:41:18 +0100
X-MC-Unique: e2xvJ3RBP5GiHGYgfSzsTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Fri, 8 Jul 2022 13:41:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Fri, 8 Jul 2022 13:41:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Saurabh Singh Sengar' <ssengar@linux.microsoft.com>
CC:     'Praveen Kumar' <kumarpraveen@linux.microsoft.com>,
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
Subject: RE: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Topic: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Index: AQHYkRjhlVfTnLUZGEKVRk7w2SiyFK1xLt+AgAMM44CAAC7FkA==
Date:   Fri, 8 Jul 2022 12:41:17 +0000
Message-ID: <2638aa8409104c41a560548be5628173@AcuMS.aculab.com>
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
 <b4fea161-41c5-a03e-747b-316c74eb986c@linux.microsoft.com>
 <a9af8d8d5ee24d19a87c3353a4e8941d@AcuMS.aculab.com>
 <20220708104203.GA10366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220708104203.GA10366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Singh Sengar
> Sent: 08 July 2022 11:42
> 
> On Wed, Jul 06, 2022 at 11:09:43AM +0000, David Laight wrote:
> > From: Praveen Kumar
> > > Sent: 06 July 2022 10:15
> > >
> > > On 05-07-2022 21:02, Saurabh Sengar wrote:
> > > > There can be scenarios where packets in ring buffer are continuously
> > > > getting queued from upper layer and dequeued from storvsc interrupt
> > > > handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
> > > > executing as a tasklet) for a long duration. Theoretically its possible
> > > > that this loop executes forever. Add a condition to limit execution of
> > > > this tasklet for finite amount of time to avoid such hazardous scenarios.
> >
> > Does this really make much difference?
> >
> > I'd guess the tasklet gets immediately rescheduled as soon as
> > the upper layer queues another packet?
> >
> > Or do you get a different 'bug' where it is never woken again
> > because the ring is stuck full?
> >
> > 	David
> 
> My initial understanding was that staying in a tasklet for "too long" may not be a
> good idea, however I was not sure what the "too long" value be, thus we are thinking
> to provide this parameter as a configurable sysfs entry. I couldn't find any linux
> doc justifying this, so please correct me here if I am mistaken.
> We have also considered the networking drivers NAPI budget feature while deciding
> this approach, where softirq exits once the budget is crossed. This budget feature
> act as a performance tuning parameter for driver, and also can help with ring buffer
> overflow. I believe similar reasons are true for scsi softirq as well.
> 
> NAPI budget Ref : https://wiki.linuxfoundation.org/networking/napi.

The NAPI 'budget' just changes where the system loops.
Instead of looping inside the ethernet driver rx processing
it first loops through the other functions of that 'napi' and
then loops in the softirq code.
All that just allows other 'softint' functions to run.
The softint code itself will defer to a kernel thread.
The softint code got patched (by Eric) to make it defer to
the thread less often (to avoid dropping packets), but that
change got reverted (well the original check was added back)
so the problem Eric was fixing got re-introduced.

If you are trying to stop rx ring buffer overflow then you
do need it to loop. If the softint code ever defers to a thread
you lose big-time.

The only way I've managed to receive 500,000 packets/sec is
using threaded napi and setting the napi thread to run under
the RT scheduler.

If you are looping from the softint scheduler you probably need to
return within a few microseconds - otherwise the ethernet
receive will start dropping packets at moderate loads.

OTOH I don't know where 'tasklet' get scheduler from.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

