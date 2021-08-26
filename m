Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A433F8F8B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Aug 2021 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhHZUPy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 26 Aug 2021 16:15:54 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46851 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhHZUPy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 26 Aug 2021 16:15:54 -0400
Received: by mail-wr1-f46.google.com with SMTP id f5so6834912wrm.13;
        Thu, 26 Aug 2021 13:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hr1dE90H5YdZDUlgzkS8UsQx9P+U2IwJloakxSeTCKw=;
        b=LSNWrXGI6b24ZVpRGryz+J9EguYQ8KycqBSXRbjJa6DYyf27BGwitYnyPoMltihnuw
         /wKB0PptQ0MWmjLc16ChGEEwB5+EV/Vv51dyuQSk3D46OHWrZt9ihd6ZaKqGp2e8UvIW
         yGoiblAAmGKioMeVTrXgIrjo7e/rv1bh94P3zBB9ZzmyzQuX45XsJH5esBLfjikaNaAI
         vsF6NCZO+c8gAaPrmE9d83ydvGbl9CV2uTIBaZKP0hkywge4Gtuz55xXRqHHQ/xwl1J8
         +Bf5Ircv45DfCP4aq0cd7/dzSurfuuWuUB73ThSRYNNVD4QBkJJgvGI0WUyL3SZDk1Z1
         v9+Q==
X-Gm-Message-State: AOAM532KzcH38p1f1YtHFoIwc0CkQIINzHDpv08z/jh2kzX3gaAxLbWQ
        mDkyIEWxWaadOT+5RfBTdW0=
X-Google-Smtp-Source: ABdhPJw4lJvoaO3HqXnk+MsvI4fT0h65xsO+WusOJh7nhUtsqTUmSGWF52OMa8CPqS+Bi5IUDsW/VA==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr6031139wrv.119.1630008905618;
        Thu, 26 Aug 2021 13:15:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k16sm4207187wrx.87.2021.08.26.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 13:15:05 -0700 (PDT)
Date:   Thu, 26 Aug 2021 20:15:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Long Li <longli@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
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
Message-ID: <20210826201503.ycckbcpu3f6flbb6@liuwe-devbox-debian-v2>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593E4B1051F96DB6E715C0CD7C79@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210826194113.yihk7ete4n4ej4gz@liuwe-devbox-debian-v2>
 <BY5PR21MB1506A389A26964A8C7768D31CEC79@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506A389A26964A8C7768D31CEC79@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 26, 2021 at 08:09:19PM +0000, Long Li wrote:
> > Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
> > 
> > On Thu, Aug 26, 2021 at 04:50:28PM +0000, Michael Kelley wrote:
> > > From: Long Li <longli@microsoft.com> Sent: Wednesday, August 25, 2021
> > > 1:25 PM
> > >
> > > > >
> > > > > I thought list_for_each_entry_safe() is for use when list
> > > > > manipulation is *not* protected by a lock and you want to safely
> > > > > walk the list even if an entry gets removed.  If the list is
> > > > > protected by a lock or not subject to contention (as is the case
> > > > > here), then
> > > > > list_for_each_entry() is the simpler implementation.  The original
> > > > > implementation didn't need to use the _safe version because of the spin
> > lock.
> > > > >
> > > > > Or do I have it backwards?
> > > > >
> > > > > Michael
> > > >
> > > > I think we need list_for_each_entry_safe() because we delete the list
> > elements while going through them:
> > > >
> > > > Here is the comment on list_for_each_entry_safe():
> > > > /**
> > > >  * Loop through the list, keeping a backup pointer to the element.
> > > > This
> > > >  * macro allows for the deletion of a list element while looping
> > > > through the
> > > >  * list.
> > > >  *
> > > >  * See list_for_each_entry for more details.
> > > >  */
> > > >
> > >
> > > Got it.  Thanks (and to Rob Herring).   I read that comment but
> > > with the wrong assumptions and didn't understand it correctly.
> > >
> > > Interestingly, pci-hyperv.c has another case of looping through this
> > > list and removing items where the _safe version is not used.
> > > See pci_devices_present_work() where the missing children are moved to
> > > a list on the stack.
> > 
> > That can be converted too, I think.
> > 
> > The original code is not wrong per-se. It is just not as concise as using
> > list_for_each_entry_safe.
> > 
> > Wei.
> 
> I assume we are talking about the following code in pci_devices_present_work():
> 
>                 list_for_each_entry(hpdev, &hbus->children, list_entry) {
>                         if (hpdev->reported_missing) {
>                                 found = true;
>                                 put_pcichild(hpdev);
>                                 list_move_tail(&hpdev->list_entry, &removed);
>                                 break;
>                         }
>                 }
> 
> This code is correct as there is a "break" after a list entry is
> removed from the list. So there is no need to use the _safe version.
> This code can be converted to use the _safe version.

After this block there is another block like

  while (!list_empty(removed)) {
	...
  	list_del(...)

  }

I assumed Michael was referring to that block. :-)

Wei.
