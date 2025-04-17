Return-Path: <linux-hyperv+bounces-4954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC0A91637
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFABD166434
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6C22D7B5;
	Thu, 17 Apr 2025 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n82oSPFO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644A1F8937;
	Thu, 17 Apr 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877576; cv=none; b=frdAc7VUMN+UYMyCvu9uaXrcJKq9mJ3m8wDlNXAPA46LQwHkcowsSfsp0ATaAqs4RdkuXyigwdpgcQA5nnKpYox/453Y6/0sbkCjp8yNUUwXzSX1q2zHrhJXEJjAROQY0NNg5eig5xeise4wbVKETRaSLqcAVsaCiD5ExaqQfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877576; c=relaxed/simple;
	bh=ausffIwdAWgX2eiDnN/xWkFLcAKEIHmv735KMjP74Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlkoEYuCwRA0ySThUpxWEBviji02mmSwrBWJ3EjhyEQWgnWrrjUZuoMKXYZ0eSjqV0X4BA02TT0/IceJDzvB3SP9tNLlzCs5/k1+E9Sl58YEI7OU3NSZQ8qVufuWVm4MkJfmDvRq4YW9xCLtZm2pTidaiGobDm7UhqwesE3O86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n82oSPFO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4459421199CA; Thu, 17 Apr 2025 01:12:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4459421199CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744877574;
	bh=S9VENa3hYgzvatnix+kIlW1E4DfVat/eX1pf1K4UW08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n82oSPFODY+SlcpPsvrOFUo3UtbSq1Mj2qm4eJDFqSQgLHaIiLGrmjexJP2Yhw07z
	 gMCsNPXswizBJMnIURsGVSXzJJt5VlwlkBNTSgOcJ8V6uNbUtFDq1J9zmb49Y79nAh
	 3FHjAYj9Mkyv6IfENq6CbvqWUTj/aVCp1ObpA+QY=
Date: Thu, 17 Apr 2025 01:12:54 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"surenb@google.com" <surenb@google.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>,
	"rosenp@gmail.com" <rosenp@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Message-ID: <20250417081254.GA30387@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
 <MN0PR21MB34376199FAFAE4901EF18E75CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <f2619b80-8d5d-4484-a154-18f902d43d63@lunn.ch>
 <20250331090822.GA22061@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331090822.GA22061@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

I hope this message finds you well.

I wanted to follow up on this patchset I previously submitted. 
Based on your valuable feedback, I have made modifications 
and incorporated your suggestions along with my
previous logic. Please find the updated patchset attached.

https://lore.kernel.org/lkml/1744876630-26918-1-git-send-email-ernis@linux.microsoft.com/

