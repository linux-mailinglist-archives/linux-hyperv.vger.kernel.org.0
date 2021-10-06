Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF842426C
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhJFQUK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhJFQUJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 12:20:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6EC061746;
        Wed,  6 Oct 2021 09:18:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so11958102edk.2;
        Wed, 06 Oct 2021 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FlCsRca+BE+fo/TXe7iThdnn4Vy0oj5uuZWCksIsUDY=;
        b=cN2rZfRe5mFyvRzOBEYdD2FtkAQ8Rx4kP0d2F4gnxtGvVH5eqfBQNLAzFu2CLNxbn6
         xNV7JsLh9+t+BRHFlL/qun48O6uLtf6Tf63QtivV6L7aJ4IB4dpI6/JO3zbseW6ARC/V
         VWVXW3wOI6A8zlCWFUD8yt6y41Pzj4VbjhlT3IzBPUZPFRtmm0kcD49AWLMfOs1nTqlK
         tokm3Ytqw7UEqig269Q35runipFOtv4kkrU8vN06SekA4uhGikYpkJPyormKlAbzsAvw
         hNDDnqGmZuTK2GWhlUNyjc7cWUYR5oW/6ViqvXRbnGTEWCrhZGOPDn2kaZocGec5cWnX
         fnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlCsRca+BE+fo/TXe7iThdnn4Vy0oj5uuZWCksIsUDY=;
        b=m5q/O1IQbuq5SSIjC4NJ/rQIn0hwvIH+gtUUbZaXLL8ipVmX5Xfg/h/RIO0uGcYbdm
         t7wVq4ACDKwsveo3altPbynFkDPwdTej801m60suuVikeNh/W3tFN+/pxcqQ7saV0na1
         lWcKKR3WkZTgVTuJDNNiv0KEyPPZDEcSb+f8a7IlOmKq3pq5SNd616L18Mlqhcdel0D8
         OJ6BPm4mgxwPJ0LoBKwsT23dwt7af4+MDL7OoDmiu10JLzA3uK4k1VMhLpWBRF1nQT/I
         DI11/PjD5hK/6dDa62XC+AC0Q14Z2wGLfU9Bie0x6gLAvXoKGm+drmnjyJjOFRda4j0w
         f7Fw==
X-Gm-Message-State: AOAM530YUNS5ARftrPqGGy/O9f8xq4jQ9vd6M96FLl8UwWJs9lUgUv6u
        Mg/wK6keDoiFpuceKWEqF4U=
X-Google-Smtp-Source: ABdhPJxHJCkSTYXBx+7T/DhBKndQxFfmFS/uzibJEGv5l0/d2Mc12bvDpHw0camNClA7LraWmFchOA==
X-Received: by 2002:a17:906:1289:: with SMTP id k9mr33893360ejb.2.1633537093310;
        Wed, 06 Oct 2021 09:18:13 -0700 (PDT)
Received: from anparri (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id t4sm10190873edc.2.2021.10.06.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:18:13 -0700 (PDT)
Date:   Wed, 6 Oct 2021 18:18:05 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Message-ID: <20211006161805.GA24396@anparri>
References: <20211006132026.4089-1-parri.andrea@gmail.com>
 <MWHPR21MB1593050119EACC0E49748209D7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593050119EACC0E49748209D7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1302,13 +1306,25 @@ static void storvsc_on_channel_callback(void *context)
> >  			if (rqst_id == 0) {
> >  				/*
> >  				 * storvsc_on_receive() looks at the vstor_packet in the message
> > -				 * from the ring buffer.  If the operation in the vstor_packet is
> > -				 * COMPLETE_IO, then we call storvsc_on_io_completion(), and
> > -				 * dereference the guest memory address.  Make sure we don't call
> > -				 * storvsc_on_io_completion() with a guest memory address that is
> > -				 * zero if Hyper-V were to construct and send such a bogus packet.
> > +				 * from the ring buffer.
> > +				 *
> > +				 * - If the operation in the vstor_packet is COMPLETE_IO, then
> > +				 *   we call storvsc_on_io_completion(), and dereference the
> > +				 *   guest memory address.  Make sure we don't call
> > +				 *   storvsc_on_io_completion() with a guest memory address
> > +				 *   that is zero if Hyper-V were to construct and send such
> > +				 *   a bogus packet.
> > +				 *
> > +				 * - If the operation in the vstor_packet is FCHBA_DATA, then
> > +				 *   we call cache_wwn(), and access the data payload area of
> > +				 *   the packet (wwn_packet); however, there is no guarantee
> > +				 *   that the packet is big enough to contain such area.
> > +				 *   Future-proof the code by rejecting such a bogus packet.
> 
> The comments look good to me.
> 
> > +				 *
> > +				 * XXX.  Filter out all "invalid" operations.
> 
> Is this a leftover comment line that should be deleted?  I'm not sure about the "XXX".

That was/is intended as a "TODO".  What I think we are missing here is a
specification/authority stating "allowed vstor_operation for unsolicited
messages are: ENUMERATE_BUS, REMOVE_DEVICE, etc.".  If we wanted to make
this code even more "future-proof"/"robust", we would reject all packets
whose "operation" doesn't match that list (independently from the actual
form/implementation of storvsc_on_receive()...).  We are not quite there
tough AFAICT.


> >  				 */
> > -				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO) {
> > +				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO ||
> > +				    packet->operation == VSTOR_OPERATION_FCHBA_DATA) {
> >  					dev_err(&device->device, "Invalid packet with ID of 0\n");
> >  					continue;
> >  				}
> > --
> > 2.25.1
> 
> Other than the seemingly spurious comment line,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

I wanted to make sure that we're on the same page: I could either expand
or just remove that comment line; no strong opinion.  Please let me know
what is your/reviewers' preference.

Thanks,
  Andrea
