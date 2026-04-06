Return-Path: <linux-hyperv+bounces-10022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E6UHivw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10022-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:40:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D33A5C17
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 167A8300B455
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B07392C5F;
	Mon,  6 Apr 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ib+L63Jd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FD3932C8;
	Mon,  6 Apr 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497254; cv=fail; b=S9s9D8kugyHsaEES9A0Iz1GzlG3mNPgb/qiCmZ4zHOz1X6+nbhDoSpwZi8+UyO4LoulJdpMSfVTMqtnzc076p8vDSPL8OyeBzktpfPaL6wNlsObPMVrkaxYkP63ViL3MVa0xcKGpGQQ8tVH33vq+5UPVt2gYJ+McuZqr4EcOYxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497254; c=relaxed/simple;
	bh=DcpFoph678rvKpfrtgK/z++5HCITSqdCMoAksbppib8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onMJyiQnt/gLLEuwss6astq9Rau5+jRW6pCGvqJVJCWkaGtpa2CWMw9/o2jIQU2v51huJ9rNWiFojE0C1uBJWqSaftJ6NDZmr7VOyYO1i6NNHtSNiDIspIRCR9KgL6h23jweP2iW7xvHcY//x+7fn5lET9p/1QEZD+c3MAUJubY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ib+L63Jd; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NykEUVV8b9aGrXmFVS54lpMnxPN4hSPhNzAbx2RSw0Ju296G5NTf6j6TeDs0GKpRepdkcKRmhOhM/Adhfn4UT/CYhgUrfOrmK1jUyjrk+Z1dAZyLfxHvx7N82Dd+7FE/H27NzSXmGbX2IuGDqO07ZFTey3lGuDWkOwJu3JaqrI+w36oEAyQHJ/H7iBxt7dp31k9Z7ZAISjFHs1d2kLwi5rCDflq28qmW70sjPfSiaeoCyF+5OVkJZL0klZsCfZfAuP5gBLNIUMqxNVI3KPKv+zJTI0LWHshCOlZxgAFo9KfsGkRvmPcplYRbq2InliUveebSVZbu8/31jI+88jt6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTWl1RT47avgUmOLx133rPATpfbwgEw1EuWjnfKaKbk=;
 b=dXWnVm/Xxbs49vcX46P90DGAVs0Ax9OcQPMF5EK09GibTG0LOGk1UilZ7nNH6nHUNQLpyQxlhroCW3vMz3juI90DHmIP8a4SoTZmkAsqs9OF2HVAVQk5gvmjrCEbcaked3S5EMSkqfnIyzTSYYCG6BfUcasLibdrwS3HvlvsYjpUdjyUQRDCAFrdJjAMTD0NZuAfhdNTxPlRUGP91eRlVdrrpPvF7VUVgwWdE2jHDQCX84PG3s5YHNF5g1/WVPd71+WY5ULZ5+ZoqaZzO9960mzXtiOPB6mbDqSU3BsfaoS5LwtIuL9IM8oYyzfjfJsqQTQ1wqkFU56cWe6Srmw6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTWl1RT47avgUmOLx133rPATpfbwgEw1EuWjnfKaKbk=;
 b=ib+L63JdsP4Pt1ZWuweRl7I0emp7EqLQgOEPSXgijHUftG8s6dEIJN1/iK179d0+qAJHX1YnWc0o4EzSilncNVG/KgGiOUAfKjqIi3nXZjCsTGpL9p4kQ+Ha9Yx/lkX3mwyi6Yar10cPs3Ipy6U4GWuZaN8Ggh1dhHY+te/uufmIaJ3QPZpOFx107f9Q0KEI8jjz5qQ4lKYoSJC8yP91a7AIH8/dNcJVwp4kQxOeIn8ECb+/TnMIohA6hCdo982kqw83RzH2Vn5otRzfNq+BiVBNnQ816O28Jjq+uk2J54nvGhlNfE1V3AVFGdgK/+z8Ps2ABwu6PLYcFeMparSsCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:43 +0000
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
Subject: [PATCH v2 06/16] RDMA/hns: Fix xarray race in hns_roce_create_srq()
Date: Mon,  6 Apr 2026 14:40:31 -0300
Message-ID: <6-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: d435533d-4c10-4e67-e946-08de9403a058
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	v8wBGpbY7BLKfwkLj+wyTVnT7Jzt5NJ5IxqwwiOVT9axOja0jCsVHeFeXvqyw+DsKefjK1Xj0hIKQE4kZPuBQqH3seQrFd3wy6crZgJv1XcxGlEN4n91dgU1haC6WC0lWn599VL37pU/5vRm3p1qDvV/77Iktdm2TVKku04+TbdAMmJ+Moxkw2UTZQoE2tRgw7raGb6NNkqN+rH8k1BYRiYXykmj+fjeYc8POVO6H2eWVt7We+7CPXxv/MoewuMZZPjS9GO7xYTevJU+wtSUitVFaYM1Z+oEnOUx4NAZxEzXL3HADcjf2rcfCFscbGDpckAAMnpADYPtSoFoSARTT6EHKu+bxAHs9PSH7Bk6gAmXy2wpgGKlEO8wg9K4I4JnswUWyhJTmTT2kumWE+VDUmGt+B+RTZD0SywMnFCoPANCQR/VgqB5Zpsw7K2sA1TjdljbxOjhKSJ0P2pst9J16RebUJoMBcfkMzuGFSW+pNwsx36fLdn8khLhUQ6EzaEDHcNPrhotskrWUnnrdFUVVkMcLyyGk64tZsg/ysx41e1qZLrgO89TbXZNxCuyKAfV6bCkhoQvtrk/m4siUExkfNOeGF/kzBVxrubk/vGeSLdpBwsWvH7LinPdLzFoznu7CCMqZ5/dO4kvWtYwMP2KSbgZIELKSy8CueF4eLYCL62HRf8SwWN8KTbgjsPiF2oypPr7lOQ6gfspghVA8IMUJkxqSStesGVZxTFX9Ztlt5x0cuyCn/G+jeosqGLP336W+3Zm20+Kd7fJziaQcGfkYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KF8FXqaLZA+JTtC6Sf64NhgnkcFTKF4J0tquTBQvD4P/Cw0TnvKDoI/ZUGTD?=
 =?us-ascii?Q?GQ+5cCB27BgcMF5U4G7C8S20JKEb86eCsj0ccKVqjtB1ozaPfjaLjH/BQ3es?=
 =?us-ascii?Q?H9rw3HlSZ1cq53XflW5ERZlNrBITOHJgT9yXB+C2vwVkvfDjpoKLC/9vRhz1?=
 =?us-ascii?Q?BhjHad5tlPTcLubd+t6mRl26FIP4PqCIocQswrk+ennNPAsFvTA6hdjEpINT?=
 =?us-ascii?Q?jR1QJRs8sP/kuj94VFay0kcDbL/PSYKt/xae6P+js/2lkvuhmngZpjJwTf2P?=
 =?us-ascii?Q?DNFZuLBkEP70yXLLbqhI0j0DZQ0i8BZWQBwTd2wWo3l6elagbrC59OnUOL9n?=
 =?us-ascii?Q?vefWRwNKaVqyoOE6W+mSV47Rc+wWJojlaqS6XxAG77FJETwCPif+kfUbF8At?=
 =?us-ascii?Q?hce+wJFZhgMqXprC7f4P+OR6XpnbbxzUDZ4UbezsR3Gsgw0ozIAtjiO4vj2L?=
 =?us-ascii?Q?wK/tlzdTJbUlPEYM56iPcgaC1kQCfRSItxoJkdnDPXzLoL3vknv8OBz6llZ7?=
 =?us-ascii?Q?eQLlNl1v8fntrIm09r9kfjz9zxaROLQnoMDsNHV5HlIO/v9K/RQZhBmbxEL/?=
 =?us-ascii?Q?MsnfI9pgBtf6o1o3r2nL2vwcwQRUAMlVoFaqGxYn/1/J6O7UKPUgEgRKsu6D?=
 =?us-ascii?Q?9utB9YCHFp5pOphFVVXk7loRYtyj4VB7mUbwntJORdFBaOyUcIHfws0vTj6s?=
 =?us-ascii?Q?a+WsO8y8tEVPDpy0CvF+UeEofs3bvgcyLykr/Shy6L8EWoq3Hmi2PVCARaga?=
 =?us-ascii?Q?s14C00aXifiSUD5jTACB78cUQLpr9swG8MWiqtdXXCAGgyoH85spNc6DB5oc?=
 =?us-ascii?Q?ByLKOoR3qzWavBy4ciDb+qay1r+Hwb/Md4ldLoKGG0IclivkwRfjBiSPwgTf?=
 =?us-ascii?Q?y/clffkqjo5duJ+dBGTB1/uLhIKHolzhsDrZ3xtejA6Te0CsVPKPQUpXh8hp?=
 =?us-ascii?Q?ufaG41E0QMtAuCYfHBt57kC7FjL2ScSJskblP73AZJv7Cr2cdq3S+XjqJjwP?=
 =?us-ascii?Q?PACzDUKVKKdnUhGftxPnL/DaU07TeKKZt7chWMVFmsQGkaGhckq1kjUfc1zd?=
 =?us-ascii?Q?ztvd7p15tpHLzs9v6stc7Ok+QkzZnOjyOEMdswvae3vPU2XR1VLvxQOlfIzI?=
 =?us-ascii?Q?A5LzcxelsqpYsWdbyWxN1zi9J4vPTyKpWk/kzVmTlZh2CpCSZd0blV789Q6Z?=
 =?us-ascii?Q?zzvsoxIsAfDCR0pTh2VM2rdJZ+o+ylrSsDiWcYYV/tw0auKPZd4IappN85Cd?=
 =?us-ascii?Q?7gw3A2kzK+PjCLrYjpbrhEsW52tnjSMrL/QlxcOinN8mMkX9ekwRPtFrCBxf?=
 =?us-ascii?Q?iI+dTq0T8bUvUS9xY7WLj0NtkQWJABNH6soq51RJhES41Z5JHbEjL3XIrUtH?=
 =?us-ascii?Q?7b547i+pKAjXBNpoAD+Pd3tpEv2IMLJ6rjNU5oOXtUcsMBqtF4K4zQ6GqtWE?=
 =?us-ascii?Q?vBfYNSC4CGoO5nKpVX4Va5OkdGOmL5nFuKCXE/z9Y65Ej0WHd96rYnwFJD/y?=
 =?us-ascii?Q?mI9nrnm34Cn9sbJ6ELWJKE/iPaeQFktYE57n+xkaA/iTK36PB21bcJ3F792f?=
 =?us-ascii?Q?KEl6e8v8yVEocwzhk6k4TXMkAtAlUaN7QDsUSfmcwECojUuU8G4fOCicOOMG?=
 =?us-ascii?Q?DYV8ZLYloXfsJN+inylPSdiBHLYVvqNkLOsCK+IvFnxxTGvOfA1bb81Pi2RR?=
 =?us-ascii?Q?WBKJxmLZGpKdbD9YAgWR79app7EL17YwbD3NelmAz1j9j9LK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d435533d-4c10-4e67-e946-08de9403a058
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:43.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /95hfMd0uWSlQF+df8jiEbWNVIZc14TIsQ6onUk4SjsqBzm/g7TLKHaOhOuiv94O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10022-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 2D5D33A5C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=3
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index cb848e8e6bbd76..d6201ddde0292a 100644
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
@@ -481,8 +481,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	}
 
 	srq->event = hns_roce_ib_srq_event;
-	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
+	refcount_set(&srq->refcount, 1);
 
 	return 0;
 
-- 
2.43.0


