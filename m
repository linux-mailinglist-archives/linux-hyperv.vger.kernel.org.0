Return-Path: <linux-hyperv+bounces-10733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOQyJPnjAGqIOAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10733-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 May 2026 22:00:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089DD506219
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 May 2026 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9351300A75B
	for <lists+linux-hyperv@lfdr.de>; Sun, 10 May 2026 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503B3242B2;
	Sun, 10 May 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eNJAO4iv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A32494F0;
	Sun, 10 May 2026 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778443255; cv=fail; b=ciWgXcIZEL0clCAXqSWSPj3PZFHlpoZPoSs2BpASG4G4792qcYP1mHjsOygFP92IMKp23Vq29MncobjtfIb1qAlRYoLkHUjCibrtGRUjib/nh0anQslicVbIVEw+Pd1/zJbvDA552c18mMQjEibg+qVTyBRCYebcUvYtRMhaEZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778443255; c=relaxed/simple;
	bh=eXRPBuOGI0fvSEj+2F1LNFvFxXyNNRt7pdNcegYWlAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1/w4F+M+7I71jOv1gQOkJYO15sYoXTOBlKBGKEceFScZ62+hOdsEPkNl5W+EQK3asOrizNCJ/uQdyA+A5mUhujRUM6KCrKfJSrv/RfVQBNLk4ZLsGebQUEy2zpSSbPX/uOpW2VhI5m+xg5bkdT9Bs/pn3VPw1KIhCEqjUnv5gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eNJAO4iv; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjuCyJd3WiG6WUsq5FA9cPQuPZFs2avpW4B4kAZDeoEke0VpZ7QW3G8hzQnpNfEXFvuIqLiiVI+sXZdkBUoTTgWrPJqheju5ghr9P+D/KT6cNDIRCDiy7VLwQmz5BFOEmLWbiXbk3Y/pasC7NYhZIaig8aI4dZPetsWxGHZ09DD59RAl83sXI1su65BY7QoFNgPUX2Qo1HDfBmw298wfTDjw4avxwAKYXrjCpqLW87pvoqSdahRUDGUuUSkb3KoZJDaQYP2fIpRb6RqJx0jMS1g+Bc0pxIovLZcf1cze+7f7p/ECe/IsKBiOB/JXtsqrskq0TIOnV6QLJftCuWxXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1smsuae30AjyQc9/YbEBjSa9uEQuCYZasL7WcDs4TuE=;
 b=Znzeer0UffgOg/phkYgFpQVzGlzSVbrjBwra8Ma1nwHUReC49o/MkqUvqmmtQba+UDyUSH9+S38DYtf3V9Yr/+4tzLciLu4x9Zqw1Al42m0oOXS7XhyRbib2FkzmNu+3NlAXOznnQ9HXM5y/skBWtK4k499h7oXAC7Z8XM5FGJrp4WLaGrrmNOQLwjnqrO9KWSwvhU8paVqUFY4t4753DmKlqzLFVX7eCOD7hHAz1tZh5bzCDEIhDNPCKX0maef38zZwkc3YwvUkTdKCE5Ll15HEy9K2p24yIpc42UymoYTpARU0DdjO2pzRLY5nJR67tZp15Z49sA0tsYJc609zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1smsuae30AjyQc9/YbEBjSa9uEQuCYZasL7WcDs4TuE=;
 b=eNJAO4ivlhTnIXuyQKDY2GBX0q5ZeZZUGu89fHd1o56aKmkcxreDqUblVuvygMDVC9v9eTU+qOZbPJVvH7houPkI47DNnwEpxNOxFJrprf2VlNiB+qY1+aWVG/9AL1M+hP/zo4q/5VMUXSx/Ew0PAJqXWH4T5nvsTBSU6FlJYoBdJYQpwIJpSevhJbG9A2KcNmTIbpxgbDtvq3+En+l18y9HeO5vGp3AmP+7NTOG7dPQywqA02xXOn7s9ueMLqEHO/vhHbzNf3ENQ1MY3EEZKlkLluYQQka2Yg1Zwa2n9W5Y6cD4EmSrgf1u5J+OxKsV0o5JnQohdJWTVHen5dXeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 20:00:49 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 20:00:49 +0000
Date: Sun, 10 May 2026 16:00:46 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <af4X_52txN28b9RV@yury>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afYxOPL4DNjXM7tL@yury>
 <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afoQHm28qj8JnKww@yury>
 <af15yfdotzVbK8Kb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af15yfdotzVbK8Kb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: BN9PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:408:f7::28) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3eb0ab-c87e-4fa4-b66e-08deaeced4e7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c+9TSzjenjFPB74khPmyaxsyh5z17KFafA77eQ5Uj4thiE773CwqgI9VSaNf21jx43q2MTNRI1JIBIGYczuYGN7wtxMhpGBGEkdhi4nWvICh6AJFE4RB2LtmYsPYnDAHEG1F7myXdB3Z98MfGdkFE/ZhldLwFf11RVRrVF3yR0OLYMHFi5XNFPRRjcHqdfASn2pvR9IUYdw/XIOiYwJM90hmePD17+fbvJA4HBhNdZ0QLr2PJ/YX6AomAKL+3jyi3fbwv2yuS56IM24ELlsMoGyD1rV2ZKiTYtL5RSpr2SSZJzmAayTp4odx9v9ebNKACKBEOAkx3MOCnx9ccA8Sh4XxQoFcXIRVEHr/LHcgvCMwt6jAyl7N8I91MV/sbjOB+EJgWT6OpP2XKVB2Fe0Lw8m5v47u2LCaNopUSkfCRt8bY/Gr5HjkPykVX6uy+wQ7em94gW6WdQZJPwMSkDv70Aau+MbrrqvS2OBOaf5AFFnSDIQvEZ7cXFqukdc5/hhWG3ErD8QP31A3OJ0pfswrXM9/QM5Pw6H/mH7a27U0kcoBo5EaDYo0hCjnVjv6LKhoMXh9XLXHnlYrt1l9QhjFEq3Oh4UVZjQYmve+kWRgNdBzBaYXZBevN8NGd3hYB8PhkNIL/Pb8tPLw0iDzhUamqF/hzvgi4AUwFlkj0VF+SFE+KpYkEFA07qg1UdOAA1tN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xF6jHWh91I8a2FJMhZEdkpZQ6f0XHPmFL5EpdejnZ1f8Ivmh/0LTD3voERkT?=
 =?us-ascii?Q?KmZZq9U6W5/Q/XO0PUyQr8d8bYwgzx6tHM8y5YDEuWaWJavi5afiFJfhSPS/?=
 =?us-ascii?Q?rAGwTRG0MKDvZpM0/R3E17WZLawirHUrsbEJHkAlc271lSw7BEJuEXUjkPZK?=
 =?us-ascii?Q?zBlaCTuMXon5PrOkGY3Z9fFhQI2zje5DpEhOK+OR7LpZ1q7+NfPs0t//O9Lt?=
 =?us-ascii?Q?iHXRuOjGpf74Aai54k/32aXMrZI55teNwtmpNe5WQ7/U72o5pzHIRy6XlWoE?=
 =?us-ascii?Q?WSVcUbwKRU7poHQspZ4FaxwMSRnUtTaEvdjlbJoo9V2iEN55z3YJ1699IQSW?=
 =?us-ascii?Q?Co9yBS6SEG1dteCQWe4p5BAUlAgOvqZm0lVKKT8lcTuLHUmO7diCFkq3UfgD?=
 =?us-ascii?Q?pgpPMvKTNmnwpfFBXuwZA0bIdXlpI11o7W2HleU6qPaC0B89OwM/gKRTTeWM?=
 =?us-ascii?Q?2Hiiu9FmcA28TOof3TjOMi4RmJYnfQPqZd1x96VZsilIODB84mosf6I/748d?=
 =?us-ascii?Q?4h4mxmxs6RsAW6pW4gGhyzbHyKTZc7nR/mIV3LQ8bTlRT1N6TYbrLLorICyc?=
 =?us-ascii?Q?n6tXGkFDHafzy/9O3iY5l+67SFLjfm3vzZF7kGlC799yLECeYtnNB/YMCpE3?=
 =?us-ascii?Q?J/qZeY/7BBFssLjhJzj61Jxencd/4B931SsP3hf0Zv07jMhbc544xMMpdUiE?=
 =?us-ascii?Q?Xqeqqo2JOx277yEg6338vmtLFPmzFv1oXkmfDSpElodFH4SN96NdOAK4ey+E?=
 =?us-ascii?Q?UE0F72hhS0tZLfI5cpukf5Q9v1ZPaa77ooZUTwiGpCQhTvBV+Sz1NnhugQ9s?=
 =?us-ascii?Q?MDVcTLYw6OXk66rO3/4XgZKwSAP1ch6J1Uy6ys8YkoW6ajyeXSR9m36d1Zvu?=
 =?us-ascii?Q?fMQCcFSbHfbaa4KZGk0QM0rf58nPBwEBOasgiLoTmjU/mMh07bKpRMiv3Jzc?=
 =?us-ascii?Q?hb9+tgpbFRmigsmAEOAw/tv93yKL5m7mTnyCMj3rLRlzgnBxI7h/05Zmv8e5?=
 =?us-ascii?Q?mrYPGHZMy7H4sO5sswG+jGBZ9xp1K9iOnvNMJxX9tbG/6aF45Bv8GVT3yWuh?=
 =?us-ascii?Q?m4TgsRf6Nw1zQKfjWj8hwNcBIoFT2mwdZu0nNteVc3y348j2bWTyC8IhvfFC?=
 =?us-ascii?Q?MUKGRERHtiq9apybE/Y1JymIyP2NOslxcuQiLnsFaA2bSpWzHViQI1uBzuFi?=
 =?us-ascii?Q?KiBbZPXwNRigQXAbljVHySSLpwkyWJO4veXOUeY+rm9ld/bBpFEUgeJH3BNh?=
 =?us-ascii?Q?QViSG5dEIjPA22QL0ZFcoWP4/wNY6nHHn360yY2nYUGzsSo1LcFx5jTigKtO?=
 =?us-ascii?Q?ph+RGX3YrTNxwF1+7IYEp23v/k7R4R7KVg8Yqqr76+U9NMq9VHpsgQKpP6FX?=
 =?us-ascii?Q?B1dk6fD5OUwFRePNp+H48IqpJEeH1EgACI1MrrP8uH8EIJdnN0VEd8Xxn7In?=
 =?us-ascii?Q?21gFGwGlHzExvmbFT1NYIIxJFL8AA33CeG2olAVbnjtDCt34onon81v6d2IZ?=
 =?us-ascii?Q?kyDZODgaO+jHcbnweWviFoAdUWB7x/sZbe7S4egRIlSG7kqsxGP9QTk+ucH/?=
 =?us-ascii?Q?mxcvwTVFeqPOJQl9ALeRorxZMIv1inyufGTlyQOQkifsxMkWE8qRV1ynZB3T?=
 =?us-ascii?Q?0opyVbWWYJpbGbRO5pAaxbGJ7qT29i+qieu0VQK3kwjHgYZybuqjTsAxgB2O?=
 =?us-ascii?Q?VNe5bcL2RFu7FE2FoJqPTqRvL2k1Sk0i506IqdOfQfOkBQdhWIKC43cB2Ge5?=
 =?us-ascii?Q?4tfMoj3PKEP/yqxsdwKy0P/KOF28BRKNnIKDeu1NPiTCXyyPpwk5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3eb0ab-c87e-4fa4-b66e-08deaeced4e7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 20:00:49.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kal06p/ZVr3BRyy/tyEaz8o42l8y4ILR073T+XdR9/5r9KoLIkL6EEtqluwfwy3AK64HLZ6W2CS+E6JbaTFdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
X-Rspamd-Queue-Id: 089DD506219
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10733-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:51:05PM -0700, Shradha Gupta wrote:

...

> > > We can definately get our throughput run results on other suggestions
> > > you have. And about that, I just needed a bit more clarity on what to
> > > test against. Are you suggesting, with irq_setup() intact and in use, we
> > > configure the non-mana IRQs to say CPU0 and capture the numbers?
> > 
> > Can you try this:
> > 
> >        while(len--)
> >                // Or cpu_online_mask or cpu_all_mask?
> >                irq_set_affinity_and_hint(*irqs++, NULL);
> > 
> > And compare it to the linear version under your vCPU scenario?
> > 
> > Can you run your throughput test alone and on parallel with some
> > IRQ torture test?
> > 
> >         stress-ng --timer 4 --timeout 60s
> > 
> > And maybe pin the stress test to the default CPU. Assuming it's 0:
> > 
> >         taskset -c 0 stress-ng --timer 4 --timeout 60s
> > 
> > Unless the 'linear' version is significantly faster, I'd stick to the
> > above.
> > 
> > Thanks,
> > Yury
> 
> Hey Yury,
> 
> We tried a few tests with your suggestion, and throughput seems to be
> the same compared to the linear distribution approach. We stressed out
> CPU0 in both the cases and the results were similar. No IRQ migration
> was observed in either case and no throughput drop.
>  
> But one observation I had was that " irq_set_affinity_and_hint(*irqs++,
> NULL);" is essentially a no-op and we end up relying on the initial
> placement from pci_alloc_irq_vectors().

Yes you are, assuming you're not binding them before in your call chain.

> Even though in these tests we
> were not able to reproduce it, but with this distribution there is a
> chance we end up clustering the mana queue IRQs, while other vCPUs are
> not running any network load.

That sounds like an IRQ balancer bug which you're unable to reproduce. 

> It's because the placement depends on
> system-wide IRQ state at allocation time.

I don't understand this point. The 

        irq_set_affinity_and_hint(*irqs++, NULL);

simply means: I trust system IRQ balancer to pick the best CPU for my
IRQ at runtime. It doesn't refer any "IRQ state at allocation time".
  
> The linear approach however gaurantees each queue IRQ lands on a
> distinct vCPU regardless of system state. Even after stressing the cpus
> using stress-ng, we did not observe any significant throughput drop.

If you just do nothing, it would lead to the same numbers, right? What
does that "non-significant throughput drop" mean? It sounds like the
linear approach is slightly worse.

--

So, as you can't demonstrate solid benefit for the 'linear' IRQ placement,
I would just stick to the no-affinity logic.

Thanks,
Yury

