Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D6D016C
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfJHTrY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 15:47:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729616AbfJHTrY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 15:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570564043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiLraLEOHVJMQW3DZM6T811AWApI3wm6nU4uAi5YLA4=;
        b=fSjxWfWuntY7x4DKEd4necUVWR3P2cL+HGTTsGAoh+5JPGdm7gyg/saXURl8Q/PcQEBIVl
        p/cSRsaOp8RCSHu5e2KxoFQFHFZTkD21xbBZ5MwDb+lArdy25a9M/FOLKGumPepMfT6Uo7
        F2OVKPnrfP5lqafHjhMfTeNG6LUjejo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-yJgh6OdQP5SIX_9movFTHg-1; Tue, 08 Oct 2019 15:47:21 -0400
Received: by mail-wm1-f69.google.com with SMTP id f63so1386946wma.7
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Oct 2019 12:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9PwM6aqKCiJLV+IIYiBNTz1lzh80V+pvcsEJSuL6Dsk=;
        b=BcgYnN4xD1irWXPtBucp9QDLgSXiZedUd4d+BRogBLRMwCQRaSL5FHl7mFzbaPTBL5
         i5QQDZILM4v1sAEBANW7K58TK2cOTCi7Ew8h0uvjAt3w8y6kCme6kMBGOIhuNqNEZC1G
         EaB09q0PEkT5dba5IaxQnLpYNTEO/LFT/YyK80dZ7A3ak06OzM2uy2ebN8v9zLu0ZY20
         jMwsbcYT7Uztawb4S1fz5sVcI/egpeP3T9On8SMKrhFAFA4yvAcLtyCysI5FxsRCZcB7
         QwlIRcsAaOT9x0W9GE5n6bXUWtQqy9R8kEluiNTi0DDsm+mZj/JykabDLhy8lNUNt46E
         nz8g==
X-Gm-Message-State: APjAAAUtAjN5f90GPFx2LEg4omN6POofFoPoJz6WmzdUWExYTDrPidAk
        rk+cbcZmMI43wsyAOO+HnXLKqKBi0JtxYlJbFB6pvnG0mDicfczFhxQ3PySUjIKJsPcQbExVet/
        CdnFrwvNE9XQCdd7F9dpqncL/
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr4831602wmj.71.1570564040698;
        Tue, 08 Oct 2019 12:47:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJlALWevvlEenjVPCyVJrYw0c1CrRdaL/NdPL7Y1i+9HYclK/R/sOgnLBu6GUskCbDEiEI/A==
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr4831588wmj.71.1570564040470;
        Tue, 08 Oct 2019 12:47:20 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.158])
        by smtp.gmail.com with ESMTPSA id x5sm17615412wrt.75.2019.10.08.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:47:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
In-Reply-To: <20191008150847.GA15276@andrea>
References: <20191007163115.26197-1-parri.andrea@gmail.com> <PU1P153MB01691E9B0DD83E521B1E12C0BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <20191008150847.GA15276@andrea>
Date:   Tue, 08 Oct 2019 21:47:18 +0200
Message-ID: <87imozyq7t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: yJgh6OdQP5SIX_9movFTHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Mon, Oct 07, 2019 at 05:41:10PM +0000, Dexuan Cui wrote:
>> > From: linux-hyperv-owner@vger.kernel.org
>> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
>> > Sent: Monday, October 7, 2019 9:31 AM
>> >=20
>> > Hi all,
>> >=20
>> > The patchset:
>> >=20
>> > - simplifies/refactors the VMBus negotiation code by introducing
>> >   the table of VMBus protocol versions (patch 1/2),
>> >=20
>> > - enables VMBus protocol versions 5.1 and 5.2 (patch 2/2).
>> >=20
>> > Thanks,
>> >   Andrea
>> >=20
>> > Andrea Parri (2):
>> >   Drivers: hv: vmbus: Introduce table of VMBus protocol versions
>> >   Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2
>>=20
>> Should we add a module parameter to allow the user to specify a lower
>> protocol version, when the VM runs on the latest host?=20
>>=20
>> This can be useful for testing and debugging purpose: the variable
>> "vmbus_proto_version" is referenced by the vmbus driver itself and
>> some VSC drivers: if we always use the latest available proto version,
>> some code paths can not be tested on the latest hosts.=20
>
> The idea is appealing to me (altough I made no attempt to implement/test
> it yet).  What do others think about this?  Maybe can be considered as a
> follow-up patch/work to this series?

IMO such debug option makes sense, it shouldn be a simple patch so you
may want to squeeze it in this series as it will definitely have code
dependencies.

--=20
Vitaly

