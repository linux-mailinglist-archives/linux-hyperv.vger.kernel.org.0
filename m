Return-Path: <linux-hyperv+bounces-4747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64091A762F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC9018882D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D061D88A4;
	Mon, 31 Mar 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G0UXm+E5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD81D63D8;
	Mon, 31 Mar 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412104; cv=none; b=S5YCb4epuL6iKWl4r3kQo0XAmwuyYItiDtdsrH4G7PUJ/XzRXopLHk5fzdw3jOs6Fbf0F2YUiwTPojqBIBvvViFAOfJi4HZV1TUinAm1MTkZFCC7arN605NVCVCVLHv8xSwos5uHswoES5dqDq55B7Yiy77/+9q4YZYqVrS+B0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412104; c=relaxed/simple;
	bh=wj8xpmWgK5yX9tmvccKgarihUFYI3+6qfieaV0vte8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmlVFqFVMIQ+7yRNIuD8oKBcTpT59BeNf9Il2gplybcY5CvXoWYvqU0yCuD/XRf+ubS4g/BthWgFWB3kcmq3dtMReZgZfRlz7wsSanyW0UJow3j9x/Sq4DLpSNGmXl1EKkXX+06zMhp26ixmuVhN4wNKxiJgCDrvEObFqHVA2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G0UXm+E5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3F07D211251B; Mon, 31 Mar 2025 02:08:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F07D211251B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743412102;
	bh=fABQHcWYZ8fxGq7/i5KjcTNIPf7v1OtIahvQKBq53HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0UXm+E5pJvBajFQAcgChgjbeLApGtSbrxm9PWAclRtmiFjZyrAzZfd6CDJl13g1m
	 I76jORF5O8NDRWT/5uzAmJHGD8H2GDyt0Ig6fpcSuPIZrnPaZ7D4/nfUQl/udaVP3R
	 j+BsyYfKaJaGYkuAQjd3kUS0nwRLhWXkOO3pxoGs=
Date: Mon, 31 Mar 2025 02:08:22 -0700
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
Message-ID: <20250331090822.GA22061@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
 <MN0PR21MB34376199FAFAE4901EF18E75CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <f2619b80-8d5d-4484-a154-18f902d43d63@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2619b80-8d5d-4484-a154-18f902d43d63@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

Thank you Andrew, Jakub for pointing out all the available options. 

We are currently investigating their feasibility based on our use case.
Would update the thread/get in touch, about our findings before sending
out the next version.

