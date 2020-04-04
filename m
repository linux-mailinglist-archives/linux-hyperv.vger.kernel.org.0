Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444DB19E67F
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2020 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDDQs3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 4 Apr 2020 12:48:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDQs3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 4 Apr 2020 12:48:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so11233965wmf.5;
        Sat, 04 Apr 2020 09:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jCdl7diGu/5E6LUTJQbC87oUXvUtnqJvlN7RqWS2wE=;
        b=NQ8WsE5cYQOvSd2V6NqpAFYf5XOvyTVeZxTiPOLIfdHIIsXCVN1YrdIKlJaIcHkGaH
         jWF3KxnG/khQPkaAOnaaSI2gpYtDPJxsJ3/WeEtvstYLlWTeB9e6eZLdN/XXWB7VjD5Y
         2t9dS7hFAtpffp1g/AMHagT/8s8Xj2VDjvaIKGjvFrXnVqPUkrCHAaTRABxb8paziEsi
         YVtNfDUihOEsG7sXXB66SENX56MkWCw9dA8RwlgNwFCsIryqYVaDMB+62Fvhl/6RqEpi
         LZTcXm4CDOmpx2SEHARfsvcsAwWKyqrV//6iUOGBshVUKp29Kyy8AOpUvCHLUvMIwhIX
         dDlA==
X-Gm-Message-State: AGi0PuaOdxq4h1N3koN9C0MTzCxXiHaevCvvUFA2mxoeGsYWwNwVICcM
        vrsS9TbThEHVT/Bfjt/AwpySZP1t
X-Google-Smtp-Source: APiQypJMMMXcQ/Xbs6aJr17+LK/xs6pjYwjySK2k06igsh2fLJ76ApPCkDnfHCnUblgwS/tnMJ3+lg==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr13987254wmh.120.1586018907203;
        Sat, 04 Apr 2020 09:48:27 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id i9sm2853881wrm.74.2020.04.04.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 09:48:26 -0700 (PDT)
Date:   Sat, 4 Apr 2020 17:48:24 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] hv_debugfs: Make hv_debug_root static
Message-ID: <20200404164824.yu3ye46ykwotc3ej@debian>
References: <20200403082845.22740-1-yuehaibing@huawei.com>
 <MW2PR2101MB105222D949FB4944EE647F2FD7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105222D949FB4944EE647F2FD7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 03, 2020 at 12:21:47PM +0000, Michael Kelley wrote:
> From: YueHaibing <yuehaibing@huawei.com> Sent: Friday, April 3, 2020 1:29 AM
> > 
> > Fix sparse warning:
> > 
> > drivers/hv/hv_debugfs.c:14:15: warning: symbol 'hv_debug_root' was not declared. Should
> > it be static?
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/hv/hv_debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
> > index 8a2878573582..ccf752b6659a 100644
> > --- a/drivers/hv/hv_debugfs.c
> > +++ b/drivers/hv/hv_debugfs.c
> > @@ -11,7 +11,7 @@
> > 
> >  #include "hyperv_vmbus.h"
> > 
> > -struct dentry *hv_debug_root;
> > +static struct dentry *hv_debug_root;
> > 
> >  static int hv_debugfs_delay_get(void *data, u64 *val)
> >  {
> > --
> > 2.17.1
> > 
> 
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 

Queued. Thanks.
