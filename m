Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405B5447F1B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhKHLsg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 06:48:36 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44551 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHLsg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 06:48:36 -0500
Received: by mail-wr1-f43.google.com with SMTP id n29so14613101wra.11;
        Mon, 08 Nov 2021 03:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcX6PV1+ZBo9eou2lhQx0XIxyD2E0mkp8HVMZY3su90=;
        b=3WGbzAOdnz265srJS5ybGjMg0ej8+zRDRhWEMd+gm1t5QZtnT1MRYCM84H3IbXBEPo
         yOaFlHgoARfgIuTt2fXTkANEkQswbJtIw+8OyBSZmLqLhYiSUHCtGcUVMMyrYDVtLa06
         Czb24ysBZKAhCMSWgkDvF89ZyF/Hr6wnaWdS7APmjoHzaHst6gIZxzk3hEyUoEGycrVO
         CuT9jfd1IeZaHHODUyr3Uzv9lGEuMHZ45WgIYfssOJ7qtMvguacCHq+n9S71EG3cOCtz
         wngy2cWH1TYnilvo9gqFG57knV2DyMARvpbyAZcshM9gSJVAiw+eeeGh37uDVUx9hUqb
         3KjA==
X-Gm-Message-State: AOAM532Ik392rfXdFyj+ag88uFgaZlushFGgrKauGKgg77S5eSF8q8g1
        dGL0fZWKsqkMW6206F0M1QTd0unEN4s=
X-Google-Smtp-Source: ABdhPJyLsW7OhUijj2/nzKCYaaNr+8LbWZe8NFIZp2ySUgi+YaRWOpUE/U+j08og2bFKfHnj7HBcCg==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr95129940wrn.335.1636371950843;
        Mon, 08 Nov 2021 03:45:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n4sm18882595wri.41.2021.11.08.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:45:50 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:45:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Liu <wei.liu@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v0 08/42] Drivers: hv: vmbus: Check notifier registration
 return value
Message-ID: <20211108114549.q3lkgjwm5d7tkbcp@liuwe-devbox-debian-v2>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-9-bp@alien8.de>
 <20211108111637.c3vsesezc7hwjbty@liuwe-devbox-debian-v2>
 <YYkMYtYkvwiyzGNG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYkMYtYkvwiyzGNG@zn.tnic>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 08, 2021 at 12:39:14PM +0100, Borislav Petkov wrote:
> On Mon, Nov 08, 2021 at 11:16:37AM +0000, Wei Liu wrote:
> > On Mon, Nov 08, 2021 at 11:11:23AM +0100, Borislav Petkov wrote:
> > > From: Borislav Petkov <bp@suse.de>
> > > 
> > > Avoid homegrown notifier registration checks.
> > > 
> > > No functional changes.
> > > 
> > > Signed-off-by: Borislav Petkov <bp@suse.de>
> > > Cc: linux-hyperv@vger.kernel.org
> > 
> > Acked-by: Wei Liu <wei.liu@kernel.org>
> 
> Thanks.
> 
> I assume your ack means, I can take the two through tip.

Yes please take them through tip. I should've been clearer on this.
Sorry.

Wei.
