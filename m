Return-Path: <linux-hyperv+bounces-6692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A901B4031B
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EB8544465
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Sep 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2B2311C19;
	Tue,  2 Sep 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ML35Zhaj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548303093CE;
	Tue,  2 Sep 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819467; cv=fail; b=NcFEnqSJwC3WyLaI/ENM/OEjUYcE57fhZ9OW4N+CJjKrYs20DLfhLzngWRi9xqdSsrJyHrhBszJjMb1MVne2gsUaNAwG8YMIU34B6SYpZi2+5b/O7Ts1oUbjSO6AlQ5f251lAiskq1GdXOjg2azQWorJ4BtFV/ijXv2jlwjMVi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819467; c=relaxed/simple;
	bh=88aeNzDVOF+9jTTcxD6yoGqNPBt9Kv/Jd4ggnpb0X1g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HhJvao+YfU98R1dq7U4+MCtaaDG3bSSbOB+0u7ccuSZ5kfsIfOALDeGPhkyNFIx57Z81G28eukT395jact+ch72W7QFYpNd4ww/bj5EEk8jN5oCT8GIGBF1s5D2nOAVFx48kJXsq57MJxXxrEo1tRivwqM/+gVkiRJhCUOfqC0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ML35Zhaj; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbw2HvqIup0hbvdXj71ZhydYNDP9irOyr59DjGRuQ3+d8GCKXocG7lezevX8wAkzeKaP1zpw2Mz5eZMP5/KLMeVsU7x4c2/iOithaiakLwMX9nZhgab4grCsyke9m8ivbQr8ncZF2wn3KbbQBbpQ3Lcum1/L5RDOvCp/VXpwjiOdWh3IrJ2Wv/STl/a0JdStgmB3HJhkRZMJbHGTBdT+veg9uIsGrxRDd47SudnjFerh2yGtOpRn/wsx50yvu/Sey0KpsBZXyF3RQWGLqGMeWqwg9UARb6K627nRkPXbf1ONkpBnnCzmr0Laelz371YCHXubpLo0cf55ZpQK02QMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdbLKqm6IM87vayXJOLvLC0T7GZfSPe1OuYyJVqNCFc=;
 b=aKCwYo5mBQOZ3XVQQrpm3CjpanQfuF9p5+gzF8ZyNn9bch6dWGLWE0IjomW3WHcpyDyVfKD8moDZ0UspKwxJoQYfzmE9CGQuZtmA/eXuB2HUyF/6EWHa62mBe9Bva2Y3NbqRhnNm7Gup/kFYGbtDYQq7w/fQwUYT72VOMDIm24Uw5H5Pal1JYQhGC5xUQlHa03C9STvr9VGONzRWFWJ3z26r5CsijzVW7LZRTrhFLfV6BSj5gz2S9mkxdoH93SOHhMRaTEPZd+mRf1mpuPoKZ8xeVoQP8xIY7jIakrNPg0MR43i/3vIOscLOVRtupON5VHTvpa/q1XRHuGcScEwClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdbLKqm6IM87vayXJOLvLC0T7GZfSPe1OuYyJVqNCFc=;
 b=ML35ZhajA2CfSfmeHGAP9rSqtrLgWKNLILI2PGSZBNPpE4uGPfw7Hc+5Fr3nzgHlmBXIJc/VdzXkmMYJrao5dQdmip5j2SU6V+272Fa+88wiFyqRVyggYzK4PDXm2MxxMx7Lk6e+c8bg4Tm9I+nuCGGtInASCLsF8Gt3xQRnlHoDNwpT922JoH09+B+kBIKVaEXHbtXIQxCx3emhkKcYgsK0vohOxalCgTC74pZHeKx5bDKIz6O4NYoVef6FtX740aKwJFZby3Kyw1FK4gowur1Y3FeNShGA5VcxJaU9M6M7b+xQAiKRpoKREVM576lMrUoamOjtLFLm9vAAGRlDTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5078.apcprd06.prod.outlook.com (2603:1096:400:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:24:21 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:24:21 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Khalid Aziz <khalid@gonehiking.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Prateek Singh Rathore <prateek.singh.rathore@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS),
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 0/6] scsi: Remove redundant ternary operators
Date: Tue,  2 Sep 2025 21:23:40 +0800
Message-Id: <20250902132359.83059-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0238.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::11) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a30c12c-b1fe-4491-8ffc-08ddea2406f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXG4K7mcZLx2/ugDvFh8fgUiTLQiQ8gx1hOoQKQPA/9PrtWLhzHTZ0MEJvLj?=
 =?us-ascii?Q?ptyIGjAIMY9x1454i4ZNIByr0VC7+FGiwZpXjJ3snsWYP0jLB5H323vTv+ps?=
 =?us-ascii?Q?n8M8Sbwti96BMw/2ygtigJTzb+fxD0IkkAZEAK7BWNRt66CF4gbHTXuPOLFR?=
 =?us-ascii?Q?v4WqDCw5qymwH8rybEqoJ0SODiZyz3h2Ttl4eBynwMczgsn4wQCuAp5chbyx?=
 =?us-ascii?Q?ZHBJFksnlEwnAJJ14b8AEE13klNDHGK15ryTi23D0c+6TVrDbC96n9OoVSxI?=
 =?us-ascii?Q?yMaW1LgtTpjjoSUf+ZXEz2/2lZm6zUdQsRz3ipLICGwUOIXtDU4vE1cKKWto?=
 =?us-ascii?Q?NuU/dRmHX3L4w03N+qi9PDNzDUKGBOov0BZ+scv1Wx2mGPQdkudhT9xI7e40?=
 =?us-ascii?Q?sWwhCmFIg1XCatkgMElMOGTJlPDOGZBnJZIk1T6KEyZoc3IzYV3KpPZweXMR?=
 =?us-ascii?Q?KIixG9HcrAZf3fb5WbklpBEAtCKNVumXCjBoaFuFeN+A2frz5NV5HU6HiuS6?=
 =?us-ascii?Q?+hY1TxV+wSR7pWtXrgt5r960Ppd8pdasYSooe65QFctfCsEzXyWWIaWEeMu+?=
 =?us-ascii?Q?9p90kCEFFWr8XA3Qkk50iHWfHn6XPNBtiojtGQtkXso87+m13ICRmKmUCfjZ?=
 =?us-ascii?Q?BIG/3+9U/al3GDlZxcLR7Gy48+W0Q1yiZXRiFL4I76QeQJuSL3uSf8hTnEXQ?=
 =?us-ascii?Q?jfGsKat4TKRLt1NH1gCjUg0N/vm5a0dCY190oKoLdz+ddXDyOKewGN0iP9Jn?=
 =?us-ascii?Q?shHP6WSmGBP45T0TN4MME+LMGfWLuVseHLAJgqVrUMzzv644e+AIc4hs4o1b?=
 =?us-ascii?Q?Kb4H9UKykSMEE/yDlWDv+1PEO7GFbc2u5ErdsDfEz6wKJZRVRSxnDioUSdlf?=
 =?us-ascii?Q?g/3s1IQDyRonhqjKwT3OPSr6es8w00XzZE9hZ5hEI3Q7tC1pUyQhRyb+dnMV?=
 =?us-ascii?Q?2TTHAwR5DnHkhA4tiQs9AgNbbKtGt/YE6Dz58ntQf05cJgaosa32rIkM+BiP?=
 =?us-ascii?Q?qnRf9c7/qpRi63l+QRzAEtRaV59xa/CkyGtVVQnweXBVmdQVacnmunrwYb1+?=
 =?us-ascii?Q?aOTGkmgHT037ncdYbCMENjK0mPFUa0aFAGAyBgRKQM2TnojAPUZpa/0KQYM1?=
 =?us-ascii?Q?4xxBtnzwjfrLknVu4T5fgu2mYhqpuA1zp5Qr+AHoPvi3kKg20dstE9Fut1Pw?=
 =?us-ascii?Q?ej3wfscM5ycsfNMQPjkli3kV0eCqXXtPnhbrdJj6+nDcTyiOPml+0zPxp0S3?=
 =?us-ascii?Q?RM50ineDuA8OY8E9iLy/cQ6UV7rW/zCsq1HEs8GPc7w+7+XZgcqy1rGOHRuT?=
 =?us-ascii?Q?xVWoATsjxe2HLHAJyyQBvfu9DGiXpB/XdoiUO3Rv45tcT7UYEvuExcBR5Dyb?=
 =?us-ascii?Q?2BeTbKJ0Ib4y2x7ep9fqE/1UsoXq1W/9EhGiQf9STACoVeRhcIAy15C0Ng5r?=
 =?us-ascii?Q?JxARNDVauiLFscIG0REiNeiokJRpYbqHS0Y7EIYaMOPCNSsX5tuAlnaHGXy7?=
 =?us-ascii?Q?eGofI5q+oIbZjpw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryAmhMw7WM6EWkunz4+WJAXOQp4/OhwmYt0F4zELWtpY8hWU87bFCyf3TuJi?=
 =?us-ascii?Q?AtWFjceWQt62Am7ep67C7vHj16cys/9WAH5NYhjm09nrdNi3luqM6+0SFGbR?=
 =?us-ascii?Q?NGfBqufzSgWZkJj3/NxfeA5X1Ce/40Tgku7XF4mSfyYDFTf5Uil+SolYCNmE?=
 =?us-ascii?Q?SYWQCRaVEpDt/goWMqaqesRGYo5Zj7/AutFYpK4H7fFrt8Pz3Ex/m/sJCumt?=
 =?us-ascii?Q?AUPTa1DvreybtN1UxY2Rpy7giHnA22Dv7mdQ1sj752IKxnn0Stom921AMhi8?=
 =?us-ascii?Q?cx5WMtLxZfyp5EOPWLiE9v3scqTX0cKaxKvnTRdZXcsq02UYmpSzUtb6BdnI?=
 =?us-ascii?Q?uoNQ/qnLqsDWnu3V6j9+63OXLYxYzuI1wnPRJsz/kh6bzxr9GFgYrMwih/9l?=
 =?us-ascii?Q?hv6qRBd6I1wTEVIMOXZkwBgHLfAB1pYZXKB84PIsAA7qUZeI/DKK6XXJUVW3?=
 =?us-ascii?Q?/jN3H2AOGlLd1nGbF8/20wUCv5+c0AszFAKUQTEHVbW6hncsshFNUPu9hFha?=
 =?us-ascii?Q?96TVI8hA03vm0aJH0Y7zhGbv949NCQRpokqWGPB+RiN2zTBGmJ0BR7+Bau0z?=
 =?us-ascii?Q?hg/0Smday1qay9ymzb55DtHNWGM3kAtByyvnc8hT7+AyNNZNx1/pxMQs6JZ+?=
 =?us-ascii?Q?J4WjCcpi1TJeNlNXKfAALgF031XMtpx/QoApIslEs3TBCOa9ScnYMC2rO/gY?=
 =?us-ascii?Q?QWbIhkF/yqDDZ4NvQOIalhZjQX+7FMobX5a4+73KMkTu8fAA7H4k6sEqrdtS?=
 =?us-ascii?Q?KGjPd3SsDW+un8vVQhOGyOSr9PbI3lKgRCUqP1Qq5G9N6wNm2mYGfQgTZudy?=
 =?us-ascii?Q?lL6gd82jU47xBhoyY3YOtEAPcWJT8A7iF1KHC25NS7BnUXW80ZcPJWSLoNzU?=
 =?us-ascii?Q?y/fFeKMSRX6uScs7PyqMsFXf1+iGg2UjAzMM2xwovtTaRXemLuDh38eiAoOM?=
 =?us-ascii?Q?CLt29iJ+CZym8w3nlBqnkEhDmQehCn+L8DMKEaMONbNv/6qDP7S0CDrks92V?=
 =?us-ascii?Q?kv+okprljYMllIw5FU/NR8pBOqn71qbVanp9u2R5FajMSGgPaoP9Zfyrk8E+?=
 =?us-ascii?Q?qE4fjMOsdRkyfuwMc8bT/gG2dZOOn7NNuzpQKjrOR2NqeJrfU9XdANgUjFqv?=
 =?us-ascii?Q?8IxXzdlDFJ1mXJ34vRB3vD00IdDBN+OPAMGvPSSfRBqz4Y0HfthOfiUaXU1q?=
 =?us-ascii?Q?y/uyIkXNuDHta1Yk2xHGS2oN7HvQN3ITWeVNckrxXSufGIYD5c/k8WUPvDZY?=
 =?us-ascii?Q?vC8IeLPr4C0bkTeI3vWmKEIIlrtGSLO/h05+Z+fjDhO7MDv9i9G+Fyp1yeOy?=
 =?us-ascii?Q?Qm+pGY2fGQYjs7SrHm/4QNYVwODwpmCP4AW29TqxzbCoUMOf1/VRPehlW4Iz?=
 =?us-ascii?Q?lDlY5iyVuh12B1lheMWpGhJb5AscSHzFETa5V89io4INEzK2ZJP/rsR259uX?=
 =?us-ascii?Q?QeXkpLIxwWYo0encL4esPrLF+NW0wu+dSld2bdjVc5uXATCjGIR1MixTmpxB?=
 =?us-ascii?Q?9s058QhN6AmYfxOPk7MJgmXldCqIs+eO+lx+umSahBzt0Q9S1lq2DfXwm78C?=
 =?us-ascii?Q?isEKREfUNNDw+dl5Y3R43GWP7vrQEKJUT6bgun0l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a30c12c-b1fe-4491-8ffc-08ddea2406f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:24:21.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELkxoFmlkspkmS0mdSxR2RIdOqlIq1gsZ27GiqHp8N+wCEEblzx4HtvEsYAYBAnsmfqXKN2JREerxqjns3ib9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5078

For ternary operators in the form of "a ? true : false" or
"a ? false : true", if 'a' itself returns a boolean result, the ternary
operator can be omitted. Remove redundant ternary operators to clean up the
code.

Liao Yuanhong (6):
  scsi: arcmsr: Remove redundant ternary operators
  scsi: csiostor: Remove redundant ternary operators
  scsi: isci: Remove redundant ternary operators
  scsi: megaraid_sas: Remove redundant ternary operators
  scsi: scsi_transport_fc: Remove redundant ternary operators
  scsi: storvsc: Remove redundant ternary operators

 drivers/scsi/arcmsr/arcmsr_hba.c            | 11 +++++------
 drivers/scsi/csiostor/csio_scsi.c           |  2 +-
 drivers/scsi/isci/request.c                 |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   |  4 ++--
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
 drivers/scsi/scsi_transport_fc.c            |  2 +-
 drivers/scsi/storvsc_drv.c                  |  4 ++--
 7 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.34.1


