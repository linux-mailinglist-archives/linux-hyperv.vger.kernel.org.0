Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC6DE8CD1
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2019 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbfJ2QfW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Oct 2019 12:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390494AbfJ2QfW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Oct 2019 12:35:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F21028831C
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Oct 2019 16:35:21 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id e25so8802633wra.9
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Oct 2019 09:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQnLYx2QWY4cuAKWiCGGUv4yf2h+qdP8BhSsdB+2sT0=;
        b=rD4IFB+pj/mK/VwR35cw+NvY1/XkQBO2iw0pQ9yx6PcHYZepvlKAZTH4NbWQes9GGl
         fp+h52qGxY0UOvqX+KezTmH3VwH9gXWIZkfNeYiRZ7cL3NkF/JD++yhUpWj/Ea0Jywg0
         +eraikxEcTek9qQXM7RmIhBdQgCxD+XGH6jgoMGwPe/myvrz7B2JtWjNf3a0BMR1pmBU
         7TFaH3PGGoYRrnx3J/YAS22s8sqUjDTCIoHrFYvzm6YpBSJPdrwql9IY1EGfSXzxWy3c
         KKOoyd50jMc6+5dKbuK22SGA4WSqnht2flmmaRCGIPfai7pxD19WrXVgRhv1YFIc38lr
         dqbw==
X-Gm-Message-State: APjAAAXj7WWd844W1ByH8k2rA+ibosH7NHqc8YsTPeT/uZwWB0h8uY7C
        OdAt2LY0ao3aRbPnCq9Ij5LYw7nQID/Si7d72o68n7zXQ9UkU2jdqqtqkjPnCo/NX4hG77mNWcd
        JWDG9HgubqRnS6TRpsAH2h7fV
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr5321609wme.92.1572366920614;
        Tue, 29 Oct 2019 09:35:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx29BHLiojOUxFUuXNicrwQ7MqELEUWM6W1qCELpsBAD/xgXR4ttLraQVt+y1hgrjzLl0jEJQ==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr5321583wme.92.1572366920428;
        Tue, 29 Oct 2019 09:35:20 -0700 (PDT)
Received: from steredhat (94.222.26.109.rev.sfr.net. [109.26.222.94])
        by smtp.gmail.com with ESMTPSA id r19sm18295914wrr.47.2019.10.29.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:35:19 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:35:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH net-next 12/14] vsock/vmci: register vmci_transport only
 when VMCI guest/host are active
Message-ID: <20191029163516.td6wk7lf5pmytwtk@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
 <20191023095554.11340-13-sgarzare@redhat.com>
 <20191027081752.GD4472@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027081752.GD4472@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Oct 27, 2019 at 09:17:52AM +0100, Stefan Hajnoczi wrote:
> On Wed, Oct 23, 2019 at 11:55:52AM +0200, Stefano Garzarella wrote:
> > +static int __init vmci_transport_init(void)
> > +{
> > +	int features = VSOCK_TRANSPORT_F_DGRAM;
> 
> Where is this variable used?

It is introduced in the previous patch "vsock: add multi-transports support",
and it is used in the vsock_core_register(), but since now the
vmci_transport_init() registers the vmci_transport only with DGRAM
feature, I can remove this variable and I can use directly the
VSOCK_TRANSPORT_F_DGRAM.

I'll fix in the v3.

Thanks,
Stefano
