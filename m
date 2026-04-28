Return-Path: <linux-hyperv+bounces-10421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNEnEGLk8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10421-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB0489408
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41EF830532DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E81331A56;
	Tue, 28 Apr 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckPiKeqc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3732ED27;
	Tue, 28 Apr 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393078; cv=fail; b=mSGutt3scDWXmEAbufpgC/Zzv/0wHYtldB7k3s4DhLBzPtWiQ9B1hbVBI2H6NMoUxz5DnEyu5eDBXLvpozcSbQSOrN1R2RIGyNkObMDAI+oUHYE3IrwtjfCofRp116Mltf+r9AAt6j59ILuAZqVVaQ6kIC2hmkRxZr2h8UVu0rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393078; c=relaxed/simple;
	bh=pA9nYoShjNCsXF0/dWpqj7GRsRHKThHrIZBTFyIyiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcFljk5FABdcgVBdqEPKTJ+TT7GGDfDXSHn7M/xdTk3wz8970iGHpxrhVIv4QYrckkqQ9toyxqBsUrXl4nwOCGr+y0d1k45AgCcB9+JZWqGUWVy9Jzb9BQC7p4vc1PEbY3rIbHP2JtPgEOQ7lQM3G3fvgqd54+XEr0fHo3vG96Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckPiKeqc; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqv/yD2JCMZcoIose9QrsmlAuACj91Qh6SynONMPbil2dQxRi5NFB8BkTsLkiycEQWikgRucDcRt7xqvDkQXYx6gxVvVOs0WkXfzPlQ9stufuF0l9DcVF89sLPsTBFUBeQfZxOjGaskaJcOdPq1AJYv8GaJEYIAnenb/KleMY4PXefxdZCPBbRYUD4kDYAused/+tfUBRTJtwvVmpGO1RnAR2GRsO0V9kTq90Otn/n8mSXRkJ5DLV+5rQPqLIGt9c/w1tuGOfNZMM+1c+lzor5r6pGIC45PaAx31TnZbf7zG1Blo9HgGVncRh8XN1V/2nrB6u7Akf3GY0RTFEBWl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc+FYkK2mXSU+6/gIeF2ZbOIY/dDKboSo9MjMubv6QU=;
 b=hreO3/FwG5tGzstuXANdI9x2qUxdDSQOfMBmnO1HjFqQwCR8Fjce1DasE5OQHjARJpzw8M7I1/GxPyCi2VBKjiu/ZNPwUPCdJDwZRbQbOuQr01/DVAr40N6wrSALm+DVe1+ee2XOEeWa30ZxgGFdJCJAg2q5YMIt7K8SGnJx5GsxR7Vmn5/h9XFV7SznfHoz06TB39GAWtZ/qG090iaSyq3G+NojC0uhrrgjwNs8f6cZyKIa8Zxpacwqf9vdJB5uH8MlFF9IwTq8ymh8oq6A78+KQHbyRPRjuj5krAb92QszgWX/nCFZz32PB9sOshOKtAjwHCA0y0V8fRaE35SMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc+FYkK2mXSU+6/gIeF2ZbOIY/dDKboSo9MjMubv6QU=;
 b=ckPiKeqc+G/cG61GZy++OXebqAePMlxFQfUDm4mIGj+NlX7a7n2DYsaASC4aWNr+EnPZI+vtNic0usjxrLO7uV2qtEr7j+0rDVfFoirtP9L3oig1qhBBE1mdg9iIlklA8390sAZF/+hGpl3+A2NKGI6bkwN1skeYRejbxgGVvSVLYGasOVffx2LfxAgX1ywF/Q0d8JrFDELfjWhWl4/3be08XTpOXotS7QqEraUboJJKI9WkA4ABNP3aOQUyXtjrEiOI3XgO/NXgyk6wctKaRGuGjoKI0lkTNd+z/f25Yo4TXTE/akxA/2CWy27YJoqk0wLpjwy2EaAUZegsQhCSOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 13/15] RDMA/hns: Fix xarray race in hns_roce_create_srq()
Date: Tue, 28 Apr 2026 13:17:46 -0300
Message-ID: <13-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1a86d8-8727-4487-c05a-08dea541b146
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	g4XXXwYjIVjcHrLFbhBc6e4VAov2jX7gqpkQR5IAsqKCoJ6MnNx27Y9m0LAF514E6BYwUcIsnoTzrbl1vvtmqPBND8s+DNyKjx1/4RmpcCmNVhPw3BvRnPRllOv6YgpWeNpQaZJLIrNVk836QGpz2fBgcUUJwQ+TRjfbXN5DX3ldnZRtbGo+09ZqrslhDMwCWxG0CrZEon0l7x3VhiGszfoUSqo/0+FYm4CL5XPdJDM7LQD6ltPTT9LsX/8eyw7OPGhF4D/cU+pE501nksSE6aZdpR5Ar5IpaGOurpUfCUo9C0PBm2skEjTW+n9unk9SN1iupjOoPz44T1p0W5uKce+B8qVo89PdtTxct/fukc14xYaYXANMhJtsBzw6qZo/CuTG8yxddyT5NYAVdbplE/eSh9SedZ9VhLY3XKGqFK04IwvryFZJhTfHLqsODzjPgRKOKt9mrvTBGwl5r0BT5DpYKsOk7Qn+his7fwqpi768EmLWjf4bVVXRM8mV8L1HDckefPtn8BNTJF3qdYnF0dZJfzxYbWe+pHgUQnDiC2WNzHdtmpebbTd+PdzcApGW7aJ3yrnz2CPsbGa/Jh9G6oao+LLQIF+TVTvJgFf393ZdImCRDt53RlLNcg1F40NJ1DJR6LF73cpUQ8gjpeQjL4/UCt0+Zn74/EmDFN31GHzXyslAcCdZb0pb2+gP/1g9DzuGS5SBLNtUUK81Tdt+GvnGjCRaYV+JXbZFOMWx5AgnxSDwfixz/Y8LHV6oYhAEEaSl6EYffTNeMOTv0gP6cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OE2IG2Xbhrsxv2RxEO4VDkknm/TLy0pB0KvChI4vLy3SYN/Hh1/mR2a4eq9q?=
 =?us-ascii?Q?tbZRw8yiT8gAU9KqXL4tjV+QwjN4zOCqRRJkRqhHryAf8K+Yw/PhR0dmXha8?=
 =?us-ascii?Q?slzwT2qG1o1LhXl2g09XRrnOhSDapotFPaGYGsKHBvJgo7Mo87OBMhL9dqND?=
 =?us-ascii?Q?PwH4uu8VwoO/iHqqOUljk2YJrCFJrmH0hUF/m3La6MPQ+N35mz58LLlAuxIy?=
 =?us-ascii?Q?nbg+8vFIrfgjRy6N/KszTudjaWisQl1H30OJnlqEIE1/u2zj+5Nj3r/eyZw8?=
 =?us-ascii?Q?GQvIlAmj0FjY/8slJfqcQPkbWMh7cDuPr36JUDyl2hrGRh8oZORLTojmZu5L?=
 =?us-ascii?Q?4kl9bKpSIROe4+SES6bhD6n+7nITwAStX0LvRXHi8niHzlJ3hNiiIMkOgDwq?=
 =?us-ascii?Q?Q6PZsQPmaxqCSMHN6sD5YYiNjUAcQd7v88vXVFyCzueUHN9MvhI5TK6dqDOf?=
 =?us-ascii?Q?liALVAU+YrYgl6eZPYz/kh3ixhKKM10CHAtsPd5wy8JSDkZRqVbu3zc45Oii?=
 =?us-ascii?Q?rqVFMiGxRFOnHcnS4eB4e0yjFyE8aKNB80xNJUZw/otykK/U+ppFHgt427Yz?=
 =?us-ascii?Q?FuEfHxajmlSUHi2mxQT3B/l8TLuUeyyQtVDc/P9u9nJ00f74JELEA/wBPwru?=
 =?us-ascii?Q?1RxTojepfB2p94YsVeENh4SOF76kLRvPWqJHU0ZRbjpOfPjfPK+mMEo2VGdG?=
 =?us-ascii?Q?uRGl7JivlcKaAsCMfz7VTkl+6+fcoLjlwXx+FezW35xOi2tCNzbmOcPGYEdf?=
 =?us-ascii?Q?csqvATsuLm1sfI9lRTBtVrc6OfPm1wZ8y+1drgIIfk6h/nvh7xltjJq8zWd2?=
 =?us-ascii?Q?bz1RVZ8vntBNN32TravReGTiFVCtC1Ej6vkL5tbYBCXw8GmnGlzJpgZPz3sx?=
 =?us-ascii?Q?RJg9w1H2tJvgEWblAJ2jdmUsy3xGB/6vr1RHQXUEEiuxVU6LcRzpeTDLO9dW?=
 =?us-ascii?Q?z4P5I7CXHkQldYOZbRLLvniyPj9LN7ZizPRC0YGBp5HtDWV175hZyg2ngmQo?=
 =?us-ascii?Q?6vFsOm/kL3ort8j3A+/w/+rzviCe6Vs70iBq/Rjd0CpsM3TcI6zjokFa2Sry?=
 =?us-ascii?Q?hMk8Gte4Srg5S8jJG0LWcoUgmRB+mvqZHK1j5xPNeYLWTs6ymHb11xPSID+u?=
 =?us-ascii?Q?oo6Lek2p/L3j/qmORH8EdeErxe3sDqGsFAA0j0v7ruEBFTkUZ3sMA8EEQOW8?=
 =?us-ascii?Q?8PRwvBPvB+Q6aTTb4R7NrUpj6RK7kWGfXISo9U36yFjZM6CAlGun0Ewu25jY?=
 =?us-ascii?Q?0qKX91yh4i0iIzeeMYZD302YGMStDPM7aAKYmH0zt5K1iZ2nXrUxLzYqv0wn?=
 =?us-ascii?Q?iiVYppYR7nSxvnNQCtwNuVaQaD3L2WHgVlaHCrMXZbnc9gyeJad49rp0djRB?=
 =?us-ascii?Q?BBO7Wb8COsUxHH9T8tS0fPfcPFcvjMKtJsSSEj0Qzxj1racsm/VXo9ijk1BE?=
 =?us-ascii?Q?6V4wpU+Od6OtqLk1iHX6wU4/KJZmu1Itrw8sgpxyWlfJAC0T+qs7GtT4AjkX?=
 =?us-ascii?Q?HH/WPcaCUQ1mvzwGhRZm79ZMrhBGOy7VwwNCRsnphvaJrG8pGJyVrSSj+rbo?=
 =?us-ascii?Q?ZDswkrtfZS4AjDZQ0IL/NqQ93WYwo+xZ+Vozksf/dHeNBmhOV3f0xDSDFXbb?=
 =?us-ascii?Q?LYl17ao734veAv+fNu4/jospuT9xAduleUI2oWpXDg3loK9xTBJerpyuLhbt?=
 =?us-ascii?Q?W3dZwAF5XjCPbUzk0xYfzP1nhLGz4RlgVLmKpsVwWmEil5QG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1a86d8-8727-4487-c05a-08dea541b146
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:50.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjKaA/yjYmASzgCjgH98TJBBKvuHqtmLuYPShxnfe1GXUNgK1HUeApizLhlZbee9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: AAFB0489408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10421-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]

Sashiko points out that once the srq memory is stored into the xarray by
alloc_srqc() it can immediately be looked up by:

	xa_lock(&srq_table->xa);
	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
	if (srq)
		refcount_inc(&srq->refcount);
	xa_unlock(&srq_table->xa);

Which will fail refcount debug because the refcount is 0 and then crash:

	srq->event(srq, event_type);

Because event is NULL.

Use refcount_inc_not_zero() instead to ensure a partially prepared srq is
never retrieved from the event handler and fix the ordering of the
initialization so refcount becomes 1 only after it is fully ready.

All the initialization must be done before calling free_srqc() since it
depends on the completion and refcount.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=3
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index cb848e8e6bbd76..8b94cbdfa54dfa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -16,8 +16,8 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 
 	xa_lock(&srq_table->xa);
 	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
-	if (srq)
-		refcount_inc(&srq->refcount);
+	if (srq && !refcount_inc_not_zero(&srq->refcount))
+		srq = NULL;
 	xa_unlock(&srq_table->xa);
 
 	if (!srq) {
@@ -470,6 +470,10 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (ret)
 		goto err_srqn;
 
+	srq->event = hns_roce_ib_srq_event;
+	init_completion(&srq->free);
+	refcount_set_release(&srq->refcount, 1);
+
 	if (udata) {
 		resp.cap_flags = srq->cap_flags;
 		resp.srqn = srq->srqn;
@@ -480,10 +484,6 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 		}
 	}
 
-	srq->event = hns_roce_ib_srq_event;
-	refcount_set(&srq->refcount, 1);
-	init_completion(&srq->free);
-
 	return 0;
 
 err_srqc:
-- 
2.43.0


