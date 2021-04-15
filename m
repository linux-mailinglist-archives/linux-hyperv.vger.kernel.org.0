Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF39360866
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Apr 2021 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhDOLjx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Apr 2021 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhDOLjw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Apr 2021 07:39:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F9C061574;
        Thu, 15 Apr 2021 04:39:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w23so20555185ejb.9;
        Thu, 15 Apr 2021 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mIImIC0xtZ0IazK35x8X+p5Lx1JpHCV9a/kj7J/Qibo=;
        b=T0+9WvQNSKyQcAP08b8W80NjHpZZwFfSci4bE/yuUzAr5eVseo0PopbMPdhu5Wo8Dx
         wPGLjmWxGf5Ft10VQZj9UZt37NmeI8vlk7TriwY8jb2RCubhVz/4Tk2z+L0Ar7B7+FDs
         GhaTiNzTHVpKX6dODrSv23vjYH26KIn9zmbTQj5Q2niH8w7DVPtM6uAAJWg3z7TuKCyv
         zq4+0SLG8Ja0XNIHS0GA79uTEOhCi0WVnVbTRcFqFTEPTWheh4Xe4SFuc9Jkg/sHjO8z
         p4tt3DC1vFjCew8SA/ZfersmFTndNNYSf3FLYI2Ln8Jlb21hPMLRzrQ4DtHCs/N0Gh/e
         jCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mIImIC0xtZ0IazK35x8X+p5Lx1JpHCV9a/kj7J/Qibo=;
        b=uOd7INbMsV5dJJ0jMzTfkvHts1RwIIySjSdPDEKNCFNc20T7FqWqbgjBn8TrlHx9pV
         V/CtkDqL068BTChdKsxeH3IdqQaIvuA8nvMBeIMEwH8TwMIc4jY7Adnk9ERLKfXXoz0K
         r/Q6z3oSKqfkklvgnq+OQLrwnfGltS2ezGkp3MiVPt0QB96UwzELoUF5qBiJFgY37oEc
         OLJNgwFtCJNP7K5HujxxTrJib80m4v/CCBgfXy7PveKRS9tItvfKfHWhR1L/T+TYxMRU
         am0SErRqVdL87hxETxUuvH7DWddQTiyEX0fa4NrYn5jjO0QbqAPS0VlQ3Mbt0LgJYXFX
         oG+Q==
X-Gm-Message-State: AOAM533NTV2ef90bKBuhyiZAm1bG2QgCccv2ocplAAa6YS1SswUJk27p
        wI8VFJIuf/Ivjer1OqBZpf8=
X-Google-Smtp-Source: ABdhPJwi8NPhC4ITFODuL0YXBICCwQOAuEa+IYomMs+Gn2pHF0hNs5sATdz+x+0xL9HRzNbpdmmCYA==
X-Received: by 2002:a17:906:e08b:: with SMTP id gh11mr2935054ejb.33.1618486766433;
        Thu, 15 Apr 2021 04:39:26 -0700 (PDT)
Received: from anparri (mob-176-243-198-62.net.vodafone.it. [176.243.198.62])
        by smtp.gmail.com with ESMTPSA id w13sm1408431edx.80.2021.04.15.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:39:26 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:39:18 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Drivers: hv: vmbus: Check for pending channel
 interrupts before taking a CPU offline
Message-ID: <20210415113918.GA75451@anparri>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
 <20210414150118.2843-4-parri.andrea@gmail.com>
 <MWHPR21MB15931F523196BCE9E23293E4D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15931F523196BCE9E23293E4D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -336,6 +372,19 @@ int hv_synic_cleanup(unsigned int cpu)
> >  	if (channel_found && vmbus_connection.conn_state == CONNECTED)
> >  		return -EBUSY;
> > 
> > +	if (vmbus_proto_version >= VERSION_WIN10_V4_1) {
> > +		/*
> > +		 * channel_found == false means that any channels that were previously
> > +		 * assigned to the CPU have been reassigned elsewhere with a call of
> > +		 * vmbus_send_modifychannel().  Scan the event flags page looking for
> > +		 * bits that are set and waiting with a timeout for vmbus_chan_sched()
> > +		 * to process such bits.  If bits are still set after this operation
> > +		 * and VMBus is connected, fail the CPU offlining operation.
> > +		 */
> > +		if (hv_synic_event_pending() && vmbus_connection.conn_state == CONNECTED)
> > +			return -EBUSY;
> > +	}
> > +
> 
> Perhaps the test for conn_state == CONNECTED could be factored out as follows.  If we're
> not CONNECTED (i.e., in the panic or kexec path) we should be able to also skip the search
> for channels that are bound to the CPU since we will ignore the result anyway.
> 
> 	if (vmbus_connection.conn_state != CONNECTED)
> 		goto always_cleanup;
> 
> 	if (cpu == VMBUS_CONNECT_CPU)
> 		return -EBUSY;
> 
> 	[Code to search for channels that are bound to the CPU we're about to clean up]
> 	
> 	if (channel_found)
> 		return -EBUSY;
> 
> 	/*
> 	 * channel_found == false means that any channels that were previously
> 	 * assigned to the CPU have been reassigned elsewhere with a call of
> 	 * vmbus_send_modifychannel().  Scan the event flags page looking for
> 	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
> 	 * to process such bits.  If bits are still set after this operation
> 	 * and VMBus is connected, fail the CPU offlining operation.
> 	 */
> 	if (vmbus_proto_version >= VERSION_WIN10_V4_1 && hv_synic_event_pending())
> 		return -EBUSY;
> 
> always_cleanup:

Agreed, applied.  Thank you for the suggestion,

  Andrea
