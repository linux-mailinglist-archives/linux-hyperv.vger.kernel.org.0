Return-Path: <linux-hyperv+bounces-1401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6178290D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 00:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60961C24BA3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B383E479;
	Tue,  9 Jan 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk+xmktr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD63EA70;
	Tue,  9 Jan 2024 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5f75aee31d2so28823137b3.2;
        Tue, 09 Jan 2024 15:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704842942; x=1705447742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IX9+LBttu/RH0kDncVePa6QCQhOlpQ7I4FJ1PbxVZmc=;
        b=Uk+xmktrfy0OCgPT+GUXNNA1O+G5DLV+vGZ2+5iYDEqGD0P/MR/N91ukItku1XethG
         QxaZZaLI9qpkF/D7yjBgeqrum9OR9ssEvNt6rwTNrTO+ImQe2ChGTKvz5Er95wqHlmDt
         jKjGbLxSafRIKJxZm90G+trUslPw6EdrDCkSfr+6yPSWBVOo70PrSTP8Nhg9U9bi5Qdw
         xnqAqYkeEtgfCih/zWT98+fca5v0wjEOzvO/f4SqZ2tMn/c/71b79CXThaH7Iilh9Li1
         /ZiIX97es0ASk/mcWr6WM8G81SK3PaqH+RGq15kAlMfwbys2qYv2yADbFozPFqI1uiFc
         KNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704842942; x=1705447742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX9+LBttu/RH0kDncVePa6QCQhOlpQ7I4FJ1PbxVZmc=;
        b=vvZm7Id8Tz3fbqm77LL/MP4CorJTiZplePH7ZsNqoVJ7x+7m9wCWhEZGZ9swpN5PX/
         NWpr/YKog77MTkez+wVmtJjvaG+JJw8MowgHoCKD7mp1b0E3GlA/hEVhNeiVLSSQmKzx
         Ey/xgQPfqpZm9sM/JdQPn7QcGLN8K8ghXGCe3woSIgmdzlaaXxEA/cRaFpR8VSjH9JQJ
         DqI8Y4+e0iZ8iKQk+HyN+6GRhBghEjBdqpVQjZbPwsbI6/1MCQ+1KlRSGSzUA3Ya2MTq
         4XK0VEyRJIAir1q7p3KPTzcsut2pe6key0Ft2bNFDsMe2HqAVrQBAOKMT10B0xSvfNLJ
         NhRg==
X-Gm-Message-State: AOJu0Yxb0sqGfNSBmOm/xKoDw9+obN5DA4OeoF+0x+Ys9NyPyseLQYbV
	TkRUb+2qZJhIVtBRG2B7+n+g5ZtFxEy96Q==
X-Google-Smtp-Source: AGHT+IFLEbEq4E6XFd6N6rJvqoswf3ZrDm1OR85FlR/A+EyeCly7n2sRjcGSFwFJTPKer/j0img+Dg==
X-Received: by 2002:a0d:e305:0:b0:5d7:1941:ab9 with SMTP id m5-20020a0de305000000b005d719410ab9mr272325ywe.84.1704842941668;
        Tue, 09 Jan 2024 15:29:01 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:5cbb:49c8:4388:70cc])
        by smtp.gmail.com with ESMTPSA id m184-20020a0dfcc1000000b005f59ba17709sm1119737ywf.18.2024.01.09.15.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:29:01 -0800 (PST)
Date: Tue, 9 Jan 2024 15:28:59 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"schakrabarti@microsoft.com" <schakrabarti@microsoft.com>,
	"paulros@microsoft.com" <paulros@microsoft.com>
Subject: Re: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Message-ID: <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
References: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>

Hi Michael,

So, I'm just a guy who helped to formulate the heuristics in an
itemized form, and implement them using the existing kernel API.
I have no access to MANA machines and I ran no performance tests
myself.

On Tue, Jan 09, 2024 at 07:22:38PM +0000, Michael Kelley wrote:
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Tuesday, January 9, 2024 2:51 AM
> > 
> > From: Yury Norov <yury.norov@gmail.com>
> > 
> > Souradeep investigated that the driver performs faster if IRQs are
> > spread on CPUs with the following heuristics:
> > 
> > 1. No more than one IRQ per CPU, if possible;
> > 2. NUMA locality is the second priority;
> > 3. Sibling dislocality is the last priority.
> > 
> > Let's consider this topology:
> > 
> > Node            0               1
> > Core        0       1       2       3
> > CPU       0   1   2   3   4   5   6   7
> > 
> > The most performant IRQ distribution based on the above topology
> > and heuristics may look like this:
> > 
> > IRQ     Nodes   Cores   CPUs
> > 0       1       0       0-1
> > 1       1       1       2-3
> > 2       1       0       0-1
> > 3       1       1       2-3
> > 4       2       2       4-5
> > 5       2       3       6-7
> > 6       2       2       4-5
> > 7       2       3       6-7
> 
> I didn't pay attention to the detailed discussion of this issue
> over the past 2 to 3 weeks during the holidays in the U.S., but
> the above doesn't align with the original problem as I understood
> it.  I thought the original problem was to avoid putting IRQs on
> both hyper-threads in the same core, and that the perf
> improvements are based on that configuration.  At least that's
> what the commit message for Patch 4/4 in this series says.

Yes, and the original distribution suggested by Souradeep looks very
similar:

  IRQ     Nodes   Cores   CPUs
  0       1       0       0
  1       1       1       2
  2       1       0       1
  3       1       1       3
  4       2       2       4
  5       2       3       6
  6       2       2       5
  7       2       3       7

I just added a bit more flexibility, so that kernel may pick any
sibling for the IRQ. As I understand, both approaches have similar
performance. Probably my fine-tune added another half-percent...

Souradeep, can you please share the exact numbers on this?

> The above chart results in 8 IRQs being assigned to the 8 CPUs,
> probably with 1 IRQ per CPU.   At least on x86, if the affinity
> mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
> should balance the IRQ assignments between the CPUs in the mask.
> So the original problem is still present because both hyper-threads
> in a core are likely to have an IRQ assigned.

That's what I think, if the topology makes us to put IRQs in the
same sibling group, the best thing we can to is to rely on existing
balancing mechanisms in a hope that they will do their job well.

> Of course, this example has 8 IRQs and 8 CPUs, so assigning an
> IRQ to every hyper-thread may be the only choice.  If that's the
> case, maybe this just isn't a good example to illustrate the
> original problem and solution.

Yeah... This example illustrates the order of IRQ distribution.
I really doubt that if we distribute IRQs like in the above example,
there would be any difference in performance. But I think it's quite
a good illustration. I could write the title for the table like this:

        The order of IRQ distribution for the best performance
        based on [...] may look like this.

> But even with a better example
> where the # of IRQs is <= half the # of CPUs in a NUMA node,
> I don't think the code below accomplishes the original intent.
> 
> Maybe I've missed something along the way in getting to this
> version of the patch.  Please feel free to set me straight. :-)

Hmm. So if the number of IRQs is the half # of CPUs in the nodes,
which is 2 in the example above, the distribution will look like
this:

  IRQ     Nodes   Cores   CPUs
  0       1       0       0-1
  1       1       1       2-3

And each IRQ belongs to a different sibling group. This follows
the rules above.

I think of it like we assign an IRQ to a group of 2 CPUs, so from
the heuristic #1 perspective, each CPU is assigned with 1/2 of the
IRQ.

If I add one more IRQ, then according to the heuristics, NUMA locality
trumps sibling dislocality, so we'd assign IRO to the same node on any
core. My algorithm assigns it to the core #0:

  2       1       0       0-1

This doubles # of IRQs for the CPUs 0 and 1: from 1/2 to 1.

The next IRQ should be assigned to the same node again, and we've got
the only choice:


  3       1       1       2-3

Starting from IRQ #5, the node #1 is full - each CPU is assigned with
exactly one IRQ, and the heuristic #1 makes us to switch to the other
node; and then do the same thing:

  4       2       2       4-5
  5       2       3       6-7
  6       2       2       4-5
  7       2       3       6-7

So I think the algorithm is correct... Really hope the above makes
sense. :) If so, I can add it to the commit message for patch #3.

Nevertheless... Souradeep, in addition to the performance numbers, can
you share your topology and actual IRQ distribution that gains 15%? I
think it should be added to the patch #4 commit message.

Thanks,
Yury

