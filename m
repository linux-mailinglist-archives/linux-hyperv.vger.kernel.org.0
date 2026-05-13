Return-Path: <linux-hyperv+bounces-10831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHlKHcNiBGq6HgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10831-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:38:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14233532637
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13653303C3A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0F3FA5D8;
	Wed, 13 May 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9VDcd+t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93510349CF1
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672321; cv=fail; b=Fmhada+8WrMoJ3Tr8x1QTJpEK7wOCBIT0nv2XjOiZi/iLxeRphZwJ2ZJ0jMYsLUkRkLrC0GdcjGWPO7XXRy/1kvgt2Z3bSZ7V6Ujctx4fewKy/ZwRDay/vqlr6RQBCvGpPb6xn6cjGRHlGUFM3jOjCHLP1sKdHcFbp1EY/mTXZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672321; c=relaxed/simple;
	bh=IPo+ztGIrnBdg0pWoBzgJi7wl7pfqhnmc5qf+jeTq1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMpYAI5Dc3SP7EUfnpMokd1stF37M74AG/FYUP8FHU1UuxPOy6n9nASLm7gLQO1o8vIl0fUcQuKk/w0tWe6AnD4J3+fb64c/zs1KFcNUDX8cK1h1WOhVNH4rGm8nnbPOOVlTFR6v7H4xIEkV4Wx/S2DCUNRGZEzs9lLbQuFZcTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I9VDcd+t; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ5cTWNqyr6yIIhvavbp8RZkMo8JXQLOo2MxiQH8S0VI0WS0jI9+xIAXT8Yij9VQm6Qv4ExsvWsJ08t/HUl9lEjL0WkiNQ5sjeClcv8cYEFwSjenFE6C02LccvHhqS86mZBe7j6JbfFXqrS8xtmOx1wdUQh6BYlcky0bzTCY1hO80cMWbUYsDipsJNyes4eF/aztHUe/tVW65JuBPbQ3zPxk1cPTS+v/yQ6a+kQvANQzGapJi2yghl7dNVUhRRprxWAAFCDKMOuaNzHqEFtLjBusSEhE2yaMFCEJKwQ0zIii6ozR6cE99ULUMr1corUu8geNr/AWdtKoteM4I84b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSQlI2rKqEvhk634d/McIM/N5Tll7Xl5AsBOKyCuOmY=;
 b=IUQrg9Onu0t7dJwpSci1UrLUlLSNuZpicrBSrO/6WYXFOGPdUTGsYS9rZmlr5hsBVrYXqtaJGz+OWvb3/Bh9mG7GMeV1DRavuTpMjWne/PbM2IYJL9dhJpHoFhi9/fB4lVrH/+Zu/a11EC8Pnp+bz496KYuE+6zWBFo8Zq9XuR/hbrbHGJ/6hPwuZCcgEGpYYtzLp28BBsCtZ9wt69a/BnEI/0HMCLNiJ92QV1mwBWlC/vJQZELU8UAgwmLJemTkfh6GfViTXOqtNdouJU+RkJG9T1U4sMX8FFkFz6lqowqRrf++tEGRSE6SHvRb2ZDmNBEFP5Q7GhxDmYwyZp8QMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSQlI2rKqEvhk634d/McIM/N5Tll7Xl5AsBOKyCuOmY=;
 b=I9VDcd+tmkpw4HtwfhAXUylsUb5DiC5ixwxx8E0slAfJZRIpJsolQvw2HecKiUBAyzU/MYRakFpBqITrj0c/m1+hsA9EpWbY5iWPev8B7nIHLdnjBeiZ+c84J7UxJsDIChDvaeuv9tAu77hJFxwiCRbfLB8c0RXgWV7GyZJEEvqt85nHm6dG8vqguEUVFCFxJ4EjJKQc46OXUHYlZKrO2N1Y01K6ZI7d2h2JxnYxZ9mt3m+JiiAsw7IfGQbAB1aFXXX83ld3EE+DXMgvmUKQqHDn51nzUSRBkzLa18uvpRPVl/OVmBH6aMNR7X0m1A+CIyd2MVbUbscaoCvkTkNVnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:38:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:38:36 +0000
Date: Wed, 13 May 2026 08:38:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: sashiko-reviews@lists.linux.dev,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 02/10] IB/rdmavt: Don't abuse udata and
 ib_respond_udata()
Message-ID: <20260513113835.GE7655@nvidia.com>
References: <2-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
 <20260513031237.4280DC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513031237.4280DC2BCB0@smtp.kernel.org>
X-ClientProxiedBy: MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e91581-70bd-402f-43ff-08deb0e42b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LH7mbmUEkA5XiThebhad2vZlLbWilfbtKywvFQ+PT1TOi3w+GcSUNNX//pxEObMRvRtutUMzecnjA6NS7uBfGJMSw1QnNa7MPsF2tgFm23ZfW9YKm/EYM/uJNdzSIkB51sXDH0QRHo4TDGcCgYxcgmd0Ml70ecVXdN3/BwWivZjzVbPryejTGzp45caIY3w0PIo0qpsu4Ij46Af43/mdy/C7Mm9W1GVk79KgvyBTkCBPRrrc95eWeQQgc1DPhKnEIzmnIVG1c0hJbcmLPhl74jjry/AqHnCrpeEaL2wNF22po1bdisLmaun8VYiBxjSERRiMpKx/XywufMK/zTKF9AMWFlYUh0h0Cid2Nc+IrdLu1ECxw50sNMVMXaOGCfdaHqPRmQW6pxmopxp7AGtH/49HbyQqBKWLlFgzVIVA3g2Q9sJ+XOxhz+jiSDHS1qtske6oSCoBSdBcwi+EzctgQ3NVG8RYd2XoT7zqpkr9DGTfJZEJlmq+B3W5gwgYiQq/ume726Urt4lefNXAqn/5Hv8/VYYHxUXB5u7pvJ0ZnPImepLqJQaISydsMou8CvESi71tAe4V3yKDfYxOd7Es25FB0LmsLwLMzT7VgCjSD5PbxXbAbjReOmK0SGKQI/0GeGayGniFGVEsVrxppJFLEHPSe0MQI2REQ9J8jXKD//cJXxYKs3Yoep1rULCY+ozm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1ptUGVLbS9ZMHVYQW1KaGVMRU5PVFFqQ1QyeTIvZ1I1cTgybExCUGpGZ1Zz?=
 =?utf-8?B?TVg4bGlNRFhZanRpbGdXNk11SUdXbW16MjJnTVRFTVhwTllnQ0tmL0UyNkVO?=
 =?utf-8?B?dzBpVVoxeTlVQXkrMS84c1ZESGlGUnJhaHJFSnVTampabnJqSjVCN1pucEJL?=
 =?utf-8?B?VkxaQUVnYnhDMGs5ZVVNKy9pRHYxSDh4OFppWnBoY3ZRQXNWKzVWWEhUZnkz?=
 =?utf-8?B?bXVUTmVTTUc3NFNOSXFQN1crWmQzQ3RQaW1XYmhQNWNKYi9tNHhMekIyWWg2?=
 =?utf-8?B?YkQ2L2FuNlBpcXdTQlIvcXhoOEV0VTVYaGE4cERjN0V5VEltL1ZSTU45UVVt?=
 =?utf-8?B?RnhLd2hlRE1BeFJTazZJK2loOTY1UTNHMkdTQlBIRDl6d2NLSGN1aWxsbEtO?=
 =?utf-8?B?Vk9SWTZHOWlzT1hIT2l0UUZBbnZsMlVrWGNDRVdOaXRXQ2RDQm14NkdRcFRV?=
 =?utf-8?B?VTNzaUNxTVFYTThnZlFGNjJ1b0M3VGxyTGEvU1N3ZEVIK3k4eEszQkY5WW1v?=
 =?utf-8?B?cGpkT21ETXJEQlEyVkpKOXo1ZUR6SkFyaW52UkJhTTIvakU5cHJEWTJsR2JQ?=
 =?utf-8?B?QUd0UE9pc1B0aThENWJXa2ZWSER6WHB6WmlnQ2dSSGN5bVpyb3o2dUlxUEJT?=
 =?utf-8?B?ZWs0d0pkck1jY1laamlqejdQNjRkK3FMVWt2bHRxZTRvcUxNa2F5eUh6Ymwx?=
 =?utf-8?B?dUJESXg3dmJyN2NpZFZDOE5ZZUp1Ri9RNmVBTjBXOExaRTV5d3YrYjhEc1Zm?=
 =?utf-8?B?WGljZXJYWXNTQUt2bVh0U0c0WGNKT3lvR0FnK2VRWXFUTjdrRW9vYUNQRndE?=
 =?utf-8?B?Rmx3Q3JOdGY0Z0RQS2xTd0FvNzNHa0tkY0J1a1oxblp5cHpJQnVuWmNxRlh2?=
 =?utf-8?B?bGs1K29KYWh3c3NhbitYRVdaRGJiTkR4OVBzYk9KWmRvM2xtajJURlgxK3hB?=
 =?utf-8?B?dWJtTVJvdks5VitwRG9ibGRRL1hWRjZZa1o0SHNaRVpFTDQydG1VUU5VQXcx?=
 =?utf-8?B?dVQxWi9lL21SK3dnSm5NeEkrb2E3bFhsRlNCU1E2KzVjQm51d0hZdWp5T2Zr?=
 =?utf-8?B?WmkzL09hcGJDKzh4Y2tKb214R1diZkdmT2xzbnZxU3pBbGZ0Y3JZZWE1bkR0?=
 =?utf-8?B?eERmY0NIZVd6RVNsV1RTMTJGNDlSejl4WmM3OVkrNEhMMkJOeUorTWNKY25i?=
 =?utf-8?B?ZHkyTDNPRlVuM0t3MkZ4V0FJNng3dzNISHpZOCtHbUIwUk9JY1d5K0FRM3V0?=
 =?utf-8?B?dVNNSGtoYnpySnZWZzBJdTAzbWNkV0lEMlR4eFRxeXdsaHdPbFJtbVFzSEY3?=
 =?utf-8?B?cWdXVk5hYVUvQk0zYzJYQmJFSTcxQ2tLNEw1Y2s4Y0VoYjlrVXJZbEdhNlND?=
 =?utf-8?B?SzhmQXlXRFJ2L0x2OEl0aWVSRmVTZU5lR3IxRy9EMnhLb3NqbUVCSzh3Vlor?=
 =?utf-8?B?N29uTDFYN1VCaklDdU1yY1A1dUVWWjZCSHJFdDVWUWMrNXBRREduRUVCM0hG?=
 =?utf-8?B?SWpmbFM5eGtWd2xVbEVselMyZ3FxdlF3a01sY1pta3ZsS0d4eWNyWXZWVldZ?=
 =?utf-8?B?Y1JkR0w1M2pJNkhKRlRSaWpkYzJqbGxRWXMxa2dwUHYrcDJycDhpNXhCcXF3?=
 =?utf-8?B?NzJhWEcrSHlkeCtWaGR0MXBEUElPMk9aQ25vWHZwWjZCN2RkN0cxdU9YVW5W?=
 =?utf-8?B?TERsOFhJSldzSS9MSXNhUGRvWEZrL2ErSXZSNlludTgvdWFUaVZKMEJDaGY4?=
 =?utf-8?B?eEVHYWFzTFZwQmpWaVJlNERQSjdud08zcWsyMFBVMDYrNUZHa2NmNjVSL001?=
 =?utf-8?B?SlR3dDFCdm9Qd2ZXNTFEV1FEY2w4L1poMHhYM3JqOEhlYkJtbnV3OWxVVFI0?=
 =?utf-8?B?clR6bkNFeFZqUkJoOTZ5ZVVuT3VjMEZDalpMczJlWkx3c2piS3c3NlBnTkYr?=
 =?utf-8?B?MklIN0hJUW51alVSSWk5cklsU0YxNit2YXdwZERFdmdUQjNqRnNsS2g4K2Y5?=
 =?utf-8?B?NkZkYjEyNHVtZStqdVo0RkkwSndYd0hKUzV2Y0hqTnkveTZTVVlEall5SUtM?=
 =?utf-8?B?NloremYzZ3VNS3FUSXJkdEVtUTFxN0UyOFBVU1Qyd0NqR1MwYkNQdlJnSWFJ?=
 =?utf-8?B?NUZmTXRRZmhLdUhUY0RuSi84cXZYd3hnTUt4V2h3NFBiVFNzL1J5TnloZHBG?=
 =?utf-8?B?enBVaG85c0diVHFmNUNERlRTc3VmbjhnSmNpTnVhbVl6Z0JxMlNxaVNNY0pa?=
 =?utf-8?B?Z2xlMnhKbUVLL0EwZWtuSHZMTjJZeWNhZHUzYmVNcVpvdTE4bEdEbVU1ZzVY?=
 =?utf-8?Q?j62Ql7dgQxktuZKlbp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e91581-70bd-402f-43ff-08deb0e42b6b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:38:36.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLE8eNpEorCs3T5udLMekw/cyhiTASzNlNClbBSigtTMe1wYJpJOreNnsB5xHsuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
X-Rspamd-Queue-Id: 14233532637
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-10831-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:12:36AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] TOCTOU heap buffer overflow due to unvalidated `num_sge` from user-shared memory.
> - [High] Memory leak of the kernel queue structure (`srq->rq.kwq`) on user-backed SRQ modifications.
> - [High] Locking imbalance and freeing memory while locked.
> - [High] Inconsistent state and Use-After-Free on error path.
> - [Low] Uninitialized variable compiler warning for `offset_addr`.
> --

These are all pre-existing and rvt is too confusing to try to fix be
me. Dennis will have to handle them
 
> commit dac7699d9e58c179b3a8859ac64da79e5fd21f46
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Subject: IB/rdmavt: Don't abuse udata and ib_respond_udata()
> 
> This commit modifies rvt_modify_srq to use copy_to_user directly instead
> of ib_copy_to_udata for returning the offset address.
> 
> > diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
> > index fe125bf85b272..d022aa56c5bfd 100644
> > --- a/drivers/infiniband/sw/rdmavt/srq.c
> > +++ b/drivers/infiniband/sw/rdmavt/srq.c
> > @@ -128,6 +128,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
> >  	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
> >  	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
> >  	struct rvt_rq tmp_rq = {};
> > +	__u64 offset_addr;
> >  	int ret = 0;
> >  
> >  	if (attr_mask & IB_SRQ_MAX_WR) {
> 
> Could hoisting offset_addr lead to a compiler warning for being potentially
> uninitialized?
> 
> The compiler might assume udata->inlen could change concurrently across the
> spin_lock_irq() and spin_unlock_irq() calls. If the first check fails
> but the second one passes:
> 
> if (udata && udata->inlen >= sizeof(__u64))
> 
> Does this allow offset_addr to be used without initialization?
> 
> [ ... ]
> 
> > @@ -149,19 +150,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
> >  			return -ENOMEM;
> >  		/* Check that we can write the offset to mmap. */
> >  		if (udata && udata->inlen >= sizeof(__u64)) {
> > -			__u64 offset_addr;
> >  			__u64 offset = 0;
> >  
> >  			ret = ib_copy_from_udata(&offset_addr, udata,
> >  						 sizeof(offset_addr));
> >  			if (ret)
> >  				goto bail_free;
> > -			udata->outbuf = (void __user *)
> > -					(unsigned long)offset_addr;
> > -			ret = ib_copy_to_udata(udata, &offset,
> > -					       sizeof(offset));
> > -			if (ret)
> > +			if (copy_to_user(u64_to_user_ptr(offset_addr), &offset,
> > +					 sizeof(offset))) {
> > +				ret = -EFAULT;
> >  				goto bail_free;
> > +			}
> >  		}
> >  
> >  		spin_lock_irq(&srq->rq.kwq->c_lock);
> 
> Can this code leak the kernel queue structure?
> 
> When resizing a user-backed SRQ, the code fetches elements from the old
> user-mapped queue. In the udata path, okwq is left as NULL:
> 
> if (udata) {
>         owq = srq->rq.wq;
>         head = RDMA_READ_UAPI_ATOMIC(owq->head);
>         tail = RDMA_READ_UAPI_ATOMIC(owq->tail);
> } else {
>         okwq = srq->rq.kwq;
>         ...
> 
> When it later calls kvfree(okwq), it seems nothing is freed, which could
> permanently leak the old kwq structure.
> 
> Is there a lock imbalance here when the queue is replaced?
> 
> The original queue is locked with:
> 
> spin_lock_irq(&srq->rq.kwq->c_lock);
> 
> But then the queue pointer is replaced:
> 
> srq->rq.kwq = tmp_rq.kwq;
> 
> When the lock is released:
> 
> spin_unlock_irq(&srq->rq.kwq->c_lock);
> 
> Does this unlock the new queue instead of the old one, and then free the old
> queue via kvfree(okwq) while its lock is still held?
> 
> Can the loop migrating WQEs overflow the destination buffer?
> 
> The number of scatter-gather elements is read directly from user-shared
> memory:
> 
> wqe = rvt_get_rwqe_ptr(&srq->rq, tail);
> p->wr_id = wqe->wr_id;
> p->num_sge = wqe->num_sge;
> for (i = 0; i < wqe->num_sge; i++)
>         p->sg_list[i] = wqe->sg_list[i];
> 
> If a userspace program concurrently modifies num_sge to a large value, could
> this loop exceed the bounds of tmp_rq.kwq->curr_wq, since the destination
> size was calculated based on srq->rq.max_sge?
> 
> [ ... ]
> 
> > @@ -236,10 +235,10 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
> >  			 * See rvt_mmap() for details.
> >  			 */
> >  			if (udata && udata->inlen >= sizeof(__u64)) {
> > -				ret = ib_copy_to_udata(udata, &ip->offset,
> > -						       sizeof(ip->offset));
> > -				if (ret)
> > -					return ret;
> > +				if (copy_to_user(u64_to_user_ptr(offset_addr),
> > +						 &ip->offset,
> > +						 sizeof(ip->offset)))
> > +					return -EFAULT;
> >  			}
> >  
> 
> Does returning -EFAULT here leave the kernel and userspace in an inconsistent
> state?
> 
> At this point, the kernel has already applied the SRQ size change, replaced
> the queue, and permanently freed the old memory:
> 
> vfree(owq);
> kvfree(okwq);
> 
> If copy_to_user fails and returns -EFAULT, userspace might interpret this as
> a failed resize and continue using its existing memory mapping of the old
> queue. Could this lead to a use-after-free since the pages have already
> been freed?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com?part=2

