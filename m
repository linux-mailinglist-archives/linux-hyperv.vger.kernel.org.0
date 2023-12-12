Return-Path: <linux-hyperv+bounces-1323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DA80F4C2
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BAB1C20D04
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8E7D8AB;
	Tue, 12 Dec 2023 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiEDnXLl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965983;
	Tue, 12 Dec 2023 09:40:07 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5de93b677f4so40779567b3.2;
        Tue, 12 Dec 2023 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402806; x=1703007606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITfpyvT+yTSAKPf02SD+zR8L+CboQOJw9W17Y7lhgTk=;
        b=MiEDnXLlBbVXhuEbvCL7UB3cd1JRmvKpiKgnV1xalgIlZYhgEIQ0MLzsm3LoC6j5QC
         P3Yad5igxpvdGv0X+Wun6+iX3lSrCJ8IpSci74fXvpo2bK/LIjJj3SQerSV4c0zGcmhz
         VGcEcFDYf6ni5CH8IYFRsmHtPRduVOX+eabx1oKprm/zcTSJBJYR+7lx4n3CAix9ztLJ
         juAfcEEMHLk5FXNkczlkmTmvabUn/R2OV/rCu2ls2PJb+YCIDL2zNfzVNyuVNaUOAvJ5
         I3Rmdz+M4MIsRrddGuPjJqu3FySLWtl1lzj35MsdvdWNQRqoMX7p0KEJxrKDhOmzmrDd
         aZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402806; x=1703007606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITfpyvT+yTSAKPf02SD+zR8L+CboQOJw9W17Y7lhgTk=;
        b=ra2iGIJRgdmjDpaLySL/QusBZ+8079dCJRoXTYy5GwnUadSPZHQEDip+jsJe2fA2Nc
         D7PgMWkpgrV2y5TmPfCMs6yNK1yPRWaNKH4PJAn0aQ0Rb2zvAEJLULi4uMi5DMR6e/6T
         cf0m5jAEGIAL6gB/apvIXwws6aj/rPV0lbq7xoElyw5c21bEq7KXmlQafZHv5CfSNx4a
         eIGzZiswoC+fEac3mUBArOlTOMHN8+6Ul9WpIPQOETfG0hW4j6eBuSpjFa+nv3PGgIPH
         qrd9pjeaxziYcGVqQoJv52VU3OIiiemVWYgeuny3N44uZbKPKWpkPGojCPhN84bXlzLL
         oogQ==
X-Gm-Message-State: AOJu0YxNG06pf6c64vO+i0XFGzg7ifMfQpgbym2TjkFW6cS5gvrlLTdz
	xDf45uzF7y1hICE9sGy710I=
X-Google-Smtp-Source: AGHT+IHZegAjNqkB+GIWw3B413cDU8EGl5b0I2oVSZ+rPLJ5//rOzR/8TbRJ6dMtw9/6NoigVqUwTA==
X-Received: by 2002:a81:4e0c:0:b0:5e1:ea5d:ba8e with SMTP id c12-20020a814e0c000000b005e1ea5dba8emr1214190ywb.6.1702402806314;
        Tue, 12 Dec 2023 09:40:06 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id fg2-20020a05690c324200b005d997db3b2fsm904517ywb.23.2023.12.12.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:40:05 -0800 (PST)
Date: Tue, 12 Dec 2023 09:40:05 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V5 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <ZXia9UVgWfV/7cEW@yury-ThinkPad>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <20231211063726.GA4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXcrHc5QGPTZtXKf@yury-ThinkPad>
 <20231212113856.GA17123@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZXiLetPnY5TlAQGY@yury-ThinkPad>
 <PUZP153MB07885B197469B61D8907B1E3CC8EA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB07885B197469B61D8907B1E3CC8EA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>

On Tue, Dec 12, 2023 at 05:18:31PM +0000, Souradeep Chakrabarti wrote:
> 
> 
> >-----Original Message-----
> >From: Yury Norov <yury.norov@gmail.com>
> >Sent: Tuesday, December 12, 2023 10:04 PM
> >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> ><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> >kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> >leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
> >vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
> >netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >rdma@vger.kernel.org; Souradeep Chakrabarti <schakrabarti@microsoft.com>;
> >Paul Rosswurm <paulros@microsoft.com>
> >Subject: [EXTERNAL] Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on
> >HT cores
> >
> >[Some people who received this message don't often get email from
> >yury.norov@gmail.com. Learn why this is important at
> >https://aka.ms/LearnAboutSenderIdentification ]
> >
> >> > > > > +     rcu_read_lock();
> >> > > > > +     for_each_numa_hop_mask(next, next_node) {
> >> > > > > +             cpumask_andnot(curr, next, prev);
> >> > > > > +             for (w = cpumask_weight(curr), cnt = 0; cnt < w; ) {
> >> > > > > +                     cpumask_copy(cpus, curr);
> >> > > > > +                     for_each_cpu(cpu, cpus) {
> >> > > > > +                             irq_set_affinity_and_hint(irqs[i],
> >topology_sibling_cpumask(cpu));
> >> > > > > +                             if (++i == nvec)
> >> > > > > +                                     goto done;
> >> > > >
> >> > > > Think what if you're passed with irq_setup(NULL, 0, 0).
> >> > > > That's why I suggested to place this check at the beginning.
> >> > > >
> >> > > irq_setup() is a helper function for mana_gd_setup_irqs(), which
> >> > > already takes care of no NULL pointer for irqs, and 0 number of interrupts can
> >not be passed.
> >> > >
> >> > > nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX); if
> >> > > (nvec < 0)
> >> > >   return nvec;
> >> >
> >> > I know that. But still it's a bug. The common convention is that if
> >> > a 0-length array is passed to a function, it should not dereference
> >> > the pointer.
> >> >
> >> I will add one if check in the begining of irq_setup() to verify the
> >> pointer and the nvec number.
> >
> >Yes you can, but what for? This is an error anyways, and you don't care about early
> >return. So instead of adding and bearing extra logic, I'd just swap 2 lines of existing
> >code.
> Problem with the code you had proposed is shown below:
> 
> > ./a.out
>  i is 1
>  i is 2
>  i is 3
>  i is 4
>  i is 5
>  i is 6
>  i is 7
>  i is 8
>  i is 9
>  i is 10
> in done
> lisatest ~
> > cat test3.c
> #include<stdio.h>
> 
> main() {
>         int i = 0, cur, nvec = 10;
>         for (cur = 0; cur < 20; cur++) {
>                 if (i++ == nvec)
>                         goto done;
>                 printf(" i is %d\n", i);
>         }
> done:                                                                                                                                                                                                                                                                                  
> printf("in done\n");
> }
> 
> So now it is because post increment operator in i++,
> For that reason in the posposed code we will hit irqs[nvec], which may cause crash, as size of
> irqs is nvec.
> 
> Now if we preincrement, then we will loop correctly, but nvec == 0 check will not happen.
> 
> Like here with preincrement in above code we are not hitting (i == nvec) .
> > ./a.out
>  i is 1
>  i is 2
>  i is 3
>  i is 4
>  i is 5
>  i is 6
>  i is 7
>  i is 8
>  i is 9
> in done
> 
> So with preincrement if we want the check for nvec == 0, we will need the check with extra if condition
> before the loop.

OK, I see. Then just separate it:

         for (cur = 0; cur < 20; cur++) {
                 if (i == nvec)
                         goto done;
                 printf(" i is %d\n", i++);

