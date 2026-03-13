Return-Path: <linux-hyperv+bounces-9404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMvBFZM8tGmDjQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9404-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:34:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB7287154
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F473016EDD
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF135B644;
	Fri, 13 Mar 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KI5bduDr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0893241665;
	Fri, 13 Mar 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419509; cv=fail; b=q+Hj/WyJXQnYqlgdaj6W/rch0Cr319B8cQrGtwuzy72gUdEOeTtS0LLgZY+PZnqyRgPFGIJ+h2KqWMpHyrY+j+YC7ZPiHocMbvEfkqiKv1vpBenAr04cynF/06V3+UjXj0QDh0SO5bQR1Pw10Tvn9TRtxYxSaJmfgeThwZLm1mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419509; c=relaxed/simple;
	bh=gQYhMqC0gbCrL8YQFTjFd+Ehcbx8GspxKug2AAEAkqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYzVHKt1UmYsbk8why2AD4S5gfmzCuijbFeSargpx46FPZySsHvmAhDUccMC6C3NyWfO5BTvyK51uBozwL5aai1rPlcHffyH8DQeiq4mYbcyd5gDm3yXHdJRagf29md3yCAXzpms1jJmVpnSLDrEzxAp2H8sCIfz8+g5lRoXT8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KI5bduDr; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0x9PXhhHip4G9/IE8UoYZ5G8qGaNsetJLHiHKZyfWQr/U6IlXEaEXoLr5R0SE8EL9tONJP6soqcEb/ahiXTBDQbmFI2JNHVbkxVMZhuAawI6kbShX/+JIHljqG+0f7u/G46FKqDpfbJFfvelWa8sypbJjyQ/KPBu7kKDM2CpN8q6EDz/5hhWaa9h86ecAx//cQlH8iUY5g0NJ4/sm9YEFHxt7Y4L0y+pyXaOAsFO6cLvJx64JBesIeX9xoKaixkiHQpxXE9vnlyN3G9+fmZGrIsfFXqrfwiVNxu+SUa2r2yNEjBuogUCaDvk7ac6IEd5O0xa5kmKq9xWmTZCRCvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgLF48WkHE3CRVHlzZfppQaXr/J1pLt7MRdCBrePrGY=;
 b=vA56JWiYp/+nOjdMoaqkTOw+gurNCO6x4ThstOBjTXWlPHSusO3z1jM7ngSnzGaO7C0LW5wCwOjYtbJlq2oQa1kga4Xgx4e3FK0I6eZoiIualX4qsmVvZ7h5C08I32EblZxmZAL+a/UY8DGS5DrlM6/n2T5i91vJOYizgDa6uKfDDgnzwfkuYtgymGa2p9rrS08rjRK7tn0e3guZo8XK+Qhh91AFjJ2mOQUNJ4YyNObFCZZlqAgk6GxMHn+YNt75u6LCctA2vCSjHRlpoeuquqT40oQ0XoDF5EPKbaBb2wOD0V0IZQ+W2iG5ic7Dh7gZCbm0h9Nsw8x6gcJkJO6Lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgLF48WkHE3CRVHlzZfppQaXr/J1pLt7MRdCBrePrGY=;
 b=KI5bduDrWBujNIKE+3klT+XH2+0MHVKT4SP0smsVtYXI8Js9yNn/zX1f6AAxHK28//2S/iT7gSDqE4ecc/jaxfFaZ3cL5YJq+n3OMeUCGAhYlI7Lpyb5QeGXb22rR1jmA4RC09oYHfBWwufUJD+Vwu9n86S9l+P1HqWtAJiMB2owaQK6ZNrKbAR5YAS9zQ0AE0wP9Cucb1/KWT9WHIPY7fEzOTZYeXk6/1yvUAJMNjM6sHkVENN9J7AOEKvqLilFPRvMPpoVMy/hJXaR/D6NOh7Q2F7aKBMZ8Gg4Hoh5AOmpPkv9Vx1VbZ59K/JpW5q20XrjR9JJZK8I+u4cMJ07UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:31:44 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 16:31:44 +0000
Date: Fri, 13 Mar 2026 12:31:41 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abQ77W5WjR7np2BT@yury>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <atnytehtvt6h6kp2ndxsa3x257usezp3bk5hp4ch7gf5w2zake@omihp5zbio3l>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atnytehtvt6h6kp2ndxsa3x257usezp3bk5hp4ch7gf5w2zake@omihp5zbio3l>
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3974d806-0eed-49a2-02c0-08de811e0362
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TGukriTe68miiacmtpoGHJTjz9LMofHNE8NUFKtu+hBdrnrcQqe7Cdbc6biJj/Tvte9u3JfHiCT5QYkNulHm1O+63ORq48mRIBzu17hFr3dfonHQWIAZYBkuYuBpDtxlneR3d3Dehfbi7F5ukLON0c5osYXEzjZfJzgRpVEhJAvZ1CxlSaTXlI/1np9YJCUBxFd8AOnnihc8S0Zf93KCvkFmshRt7ZVZhb1sk78Tm+FqhG7FYTgcycIYc8GSnvZsTyz4L79EYuucGj9dKzoW35jR43b4is1SRhG6ClTBMUMK2P+hfqJD+qZ93r1l5S2PdQ2UUZfcO2wpMaAKmAfOGdV6TT7P5P6OkUQP09RE/+piI7u1g2dLAFKdE7Mt1WGa5iOVPV8YbBLl9lu/lAzuB6I5em/EVLGk0yWo2u2U3vISkHqd0ysEHSs6m/l5ktyFLMLnTg4Gp3BvRyk64EGVdsPm7qdgor4oVFesW0lqzwpSOTmeYQgtzLOEVp0sm/vYp1PJzkhza8DsB1oJB0NzEwVvnkUMKeAkhlDcrJww7h3T6oN0+qsZCrWLGB2xd0+yOsjYTmvVeslPBt6fO07SXfpfh+E3+fyQ7nZPbJi4ZrIQqlABqqYIA6sNYMyvVX3A8Sgl1ceUh/3Q0Io7qnitEaHzC56nj9TPBQ6AjaWCmvIP2ltD9+2NTxAosJUVOVtBGC2mZuXP1XqXnHKX9BGcBjw9SS8g/sC45okOjshV7lk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kWAi05sFhfO7QtpRupWqTBotrRBkd4vybIOHyJ+9rrpGikvMJoEavcodxnJz?=
 =?us-ascii?Q?lZGCTg5/AUN6dV0x7BBWlQBQPnYtjGWVWR258tA4tIvRPNPvnvgDQHC0Hid3?=
 =?us-ascii?Q?tDp9srj6iM93g5Ij21u+oJBtGVsWrUHKu1VnVUG6r0PqloA39jPb7LwVp4qh?=
 =?us-ascii?Q?01zRDBy+HpI637VXSaq9ySVoEZB6UfTZXzuWb4nes1Nnah9L92wKSUvyRJGd?=
 =?us-ascii?Q?ynxWP9Z4jO718dza427qIDG6sNNGXjN3bH9icHR4FgGp8tvGEu6U3yGcQ5/K?=
 =?us-ascii?Q?nGdwDKyJNCnvZrkxVyNaDRljvMGolGudriibUQ6GPBPNBwADZpcXmf+l45Zn?=
 =?us-ascii?Q?1GiFSBMvwD28ZeQHX6/qSgDnAFc8r1MQdfyU1wfFKlnfy1edMjjkox2vguyC?=
 =?us-ascii?Q?HHo3hNau5fo7Af3O5BHYwcvhgVM0C/eC63gXmQ6qVtNapehanGI4tS6/YiEd?=
 =?us-ascii?Q?VHXAwNKjnh13im6F4dy8XouxM3DAyRFlJofZdZJS7Y5GoL7y/1QgvtyaFbhD?=
 =?us-ascii?Q?TDJAUdwSVeDzSnyIUHgAnySylpw8ZqVyj0QJQfD4pbwj+S1sDshN8UoE6UM9?=
 =?us-ascii?Q?X1yCH24u7SCZODqoQbvpyaskxozDD0noZ8UIctdiJs3XoGsiJZTEsg9se8o4?=
 =?us-ascii?Q?9HPNdc+oatvRH5FSj/+cAEN0dPWNdkjYThQf5/F7AFD3DqxBiSqoPDYjZuUQ?=
 =?us-ascii?Q?jt2ah5kgDA+KoPW5nWpkt/E8SS9b1FwfH+MtyyBxsTRLoZRpNfwgmeGGy5jc?=
 =?us-ascii?Q?xlIrwuKQWZv6nTcBmdoLtmHbT8uTc4kySfn0aqfZ1RROR/EiLsQB3MZYX6sH?=
 =?us-ascii?Q?VCQFlk3FX220hUrOF2ER0mvReLeX4wb8YiCKV9kfoj1+IxrEXeNwmq5Qi4+S?=
 =?us-ascii?Q?fCdmsDcoaQMgmJUht44FOZAht3Ha2AkfGcZEtywBz9C+YwPlEzlVq6qqdmCc?=
 =?us-ascii?Q?2vFndUDdSDl9M6l+AzmMUkCdNpliVtTrPyMHtcVuYhVVAUlfeFA4tIlV+L0Y?=
 =?us-ascii?Q?DWUsHMpWVSnXke3C03IgnNcMI60VGR0t3PU10wByV6CdlIzAtapAdz/YblCE?=
 =?us-ascii?Q?lcjz3+y8wZG/H/wr0DtG9qIv0VVhXAzsXlIM6jn2ea92eWoUggHta46W0j36?=
 =?us-ascii?Q?pahlGrfZdkZVtuneFHwebG3SXIb1ZXvrSBo4lAWubR8qp89SnqBugT0wJewj?=
 =?us-ascii?Q?QvpYAVJNz8X/B8REURN4VhuzfXUzJSSkTkn7Uz41Orh1pOuROJaXAlCm+rbD?=
 =?us-ascii?Q?UprzA8xgYn2IkmnqT2DrdNG41u2+dW4BnOifrx8IeIeVvNGPP6FQyoLGxUVi?=
 =?us-ascii?Q?bkP7q1SmSmhsEssdnYDSj/dbHzvtUuzgHix9okeb7+maj3zUEyDgFE4ydwGP?=
 =?us-ascii?Q?9zhSqWmzew+PES/HANiz4VoWc4K1f+fJGE8op1Q8sKZ71qPPRdgMyZkiRoxN?=
 =?us-ascii?Q?FIW0zcW2mmjokCZnDdmfL0l6SIFLGJDjQw+ru8MUeuaCjpd8UdUejsQ5Fvgb?=
 =?us-ascii?Q?2r9bqZsxqvfCB343M6KgFozOFRVQWkOuj+EWwOYVQr5Hd0lkr2ABJdc4Y6H+?=
 =?us-ascii?Q?qnbdtuxGxm8XCHvd9e+piXRfD5WE67kmLcMj6rCNMPFT8G7Ay2Cpl5ql0lFg?=
 =?us-ascii?Q?xVg9i/Uoj7Qn7LvB7o3dBlLZEAH0naW46PseZRfM18+yyeBZ9rUtfqgEMRhn?=
 =?us-ascii?Q?wfcgILUY2YE8KNmHjdVi4u/xBUNvy2aDbbpKXakMtaCjNSbOBKAxZwTBPU6Q?=
 =?us-ascii?Q?N9V87tMZWTlGuw433lcTYvXxRVW9Ohlm/jewZYmKyZ//I4dQRsld?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3974d806-0eed-49a2-02c0-08de811e0362
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:31:44.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id1r2na7q+sNlOu3kI/WYnuCxwm9+4hm3wVjAplEMN/kRsU+REAHsTCZcShB0wEyXreP0kq6m1w/NNyyTddPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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
	TAGGED_FROM(0.00)[bounces-9404-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: BFFB7287154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:54:29PM -0300, Enzo Matsumiya wrote:
> Hi Yury,
> 
> On 03/12, Yury Norov wrote:
> > Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> > to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> > ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> > 
> > The 32-bit behaviour is inconsistent with the function description, so it
> > needs to get fixed.
> > 
> > There are 9 individual users for the function in 6 different subsystems.
> > Some arches and drivers are 64-bit only:
> > - arch/loongarch/kvm/intc/eiointc.c;
> > - drivers/hv/mshv_vtl_main.c;
> > - kernel/liveupdate/kexec_handover.c;
> > 
> > The others are:
> > - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> > - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
> > - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
> > 
> > None of them explicitly tweak their code for a word length, or x == 0.
> 
> Context for lz77_match_len() case:
> 
> 	const u64 diff = lz77_read64(cur) ^ lz77_read64(wnd);
> 
> 	if (!diff) {
> 	...
> 	}
> 
> 	cur += count_trailing_zeros(diff) >> 3;
> 
> So x == 0 is checked, however it does assume that
> sizeof(unsigned long) == sizeof(u64).  I'll have to fix it for when
> that's not the case (even with your patch in, as __ffs() casts x to
> unsigned long down the line).  Thanks for the heads up.
 
Yes, in your case you need __ffs64() (which doesn't exist). Or simply
leverage bitmaps API:

        DECLARE_BITMAP(bitmap, 64);

        ...

        bitmap_from_u64(bitmap, diff);
        cur += find_first_bit(bitmap, 64) >> 3;
> 
> Cheers,
> 
> Enzo

So, if you're not objecting to wire 32-bit count_trailing_zeros() to
__ffs(), can you please send your ack?

Thanks,
Yury

