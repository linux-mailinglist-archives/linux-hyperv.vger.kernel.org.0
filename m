Return-Path: <linux-hyperv+bounces-1432-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEEB82CE3A
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jan 2024 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE643B2200B
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jan 2024 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9E5227;
	Sat, 13 Jan 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JilLmU2u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F3610D;
	Sat, 13 Jan 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e784ce9bb8so60024657b3.0;
        Sat, 13 Jan 2024 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705173111; x=1705777911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZUYQq6ZeHPwpQSptoecLeEtOwBdqH6kWgYuNYaqluQ=;
        b=JilLmU2uWeT6vQscQbOpFh9/im8K4J2IxSt/IfvvVHl6UhxteD9sFiEOPmG+FpnsSI
         qNDR6LIgTjU5uKhZDpUmjdlSUUVsnokSSLgwuYtAv4346kLZGvQI/Cx8/7xz2787x6pt
         fx65mwEPajoEKpOPTzwA4SK0XJXLpc6f7sp/LuvK+ekRl/F5XFW107QRSnk3uOU1FLOf
         OmADZEfM1cyK8MFxi/DIGfWKlZgwrOc/F6m6kqA23E1Ni/HFer9zy9phU7tnl8gABYP3
         ISlpu8v83y3GV8oZ7KsHM52e1RuBKlbIJi3iL/WrwswKl/q+IaeJ6fOruyjcOu/nYa20
         qOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705173111; x=1705777911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZUYQq6ZeHPwpQSptoecLeEtOwBdqH6kWgYuNYaqluQ=;
        b=EG6Jps995Cs8SKVkkGNrEHGUzIFn0l6rofz4j5lrqL+HzFj/u5PhndwW90qPFkMpMh
         mj4zS6fEEFH3eyToU9jIbK8Bw78ShYTbeCLnfdIBL50J/MPVQQ+P1qvN9+wqBxrUePaA
         U/KcujxWjmB9DFBauHfduNxoRzBlW9B4XncuN8HJ81+b9fyJHAGCzGvVrx80kUEDkt2C
         9NM7A3X2M0hmTlJI7s64pzOLIhjLw5cR+DlZgaPmNvsPFMmH7j8WUYMUOPZHBjkrPyUI
         uG2vRW0zVQz4oFY+XGlT9EuuPXWdIu62P/YnY3EJQvqrPWf9ygVlY5wtSNTQ5WYQRKCg
         xjtw==
X-Gm-Message-State: AOJu0YyHQjgJSDPqA8L32hHJtN+1lzFyULP1D4FCsy13cGg3bIJxhcif
	bE6/gIajgnl+uXdgm8hZlDu/Bt4Jn2pYsw==
X-Google-Smtp-Source: AGHT+IF62qQYyYHsN1meu6vDcu/esV8lR4jR7pBGU8ImgHCpBBoreqPMPbt9ZEZ/qA0Ic6Rs3f7h6A==
X-Received: by 2002:a81:5482:0:b0:5ef:f4a4:2f4 with SMTP id i124-20020a815482000000b005eff4a402f4mr2624249ywb.12.1705173111555;
        Sat, 13 Jan 2024 11:11:51 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:33b2:8901:1c90:18a2])
        by smtp.gmail.com with ESMTPSA id v141-20020a814893000000b005fb420b14dcsm2346352ywa.108.2024.01.13.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 11:11:50 -0800 (PST)
Date: Sat, 13 Jan 2024 11:11:50 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
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
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Message-ID: <ZaLgdn53bBoYyT/h@yury-ThinkPad>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157234176238D6C1F35B90BD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS1PEPF00012A5F513F916690B9F94D3262CA6F2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
 <20240113063038.GD5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157372CF70059E8E35D5545D46E2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157372CF70059E8E35D5545D46E2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sat, Jan 13, 2024 at 04:20:31PM +0000, Michael Kelley wrote:
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Friday, January 12, 2024 10:31 PM
> 
> > On Fri, Jan 12, 2024 at 06:30:44PM +0000, Haiyang Zhang wrote:
> > >
> > > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, January 12, 2024 11:37 AM
> > > >
> > > > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> > > > Wednesday, January 10, 2024 10:13 PM
> > > > >
> > > > > The test topology was used to check the performance between
> > > > > cpu_local_spread() and the new approach is :
> > > > > Case 1
> > > > > IRQ     Nodes  Cores CPUs
> > > > > 0       1      0     0-1
> > > > > 1       1      1     2-3
> > > > > 2       1      2     4-5
> > > > > 3       1      3     6-7
> > > > >
> > > > > and with existing cpu_local_spread()
> > > > > Case 2
> > > > > IRQ    Nodes  Cores CPUs
> > > > > 0      1      0     0
> > > > > 1      1      0     1
> > > > > 2      1      1     2
> > > > > 3      1      1     3
> > > > >
> > > > > Total 4 channels were used, which was set up by ethtool.
> > > > > case 1 with ntttcp has given 15 percent better performance, than
> > > > > case 2. During the test irqbalance was disabled as well.
> > > > >
> > > > > Also you are right, with 64CPU system this approach will spread
> > > > > the irqs like the cpu_local_spread() but in the future we will offer
> > > > > MANA nodes, with more than 64 CPUs. There it this new design will
> > > > > give better performance.
> > > > >
> > > > > I will add this performance benefit details in commit message of
> > > > > next version.
> > > >
> > > > Here are my concerns:
> > > >
> > > > 1.  The most commonly used VMs these days have 64 or fewer
> > > > vCPUs and won't see any performance benefit.
> > > >
> > > > 2.  Larger VMs probably won't see the full 15% benefit because
> > > > all vCPUs in the local NUMA node will be assigned IRQs.  For
> > > > example, in a VM with 96 vCPUs and 2 NUMA nodes, all 48
> > > > vCPUs in NUMA node 0 will all be assigned IRQs.  The remaining
> > > > 16 IRQs will be spread out on the 48 CPUs in NUMA node 1
> > > > in a way that avoids sharing a core.  But overall the means
> > > > that 75% of the IRQs will still be sharing a core and
> > > > presumably not see any perf benefit.
> > > >
> > > > 3.  Your experiment was on a relatively small scale:   4 IRQs
> > > > spread across 2 cores vs. across 4 cores.  Have you run any
> > > > experiments on VMs with 128 vCPUs (for example) where
> > > > most of the IRQs are not sharing a core?  I'm wondering if
> > > > the results with 4 IRQs really scale up to 64 IRQs.  A lot can
> > > > be different in a VM with 64 cores and 2 NUMA nodes vs.
> > > > 4 cores in a single node.
> > > >
> > > > 4.  The new algorithm prefers assigning to all vCPUs in
> > > > each NUMA hop over assigning to separate cores.  Are there
> > > > experiments showing that is the right tradeoff?  What
> > > > are the results if assigning to separate cores is preferred?
> > >
> > > I remember in a customer case, putting the IRQs on the same
> > > NUMA node has better perf. But I agree, this should be re-tested
> > > on MANA nic.
> >
> > 1) and 2) The change will not decrease the existing performance, but for
> > system with high number of CPU, will be benefited after this.
> > 
> > 3) The result has shown around 6 percent improvement.
> > 
> > 4)The test result has shown around 10 percent difference when IRQs are
> > spread on multiple numa nodes.
> 
> OK, this looks pretty good.  Make clear in the commit messages what
> the tradeoffs are, and what the real-world benefits are expected to be.
> Some future developer who wants to understand why IRQs are assigned
> this way will thank you. :-)

I agree with Michael, this needs to be spoken aloud.

From the above, is that correct that the best performance is achieved
when the # of IRQs is half the nubmer of CPUs in the 1st node, because
this configuration allows to spread IRQs across cores the most optimal
way?  And if we have more or less than that, it hurts performance, at
least for MANA networking?

So, the B|A performance chart may look like this, right?

  irq     nodes     cores     cpus      perf
  0       1 | 1     0 | 0     0 | 0-1      0%
  1       1 | 1     0 | 1     1 | 2-3     +5%
  2       1 | 1     1 | 2     2 | 4-5    +10%
  3       1 | 1     1 | 3     3 | 6-7    +15%
  4       1 | 1     0 | 4     3 | 0-1    +12%
  ...       |         |         |
  7       1 | 1     1 | 7     3 | 6-7      0%
  ...
 15       2 | 2     3 | 3    15 | 14-15    0%

Souradeep, can you please confirm that my understanding is correct?

In v5, can you add a table like the above with real performance
numbers for your driver? I think that it would help people to
configure their VMs better when networking is a bottleneck.

Thanks,
Yury

