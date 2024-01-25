Return-Path: <linux-hyperv+bounces-1470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BF83B968
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jan 2024 07:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C281C217C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jan 2024 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E110782;
	Thu, 25 Jan 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TARg7VaF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0210A01;
	Thu, 25 Jan 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162855; cv=none; b=J6rtbyXbQd2jY1x28i3tbHTfCX/ZLOpMiQI7324VsEOjmuDlhnzWbs863CHfZwOXilIzqBLqmhPj6lrg1nJaKIJ8prmnfaU5T5XdAuLgzjwIkVjFlrwkGxlfmWF8c4pjIdUhViVWhsPA1+Wds2YbORDKK74pP8ppfE8n1k0APEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162855; c=relaxed/simple;
	bh=IIDjC280Z3zWAHyp5QAbdKygm8MpeDKViYg+j2FlPog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy5jviGf5WUW9FX6ECOK2sL9cmux7uiaywe6LXnGu/7yRcxG2TFuoK4csKwbYzKAjpDdmtckHnloXVI+kJ7teZ5J0a0GWNPM3nsk/Bl1PasQezxlMkNdeYWwnWLX68CeO8v1/ukrcMHpPlji7sU1hSy415Ov9YBHy+Ph6k4wPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TARg7VaF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 6C74920E5692; Wed, 24 Jan 2024 22:07:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C74920E5692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706162853;
	bh=o7UkRO8dE1Xp/Y/Xubp6ytag9K1yUqGfcqFU+xvdA/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TARg7VaFYulTsQS1jIbdFqQ/azo5mPbnkTOW6axIIjpaN9dZVBvMKuUHKjzuOaVKC
	 IJefpEyMfdM9izt1Myn8LDmNxBr92rZ9YfzKVdtorvchbpnwsCPPfw86qcHwuhYorJ
	 AWF75fVA1VFA7utUib7m7P0xNY1aITNexxh4YOlA=
Date: Wed, 24 Jan 2024 22:07:33 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH 4/4 V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <20240125060733.GB18142@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>
 <ZbEqu68J3f9W8nIM@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEqu68J3f9W8nIM@yury-ThinkPad>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jan 24, 2024 at 07:20:27AM -0800, Yury Norov wrote:
> On Mon, Jan 22, 2024 at 08:00:59AM -0800, Souradeep Chakrabarti wrote:
> > Existing MANA design assigns IRQ to every CPU, including sibling
> > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > in the same core and may reduce the network performance.
> > 
> > Improve the performance by assigning IRQ to non sibling CPUs in local
> > NUMA node. The performance improvement we are getting using ntttcp with
> > following patch is around 15 percent against existing design and
> > approximately 11 percent, when trying to assign one IRQ in each core
> > across NUMA nodes, if enough cores are present.
> > The change will improve the performance for the system
> > with high number of CPU, where number of CPUs in a node is more than
> > 64 CPUs. Nodes with 64 CPUs or less than 64 CPUs will not be affected
> > by this change.
> > 
> > The performance study was done using ntttcp tool in Azure.
> > The node had 2 nodes with 32 cores each, total 128 vCPU and number of channels
> > were 32 for 32 RX rings.
> > 
> > The below table shows a comparison between existing design and new
> > design:
> > 
> > IRQ   node-num    core-num   CPU        performance(%)
> > 1      0 | 0       0 | 0     0 | 0-1     0
> > 2      0 | 0       0 | 1     1 | 2-3     3
> > 3      0 | 0       1 | 2     2 | 4-5     10
> > 4      0 | 0       1 | 3     3 | 6-7     15
> > 5      0 | 0       2 | 4     4 | 8-9     15
> > ---
> > ---
> > 25     0 | 0       12| 24    24| 48-49   12
> > ---
> > 32     0 | 0       15| 31    31| 62-63   12
> > 33     0 | 0       16| 0     32| 0-1     10
> > ---
> > 64     0 | 0       31| 31    63| 62-63   0
> 
> Did that omitted lines mean 5-24 : 15%, 25-31 : 12% and 33-63 : 10%?
They are same like you have mentioned, so I have skipped those ranges.
Whereever the major changes were there, I have put them.
So it is the full coverage only skimmed a little.
> Or that means that you didn't test those?
> 
> Would be nice to have full coverage...
> 
> Thanks,
> Yury

