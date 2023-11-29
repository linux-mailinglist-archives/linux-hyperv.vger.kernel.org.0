Return-Path: <linux-hyperv+bounces-1149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D297FE318
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 23:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A13281EEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE163B1A5;
	Wed, 29 Nov 2023 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XWLmTpVL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 831A12110;
	Wed, 29 Nov 2023 14:24:33 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 9588F20B74C0; Wed, 29 Nov 2023 14:24:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9588F20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701296649;
	bh=N2gdfXEtDL56X5KE/D0j4gq3nXY5wXUdieLJyNGatYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWLmTpVLwaymFnm+nj/NzdoCTbgU5Yq4t++iTerQS4gun/c9T2VPZXRe4B8ZSmTnx
	 jEzZbHrFONut7aDGdNfuCN1ofKSWm62bYhihGrf99LULdc263L9iqfX/rYK4m6qrQR
	 uSU8pIMgHSWdL9HQef+Nisw4YQOeUkHEuXu1Z4aw=
Date: Wed, 29 Nov 2023 14:24:09 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231129222409.GB20858@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <44a4e759-02fc-4015-90a8-c41eb7cb3dc1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a4e759-02fc-4015-90a8-c41eb7cb3dc1@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 27, 2023 at 11:07:31AM -0800, Florian Fainelli wrote:
> On 11/27/23 01:36, Souradeep Chakrabarti wrote:
> >
> >
> >>-----Original Message-----
> >>From: Jakub Kicinski <kuba@kernel.org>
> >>Sent: Wednesday, November 22, 2023 5:19 AM
> >>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >>Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> >><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> >><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> >>pabeni@redhat.com; Long Li <longli@microsoft.com>;
> >>sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
> >>ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
> >>hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>linux-rdma@vger.kernel.org; Souradeep Chakrabarti
> >><schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> >>Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
> >>HT cores
> >>
> >>On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> >>>Existing MANA design assigns IRQ to every CPUs, including sibling
> >>>hyper-threads in a core. This causes multiple IRQs to work on same CPU
> >>>and may reduce the network performance with RSS.
> >>>
> >>>Improve the performance by adhering the configuration for RSS, which
> >>>assigns IRQ on HT cores.
> >>
> >>Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
> >>Please take a look at include/linux/topology.h and if there's nothing that fits your
> >>needs there - add it. That way other drivers can reuse it.
> >Because of the current design idea, it is easier to keep things inside
> >the mana driver code here. As the idea of IRQ distribution here is :
> >1)Loop through interrupts to assign CPU
> >2)Find non sibling online CPU from local NUMA and assign the IRQs
> >on them.
> >3)If number of IRQs is more than number of non-sibling CPU in that
> >NUMA node, then assign on sibling CPU of that node.
> >4)Keep doing it till all the online CPUs are used or no more IRQs.
> >5)If all CPUs in that node are used, goto next NUMA node with CPU.
> >Keep doing 2 and 3.
> >6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> >then wrap over from first local NUMA node and continue
> >doing 2, 3 4 till all IRQs are assigned.
> 
> You are describing the logic of what is done by the driver which is
> not responding to Jakub's comment. His request is to consider coming
> up with at least a somewhat usable and generic helper for other
> drivers to use.
> 
> This also begs the obvious question: why is all of this in the
> kernel in the first place? What could not be accomplished by an
> initramfs/ramdisk with minimal user-space responsible for parsing
> the system node(s) topology and CPU and assign interrupts
> accordingly?
> 
> We all like when things "automagically" work but this is conflating
> mechanism (supporting interrupt affinities) with policy (assigning
> affinities based upon work load) and that never flies really well.
> -- 
> Florian
I have shared a proposed patch in my previous reply to put some
part in topology.h. 
Regarding why we want to have this change in kernel rather than in user-space
is because most user in Azure expects things to just work out of the box.
It becomes difficult in Azure to adopt scripts in thousand of images in
short time. To avoid such problems for customers, we try to have this
changes in kernel.

