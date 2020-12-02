Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EE72CBF54
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 15:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLBOPY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLBOPY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 09:15:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC575C0613D4;
        Wed,  2 Dec 2020 06:14:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o1so4140974wrx.7;
        Wed, 02 Dec 2020 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y09Yc6Gy3QraLOEdgVpi1+sbCU87xyp9KMOciYZdYPA=;
        b=LNF0QjiPxwKDMiRR+dopQBjFpbGq4dzE9u/irqWJu5T5XzfQbwmo9n9PGB7Mo7HtCo
         3It45M6Rm1BkVuNDDaukQ85737dlDJfVSMQT9Ofmw2rSWYZI+59dp17Zsv4Ao9UdFkCT
         j9nMQ/LJ06ItQ0+0q0DS3siV822j3qLalfmQGki93R/JJUrIr8ayLEqOkUhRioPpjZi6
         qdJnjtF7tAiWk3iNkEgxFYgS1BT2KVo5WUFVGFqfKdbrnovwGikOo57zfFq+1ZGBv6ZK
         EPWO6Ql9DrcBlc4n+NhNvfKvRtR81MnHJBr7rhk5cM+agph5kRdl5Ixj332dzHz5K5aV
         hwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y09Yc6Gy3QraLOEdgVpi1+sbCU87xyp9KMOciYZdYPA=;
        b=EQCd0FlKvs6B1T+y8XBvZbCzhTns8bevogl3WTDx/o9EgoLRW0DdMByhKCoZTla13u
         Bw5T4LRaKM4OFOBR24Vl1N00OP+f4kS/2G1bsnQEJQDaARdf6+88840gQnKNXwjJ0Mvx
         EZ/9IXyY/a8/D5QTl0WkEbpvFU6gbSPkIOWYwd9UIqtiiUPGPQ+droH1UxocK3GhqTc8
         oIKVz8EJh3A2GLYrgdHFaKWqmyj/QPoZrac+mAJSrnhCXYmTLnYKXOag7ncprNwr2B0Y
         v4Sy4JN5ewD79uXteQFhTuQRJQR7FAJ4pNle7usxCw08JDekd+ShlqpHFz8AMBN6hXvY
         MtAA==
X-Gm-Message-State: AOAM532UHl+htfOlk5zKpFmo/V/AKRzL+oLMXvKDntpSo9ujFlv+TArO
        OB+6tB1YhyTyKYu7mRUanIY=
X-Google-Smtp-Source: ABdhPJzvfSW63NIYgCI5jR4y00vXV9+cKa8GVNmTDBb9hfiIlPMuaihyZaPr6TcAC+oiCi4K4g7T6Q==
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr3707931wrx.314.1606918482270;
        Wed, 02 Dec 2020 06:14:42 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id o2sm2247428wrq.37.2020.12.02.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 06:14:41 -0800 (PST)
Date:   Wed, 2 Dec 2020 15:14:33 +0100
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
Message-ID: <20201202141433.GA24359@andrea>
References: <20201202092214.13520-1-parri.andrea@gmail.com>
 <20201202092214.13520-3-parri.andrea@gmail.com>
 <20201202122254.zjhu3cfcq3zwvmvu@liuwe-devbox-debian-v2>
 <20201202133716.GA22763@andrea>
 <20201202134004.5tgrbyijrhvwwmk2@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202134004.5tgrbyijrhvwwmk2@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 01:40:04PM +0000, Wei Liu wrote:
> On Wed, Dec 02, 2020 at 02:37:16PM +0100, Andrea Parri wrote:
> > > > @@ -1072,12 +1073,19 @@ void vmbus_on_msg_dpc(unsigned long data)
> > > >  		/* no msg */
> > > >  		return;
> > > >  
> > > > +	/*
> > > > +	 * The hv_message object is in memory shared with the host.  The host
> > > > +	 * could erroneously or maliciously modify such object.  Make sure to
> > > > +	 * validate its fields and avoid double fetches whenever feasible.
> > > > +	 */
> > > > +
> > > >  	hdr = (struct vmbus_channel_message_header *)msg->u.payload;
> > > > +	msgtype = hdr->msgtype;
> > > 
> > > Should READ_ONCE be used here?
> > 
> > I think it should.  Thank you for pointing this out.
> 
> Glad I can help.
> 
> The same comment applies to other patches as well, of course.

(As discussed offline/for reference:) I can spot a similar case in
patch #3; however, #4 is supposed to make that access 'non-shared'.

I should probably just squash patches #3 and #4; I'll try to do so
in v3...

Thanks,
  Andrea
