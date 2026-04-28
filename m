Return-Path: <linux-hyperv+bounces-10435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIYrOibi8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10435-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724848912F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A63308C437
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2045091D;
	Tue, 28 Apr 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwiaeeb2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA544E02A;
	Tue, 28 Apr 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393091; cv=fail; b=d4o+K5PisArSgLbJn2oM8IZ6rpOfea1ex1LTx5fnMDcZh5zRrGYdijLYcmRSPwQBMDKKDohi0MaJbzlDiv2GCgeFtTS17/qZBOYvMN6f8hXLtHV6VAwgxRE+3tBb3q1VhHEdW1QFgRFEA77NtLCUi4J4I66UebJ/hXiALasIwrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393091; c=relaxed/simple;
	bh=ubsyr1g8W03QK8fXWcIYOttYhfLSNYPXJuyBVFsa2KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beFXA7wNzzwObO+kyCG/1eezIdj41A1m/lwybUApNXApPFDc19lKq08wPD0E091v9zZpxWy3jh9TRxRPzMbZ/IMVq9BUBD0oPGGS7BdFsUnbpNr8iUhbphpuXTJW6QWc4aqR0cyg9L2MnB02ZKrRzjm3NXiEkuS1GsiVMjPzWBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwiaeeb2; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXPhQ87NmXBz3VdMoDBssu6ZrWV2DAvhzGxubgmKSHWzTb9J1gicI1X11phCHa3dXJe6KRt7VzSJXYJ8A73NEDGUqPiI5uPAc8/G++UKjKd1blgdtfKIDKq2Itbf90SS89afnEAtVVN15LKUnpCRq1sMscHZy37W20g1INkmk8YJbU3+dY0lL8cblCSNPebE2Ca3M5vQfQZC8CLk8MJJ+9+pzmUe7qAHhXB9REx2p4lnXR9y4bARIUvNEtqjiYm2ukHeJtf3RVyDYBQR75DiZ6Z+necWl7fr7Sjwt17RfVffVf93z2DUi/iCQyqsoc/rtNZESQqa9diM7MwtXnuzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2YJW8qcew8KkVk3MGe4PXGHiCJdNcPUSXkDtXrKy68=;
 b=hJ+MxDfu+IehYLxloXT15qY1U+sEmDVkaP0yWTOAo/XLjiCAOp8y/6ckJ8yBkL5U+0nLEYlMtNEZN8K0HrGUxteIJjxYt+UEUiPHPfhwJaiJxJhYcfSnYjrya7ODhpSo6xKHGgKsn4iT/LbAn2/13bSUkxHsfumEMQHV2c4yfxCKipJatkWbfrKEuAwdMc9E89sjh4EgNQw4k/sAzrjfiGiGd6wijnq35XKkF8ZQjjW+AN514B5yWwRadqWLjKVQkfDNZKNibGmKkw2QD9jLu/iQdplD/EmJ2UeHLayYdrJ+iwEfhMMrLofE5CSy4b6X1ICiBX+ya/r9q1NBXVTHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2YJW8qcew8KkVk3MGe4PXGHiCJdNcPUSXkDtXrKy68=;
 b=nwiaeeb2581NGBeV4y9rnmpcWeQukXRH1XFMKOTcLdXYJN4PiqLuRMz9r0imxxBairn/CBO0zCocLXXLFWOpfokvDzoeVB9aWcvTSiXyakuh4yvp++qDVZNVX3XMHHSC13bC9Zi3EmxsPhNkeoBEq230KI9J1B2Dvu++x7gGmrqbPc9Xbax4G+Yuf5jq5ldmRheI9HSbOEJszkWeXow1q66gNjTysHFSDrmH+1NsrOIFq+fG3HFZF/gzhzF0G8Lxz+l0zC+YhlbtmwYIQxseFsKuFS/fF8YjjthiLNmTxY2oGTZ03+kyWwSbQVskW19elB7BgzdCLE0mGKeHlRzPpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:58 +0000
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
Subject: [PATCH rc 09/15] RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
Date: Tue, 28 Apr 2026 13:17:42 -0300
Message-ID: <9-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:208:32e::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6ef440-6f4f-49f0-3f7b-08dea541b3d0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	4GUYb5SF1RFB1+wQiYiCEKeAT4ofvsdxuJCFBzDC0BQ/warDFUPPuZZfrklcInC8P6b6C+JqUyxLr5M6nb8ABH2Kj9EWIRyhY3PXUPd00HBhMXGb7iMA2MdM1z1g4tepy34c2ueF1dZ5U7TKArUiDuQ5uB+jhy8CvwdE0MnPJkFw/5fTZjahvio9TLlGdTLEG0MOxeZ1DbrAkf+wY9b2eAZmYuuqbq0gMESNK+arBsIM7oO9V4+wcvYJ7SNxxz2Gt8CpL1f6DW06eu73n290+kJn1DavW9i0l0diTbxZtc3S6nJUYWPMHdVifisHv1LQZc8DHDb1mZNnHI6y91DFjJGUuF6h5kj+0WEe72bmWL1gWcanTn4w+qzs7OMv7ikj3oowSkpkQyZeQSxS5obPUmb2VGHmZtmBaNHwOm3egUgN2oDHQsvlf/tJssSry3DlSWSg2eamaSQQorV62ZbibqhwIeXXkXCrFaGB8PrZkvLrFftuR/EjIm4q+/5FMJ9/IwT4YrJjTDV6+JDRDAXtQbYHNVOZ+8ZnLGwoeXJbbjVTMFneHpJJrp9bgK9onpYXoT+8w9KejDUINXhq9n7FF4lSj+HfPnx91ffJqPWIibtVqk9+PA7JvvLeH0+5qUN1kUN694CPkqGevjQFZCB8yBnWKAZOu1RC58cHZ5KWODNqVaqYj2hLRmjIJVJDXncA2tKVQ+yKzsyGBMeyT2NMNAps3CV3F7JgNk8dD0S04KWImT6HA/mT4WRoYibU1v3uTONYhp5rRikdTLlTZNUbyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VA6dX78RRncQQJDJlAhSB5Y8TmK72/YFnxXN7s6XdZHXyCSTwHeO8DsMdoSr?=
 =?us-ascii?Q?qGZoik+ADGX90snDXOvDVtdplGhZtaqxBqHDRCxsyr9eBVRY1FZNJ1BSTG7L?=
 =?us-ascii?Q?au+dp2xqnMC2eB7DplJt8JDsuhHjw3g/yQaocP1T8MxcYvFqH4BO9vPNO/eE?=
 =?us-ascii?Q?PTDv+0NyFzELB41ds/FMM4ME4pUrAaQXlixJrqkVTqZzc+Q8audf29qNltjR?=
 =?us-ascii?Q?yd6YFB8iYMhtdzsluZut8I+AVUoJsPdWDFuF6BBR3oWpZbVwwt4h8FyorXgN?=
 =?us-ascii?Q?UuclNoZFVpnbAughG8mPHBpfoDpzouHL4zliY28jBUZaCLa8xl6dohwgY0Fq?=
 =?us-ascii?Q?DObIuaxcoBCjAPBtoHlUHGYTP9LkUC+hmN4Br7oIUG83rJmwUqYaAj/0wCFn?=
 =?us-ascii?Q?ohGMmdIKrtW021dZLGcMHkrzaYSB9NxXzMk67nwt22F2slBDGGrQx3Xk/qLa?=
 =?us-ascii?Q?1DjSBX+2IcUbCkD8gGIQfGDmeN/hl2cnQv4M+Ebyg7OT3HjHaPXXw/CksRq6?=
 =?us-ascii?Q?tVnwNuMnAfmG9EQ4TfjSpr4wKiokaLjEOFgqSdsXd6hofOzkXwcZW/Ff0ycA?=
 =?us-ascii?Q?TZOQ1+WkOD9Vcm019SIb+AEFJA/uW1laCYseDlJEXNGuddReaf91mulU3oo3?=
 =?us-ascii?Q?pefYMmYj6HUyol7uv/SVfoicK1rKpbIJUgbsrhsWmJSfCoCoSAA6CoPwTTgF?=
 =?us-ascii?Q?4LiOaUZZSEGD5hMe/BND//EjQFOgqP9EVMzHBCv06pBov0ZLnAbbkDRBVC22?=
 =?us-ascii?Q?lAFG1f70ToYbtzDUdxkd5kn0S08eFYny7sG4ECq33bgCbzQ4DCx67HxyBCm3?=
 =?us-ascii?Q?nALFxlG0hrCDxX9rS3IqZGOHOg2U+BTdsaJHeHVatRpCcOoiBZlxhaW2WGwi?=
 =?us-ascii?Q?j6aMuz0y14wHQjd3V43yd694pha+9RFCUU3CmXKOds+3rPw9mk9b4zONJ842?=
 =?us-ascii?Q?Muv8h4F11+2eycAj7pU2s42Eybax/PMjyv9RSb1LgVqBF/NmdZhxq7O7lJto?=
 =?us-ascii?Q?rtUg9QSH8zj/MLrFP90bTimn7bbJr778JfKmmHIc8BfLFqY9nnJ75VxrAUnO?=
 =?us-ascii?Q?wRQ3z15wp7NLUNtC0JeeRklBpEmaFcQgLE8WMR4hLhmoc3FQrl3hMK498eXC?=
 =?us-ascii?Q?bPSm2k0qckci7HCDiDMugOHSD8OQmNq569/z+slSEy9lor5e6zKDufnnv1Qy?=
 =?us-ascii?Q?hvEgwITlTpQ2B96J0HqjPyeraHxFG9txYQBmOnQDzvGR44CQM47NaTIf+1XF?=
 =?us-ascii?Q?OzcM2/rOc5/nDyqcBWv2lFOTbaxfvVm20BTs7/2dHbcTg5Rylt8jD+diBPXo?=
 =?us-ascii?Q?GQI6ckV95fXCnNnjZVHerpEbTSAz/vEQu/B0afM3bBI9oHcX/pTHbNJrfGCd?=
 =?us-ascii?Q?yvnGkdcHmBpmD9uJg0GDwyeGinJ5IFeSeCEJuSwsayXaxz5GAqDEl/AhSqOK?=
 =?us-ascii?Q?AUzpd4wx9rujzwLIREwyya21cZzsWoOIXD7sxeR4L0aJC+crhLlmqofK+wPc?=
 =?us-ascii?Q?pxE9v1A6dfufUsV0dAI2kqZwtfLw+NFKWVtmz2/W/GHmL9T5U0S2YNg3G+8e?=
 =?us-ascii?Q?e73nEe4suntJVBj2EDjhGIRQdfnmpJGokmbuWyUMXQTZGiAFLWg8thqK6ubG?=
 =?us-ascii?Q?btk3LFYtTB26cmJxh7FA/BZ9jQ/w9GlBybinyfglrjCoHc52IqTEpJrSWHCI?=
 =?us-ascii?Q?wrsmPjmMfvT4j9kJmGB3G13tanHeuU0juyMg5YA8a8/t/Yjt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ef440-6f4f-49f0-3f7b-08dea541b3d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:54.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f5SZ6zJek63BEM6jI6yfGgitKBiP1ZLNMstmZEhoawD1r3lly8MCZPidmuNowEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 8724848912F
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
	TAGGED_FROM(0.00)[bounces-10435-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

Sashiko points out that pd->uctx isn't initialized until late in the
function so all these error flow references are NULL and will crash. Use
the uctx that isn't NULL.

Cc: stable@vger.kernel.org
Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 463c9a5703fc4e..a88cc5d84af828 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -620,9 +620,9 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 
 ucopy_err:
 	if (pd->dpp_enabled)
-		ocrdma_del_mmap(pd->uctx, dpp_page_addr, PAGE_SIZE);
+		ocrdma_del_mmap(uctx, dpp_page_addr, PAGE_SIZE);
 dpp_map_err:
-	ocrdma_del_mmap(pd->uctx, db_page_addr, db_page_size);
+	ocrdma_del_mmap(uctx, db_page_addr, db_page_size);
 	return status;
 }
 
-- 
2.43.0


