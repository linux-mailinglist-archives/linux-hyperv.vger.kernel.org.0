Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBA2687CB
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgINJDE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 05:03:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJDD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 05:03:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k15so17784931wrn.10;
        Mon, 14 Sep 2020 02:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BA59uvNwWeLbW3/gARBLS+3iLS+i0V5L1/WrQ9lOZOQ=;
        b=e5q7gbZmjmh2u6wBI6hRIkqvTbxyYVnmDCGT2JyhtL3YPmrzjhcq+EZGpiQy+FMxhB
         IqGUk10LeL8AuQTiDmeeZMvlzY/hom0ua+aEHtDANGA/MHKW3iCuUCzcR4RbfihUvam6
         Uf30g5ZDyTlD5ssMRrFX43yWUCThgnBJ+gEV7EbjoOAVl3ly2xLmvEdNBX7K/Spt+OEO
         a6rVjnEkuG+GxNUSjRmVOoO0LThcA2MD6+BSZesqCmmgSEzSmr5CuMagkuzTolDBhBSe
         UclGsbIWDNgjTT/rF54lOm9aB5kIhGL0SkZhkcj8SK2XJdk4FpoAusdTHGlwDJT5PvTI
         5/wQ==
X-Gm-Message-State: AOAM532rWqfnc59hQjdaL2umZOysukWOoRSTi7SMUPVlfCQSJNGR0iX8
        KxsP1EsND0ph0+dXrnVy87s=
X-Google-Smtp-Source: ABdhPJwi1ig8O5wYHnAsy2M2D55tuMDqr8YWBOnn7K2hiVEAbPGdiGu4gUcpIwsJ7NIBBtanJBA2dg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr14264256wru.133.1600074181226;
        Mon, 14 Sep 2020 02:03:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t6sm22308511wre.30.2020.09.14.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 02:03:00 -0700 (PDT)
Date:   Mon, 14 Sep 2020 09:02:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Add timeout to
 vmbus_wait_for_unload
Message-ID: <20200914090259.nhxxezpljbrvq3xo@liuwe-devbox-debian-v2>
References: <1600026449-23651-1-git-send-email-mikelley@microsoft.com>
 <KU1P153MB01202778DC760ED16AD687F4BF220@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KU1P153MB01202778DC760ED16AD687F4BF220@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Sep 13, 2020 at 07:56:30PM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Michael Kelley
> > Sent: Sunday, September 13, 2020 12:47 PM
> > 
> > vmbus_wait_for_unload() looks for a CHANNELMSG_UNLOAD_RESPONSE
> > message
> > coming from Hyper-V.  But if the message isn't found for some reason,
> > the panic path gets hung forever.  Add a timeout of 10 seconds to prevent
> > this.
> > 
> > Fixes: 415719160de3 ("Drivers: hv: vmbus: avoid scheduling in interrupt
> > context in vmbus_initiate_unload()")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

LGTM.

Applied to hyperv-fixes. Thanks.

Wei.
