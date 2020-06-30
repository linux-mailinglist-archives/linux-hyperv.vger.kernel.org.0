Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5519820F30F
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgF3KtC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 06:49:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbgF3KtB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 06:49:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so19597320wrs.11;
        Tue, 30 Jun 2020 03:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7H7Wd8V6abo/tC7AAicI30ABnPqpXYupkqQc2ZfwkRQ=;
        b=oelA98B3AsQuS8FjPHNIzc95abQcc5MYirvCnKQZb13rWW+29AuwtjLmHZEpIV43Vf
         UTvhV4Z5OdC/WNhYbMInQtFtBue6nhRAJWdoMSz3izq+14oAWeUO1zLjGrqQTBL3DFSM
         XMDUI5mJP+wppHl5LmEjUWi/bDGYFSECH2SxQZUHPGHO1Pize2ZGi10K9iPiPfA2/edd
         56UcibeDjNXMcZ6h15dK6qIrm+RY5toZD7rzh0OVBThqcnOLKLERVUrbf5lfUeBdT+G2
         JABYssRCOVWtBIKMPQuI92EP+SZRBTBsTOAeBq7CIV6PQqBVpTZKxYibLH5WdwLSuV2q
         8s2g==
X-Gm-Message-State: AOAM533vi1CYXlM3MRZwn1ny+XMAcYsdqEhaqrfEdVMIlMnaXWDtLKdW
        /EcmEUpK3E6DzAfBCcoWkLU=
X-Google-Smtp-Source: ABdhPJxSBa8M+8p0Ik+N+t3+CtlUEMVZnuIQkUWsY9qObcTbRIqxOIpQ6eEYMoAndKow67N0yi8UGw==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr20712165wrs.353.1593514138678;
        Tue, 30 Jun 2020 03:48:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z132sm3160573wmb.21.2020.06.30.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 03:48:57 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:48:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andres Beltran <lkmlabelt@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH v2 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200630104856.i3zwib2zrf644w6v@liuwe-devbox-debian-v2>
References: <20200629200227.1518784-1-lkmlabelt@gmail.com>
 <20200629200227.1518784-2-lkmlabelt@gmail.com>
 <20200629204653.o6q3a2fufgq62pzo@liuwe-devbox-debian-v2>
 <CAGpZZ6sUXOnggeQyPfxkdK50=1AhTUqbvBvc2bEs4qwwk+rSPg@mail.gmail.com>
 <20200629222040.bh7tkkridwt7sdlw@liuwe-devbox-debian-v2>
 <CAGpZZ6teQ1KDKZ28Q50DSOZ3dF4oqEHagC2YSkb9WjKZ1io5Mw@mail.gmail.com>
 <20200630100945.jzl2a2plw2gsnkyw@liuwe-devbox-debian-v2>
 <20200630101736.ggskutpgv36lr4q7@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630101736.ggskutpgv36lr4q7@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 30, 2020 at 10:17:36AM +0000, Wei Liu wrote:
[...]
> > > 
> > > If the allocation of the requestor fails during runtime, vmbus_open()
> > > fails too and therefore,
> > > the channel and the requestor will not be created. So, the 2 functions
> > > (next_id, requestor_addr)
> > > will never get called, right? The only case in which we hit this edge
> > > case is if a driver is using this
> > > mechanism with a size of 0 (i.e. rqstor_size is not set to a non-zero
> > > value before calling vmbus_open()),
> > 
> > Right. This is what I was getting at. Setting the size to 0 effectively
> > makes the driver unusable. And per your design, it should be considered
> > a bug.
> > 
> > > but that would be more like a coding bug. So, I think it would be
> > > better to return VMBUS_RQST_ERROR
> > > as a way to assert that there is a bug in the code. I don't know if
> > > I'm missing something here.
> > 
> > Since we know setting size to 0 is a bug, you can actually just do the
> > following in the __vmbus_open function instead of going through all the
> > initialization with the knowledge vmbus_next_request_id & co will fail.
> > 
> >     /* Create and init requestor */
> >     if (!newchannel->rqstor_size)
> >           return an error to caller here
> > 
> >     vmbus_alloc_requestor(...);
> 
> And obviously you should check vmbus_alloc_requestor's return value
> somehow. You get the idea...
> 

Andrea pointed out that I missed one critical aspect of the design --
not all drivers are supposed to use this infrastructure. That's contrary
to my original understanding, in which all drivers are supposed to use
this infrastructure.

With that in mind, it is okay to only initialize the infra only when
->rqstor_size is not zero. Then you just handle the edge case in
vmbus_next_request_id & co.

Wei.

> Wei.
> 
> > 
> > 
> > Wei.
> > 
> > > 
> > > Andres.
