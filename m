Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3795FCFA33
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfJHMmh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 08:42:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHMmh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 08:42:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so18436998wrq.10;
        Tue, 08 Oct 2019 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6c0bIYvUZKGgcQz0qQT8eHB8QDSPvevhTwLKKCbgKZc=;
        b=MJh4luQXeQi7f9Ak7rJ9cENXSF16UCUQUHf9om/Lt2IZs/9jwpjpkKHdljR+QOA3Pw
         TpdFvdQSmz1nWKEhJbX1UUsPJ6f4lNmVr3l9Bnt5sklDIpPXyiH6PayCVTC9rYYoxHnI
         bn/MH+7zkfYeM6VeqZUxOUm/ws09gIJfP9Pno3EAc2wZr0duw7pCjxeSBo0MsetJHf4R
         9XA9/I+vecwLhE7m9XU7w0HxTCXY+uk5cHApv9bNc4FzbhF+rjYg6EGm25cOepH+dEdw
         PyTjtgUKHub28KqaC9bDtVozEjrckD8p6fkBeYp9NUAiLaVyHTamuXzhPcd0GqgI8RVt
         Qq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6c0bIYvUZKGgcQz0qQT8eHB8QDSPvevhTwLKKCbgKZc=;
        b=tJmVJ5eM5iNc+uugziFc5mwtVxCnXV00uY7bqS2SskE4sxB2EjFw0mB1dlz/cmbEXv
         Y2HTed8TAFeFsFfDHuCGi4c8fX0JDCOez06zuzpf/4cJlZNJme43NB3PiOdFdTab/G61
         KA8ZZSs2BdwYXTpYE55Op71QVWlAv2m4ZiaNA3yI/xA7iTUBT47dJ5EkrSTrmBw9MUSt
         hgCyMF0HxKIcRJMNLLxzbAmv5kmH59DAZsunpcDfRgXEcGgCxT9J2FWFuw0Fjj2qCBMR
         2sZTDDaixpZDE7fX0ZR9VRsEuV3rbjVI2YXknTBgBPBO7gmBJzIXi4M+L2qT4UJLqOOp
         iZGw==
X-Gm-Message-State: APjAAAVCXaa/uqDCijkhlPegI9KoApdAm0HKH7AUYBoalWguK4CIKsJ5
        dfzIHLxSurwhHowMNjw/kys=
X-Google-Smtp-Source: APXvYqyhlTtpTotzacKg7J3FXg+j4u+TgibODownoyxwBafj/HAGqEkPAKaAbGcq2/hb5PM/Sdoo1A==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr3618220wrm.178.1570538553708;
        Tue, 08 Oct 2019 05:42:33 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:c582:959a:923b:9ec])
        by smtp.gmail.com with ESMTPSA id a3sm5147517wmc.3.2019.10.08.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:42:33 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:42:30 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Message-ID: <20191008124230.GB11245@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
 <PU1P153MB0169CAC756996A623CFDFBA7BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169CAC756996A623CFDFBA7BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 07, 2019 at 05:25:18PM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
> > Sent: Monday, October 7, 2019 9:31 AM
> > ....
> > +/*
> > + * Table of VMBus versions listed from newest to oldest; the table
> > + * must terminate with VERSION_INVAL.
> > + */
> > +__u32 vmbus_versions[] = {
> > +	VERSION_WIN10_V5,
> 
> This should be "static"?

I think so, will add in v2.  Thank you for pointing this out, Dexuan.

  Andrea
