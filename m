Return-Path: <linux-hyperv+bounces-5513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4282AB7201
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638731B6860E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535C27EC7D;
	Wed, 14 May 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3aAeVA1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18827E7DE;
	Wed, 14 May 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241706; cv=none; b=cIzlmmq/dh+0UKd0NzHfhaAYP2uTW1CGbL4WMvvdBq+c5ODNkPdsP3wijGCc4ab3GsiVzT8rgHDugU3RJ/qA/apQsdpg8uT0hFZJLnQbx4aSTUye1MJENMiQh1fryXHDMEWJi8Sqjj9HQ5xbw8TU8QaEN5QBorAkKjbB06WgigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241706; c=relaxed/simple;
	bh=WpM+JcX1WaS+PU+QHS2OAq0l+8B1CNymhsJ8V9SwXuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1Jm0uqMDZkBlW8hC4yEBuu9/rNnP3cKg+DLuVvCFCADblT995gGs8F/T1Qnjv5HuD1X0SXtR5AVf+mjK57oEHTiZm+1JJnnB9O8DMYP3DDc1Knb9Ux5JNkECE+NQObJP1PrmEWLiMAPWrOMfV5n7k3QMm/sdnbPFGBQBcDam58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3aAeVA1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30ac24ede15so108444a91.2;
        Wed, 14 May 2025 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747241704; x=1747846504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjAaU38K+dPIUQCxORagYj2WJCZrV6ZUCkrYlp3GHFQ=;
        b=l3aAeVA1EgjsmyGwltWSNL1BqkG4d3LT/CIzo0YP+CO8SUO/NGeSAUcJNo5wOr83Vs
         fo/9GDcXZASfKEqXpBKArxjVdUGioFFi4AOlsNdCKUGxavwi3ClJAd8SEM8SwHWkSZZJ
         sm94o8tupVu7OCa/yjN72Q6XxEy2KvgL0GOnrqaj5wFca5dswPmCxwAlj9aOlGod4oRY
         ndnVLJyYtPZvmLKdydEWKCGnfXNTCWHErckHPNcvVevSkcMdPvVJUaCjLd0M4USSMG2r
         VyAkERDXbsJ9Muuropig9YKUYkwqn+vK7IGp1/MQEkb1mDbySKSBZg4w502L4Viph5/G
         9Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747241704; x=1747846504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjAaU38K+dPIUQCxORagYj2WJCZrV6ZUCkrYlp3GHFQ=;
        b=ZDrydHs0bL2cDFC9i+g80d7aXcuRriosvON7NHK24iw9G0uZIZhEnnXRHsDi6cipBi
         PS+TDvPfl7Wt64ChLNc0uSn/oH83riwBEbHteb6xo/uIj4K1U4PBOblmckQNnwFza44k
         kOTUxCrY3S1D58jWCjDIRbJ4mZnzcSHTW4LDg59ld1kFUvXtGHp9fMq+2j2xr0IxSN4T
         P3ssQILLOLywf5Nf7lO1VmsjbUHZCyOgF5FKSU1DjT6vpkqHIg5RvfumscDFp2OhCKyc
         5rTkRygk3NeuJrdNJIoJOCiWcE960nzdjXgc3SJqhry3V6eTDugcq+OpQC3vgvgqXcv1
         GSsg==
X-Forwarded-Encrypted: i=1; AJvYcCUMBEUEU5JMni1mifUX/lpqrSYCyc8OEhj/3s+U0uILfnDBkzFcjSCJVtngR8IxXPhcAJE4Z8VEQoO5@vger.kernel.org, AJvYcCVCbEMc85LzQHVvhtuqXh+TRI1luvmJc3zxu0QQFWkshyYhWXBZdI3vLkNblcA8t0NDh5npgW1x4HOhuSgK@vger.kernel.org, AJvYcCVTiRW3j0ZJwRHw9A3rznds/ww/24rAwxUVE0rE6T40o3IQjZf1GcooD7A8p1z9HAZt69uECJSBGFJ3J/w=@vger.kernel.org, AJvYcCXLGTNDcrMF/Silf2OP8ddFDarbPfT+drOaCRwgn4Zs7J1I3+uPU8vNDi/tL8NcDvpPte/poIp61m4bYQ==@vger.kernel.org, AJvYcCXNhVtknHK+Zpt5dGse5FOlyJRsP9cV5bEZlx4F9IKe2AYlGHlvN1zyM2gNSAxdtXvC3V2NyF4T@vger.kernel.org
X-Gm-Message-State: AOJu0YzN03Gp18zUbHRgHXSzgZg7jh9PQ5fT+Hr+R+1kWe/KeHLuVPNg
	/B9zM07m7otXxP9YrcXGRItXFfKZ2rSI1kdEh+GFn86ScMxbaVsB
X-Gm-Gg: ASbGnctROFI2Bgfypa9fPb2iraRft88D1R4tYU6s5kddXHY8HG31FkjqfOh15c3EwTO
	gWtFDOG6bqP0EElX+qqFsnU8EsTpz++2h5v390NZEeOU8fchM5TlnkgrdGzyRcnmBya8lXtNHom
	vZIAEsu6mazZnYfTLJqyrfxrETXh9JK0XdUgkx6JjoaXoPoKQ6HH+g5CjP27VQ2WhfK7XmB1Rpf
	i5vVL15quXTd01WWK/0CRGk8f1Td1qiujpqqLtm4CIO+gWRGn+aYIm6PVA4XiZezCRAusZOAW4o
	8Mt3WI5He1qKVJf95rgdqCLWoJIZyIpx8jessBPWHuQ1FrkAORwRrWFXQV1d4Q==
X-Google-Smtp-Source: AGHT+IFtxVrOsaJi6T2aUz0enn/7PlvuksPoRElJWxF7qFDWdeSdmcwqmG9VKuv/S86z9Q30urH4ug==
X-Received: by 2002:a17:90b:38c4:b0:2fe:b174:31fe with SMTP id 98e67ed59e1d1-30e2e583d63mr6563988a91.2.1747241703525;
        Wed, 14 May 2025 09:55:03 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33401872sm1830197a91.6.2025.05.14.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:55:02 -0700 (PDT)
Date: Wed, 14 May 2025 12:55:00 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 3/4] net: mana: Allow irq_setup() to skip cpus for
 affinity
Message-ID: <aCTK5PjV1n1EYOpi@yury>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785625-4753-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577E2FAA79E2803C3384B0D491A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 14, 2025 at 04:53:34AM +0000, Michael Kelley wrote:
> > -static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > +static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > +		     bool skip_first_cpu)
> >  {
> >  	const struct cpumask *next, *prev = cpu_none_mask;
> >  	cpumask_var_t cpus __free(free_cpumask_var);
> > @@ -1303,9 +1304,20 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node)
> >  		while (weight > 0) {
> >  			cpumask_andnot(cpus, next, prev);
> >  			for_each_cpu(cpu, cpus) {
> > +				/*
> > +				 * if the CPU sibling set is to be skipped we
> > +				 * just move on to the next CPUs without len--
> > +				 */
> > +				if (unlikely(skip_first_cpu)) {
> > +					skip_first_cpu = false;
> > +					goto next_cpumask;
> > +				}
> > +
> >  				if (len-- == 0)
> >  					goto done;
> > +
> >  				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > +next_cpumask:
> >  				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> >  				--weight;
> >  			}
> 
> With a little bit of reordering of the code, you could avoid the need for the "next_cpumask"
> label and goto statement.  "continue" is usually cleaner than a "goto". Here's what I'm thinking:
> 
> 		for_each_cpu(cpu, cpus) {
> 			cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> 			--weight;

cpumask_andnot() is O(N), and before it was conditional on 'len == 0',
so we didn't do that on the very last step. Your version has to do that.
Don't know how important that is for real workloads. Shradha maybe can
measure it...

> 
> 			If (unlikely(skip_first_cpu)) {
> 				skip_first_cpu = false;
> 				continue;
> 			}
> 
> 			If (len-- == 0)
> 				goto done;
> 
> 			irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> 		}
> 
> I wish there were some comments in irq_setup() explaining the overall intention of
> the algorithm. I can see how the goal is to first assign CPUs that are local to the current
> NUMA node, and then expand outward to CPUs that are further away. And you want
> to *not* assign both siblings in a hyper-threaded core.

I wrote this function, so let me step in.

The intention is described in the corresponding commit message:

  Souradeep investigated that the driver performs faster if IRQs are
  spread on CPUs with the following heuristics:
  
  1. No more than one IRQ per CPU, if possible;
  2. NUMA locality is the second priority;
  3. Sibling dislocality is the last priority.
  
  Let's consider this topology:
  
  Node            0               1
  Core        0       1       2       3
  CPU       0   1   2   3   4   5   6   7
  
  The most performant IRQ distribution based on the above topology
  and heuristics may look like this:
  
  IRQ     Nodes   Cores   CPUs
  0       1       0       0-1
  1       1       1       2-3
  2       1       0       0-1
  3       1       1       2-3
  4       2       2       4-5
  5       2       3       6-7
  6       2       2       4-5
  7       2       3       6-7

> But I can't figure out what
> "weight" is trying to accomplish. Maybe this was discussed when the code first
> went in, but I can't remember now. :-(

The weight here is to implement the heuristic discovered by Souradeep:
NUMA locality is preferred over sibling dislocality. 

The outer for_each() loop resets the weight to the actual number of
CPUs in the hop. Then inner for_each() loop decrements it by the
number of sibling groups (cores) while assigning first IRQ to each
group. 

Now, because NUMA locality is more important, we should walk the
same set of siblings and assign 2nd IRQ, and it's implemented by the
medium while() loop. So, we do like this unless the number of IRQs
assigned on this hop will not become equal to number of CPUs in the
hop (weight == 0). Then we switch to the next hop and do the same
thing.

Hope that helps.

Thanks,
Yury

