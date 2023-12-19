Return-Path: <linux-hyperv+bounces-1360-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7E81894A
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F4B1C246F8
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Dec 2023 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5F1A702;
	Tue, 19 Dec 2023 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzeCKHXF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF41BDC5;
	Tue, 19 Dec 2023 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5c85e8fdd2dso37563547b3.2;
        Tue, 19 Dec 2023 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702994631; x=1703599431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N37HHPKxfmv+voKC+TVPQoiu8z8zuuw9kS6/ar7EHYI=;
        b=mzeCKHXFd12KBTIpoblLWSFGnXhIcjzol8TzMqzOKNfoFq7sywrGQKYWgCONzNSVtk
         CVVpz/EdM59MZz7OYbHNrkVR73kMp3gh1O5iSEBZUdbErj9sHSz+V9UT/6PuMSLBPD0n
         C0veaDDVILinW74gPOazSgk2kDUBiy7iF5H79201tTN6+wkfUU1/8IXRLmCKyOjfBJET
         bAgokIDVYVnPKK8cOdO5tTim0j/Ho8FN0xJQxs4fqDfgfIYd0TGbaI97poTrQo4pTWLV
         wmfj7qRlobWrDq2JMBuRKmhg60Zf1g+CSsg6OyvDmym6YgoQv4KqcrF9Xj/KZHmwWF3Z
         dDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702994631; x=1703599431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N37HHPKxfmv+voKC+TVPQoiu8z8zuuw9kS6/ar7EHYI=;
        b=pnXY1m2Nn7WXSDaAcXWNXfag/G6n9hKpfa6L7+JO10jI7MCg8dGA8JtSI5H4wN5hNw
         rX7Jtcq5auh6L5t+g43tEJriVvk75hDcE4NI9lh8PEHvoLbt2qClI6Z1yzrBMIbMll31
         cZCRiOgFYbdBYUIyPXg1GKXAAJbXhVsBQ27Yde92CCm5tkKLHkk2Ix+wQ6v1PyPkACPJ
         0UY1ynYkAfH+zht1lM1CzuzTxKy+yK4aqcKeH7kwiPjKaFolH0S+OtDzAK+/rVtPCrXe
         mfrC4qZa7HTQbkHcMjW4npc6sc8o2tI5TsORw7L5pCPGLfuYESGQU8wSiOGS6rYKJCUw
         L8iw==
X-Gm-Message-State: AOJu0Yy1uC4fKSH6pCka55qGwXyDi0Gj4JpAWvHHzXBj+lL24hr+pOLz
	yISoqFaeKC5HYLUVmqELLh4=
X-Google-Smtp-Source: AGHT+IGtbbcT+HOqheXBPJrTeTn0hzXCbnmkPnP4vqy+fi2iNE2ryURfR7AMC8YRKDn1tPDJpotNmQ==
X-Received: by 2002:a0d:df09:0:b0:5e7:d4c6:ab0a with SMTP id i9-20020a0ddf09000000b005e7d4c6ab0amr520400ywe.46.1702994630969;
        Tue, 19 Dec 2023 06:03:50 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:5e78:6e9c:6a86:dd49])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm9755526ywf.42.2023.12.19.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:03:50 -0800 (PST)
Date: Tue, 19 Dec 2023 06:03:49 -0800
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
Subject: Re: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs
 per CPUs
Message-ID: <ZYGixTdW4PYF3RjR@yury-ThinkPad>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
 <20231217213214.1905481-4-yury.norov@gmail.com>
 <PUZP153MB07886CE88351F6B7A2AA0096CC97A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZP153MB07886CE88351F6B7A2AA0096CC97A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>

On Tue, Dec 19, 2023 at 10:18:49AM +0000, Souradeep Chakrabarti wrote:
> 
> 
> >-----Original Message-----
> >From: Yury Norov <yury.norov@gmail.com>
> >Sent: Monday, December 18, 2023 3:02 AM
> >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasan
> ><kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> >wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; davem@davemloft.net;
> >edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> ><longli@microsoft.com>; yury.norov@gmail.com; leon@kernel.org;
> >cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
> >tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> >kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> >Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
> ><paulros@microsoft.com>
> >Subject: [EXTERNAL] [PATCH 3/3] net: mana: add a function to spread IRQs per
> >CPUs
> >
> >[Some people who received this message don't often get email from
> >yury.norov@gmail.com. Learn why this is important at
> >https://aka.ms/LearnAboutSenderIdentification ]
> >
> >Souradeep investigated that the driver performs faster if IRQs are spread on CPUs
> >with the following heuristics:
> >
> >1. No more than one IRQ per CPU, if possible; 2. NUMA locality is the second
> >priority; 3. Sibling dislocality is the last priority.
> >
> >Let's consider this topology:
> >
> >Node            0               1
> >Core        0       1       2       3
> >CPU       0   1   2   3   4   5   6   7
> >
> >The most performant IRQ distribution based on the above topology and heuristics
> >may look like this:
> >
> >IRQ     Nodes   Cores   CPUs
> >0       1       0       0-1
> >1       1       1       2-3
> >2       1       0       0-1
> >3       1       1       2-3
> >4       2       2       4-5
> >5       2       3       6-7
> >6       2       2       4-5
> >7       2       3       6-7
> >
> >The irq_setup() routine introduced in this patch leverages the
> >for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups as
> >described above.
> >
> >According to [1], for NUMA-aware but sibling-ignorant IRQ distribution based on
> >cpumask_local_spread() performance test results look like this:
> >
> >./ntttcp -r -m 16
> >NTTTCP for Linux 1.4.0
> >---------------------------------------------------------
> >08:05:20 INFO: 17 threads created
> >08:05:28 INFO: Network activity progressing...
> >08:06:28 INFO: Test run completed.
> >08:06:28 INFO: Test cycle finished.
> >08:06:28 INFO: #####  Totals:  #####
> >08:06:28 INFO: test duration    :60.00 seconds
> >08:06:28 INFO: total bytes      :630292053310
> >08:06:28 INFO:   throughput     :84.04Gbps
> >08:06:28 INFO:   retrans segs   :4
> >08:06:28 INFO: cpu cores        :192
> >08:06:28 INFO:   cpu speed      :3799.725MHz
> >08:06:28 INFO:   user           :0.05%
> >08:06:28 INFO:   system         :1.60%
> >08:06:28 INFO:   idle           :96.41%
> >08:06:28 INFO:   iowait         :0.00%
> >08:06:28 INFO:   softirq        :1.94%
> >08:06:28 INFO:   cycles/byte    :2.50
> >08:06:28 INFO: cpu busy (all)   :534.41%
> >
> >For NUMA- and sibling-aware IRQ distribution, the same test works 15% faster:
> >
> >./ntttcp -r -m 16
> >NTTTCP for Linux 1.4.0
> >---------------------------------------------------------
> >08:08:51 INFO: 17 threads created
> >08:08:56 INFO: Network activity progressing...
> >08:09:56 INFO: Test run completed.
> >08:09:56 INFO: Test cycle finished.
> >08:09:56 INFO: #####  Totals:  #####
> >08:09:56 INFO: test duration    :60.00 seconds
> >08:09:56 INFO: total bytes      :741966608384
> >08:09:56 INFO:   throughput     :98.93Gbps
> >08:09:56 INFO:   retrans segs   :6
> >08:09:56 INFO: cpu cores        :192
> >08:09:56 INFO:   cpu speed      :3799.791MHz
> >08:09:56 INFO:   user           :0.06%
> >08:09:56 INFO:   system         :1.81%
> >08:09:56 INFO:   idle           :96.18%
> >08:09:56 INFO:   iowait         :0.00%
> >08:09:56 INFO:   softirq        :1.95%
> >08:09:56 INFO:   cycles/byte    :2.25
> >08:09:56 INFO: cpu busy (all)   :569.22%
> >
> >[1]
> >https://lore.kernel/
> >.org%2Fall%2F20231211063726.GA4977%40linuxonhyperv3.guj3yctzbm1etfxqx2v
> >ob5hsef.xx.internal.cloudapp.net%2F&data=05%7C02%7Cschakrabarti%40micros
> >oft.com%7Ca385a5a5d661458219c208dbff47a7ab%7C72f988bf86f141af91ab2d7
> >cd011db47%7C1%7C0%7C638384455520036393%7CUnknown%7CTWFpbGZsb3d
> >8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> >7C3000%7C%7C%7C&sdata=kzoalzSu6frB0GIaUM5VWsz04%2FsB%2FBdXwXKb26
> >IhqkE%3D&reserved=0
> >
> >Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >Co-developed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >---
> > .../net/ethernet/microsoft/mana/gdma_main.c   | 28 +++++++++++++++++++
> > 1 file changed, 28 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >index 6367de0c2c2e..11e64e42e3b2 100644
> >--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> >@@ -1243,6 +1243,34 @@ void mana_gd_free_res_map(struct gdma_resource
> >*r)
> >        r->size = 0;
> > }
> >
> >+static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int
> >+len, int node) {
> >+       const struct cpumask *next, *prev = cpu_none_mask;
> >+       cpumask_var_t cpus __free(free_cpumask_var);
> >+       int cpu, weight;
> >+
> >+       if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> >+               return -ENOMEM;
> >+
> >+       rcu_read_lock();
> >+       for_each_numa_hop_mask(next, node) {
> >+               weight = cpumask_weight_andnot(next, prev);
> >+               while (weight-- > 0) {
> Make it while (weight > 0) {
> >+                       cpumask_andnot(cpus, next, prev);
> >+                       for_each_cpu(cpu, cpus) {
> >+                               if (len-- == 0)
> >+                                       goto done;
> >+                               irq_set_affinity_and_hint(*irqs++,
> >topology_sibling_cpumask(cpu));
> >+                               cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> Here do --weight, else this code will traverse the same node N^2 times, where each
> node has N cpus .

Sure.

When building your series on top of this, can you please fix it
inplace?

Thanks,
Yury

> >+                       }
> >+               }
> >+               prev = next;
> >+       }
> >+done:
> >+       rcu_read_unlock();
> >+       return 0;
> >+}
> >+
> > static int mana_gd_setup_irqs(struct pci_dev *pdev)  {
> >        unsigned int max_queues_per_port = num_online_cpus();
> >--
> >2.40.1

