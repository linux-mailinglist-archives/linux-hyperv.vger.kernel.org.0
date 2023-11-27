Return-Path: <linux-hyperv+bounces-1059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90D7FA331
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8969128184C
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651F1DDF1;
	Mon, 27 Nov 2023 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QdWclXVP"
X-Original-To: linux-hyperv@vger.kernel.org
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 06:42:31 PST
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE314E1
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 06:42:31 -0800 (PST)
Message-ID: <966f54dd-f083-4a7d-a15a-3a203a21d4ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701095582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vObv6RyITFVrMf1y8I26NGtkSDIHE/K42LLMcUo0st8=;
	b=QdWclXVPugaZ40tkeAmvvLE9DSxL36FaskilcyU5HHprK9FlE8RYXt0eg+0fiQRSH8W4a0
	vCOooQL+lm2ZKJ61RvlWEO59YZfS2LeOl5aCfwqHTM/ng8ujztV9mOaB+1Ip6aHIr3owHZ
	ZFMSMjenjWb8w7TV0NCnZKNu4K08Chw=
Date: Mon, 27 Nov 2023 22:32:47 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
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
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/11/27 17:36, Souradeep Chakrabarti 写道:
> 
> 
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Wednesday, November 22, 2023 5:19 AM
>> To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>> pabeni@redhat.com; Long Li <longli@microsoft.com>;
>> sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linux-
>> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-rdma@vger.kernel.org; Souradeep Chakrabarti
>> <schakrabarti@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
>> Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on
>> HT cores
>>
>> On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
>>> Existing MANA design assigns IRQ to every CPUs, including sibling
>>> hyper-threads in a core. This causes multiple IRQs to work on same CPU
>>> and may reduce the network performance with RSS.
>>>
>>> Improve the performance by adhering the configuration for RSS, which
>>> assigns IRQ on HT cores.
>>
>> Drivers should not have to carry 120 LoC for something as basic as spreading IRQs.
>> Please take a look at include/linux/topology.h and if there's nothing that fits your
>> needs there - add it. That way other drivers can reuse it.
> Because of the current design idea, it is easier to keep things inside
> the mana driver code here. As the idea of IRQ distribution here is :
> 1)Loop through interrupts to assign CPU
> 2)Find non sibling online CPU from local NUMA and assign the IRQs
> on them.
> 3)If number of IRQs is more than number of non-sibling CPU in that
> NUMA node, then assign on sibling CPU of that node.
> 4)Keep doing it till all the online CPUs are used or no more IRQs.
> 5)If all CPUs in that node are used, goto next NUMA node with CPU.
> Keep doing 2 and 3.

https://static.lwn.net/images/pdf/LDD3/ch10.pdf

Zhu Yanjun

> 6) If all CPUs in all NUMA nodes are used, but still there are IRQs
> then wrap over from first local NUMA node and continue
> doing 2, 3 4 till all IRQs are assigned.


