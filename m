Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0285220D446
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2020 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgF2TGt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Jun 2020 15:06:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39070 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgF2TGs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5so17657430wru.6;
        Mon, 29 Jun 2020 12:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kB1Yqxehc4mOOV+E+s8ly+87mL5I0qDl2+46tT33LU=;
        b=FEd80YYsVCJ6pf74frJNQnajWBRVFV0QMHP/qy3W0W9HXQvypW8nvMlgqUbUnomnHi
         O8YsWoOkY/0gsW1wuFENzG/2p0MVio6drckkCAWQhUX6YDslI8N05qYfTEXdmhP050ez
         bhhL/WcbK3Get7wdtSpsPanlCdnMclxEMNQpfZM5K1TVukzTINfUA72OwM6DkmfPxH9t
         /nSv3f411beyEx6DfQgAOSHjXwM11BzG+OadcwuOj4GrnqcsG3ZF6B8VfA3RAP+dKogT
         E1J4xLWzGLTYfhBLP5IHDZsHCJwR02k3Inzl4qa08HVYqt+obUA97UjS6qAGnkjPz7dV
         9u+w==
X-Gm-Message-State: AOAM532gqGscXvj6dC9M5WbWWjQSodQTDCt6C2jhKsLmH65iLW6oWn1k
        /XtV0uL03teTbKbOIBhaR8A=
X-Google-Smtp-Source: ABdhPJzQcaoC3As2bwvXjFpEkhrTsir6J88mWLOgOu4Igyehnga3Bo7Tm9krH0O+TUUtcdYBw1n/EA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr19710508wrm.390.1593457606425;
        Mon, 29 Jun 2020 12:06:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e17sm728179wrr.88.2020.06.29.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:06:45 -0700 (PDT)
Date:   Mon, 29 Jun 2020 19:06:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andres Beltran <t-mabelt@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Andres Beltran <lkmlabelt@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20200629190644.hlem6jskyx26csaj@liuwe-devbox-debian-v2>
References: <CH2PR21MB149464F9EF20C516C6FB362A8B6E0@CH2PR21MB1494.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR21MB149464F9EF20C516C6FB362A8B6E0@CH2PR21MB1494.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 29, 2020 at 06:19:46PM +0000, Andres Beltran wrote:
[...]
> > >  EXPORT_SYMBOL_GPL(vmbus_recvpacket_raw);
> > > +
> > > +/*
> > > + * vmbus_next_request_id - Returns a new request id. It is also
> > > + * the index at which the guest memory address is stored.
> > > + * Uses a spin lock to avoid race conditions.
> > > + * @rqstor: Pointer to the requestor struct
> > > + * @rqst_add: Guest memory address to be stored in the array
> > > + */
> > > +u64 vmbus_next_request_id(struct vmbus_requestor *rqstor, u64 rqst_addr)
> > > +{
> > > +	unsigned long flags;
> > > +	u64 current_id;
> > > +
> > > +	spin_lock_irqsave(&rqstor->req_lock, flags);
> > 
> > Do you really need the irqsave variant here? I.e. is there really a
> > chance this code is reachable from an interrupt handler?
> 
> Other VMBus drivers will also need to use this functionality, and
> some of them will be called with interrupts disabled. So, I think
> we should keep the irqsave variant here.
> 

Okay. This makes sense.

Wei.
