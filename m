Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F162CBE96
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgLBNks (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 08:40:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgLBNks (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 08:40:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id k14so4018063wrn.1;
        Wed, 02 Dec 2020 05:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E2aHvC6gzDfI13t0gWtopdzCEI0eCcmet0QIX5R7nH4=;
        b=FAAHdyDDdfwTbkVV40baCdZHh0PAbtT9ZIp+Fi1tTNSLQG5JWbsimCOhLglWF2dp0c
         LqBae5QhRancBYofoUbvMD8h60mtUNAkC3ZvS1lSIn6T66LGCOzTYgMOMkjSdhrlwYoj
         H2lOmxYaClQNQ3Qv76rZRsAnqyCOu5LM4ojGCZj2P8g/4piRUdREag5aqNKiH9sz6yLe
         1Knpl6NYuhKzYe8y46pCJp5lIVZkAgViqFkgdOm2YZETgJC3L6GYYgAmsEelz3hncU98
         ZhjZHTgDoI9FewPlOd/AvUgaPX5TDXcwo+QxY3MMEf+SEjv5AsVZmXftkqgwVYcAXPpE
         p3eg==
X-Gm-Message-State: AOAM533SracTavbr20gu7Q2TfLH0FstVSXCvkxCtHEz7mTO1eUogX7J6
        Kyqit9Sm2Bn6S5ryLKFyqbiJZ4tF7QQ=
X-Google-Smtp-Source: ABdhPJwSEdEnNoMwjSB5do+eY/S6NR33quyCHC5uvvq8xOcxvE3w0/81V39yPD3u7hjPYniwZPxMQQ==
X-Received: by 2002:adf:8b4a:: with SMTP id v10mr3571804wra.212.1606916406345;
        Wed, 02 Dec 2020 05:40:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f3sm2144514wrx.10.2020.12.02.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:40:05 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:40:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH v2 2/7] Drivers: hv: vmbus: Avoid double fetch of msgtype
 in vmbus_on_msg_dpc()
Message-ID: <20201202134004.5tgrbyijrhvwwmk2@liuwe-devbox-debian-v2>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-3-parri.andrea@gmail.com>
 <20201202122254.zjhu3cfcq3zwvmvu@liuwe-devbox-debian-v2>
 <20201202133716.GA22763@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202133716.GA22763@andrea>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 02:37:16PM +0100, Andrea Parri wrote:
> > > @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
> > >  		/* no msg */
> > >  		return;
> > >  
> > > +	/*
> > > +	 * The hv_message object is in memory shared with the host.  The host
> > > +	 * could erroneously or maliciously modify such object.  Make sure to
> > > +	 * validate its fields and avoid double fetches whenever feasible.
> > > +	 */
> > > +
> > >  	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
> > > +	msgtype = hdr->msgtype;
> > 
> > Should READ_ONCE be used here?
> 
> I think it should.  Thank you for pointing this out.

Glad I can help.

The same comment applies to other patches as well, of course.

Wei.

> 
>   Andrea
