Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281162CBE7B
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgLBNiG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 08:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgLBNiF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 08:38:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421FC0613CF;
        Wed,  2 Dec 2020 05:37:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so3952285wrc.8;
        Wed, 02 Dec 2020 05:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l/C90f3+rH95i4xGnwc1KHGWZKMjt7nbaW6VsSOdvrc=;
        b=u12vLg7+aWh9JsuOUB9vDnzS/ivy4SZwBk6Dil6rEpUw+6qqlzJ1tN5h15TNpe60AI
         FQM8O+u2hfu6Aaxvqi/oi8m39en3wd9fxk//keg5t4Hl/lZ4gnEjM131JIgEsu8yE5GL
         m8LO4Uw/eBaDRexUzrtM6YqtjT7K6E4ySHmosJRu4lYRM0NnwzRdkZpu2qHXoOwWTgSu
         lF4LhWR1HaxuUuOhORv1uiBB64b2zUEpN18ZtE2gpKnDamfQv74fO5H1DclKf98Wr6UE
         bwhMAlVEFOOFC/ePVcpmsuyd731OR7BvEgvN53X1pKFkWFDkE7oUj4/xWN5CXm35XPA1
         Db9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l/C90f3+rH95i4xGnwc1KHGWZKMjt7nbaW6VsSOdvrc=;
        b=kyR8usRZ49xGD6cqp/Jzdy5G+kO6SfmtDl+kcIZxjDqRu/aEi20UU5imMFwMepxr4I
         qk9J8oClLGKL6z1vtGVhFw6PwhPi2Ji6zaFzs/97XSjDz63TkHNuMcI3tBNvc6hZjTJG
         gmskgUOxA21UtIl5ID66+tPiEVVQVEAayoQr95s1YX/58X6CkI7Bn3dTqmI1J47ZZviy
         fSTRkN2Vl/F5IBufjxRD5MXBzLYelRT4Yv2xNe/hsKsNmsihY4Gzl+2FlC41V1tW5GOL
         kq5AavJppcgA5ppSjJukwWdDU3ku8i522RUiq0wv2acLMMCAetV5ZSEjfFMhEBDIBq5/
         9q3Q==
X-Gm-Message-State: AOAM530aF7NtcyU6zy0StCqNzPIPWHFbdudK7Wb0M1odpHVSRjOZKdgu
        beDefbYAWbOZjsItLr5X5MVmNgpZeQsz7Q==
X-Google-Smtp-Source: ABdhPJzAli4egIF1EuIcfm4bEgoLc58noXEvlENm2/2eRAT2Bwdb4BWXfqIMb6Ga8pFsgND+6WiZxA==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr3626633wrm.409.1606916243505;
        Wed, 02 Dec 2020 05:37:23 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id q12sm2051316wrx.86.2020.12.02.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:37:23 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:37:16 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH v2 2/7] Drivers: hv: vmbus: Avoid double fetch of msgtype
 in vmbus_on_msg_dpc()
Message-ID: <20201202133716.GA22763@andrea>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-3-parri.andrea@gmail.com>
 <20201202122254.zjhu3cfcq3zwvmvu@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202122254.zjhu3cfcq3zwvmvu@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  		/* no msg */
> >  		return;
> >  
> > +	/*
> > +	 * The hv_message object is in memory shared with the host.  The host
> > +	 * could erroneously or maliciously modify such object.  Make sure to
> > +	 * validate its fields and avoid double fetches whenever feasible.
> > +	 */
> > +
> >  	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
> > +	msgtype = hdr->msgtype;
> 
> Should READ_ONCE be used here?

I think it should.  Thank you for pointing this out.

  Andrea
