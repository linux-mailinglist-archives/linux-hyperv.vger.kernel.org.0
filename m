Return-Path: <linux-hyperv+bounces-1356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40217817CB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 22:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9C52861AF
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A5A740A2;
	Mon, 18 Dec 2023 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp17vnOo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E00273467;
	Mon, 18 Dec 2023 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28659348677so2561511a91.0;
        Mon, 18 Dec 2023 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702935882; x=1703540682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsIQRoDMyAO/1DgxQjK7hg35wfAQDmgiayboWw066aQ=;
        b=Gp17vnOoU0YRBcRwYY6sIP/lzFDxecnFZCWWG5n4lkj9+u5aik8Cm+Jo3Ziho//TT0
         f+Gh7Dez8xhAy9zSZm0EcvYg2FZ3nhMXWfB4t4WAJaFE8heuC+Fu7VA7hyDQH7aalEaf
         pQXZxR5ebfnsdRUxdGofrGEpKr8S1mLgSqCx1+QVdUYTfqgbCdcewCUE8kppbRSuE6G1
         U+xy9EWkA6ylgiX8RSzkOMVhGrxT3DzTX9KJAtUZs1NFa3D9jVJi2t5F2RVwz7RDygds
         bN94SRKmlC4SKzfyH0ltOll2xQ8Bq0bwgv2FpSq5STEM87+Dbjb0Wcdw7uv3oPJa+H4f
         dR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702935882; x=1703540682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsIQRoDMyAO/1DgxQjK7hg35wfAQDmgiayboWw066aQ=;
        b=VxgVNXkMo2TLMG3Ok+l/qOkVx0RU18EAx0B/yxBGxcxdujr6dq4os1zdrfcLaCo/21
         b9bfDTZFO/uGy8QLEW8zVLL2Z8DNWjV4z9uuAWeVTqLga2JatSc6y1LH7PyP5NtB74XT
         MkHsWfZMZ5VFNy4vuhAjCpNErqM3L1u7r6CBHWNHkaGwCGgHEmNRNOTDidaZB/6m2Mns
         Aeraax46AVJA5fJUQaCqIRvQ95JGAixJj0DXXILDLKIM3Jw4Vn1d63dS66FxC1QM6HQF
         8lP60Ez1T1gApZVzfkkpCwS1JcRuVxmWODvb7zfgegA6Tr12nlZD7uAkPpqHXXakQmtS
         JoJw==
X-Gm-Message-State: AOJu0YyJKNVkJjDmvkpq71V8OgPvm6ax6y6gMQ2TfpH0GqB/iWN2FnKy
	hoLSuyGWHKAFZXkj6uoiHZY=
X-Google-Smtp-Source: AGHT+IFovrmEbJoaKAuL0WhPM+7iXQ84uNI1T6Ho3Ro2axd+SDJpSLOBetddAyB1nl1YYc1ub8pO1Q==
X-Received: by 2002:a17:90a:f3ca:b0:28b:664a:807d with SMTP id ha10-20020a17090af3ca00b0028b664a807dmr77347pjb.25.1702935881851;
        Mon, 18 Dec 2023 13:44:41 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001d2ffeac9d3sm8253339pln.186.2023.12.18.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:44:41 -0800 (PST)
Date: Mon, 18 Dec 2023 13:42:25 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH 3/3] net: mana: add a function to spread IRQs per CPUs
Message-ID: <ZYC8wYdyHi3KA3Bp@yury-ThinkPad>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
 <20231217213214.1905481-4-yury.norov@gmail.com>
 <9ba04aef-ba13-4366-8709-ea1808dd4270@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba04aef-ba13-4366-8709-ea1808dd4270@intel.com>

On Mon, Dec 18, 2023 at 01:17:53PM -0800, Jacob Keller wrote:
> 
> 
> On 12/17/2023 1:32 PM, Yury Norov wrote:
> > +static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int node)
> > +{
> > +	const struct cpumask *next, *prev = cpu_none_mask;
> > +	cpumask_var_t cpus __free(free_cpumask_var);
> > +	int cpu, weight;
> > +
> > +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	rcu_read_lock();
> > +	for_each_numa_hop_mask(next, node) {
> > +		weight = cpumask_weight_andnot(next, prev);
> > +		while (weight-- > 0) {
> > +			cpumask_andnot(cpus, next, prev);
> > +			for_each_cpu(cpu, cpus) {
> > +				if (len-- == 0)
> > +					goto done;
> > +				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> > +			}
> > +		}
> > +		prev = next;
> > +	}
> > +done:
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> > +
> 
> You're adding a function here but its not called and even marked as
> __maybe_unused?

I expect that Souradeep would build his driver improvement on top of
this function. cpumask API is somewhat tricky to use it properly here,
so this is an attempt help him, instead of moving back and forth on
review.

Sorry, I had to be more explicit.

Thanks,
Yury

