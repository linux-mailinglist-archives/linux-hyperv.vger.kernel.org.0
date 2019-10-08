Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F831CFA42
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfJHMpB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 08:45:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51380 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfJHMpA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 08:45:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so3006819wme.1;
        Tue, 08 Oct 2019 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9yDaroMsm4CI8Hh6QbGq4eORn4M7okAkDA4uXKpP/5g=;
        b=DW4NaB/AIYOc2OYd1jDzN+WSSZhSWViSKulHRS296tJZThyC2l1ToOSmlK1uW+oYu+
         0ej0xkLc2SbSjEGg+KCB1Y5tu6sxXBJAhSVEvRsERBorE1aut2R920zwPcKrSoCSlKpg
         7AkeniV7nnEZ1WWw58IBhj6cH6H0paJE+5TgmbKIGoAjajSATP8QOSITJO5lYYD7HV1F
         2oqwu0LvipExIo23f+6sM9+dO9/pBJuZKz34yVEUaoe13YqErUNoK3uRJ9bl1KnfCpPi
         Qhdh/vBVO+xksZOme3XsSMWmQu7Bo3Z9/5ZyAjT12l5NCitMCSToLAKRrKgfBLO+K6RC
         803g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9yDaroMsm4CI8Hh6QbGq4eORn4M7okAkDA4uXKpP/5g=;
        b=THszsfMIObJzxfsZwWgJv7Nn+V0pkcWYxFe/vR6Z3xUGzUMJNuzmDRlCVJZCdQFujZ
         KvYqHjwrmHqAgCgEiBxZ1X2Rx9kZQ0SLGZ9mc3Un1WAWnQ7HWLieKnx+SG4jtJ4vDLw4
         Q6hkmxxA0FGXE2wknN4BImONal+u/I2hj1MmtCZGLFPGi9f0gST+9anA4twPckGIx6/e
         w+bd1413/jrgV4vsVRAODmWVj/Nt2t7gsm/e/TYugF/kluazOkZ/4esf5DJCL2HqmWgv
         6jdv+05QOTVelXGROfMBqlod0dRmXo0tkOAXa4knrhEvip5gjn/r4mpTVI48rPcQab1K
         0T3g==
X-Gm-Message-State: APjAAAVlXC9/SBe0ewftkMNnzqV5O2JnIwxFl5T0lOId+yaKcVsejMec
        YhWy21G3RXdJKbtCOf2jVYo=
X-Google-Smtp-Source: APXvYqwRm31JnT+i75J3rRhce56e1FUUGA5IID0w6BfYAGlIL4Z/N/bHJo5SA9o/uiETU44rVvBaRw==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr3613571wmb.5.1570538698456;
        Tue, 08 Oct 2019 05:44:58 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1010:c584:959a:923b:9ec])
        by smtp.gmail.com with ESMTPSA id e3sm3416147wme.39.2019.10.08.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:44:58 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:44:52 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Message-ID: <20191008124452.GA12191@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
 <87eezo1nrr.fsf@vitty.brq.redhat.com>
 <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> IIUC, you're suggesting that I do:
> 
> 	for (i = 0; i < ARRAY_SIZE(vmbus_versions); i++) {
> 		version = vmbus_versions[i];
> 
> 		ret = vmbus_negotiate_version(msginfo, version);
> 		if (ret == -ETIMEDOUT)
> 			goto cleanup;
> 
> 		if (vmbus_connection.conn_state == CONNECTED)
> 			break;
> 	}
> 
> 	if (vmbus_connection.conn_state != CONNECTED)
> 		break;

This "break" should have been "goto cleanup".  Sorry.

  Andrea
