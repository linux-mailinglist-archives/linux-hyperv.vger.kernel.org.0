Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9657A387709
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbhERLCn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 07:02:43 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44846 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbhERLCm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 07:02:42 -0400
Received: by mail-wr1-f51.google.com with SMTP id i17so9688616wrq.11;
        Tue, 18 May 2021 04:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzZxkEakh34tyEfQFZI2csBDnhSxvUZaSSg9wasYYNU=;
        b=iZTF+lCTLzCJA0ErC0qVzXwl1Urf+r3hUh7KjRofitw337DQTvjqnspgzR91PUq5GS
         SZ5ZpiMcSMpI9CGVGWUq4TdqwN8KUxUbw1thF2F4I2YmdMi115jT5m/S5DHZAusPElB9
         YwrAZxof+TQQJxWXbqYTEOunmSDLkMemIbc9sU9rP9xiYsXfz3Zx0qmOS0mctx6yddKl
         5+bSC45mY3/pkHBVQhTTaRz9RIlurAfhbadNUMfhd9XLit2oBXngKrklb4OIR81MHgWD
         pyHYOKXq/ewOXgxkoYTIr+Bgzn2Roh8+eQVs3z/cwr/+Wqtet/h6/eQSGCiTmkMF0coP
         jzSQ==
X-Gm-Message-State: AOAM5334O//orS7qUWQR2mFtSCwBQ1Oy9nqDfeAkjEcCTqawjMTD2xWe
        I8rlA9SiwQLMi+fSqyDaTP4=
X-Google-Smtp-Source: ABdhPJxs7v5zSsNsyuAEsCU0p/xdP6wAviwWyscstWsXMK28OyMhris6AMxnTUk93GcdkYfllndLNQ==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr6088525wrm.133.1621335684013;
        Tue, 18 May 2021 04:01:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c6sm2677133wru.50.2021.05.18.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:01:23 -0700 (PDT)
Date:   Tue, 18 May 2021 11:01:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        longli@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Message-ID: <20210518110122.7jbktl6olsl75vqz@liuwe-devbox-debian-v2>
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
 <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Cc Long Li.

Long, Stephen suggested I check with you. Do you have any opinion?

Wei.

On Tue, May 11, 2021 at 09:52:27AM +0000, Wei Liu wrote:
> On Sun, May 09, 2021 at 09:13:03AM +0200, Christophe JAILLET wrote:
> > If 'vmbus_establish_gpadl()' fails, the (recv|send)_gpadl will not be
> > updated and 'hv_uio_cleanup()' in the error handling path will not be
> > able to free the corresponding buffer.
> > 
> > In such a case, we need to free the buffer explicitly.
> > 
> > Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
> > in 'hv_uio_cleanup()'.
> > So, another way for fixing the potential leak is to modify
> > 'hv_uio_cleanup()' and revert to the previous behavior.
> > 
> 
> I think this is cleaner.
> 
> Stephen, you authored cdfa835c6e5e. What do you think?
> 
> Christophe, OOI how did you discover these issues?
> 
> > I don't know the underlying reason for this change so I don't know which is
> > the best way to fix this error handling path. Unless there is a specific
> > reason, changing 'hv_uio_cleanup()' could be better because it would keep
> > the error handling path of the probe cleaner, IMHO.
> > ---
> >  drivers/uio/uio_hv_generic.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > index 0330ba99730e..eebc399f2cc7 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -296,8 +296,10 @@ hv_uio_probe(struct hv_device *dev,
> >  
> >  	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> >  				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> > -	if (ret)
> > +	if (ret) {
> > +		vfree(pdata->recv_buf);
> >  		goto fail_close;
> > +	}
> >  
> >  	/* put Global Physical Address Label in name */
> >  	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> > @@ -316,8 +318,10 @@ hv_uio_probe(struct hv_device *dev,
> >  
> >  	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
> >  				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> > -	if (ret)
> > +	if (ret) {
> > +		vfree(pdata->send_buf);
> >  		goto fail_close;
> > +	}
> >  
> >  	snprintf(pdata->send_name, sizeof(pdata->send_name),
> >  		 "send:%u", pdata->send_gpadl);
> > -- 
> > 2.30.2
> > 
