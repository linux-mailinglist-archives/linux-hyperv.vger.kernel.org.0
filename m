Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391F43F8EFC
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Aug 2021 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhHZTmH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Aug 2021 15:42:07 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34809 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbhHZTmE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Aug 2021 15:42:04 -0400
Received: by mail-wr1-f47.google.com with SMTP id h13so6824684wrp.1;
        Thu, 26 Aug 2021 12:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFKJpcZRXuno0WjXg2R7y6rFWbVh+fx1jWVSUxs/tIA=;
        b=TeStLouYxnE/wF57tZ54P/g8vv6Zgdk9Sn9wnn0Dpenzq2yNt7UgdeKjiQw7DblK/i
         0Cnr+ciL8xvfSUfVBW0aqy4mk33HjwJAEi2ArvdUJa/4/YKob+lKG4feEH7AQ4G1pQPF
         hu4/KICS12lWPMyi6ElGR5aVar/SFXo3cPDhAa9qTGfyKp/0cnjNDUnZJHP8GO0bnWg4
         edhTM6GMXO7kr5/nVUrGRFivPDxoNEl7gNkagv7xwYAPzTwTS3xE1M8K9L/IysfHJzXJ
         TaUZhPthHVsLUM7p2RTrj5/xg27Z3VGglRBMgj6bbxQ7fKjXSHsWGkjKXuDswhivY8Mu
         kb/g==
X-Gm-Message-State: AOAM5327Mos7ZTOp4x0Fr7E5vkHyqoUQ3flcIwc5huZcPK9ZLqBig60p
        jf+CxptjzrFZmo2biZMFyfI=
X-Google-Smtp-Source: ABdhPJyYQ0G4CSHB1wqw3b1I7jOBw0uYRxWgiCHEpZMCVYG6ZAqRuSkaACh+Oyc+AJvMo1InJnMM7Q==
X-Received: by 2002:adf:f645:: with SMTP id x5mr6028408wrp.353.1630006875366;
        Thu, 26 Aug 2021 12:41:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b2sm3610591wmd.3.2021.08.26.12.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:41:14 -0700 (PDT)
Date:   Thu, 26 Aug 2021 19:41:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Message-ID: <20210826194113.yihk7ete4n4ej4gz@liuwe-devbox-debian-v2>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 26, 2021 at 04:50:28PM +0000, Michael Kelley wrote:
> From: Long Li <longli@microsoft.com> Sent: Wednesday, August 25, 2021 1:25 PM
> 
> > >
> > > I thought list_for_each_entry_safe() is for use when list manipulation is *not*
> > > protected by a lock and you want to safely walk the list even if an entry gets
> > > removed.  If the list is protected by a lock or not subject to contention (as is the
> > > case here), then
> > > list_for_each_entry() is the simpler implementation.  The original
> > > implementation didn't need to use the _safe version because of the spin lock.
> > >
> > > Or do I have it backwards?
> > >
> > > Michael
> > 
> > I think we need list_for_each_entry_safe() because we delete the list elements while going through them:
> > 
> > Here is the comment on list_for_each_entry_safe():
> > /**
> >  * Loop through the list, keeping a backup pointer to the element. This
> >  * macro allows for the deletion of a list element while looping through the
> >  * list.
> >  *
> >  * See list_for_each_entry for more details.
> >  */
> > 
> 
> Got it.  Thanks (and to Rob Herring).   I read that comment but
> with the wrong assumptions and didn't understand it correctly.
> 
> Interestingly, pci-hyperv.c has another case of looping through
> this list and removing items where the _safe version is not used.
> See pci_devices_present_work() where the missing children are
> moved to a list on the stack.

That can be converted too, I think.

The original code is not wrong per-se. It is just not as concise as
using list_for_each_entry_safe.

Wei.

> 
> Michael
