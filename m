Return-Path: <linux-hyperv+bounces-9532-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GkbAiDWummfcAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9532-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 17:43:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4A2BF7D2
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F20B93010638
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631D3446C6;
	Wed, 18 Mar 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1CD70Uh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A99460;
	Wed, 18 Mar 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851526; cv=fail; b=f1zRRXdqEo1n6mUm9j6dJv+lefV1cPcmER/zqCxhXdOUI+womTBM+SDyJQe2gJ48/tGcT3KA7qaFCfMHB/cf144S5EUYNHKwr8xjB+Usmudmgm1McskqMuOHQWnGZsTk3M6TNncwrD9e7hEeQ8funUgK0X/vLNC4w9P0Am97cCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851526; c=relaxed/simple;
	bh=27dIAcUvQAMUobWXY48JduMIqn2FV5mY+LaO9eOdOoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5Z4uFqqDzjUbm/j96jD361rINDkYfK006pWVCHRWbZ0tXUeiLn98MlDKjUpu706d/zVas54EBxLCEypZGSHnJ9ws1RQze+mkb+ou6IeCDl7ovLj6HHR8uds0AyNYlkDanbNtu4+mS2YeFeBOnpfJ3SG2kZmnCN0MBqpAfwlAUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1CD70Uh; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRg173z7hSdzWagjpLxOWiAVeF0w/JwFz7Hh8gjYVHeu6G115eDNdo80fj3mIqh1SIk3Sr8K2kzj+mtmBTUs5G6T+gIUhESQ9a8Bzsf+5dE5nlFATYcddX+oLlXXa75vwylSQ7TzKf3fLYbXQ4wTEhYvIabmQ/RgdKMMlit2Ts4xZ9yiPQRVQVvvrQnYST1Quv+IXaxFafkAUrA8KrXONFTQm/SiF5kzq0wAaAmQ0lXfiCTbKYxmJ1ZE1epCCIO4x8eW/2ymD1U2m2lJV3uaYeiNyN5IBRY5kQgL4edPIxJBYNmUJMD4Akqx+XTZFLEyfgHMr+3uvrkWbZ53mnT2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6LWo2Etf5lOG9GyKZT/ZZeH7ZSfCnz9P0CyKvpumdQ=;
 b=dJMjxHEm+sx6YypQfyWZT0rOY/DUm3A3JGN4ymJx/fYhCWP1mQGPH24QrsCxTcxxIqAam58OmVk8oitb0hXp0sbnlcC85Qr7Qh71ykTKkVirGBKdXkqwqzSFdPJmrAP1DgImQl8mS7QopaXDvBmgxcKff+aavIRWEVY/dX+eAfcp8vCGANGLj2C+7l79AzKr9hhzhT25r0O1y9zgHuE2zqE4fkTXWGfFiQWRp9L00+Z4A5jxB9dscbAUJqHelNaV/6zKntfbHKoFpBDQa9fW5aTxEouUvCFcRJuyt0CqHrvhINm8pQ7de/7pYgheVfPPeZV9m7HKkJZ83OcrZ9bKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6LWo2Etf5lOG9GyKZT/ZZeH7ZSfCnz9P0CyKvpumdQ=;
 b=Z1CD70UhYTGmoGw5I9cC93aBL0r4YI3dAiAj5sx8lmBnikTY1AzLemn/YFRJbc/cFLm6MVuIElAl36jyf4suuU44Q5LesrMbmSlDaRLThl/uSDGkDf+xvor2EpPrrtJpITVmT5FKFQmqg/CMUu8wRNX/j6BiS086vbIZ6yifFvY5tSBl+/lqxO2KvtTQwBcN6yT0dQ08LAPWsfKDKpD89Puh0RCopUA3cSDNzT/sTLTIW/pfXQvukyynsmB+nFC1YgZHgJghEQJ1NLE0+IhWCh9DxoCymGjmM/XBdcIViHhsK77UVXYRu+4sREv9C/76fZhCjSIVQ6wiOEJP5evDmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS0PR12MB999105.namprd12.prod.outlook.com (2603:10b6:8:301::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 16:31:57 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 16:31:57 +0000
Date: Wed, 18 Mar 2026 12:31:55 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abrTexSs8F3jiJtf@yury>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <20260313171855.GA1744604@nvidia.com>
 <abRUGVW6ZuGioa4Z@yury>
 <20260317091411.GQ61385@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317091411.GQ61385@unreal>
X-ClientProxiedBy: BN0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:e6::6) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS0PR12MB999105:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d8b044-ac7a-4283-f458-08de850bdf88
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w/i7RWR9YlCmIyHZIGi4Q+PLQNoczacZWSGQLlNqEyZ1qc8eOMG1KYCLkCnnd/gN6dXYtiT3KR6WaZX/zx67jLKE3+mxJG8GdRy28B0cS2lOWpLzlEekkcosn4p9thEgJ35Z/WaSJuhcda30c2+nkOy8LAX+aknE6O5yQ34X797qVJKADrwcyCXOfDCu5Ay3su0vXL43fQckwU0iKtJ67zo9DO1RCUunCPpyy425AKN8IJAXPgLDVNMeBYJUv28o9W/0VA2tNsIXeUWGA7hocOjUTI/3wWZn7MimgROfp0RY31G2ytdMM6CXEf6SThPZyUQRYJoFANVZfLhb+wOAQkxm7yvs6wdkXuKEB/xsw8ZZX0VIUyabgXg1mRWFR4MpHDdi88GHWvRsOuSGhosQZP0Pkoq7Rzwz9GnDGnYAH9by3sd0zGoYblQhnCFO9UIsb4MN14fFnoDC8efS3+5F4urQk6adFUjP0MQ+Yw+3Nwj9GWxs8M7cbaPTRJIkMKQJr0wsGN05GnXNllFUpwi5VwphoWRMIbCbOyVCVFl6Five3DYBMpGoBaJndKWlGAqmYkqiZKWnx2KHBGpnjWtC/+deSO4wQweJf5EpROKLv9lv1q2P92gLFWqCNzUhUzIsEa4F91oCJfM0TJvQX9EsmRwl5LnGIM9oU+PN3kl4pXJTS0tZbUEbY+Tm+X5n8BS3tJtJf2a7R5+phRO2hFEY8AQxI5NBMr40PRgf7t1QO9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pKaEOcxCzlhge3+sRqiSyK3UAzGMuIkn/KQTz/2ETFmDfCd46TI0lfgjZrKO?=
 =?us-ascii?Q?dTYONyAKRRm1iQc2q6NMefi3JTL5F5syklkHT2UrJqIOqG6fgfJM7aO0943Q?=
 =?us-ascii?Q?AkZ1AMs+IDdd2JJdAeXf2dw/SLe6buKUPF04Lt1OjKn9pcdvOsV7wxAbT7Gr?=
 =?us-ascii?Q?UISzjZTqaqUlbbakEZnzgqIaP/pbKTXIDMVVPr3ZInCeIplnA0P81iqZEL+S?=
 =?us-ascii?Q?PDaoKFqpAiwpfDdOBdRTGvkCWuX5A+bSvG2ewblNMhqMnXa3vOiS0jUfAiMx?=
 =?us-ascii?Q?F181zks0XGwfhEfdb+EPpm7/Wg+W9Gn0r7GbPlNiIXjgRA1lct5eMKlS/X8D?=
 =?us-ascii?Q?v1U6co4Ntx/2Cjo94pbxMdMEHhCNzd85mfpHDvM64qMF7TQacpgeBqLGoBe+?=
 =?us-ascii?Q?QyC4gL8Fjmu+tN+BQt7AwLxqmhs71niRQxXTm9mN2JRYx1YwYRjzbSJQaN75?=
 =?us-ascii?Q?p+NPoeYQlv/O5R2NIEbJ61xBhkHaSZJc+5x+HshXpMBSMHklcPzI4DHBpIXs?=
 =?us-ascii?Q?0RPxdehuTycS2Fs4jLJEdpfMjk0TkyyfXJBoGX8KV9vhrGSwQ5WrZqMq7LKK?=
 =?us-ascii?Q?7a2mmeTTfkz39dq6UnRyGfNqutyAGZjwkXAPRd1BJ51Uer5ZIwHDalLd50+D?=
 =?us-ascii?Q?JdqAjBfpRV/UVkRVLmvdVjG20Co5r9oICOeRAV37zdW0if9LT+XmRFUGU/8B?=
 =?us-ascii?Q?lO3Tui1qO4zhz6/yPBfZ7BhWHF6THlhQ/GOUNqOjb3f6qtrvpz/OI6mszraR?=
 =?us-ascii?Q?46BtkMbP0WrGWEy3Oc556NZa/NXcnE1tEbh09uuXcesMcjomnq5a+IF+0LNg?=
 =?us-ascii?Q?B1c7rxgyzVeQ0UJWunaSOoio8pmgfzEJfntcLmlSj2qe9FpSlosjsXB+QqMP?=
 =?us-ascii?Q?uLjFRpbIZ3rYXmO0uTZWsRWF1u4TNuvYg34iexUnImwyfqkbYZy46h96RzvE?=
 =?us-ascii?Q?SIgHNGiFaq7Pjf7KYhU2Q0yFpvZcafnzUjgEA4RXjZ6iT4OVLh/RS3bVgwnH?=
 =?us-ascii?Q?fpuv7YI7nONpP4qwBOWFoqrp4waIIOjYrrr30irfJb5XHCIoSYdEXk6Y8ny8?=
 =?us-ascii?Q?W8HxxtbxJbCpkkcg5VicA2Jf317Kmsz87Wfz0EMVgyhZ1nXjqxezH9PPW1nZ?=
 =?us-ascii?Q?FCj6hFmcuKzIx+unXQpWn/uDqHnIdDvIha0ZEazelk+vUr5JKhKucc1CVWxk?=
 =?us-ascii?Q?XXQJuwKfQdGFIhHqvsnieUHzfaZ8cJP+Y4RpsUi42karAdE1UcSEOKrHmLPY?=
 =?us-ascii?Q?iIQWUPpTI481+pN8cn3cE9jYtmvwzSBufLQLrkpWilAAqO/pIUgjqVYOod3K?=
 =?us-ascii?Q?hyn/YPXjivFsobi3+2SdorIct2WKguNSVdlbrZYhg7SAxxVY/UUjrfuhlGaV?=
 =?us-ascii?Q?KRSKqp+EpGxvbfbyLd0L6KGYx2/9SYKuuN1jORSrnV4kH6vpgyasvCokjBrv?=
 =?us-ascii?Q?HvRWW1hmudUrmy/8VVZh6Ynq7kctC3/AB1iUXCSJ4Wy3me8RXTmSM3MDfpfG?=
 =?us-ascii?Q?OhP3tUUGSW/qfXamtVi62507286EveXQzHTqqFMvcLZbCVjnyJJjqOXsHgng?=
 =?us-ascii?Q?5qRNZY0y9AsktofAJYcVFRgLaEOkXyWHPCvqXzPpHRSm+MWFzdwtpehqrqFx?=
 =?us-ascii?Q?w/pR1t89a2gFUJTeuv9MfaqkBqghCiuU3efHqNibCE6LNnFR9yssP2ZHAiot?=
 =?us-ascii?Q?b1SgS44iH4+2nkSny0xDjNNR9M8AJfXZ4eNtjEyW0pMLb705yHwSi2TP6aTp?=
 =?us-ascii?Q?zqKO97L1s56Op44NesP8RL7ZiYDRJE0/QHMqYxypbUj6EICvHUof?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8b044-ac7a-4283-f458-08de850bdf88
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:31:57.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPhE0tqNmUOcMV0kyK7gOdyeX9hs9h230SaKnEW520aZNqJ4kE/Hf8uDBrHRFyjy+RrdUByAouSir8ZFt535ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999105
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9532-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,samba.org,amazon.com,soleen.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: BBC4A2BF7D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:14:11AM +0200, Leon Romanovsky wrote:
> On Fri, Mar 13, 2026 at 02:14:49PM -0400, Yury Norov wrote:
> > On Fri, Mar 13, 2026 at 02:18:55PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> > > > Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> > > > to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> > > > ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> > > > 
> > > > The 32-bit behaviour is inconsistent with the function description, so it
> > > > needs to get fixed.
> > > > 
> > > > There are 9 individual users for the function in 6 different subsystems.
> > > > Some arches and drivers are 64-bit only:
> > > >  - arch/loongarch/kvm/intc/eiointc.c;
> > > >  - drivers/hv/mshv_vtl_main.c;
> > > >  - kernel/liveupdate/kexec_handover.c;
> > > > 
> > > > The others are:
> > > >  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> > > 
> > > So long as 32 bit works the same as 64 bit it is correct for ib
> > 
> > This is what the patch does, except that it doesn't account for the
> > word length. In you case, 'mask' is dma_addr_t, which is u32 or u64
> > depending ARCH_DMA_ADDR_T_64BIT.
> > 
> > This config is:
> > 
> >         config ARCH_DMA_ADDR_T_64BIT
> >                 def_bool 64BIT || PHYS_ADDR_T_64BIT
> > 
> > And PHYS_ADDR_T_64BIT is simply def_bool 64BIT. So, at least now
> > dma_addr_t simply follows unsigned long, and thus, the patch is
> > correct. But IDK what's the history behind this configurations.
> > 
> > Anyways, the patch aligns 32-bit count_trailing_zeros() with the
> > 64-bit one. If you OK with that, as you said, can you please send
> > an explicit ack?
> 
> I can do that, 32 bits architectures are rarely used in the IB world.
> 
> Thanks,
> Acked-by: Leon Romanovsky <leon@kernel.org>

Thanks, Leon. Seemingly no headwinds for the patch. Taking in in -next
for testing.

Thanks,
Yury

