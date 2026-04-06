Return-Path: <linux-hyperv+bounces-10036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGIXEJLw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10036-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F25843A5D60
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94677302FEB7
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B998392C34;
	Mon,  6 Apr 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IKfdQJ+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0483932F6;
	Mon,  6 Apr 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497266; cv=fail; b=PEh6Fq3fEvfMnJmqdSzeOee3pKFsYQGWgEe8JTWv1JQIfH48Vot5CBmWECb7HdgC57Yk5nZAns7IunKW7o9rW7lcyMu9Ra2tFGqQiOpX5p29mehjr24meIgsZntwgzuqYsw6pjJ8L1kF9LlKAha9cQIOMKxpHf9bGPibeHer0nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497266; c=relaxed/simple;
	bh=DchDDj6Wk89RTdSccEstGY1SwKHVStqk6Pq6P8llGcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tu6+qCAQsv5dZcuUiCtUynr8ldUZAtvN4RG7+yeVnT/ow/Dk2nfFnA39VdDB9lm9AfI8HWxTZ9i/xJXqa2BkfXqRo6uvdjXHE6+Ua6D17nELbn84xslsuIUA/IV1wnB5qe94dZWfnLLUb7SXJ1Cb6uTE1Is+SAArCXUSyR4wBw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IKfdQJ+2; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7+ViZlgfwUykL8zU73Wy9hCOjzGzVO+XdKR0hHfEPFEYPtUWwP66IAtQKXQLh6xb/fyPHgCFQRuYZvb0FGouB8VSHFF6X4ZPCeOODBuzibtd9+2d9aQnFucM37Pd4aQyBdNLlgAHdlKxN0nbFPWk++FLsQmFQFqYTGBtkAJ4Pr0n26Pn2915fV+Y8JoRRNC1CTQFqmK5cFQYD6aLxzwTuHTGr+UKqzjPpGUeX9mV2vKO/Q60iGFUdGdvcalVuN3lc0S9SvpvtXQYZXGzKFXvHUq8bvsK59G1YOaPRvFfz6sgn00P75SinVgQ1zuSoZ+mHlwtf/sf3hg0qY2MHxaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBPE76Jd7GCkqbZZ02TH8kdJJCOMj2wyKwRvgON2uTo=;
 b=RaP0OuNDPUmX7WuJuQ2lI7aRq/TM+UUfZ/8FuaGLLRkCl+dmxuchguxC1QYXmDi0Z3/uwmBwCKsty5YGRHnhxPNlEJmvqbA7GqM+rRgEhgMqbuEplVn0eBuuIvkAgsPzej+SWAKHcTR8kh14veX/59lAT7hkcJ5qcqi42XQmlV7ohRUOmWkZwrG8Ad3uvxGF6DZVkG59K2eMuiUdgGkMRdOHvVuFrSFGNo1rWBrkueN+gRjBZicEnJS+xSVbD6AxuIJqHagUKnWzuP8mJSKqHR9gDvBdbRbn/FGHSiftkx70Hs/3wj8ZW+zuOS6lW516TQa7HdkwEW/pdyQgfWRe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBPE76Jd7GCkqbZZ02TH8kdJJCOMj2wyKwRvgON2uTo=;
 b=IKfdQJ+23dKKyAlvAL2yaIQvuPam2soMG1OB4UenHKZlEbiFd+/rRj2hMqM4aepyGT8d9SJ9w7rHYiNeoInkI0NuTiHma+5KUguL1zTxEs0hZYPek6T7HdFmiL/TqU1Bfr/fovlkikgTOQGj0AKOLjs+mmddewV+qPbhYmCgDmRyfDoGffUPNRV5zXVYzXFOq8yMtWecqUbFnPNoBDWFq4MJHhzttdT3lldoXMJ57G46rs/Tgt5Ot6DzAXQMLsrwpMaIvpY0us4OnUfrffTfMxqeds5kBKmUYfNw5UB4r2cLlvX6sTv+vvxcSBWPG9Tc3kIgRaQZZ4R9wefjdKQ6Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 16/16] RDMA: Replace memset with = {} pattern for ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:41 -0300
Message-ID: <16-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: fa532403-1a54-497e-af73-08de9403a301
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	D4uDF7ws2DEHR3kreIpbGzU0qPy9fyF6m2iMMqu340xD78L1P7CbpLWh/R6mwTXuDGr8JV6/6kVLdW/cOO7quarcWDa/lfzH+0nkZPTvGHBp3KZj7kYrzr5eC+eB+dUXN47dEJSFrsBu5E9Gk7Lo5BdenvkxqvxTGF2XVrLmX8dsFyiAaBS+7kfAkieG9nn9VaUKv7iuifL5H6Fimg3h9Vc3x0pLMEQfr0wDLOxuyPDj4xVClDb2cB+cJk0VTrPhJBLIGusih4HEWg2nxqzGz6VrhS8yI8vX0RiDurMmA60iRqfcI5RpYkIF3c/qL7ko/B+dW8SLBVB8Y8jBkuWXXkxV0HjxDTgWYwXJNjS+9AyJXT0TYwgtK16VGBG2Vwm7HZXOV6M2NsZcxjKq93B6OIJGrbUdhRXr1FpuE6h3yxe2HqdOaH4/ahIpbmy6vtGRApcfQXVEng/W2ivnRijeH9O+FAGZcLq4ZDkXM+K+ADriitzKXpk2y2mLXbr4s7QnPn14xQQEAR9rbEWmVjH+KCirpl9iy3iBfzss0ooPnRfl9tz691dfsqtXbIfb6KR5lNPeaOnaBZ+qGVj+uXVQYM7GwNZEue3T48/RaZusoy0fHxiScpF/kChYH5kXsbfbOVJyii9Rl44vLWW8MybDAP8tptbWAKmv1kmcwq6zZal8gBDXcr1wp8HlDe+e1rHEWuiwlXVE9lUbfuEkJ1yc44Es2D3bYaNq7HXoJKJ6iwu3DTqXNgY5JTexU8fJYbxeq9XXHO4x08JQyfeQe8cq2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLm2ZYrz5zgR+AypB05aVulHho2GNObLGLyRPbgMlulQbbvrBd3l/UU2Vg/Y?=
 =?us-ascii?Q?Jsyi8OqLD4DqC+BxmsomgsYZNswczmqq+FMJawuT748zd3omKBUb0kanrOqB?=
 =?us-ascii?Q?FezV6CFr4KLUFblTmDEkmnd63QZnl4m7e0a0vMu96/lBxfQ+uoCNp3HwqZuD?=
 =?us-ascii?Q?23kyNkXMsL1hIQi6K6kb0iHZcgaKiKKsblvvBI96cMU8JVg3S7hBfjb1xKP3?=
 =?us-ascii?Q?2xzqiy5M+NiIPs2oYEQ7ZLfjDsNzuBgrufbBTAm65wq5qoAi2HTHfNhjH82A?=
 =?us-ascii?Q?tFv0JFaG7KHVSIgFQTH4swGbEKsFiWOfpYpUbtvz6MubROpIP56i7eU9eSMg?=
 =?us-ascii?Q?eTowxDnb4ZtigdNllIPrM7SbqLIs+046zPr/pVSjPVrfsiApbzU2u6Kbr1WO?=
 =?us-ascii?Q?OwchBXHQEBaZoNas65+yHcsFd7x2q4xcPCRUUpnXQTKc61GXPbNgQ1RwIDnv?=
 =?us-ascii?Q?vEJwfFAkdW8WSbYSZf1/uxKh9XkiTIUbxOAC8gHxdlYBKoIRWhNaE81dRsZ+?=
 =?us-ascii?Q?Scw/Oq5j21mHJq6yuBhKPbFaDvH1uEXFZvNjhCMcCqc6WuJOfVxRuPFxJy8j?=
 =?us-ascii?Q?tsVPuiwH0yNhwIoCPvB65oLwXksKy1eLBO/gF+rPaviPg9ll/GCFqAZJ4jS/?=
 =?us-ascii?Q?K6ru5fEJ5MubOYwIlfzjuJEMMQStngKOuN52cQXUAb9AH8+pacnfV56h8Psy?=
 =?us-ascii?Q?bB7fx9YkR1pofVa7H7PLqlaFpoFGg0NgswZcNDr9kY2zwtAwAoq4n6zDva3N?=
 =?us-ascii?Q?F0GNUuy6YEw5rHN7WSDcIVp230QfFKGmkaayglKuNRHNAYdn88tQiJewbycf?=
 =?us-ascii?Q?SsWenf5mRuJKyTWgZFHFWg1/raiC7p/40Rf+EERDuirECcC27wGXFP7erYx3?=
 =?us-ascii?Q?KafjuO0/KhlaTutZERV8Pr84qxyhyEYYC7HNv63VbwredY1gzGZV2Mg2fjlp?=
 =?us-ascii?Q?mB5+NvSyRBvoG3W7mPykbaxkonMvYhkc/vn1M0axsrIyd0Vcq8luc18ARfa+?=
 =?us-ascii?Q?IhfoNaSpWWHt7JoAyoH3CYeMOUGmAwrFN/1Jhw5T2ARx9ruyyRQ3ZTUBqjyN?=
 =?us-ascii?Q?A/dICG57rP8uq3DSGxn173JWEN+AVXPcqlxXtNnZLg1ylzz1/mMnNFcTE8vW?=
 =?us-ascii?Q?HT30pwhffHhk/+OqzeFXLPJinmUGDQw6V9MRgubUAPV3tdLUOtmFLMF07xDJ?=
 =?us-ascii?Q?4wCSmmZDBtRebAMOXFqguc+Gbwzt1BEiujRBh4KX2+XTqdq9ExQQICgvvncK?=
 =?us-ascii?Q?Bk6ZHhr09e4MHftVKXkcwc9Pod3SLN2NK4+jzG+xpLYlqg+aL7RPH5ZbKQu9?=
 =?us-ascii?Q?ep3IWTbNKCPEs7RHQuQ0xOt6rQGBUPvugtPcEmXuszhs2eHSWzlqyBt5r6by?=
 =?us-ascii?Q?Twu53+1eM2N6pTWseOrMOfCkC5ymODiXwGKtcmd1Rxd1+oXFd/c7pm4DZ2Jb?=
 =?us-ascii?Q?XLzGfcqjvkcKbQZWrBIL7hTR1Bi1gbTr/jgHEZDa5EX7FmJHheqwKjm5CAci?=
 =?us-ascii?Q?FBvTTN32l2hHbql5+S7nX1E2cSbsnDubIJwKabXp1lOUNJymZrmqbB/9VJ0i?=
 =?us-ascii?Q?jrdsadw6lbV21qdmCfEQ7QM88NcglWVVV3lhDht9F5vUnsatvtOotenf6Nh+?=
 =?us-ascii?Q?OWJiyxKvojtWpHSvLmcBCxIF7lvxMuBsRaGBcviUuDbEkc/Igh9/uItXT/1I?=
 =?us-ascii?Q?NMJGMsvFHKpcLID3HM6+5ne3brEf3PWd59AES3xUlCY3WMdJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa532403-1a54-497e-af73-08de9403a301
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:47.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HRe1Dp/zaOcY3Km2CY2EGpMqEOAgPZaOHbqRka9Il+c+Ih7CmjCeT+PEZFiZHfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10036-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: F25843A5D60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most drivers do this already, but some open-code a memset. Switch
all instances found. qedr_copy_qp_uresp() is already called with
zeroed memory so that memset is redundant.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c             |  3 +--
 drivers/infiniband/hw/cxgb4/qp.c             |  6 ++----
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  4 +---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 ++++--------
 drivers/infiniband/hw/qedr/verbs.c           |  6 +-----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  4 +---
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 47508df4cec023..d1517f2560b981 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1004,7 +1004,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct c4iw_dev *rhp = to_c4iw_dev(ibcq->device);
 	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct c4iw_create_cq ucmd;
-	struct c4iw_create_cq_resp uresp;
+	struct c4iw_create_cq_resp uresp = {};
 	int ret, wr_len;
 	size_t memsize, hwentries;
 	struct c4iw_mm_entry *mm, *mm2;
@@ -1102,7 +1102,6 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (!mm2)
 			goto err_free_mm;
 
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.qid_mask = rhp->rdev.cqmask;
 		uresp.cqid = chp->cq.cqid;
 		uresp.size = chp->cq.size;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index f9c7030ac6bfd0..e295f79e0cd3e5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2120,7 +2120,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 	struct c4iw_pd *php;
 	struct c4iw_cq *schp;
 	struct c4iw_cq *rchp;
-	struct c4iw_create_qp_resp uresp;
+	struct c4iw_create_qp_resp uresp = {};
 	unsigned int sqsize, rqsize = 0;
 	struct c4iw_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct c4iw_ucontext, ibucontext);
@@ -2242,7 +2242,6 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 				goto err_free_sq_db_key;
 			}
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		if (t4_sq_onchip(&qhp->wq.sq)) {
 			ma_sync_key_mm = kmalloc_obj(*ma_sync_key_mm);
 			if (!ma_sync_key_mm) {
@@ -2686,7 +2685,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	struct c4iw_dev *rhp;
 	struct c4iw_srq *srq = to_c4iw_srq(ib_srq);
 	struct c4iw_pd *php;
-	struct c4iw_create_srq_resp uresp;
+	struct c4iw_create_srq_resp uresp = {};
 	struct c4iw_ucontext *ucontext;
 	struct c4iw_mm_entry *srq_key_mm, *srq_db_key_mm;
 	int rqsize;
@@ -2764,7 +2763,6 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 			ret = -ENOMEM;
 			goto err_free_srq_key_mm;
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.flags = srq->flags;
 		uresp.qid_mask = rhp->rdev.qpmask;
 		uresp.srqid = srq->wq.qid;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index c8a35337ba51e8..b59c2e3a5306d1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -996,7 +996,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
 	struct erdma_ureq_create_qp ureq;
-	struct erdma_uresp_create_qp uresp;
+	struct erdma_uresp_create_qp uresp = {};
 	void *old_entry;
 	int ret = 0;
 
@@ -1048,8 +1048,6 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_xa;
 
-		memset(&uresp, 0, sizeof(uresp));
-
 		uresp.num_sqe = qp->attrs.sq_size;
 		uresp.num_rqe = qp->attrs.rq_size;
 		uresp.qp_id = QP_ID(qp);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 2a174d0fe6ca1e..383f1d9c15d151 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -586,11 +586,10 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 	u64 db_page_addr;
 	u64 dpp_page_addr = 0;
 	u32 db_page_size;
-	struct ocrdma_alloc_pd_uresp rsp;
+	struct ocrdma_alloc_pd_uresp rsp = {};
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
 
-	memset(&rsp, 0, sizeof(rsp));
 	rsp.id = pd->id;
 	rsp.dpp_enabled = pd->dpp_enabled;
 	db_page_addr = ocrdma_get_db_addr(dev, pd->id);
@@ -930,13 +929,12 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	int status;
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
-	struct ocrdma_create_cq_uresp uresp;
+	struct ocrdma_create_cq_uresp uresp = {};
 
 	/* this must be user flow! */
 	if (!udata)
 		return -EINVAL;
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.cq_id = cq->id;
 	uresp.page_size = PAGE_ALIGN(cq->len);
 	uresp.num_pages = 1;
@@ -1173,11 +1171,10 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 {
 	int status;
 	u64 usr_db;
-	struct ocrdma_create_qp_uresp uresp;
+	struct ocrdma_create_qp_uresp uresp = {};
 	struct ocrdma_pd *pd = qp->pd;
 	struct ocrdma_dev *dev = get_ocrdma_dev(pd->ibpd.device);
 
-	memset(&uresp, 0, sizeof(uresp));
 	usr_db = dev->nic_info.unmapped_db +
 			(pd->id * dev->nic_info.db_page_size);
 	uresp.qp_id = qp->id;
@@ -1730,9 +1727,8 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 				struct ib_udata *udata)
 {
 	int status;
-	struct ocrdma_create_srq_uresp uresp;
+	struct ocrdma_create_srq_uresp uresp = {};
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.rq_dbid = srq->rq.dbid;
 	uresp.num_rq_pages = 1;
 	uresp.rq_page_addr[0] = virt_to_phys(srq->rq.va);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 79190c5b8b50b0..1af908275ca729 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -690,9 +690,7 @@ static void qedr_db_recovery_del(struct qedr_dev *dev,
 static int qedr_copy_cq_uresp(struct qedr_cq *cq, struct ib_udata *udata,
 			      u32 db_offset)
 {
-	struct qedr_create_cq_uresp uresp;
-
-	memset(&uresp, 0, sizeof(uresp));
+	struct qedr_create_cq_uresp uresp = {};
 
 	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
@@ -1283,8 +1281,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	memset(uresp, 0, sizeof(*uresp));
-
 	if (qedr_qp_has_sq(qp))
 		qedr_copy_sq_uresp(dev, uresp, qp);
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index e887f03a84d063..261f18a8368543 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,15 +82,13 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_create_qp_resp resp;
+	struct usnic_ib_create_qp_resp resp = {};
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
 	struct usnic_vnic_res_chunk *chunk;
 	struct usnic_ib_qp_grp_flow *default_flow;
 	int i, err;
 
-	memset(&resp, 0, sizeof(resp));
-
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
-- 
2.43.0


