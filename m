Return-Path: <linux-hyperv+bounces-3374-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9A39DAE4E
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 21:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF12528179A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7B20125E;
	Wed, 27 Nov 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K+wC3x2B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020072.outbound.protection.outlook.com [52.101.46.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB712E1E0;
	Wed, 27 Nov 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738141; cv=fail; b=ORIW9hPCNXN6Qgrb1bvQLIDW9utIzWapeCEMcLrMdvHcG++ITmHidfY80/x1JE/3Ng1A+zzYJmZvmBXtNT2tWr0h6tis0y3REsQjcNVAh+Lz7oKM4Jvk27ize2uOodDq8wchOMwafTaE6ir1olCni60L3Zva0voWTBm7XucSckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738141; c=relaxed/simple;
	bh=VsPKrJ54T+1GpFYyLEpsv90gdPtIGKeZEBrWoWupN3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=coOBvpPaPwAkVDuRu3zTbxqNdcO72nsRgSRkXNOITNOJdsHdeyQDKQ0USu4PP03ZN8Eef4CNeRIaw7xuXQjyT71j8QzJcqE6Rd3wcdrf53tjzKZ4Laa9RJcp8DT3YuXUSetNMs/6s1qMMMznzI02QbfPG+ckBZH7v0TkzwRvIoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=K+wC3x2B; arc=fail smtp.client-ip=52.101.46.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+hdervkOm1qZvs/cS5HPekZk+RoFZzIKL4MgLiVi9APM3ASshufNf0Y5W7jAZwAbuai2yjdvKRtU9W0a4Qb7IaOm/i9EQWfxoj59/1/QbkSr50lfj0avFJBzMQkmEZJKlGHHY+WatvEvKDPKKVlUHU2gnaygctPcjuwxby2lQLONOupMcq3AUUNkG88VgU0Lr75f6GeTPkVuS3sRRZSpI+XgM6zeoTdyNMStE+sK6KlHNsnhblZGLSBN7MQptKRJfEPpYEixiU+krtjsoSinNg9qfTkkAYB/E18jvm63ucVDgK74Jq8wC5F40GFGrevuEDlRD5Q0p1cdx/gWQcU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsPKrJ54T+1GpFYyLEpsv90gdPtIGKeZEBrWoWupN3Y=;
 b=t/omxLjbtuKNUJob2jzi9lnWwFrMNAjvc2Adgzgt+LDKnwXDJ35s0aQu8Ian1tMnf2PQ7szT2hFkPxKdOXAHXj5WuxmA7iFvxRxDDTWvBY/fU5fiXHC0oLhDNtk+NwPBBhe0F01quQdhFxkzIip98LvuVHZQwvWljiZaZgwL87CVbI7l6ItkmwWvOckSXovNCmnRqBojzAteBHOVCo5ue9yeKAHMqv8zEo4mWIN1ybUa/VCL8lmtKfmk7M9/rgDo36NnSSOsC5d5MdK30S/7Fl9d5zrs2RZEcFegKl7C4v/f9Vb2/dgq1IqKM1CIy7GosS2zsLVBAdavb7gI4UWC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsPKrJ54T+1GpFYyLEpsv90gdPtIGKeZEBrWoWupN3Y=;
 b=K+wC3x2BT2iiGJxfYGM6HM8Pzg6BUV2Zt2A4z4XqdPSNmtpKAt1bVr/o/4jttPIXg2rmTgZe27wGEZzoXpVU+jIRQPS1hCwZX2FLTNXgc2Jx4kCAFh31ltnz9FbowB3n96LU4CsDI2PQ/TOPoCS+O+0DiMFNaVfhE6GMRSwhbAw=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by IA3PR21MB4196.namprd21.prod.outlook.com (2603:10b6:208:524::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.3; Wed, 27 Nov
 2024 20:08:57 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8230.000; Wed, 27 Nov 2024
 20:08:56 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Topic: [EXTERNAL] [PATCH] hv_netvsc: Set device flags for properly
 indicating bonding
Thread-Index: AQHbQQSULPYlBVvaCkKgp60+nf+9r7LLjVtw
Date: Wed, 27 Nov 2024 20:08:56 +0000
Message-ID:
 <MN0PR21MB343792E0085454F88ED2DA93CA282@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e3233f3-97a2-42c1-be29-e5149a5b50f3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-11-27T20:05:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|IA3PR21MB4196:EE_
x-ms-office365-filtering-correlation-id: d0ee6dca-69b3-48d7-ab7b-08dd0f1f5313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rIxtX7WiPtpJQXvLdGOxXaMB6y23n7T19iSutpYdV2sPuWMRpYT9O58m7TKc?=
 =?us-ascii?Q?wkaknCgOrNwUpuip0GaAn6VWql6kPTPJbbuQYoTFgkaJQYbPBC/4/zDAI29z?=
 =?us-ascii?Q?GcFe1GMTTQqqNeD6R/+DG8f3yGbtAdo+tOtyyCFa8EsbzhUvGwr0RRjkpdiG?=
 =?us-ascii?Q?0IOvjSZeOftKWVRDSe8P0lnQi1GJES5nsgNS5sxgXZ/vCkSzRj/un0Qv1lOv?=
 =?us-ascii?Q?ckCIv9XZ4w70vtDmFq2B/172NwhEtabUyOs4pDSS7T++i4/pPB1zzlVHH8yt?=
 =?us-ascii?Q?FSUc5/q5a9pZtqYtQBwKOlrUuoDTDkwSVJWeXOWn+G7x/Mtc0PRfRjypZHce?=
 =?us-ascii?Q?rGMtsB3FcAjxfrLYpuQ5JpYFbMHpsex2Vh6h2ibDopbKXAF7QCb1Fm4NlgSS?=
 =?us-ascii?Q?O3cChHVVFSKyLMgLLddc19muaPm9MSs7SnxwdswDR6xuaLu6laRwVWcJZY70?=
 =?us-ascii?Q?WJPGvCf86xR8KbmwV9Rwt8zJVDJ7W0hOn80/VIAcoq8D+j8I6hHaqXIYP2oT?=
 =?us-ascii?Q?Fyjrc7y9q7+G8n+hGKHT5q7vtJTRhZHF5kF6Rqk5m5Ra/QBx+Sa1/QWtKqnw?=
 =?us-ascii?Q?kd9y2fXYqpoOKE/3LVBApL9nMx/L/SQsL4CMdYGDcGMQglCNAjfN4Oy2mQbi?=
 =?us-ascii?Q?vDpYwieNfr7jT4YuK6jrB17JJWokQ+N8iZtGGC8tON9/sMe0HDl0Wko98Afg?=
 =?us-ascii?Q?dFsBtBe9dZfnVo8o/23HQ2xJ6N9W6S7Elc7S5z7TDWRjPfwJ9cPnbdY5y2WC?=
 =?us-ascii?Q?dsN/NtdQ7X77k/k4Ip1TnO039Z3x9bd7xa5u4qFZm6BIhoI0wdkUrlv2MpO8?=
 =?us-ascii?Q?2uKdFYTf6s7/hduLNC/HqbYv1bN5p0hN7BWEF9vDp6Qavzo5/+i8b6VckPd0?=
 =?us-ascii?Q?G/j1APHQDu8REfdvuOTo8Q3kiI5ri25EZzU1Pz7zkaCHwMEU2avarTetFEKZ?=
 =?us-ascii?Q?ZyuSMAUowMwREUQbR5wFnuE6tZtkAeKUv8iz89luC1aT5KNY6P5ptDHCydSV?=
 =?us-ascii?Q?V8r/bUpq/ReKL0P4VMgJ09Oo29dt60HF3g4qf0i/Xk2ETgzofwR5X7bn+tWS?=
 =?us-ascii?Q?QlTVS/kYlXc3LKX2Zrp1rfmoMLlLWmkW9/3DJzLWJBv8rhqM4zT0JgM94Fr5?=
 =?us-ascii?Q?Up9SEIcRkFn41RTJDq/DQtgXnfvAJr7bo4Ya1d+v60TYIU1lCVPiKOGywvkD?=
 =?us-ascii?Q?GG904XrfDl1TGfj7XSAMKEYWvep0dzwPMPbYR8lhqGIk8+5E33pJilP+W3Xg?=
 =?us-ascii?Q?TN0Quhhnc1S5vW4hlePlF3QO0VtMSPgvrJHw6JlM3OFFE1ImOSQDDwmRx8dU?=
 =?us-ascii?Q?s4GWdfOKW+qaE2s8kaDHgscMGVH/IGYNz9dF/j/VeYGEM9obsNS543gNW4tF?=
 =?us-ascii?Q?wVpbvamCXtV2EKR9fmDakAXttRkVSdM2YQP5r4EV3F7Sbtw7VzSqC3z0cr/z?=
 =?us-ascii?Q?DTQNQ7p/w74=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cvaVOgmIti+ykRIDk83eIku/Y9/xvQrPzo+p0KXtLeQ6w6GVWwYlSu94LVWV?=
 =?us-ascii?Q?hMwxz4QVle1D/6z4VtVXC8S09nZYXTXJualE6ShNai++yH3/jWiuuocsx+Us?=
 =?us-ascii?Q?0gwQu1Ajsilxo1RLtQQGb2tJyV+XPDIZXya04u4+PP2tD3142NIWuA0vtNcn?=
 =?us-ascii?Q?fcauags+FOJLdSCFNMxuXlIw1wchZn6feXw4lt3tiGG3hzQ+STDOq0ty+zc8?=
 =?us-ascii?Q?pHt+klse//fvbh4ETr2o18iyrYytn3hGavND/9A4daoGaqYcdyMTptPDRC1U?=
 =?us-ascii?Q?Gj8N6LyIm8JSa28+cDXDr8uWpCMw/inLyfx0BPdOKD5M6+3i2oRneaFlTPsl?=
 =?us-ascii?Q?yR+JKNuKzSUn4HmpO8uT2ArHWPDO4ZRjRq4zvmXZwEZrZUingxpqanz5yNjg?=
 =?us-ascii?Q?2a3G3CvpEneb9EdbQ7coC6g3Y8x3vUqlnuCjAcDwsnkegaNijK3KpFsG1W0h?=
 =?us-ascii?Q?pKWaNmoGpzjKKCzST0bmsSPb80JpCxdl6PXYmB/td70jFNeldCChaUtzBeBo?=
 =?us-ascii?Q?ZJHEatMOmdtlWvQpaoR7puUl5Ik25JPtWDkxCLI3f8aqGCup5JKNLBLJW3Q6?=
 =?us-ascii?Q?RQWRSzpRjRU2GMVc/s4xedan2zUgV1DZdPfBWeO3aPDrZzbFHA14dmbw6bZo?=
 =?us-ascii?Q?vkyUqLEja6DivlSn0lNDwyhRTFEZ2phJLK9BwSixDNuhP8La2/fBADIz91VK?=
 =?us-ascii?Q?jhvMUtzpWo50mgt7FZA76TXUJDa85rGPjrWcwfIajxn7Dqk903691usVTQqu?=
 =?us-ascii?Q?W5KYMDCVmdN+SDdaY2k6c/ipabmUF9wNdXFVj962/xSAQA0Pn0hagRHSRpto?=
 =?us-ascii?Q?In+2Ziu/DP1Hg8XSdpxfUC0qOlzsJiwuqAPk7x0ceu5dFboOL7OkP+FoTi84?=
 =?us-ascii?Q?a0BBEgepFAxgI3ByluBXoCV4mIsew1tGaO/+8yURz51j4X+/XWeqsLqxiMqV?=
 =?us-ascii?Q?Eam7UmLtlNBSV/ngWIeAoZZqqHk1Se0hyCZrjrK6raTdh2pPLvt57mRGoEBL?=
 =?us-ascii?Q?P6TGtKZEdEoDOA4APtx9G/u7vhJtYrXy6azgPAGN7eBoEg4QohwF7vUejxiY?=
 =?us-ascii?Q?ztivhsR9DmQQ25skW8+v4VsQNJgPp24oTXIa+4HEOh8hoJ+d9sQYFq10nOIj?=
 =?us-ascii?Q?C9lYFDDX3Ky0dsOXHcmbrD1szazfK/qseo6vRLBtU38wf/1tj5rsAiw73ErX?=
 =?us-ascii?Q?3tzZDxZqaj/OyfK+RKZDKSQncNg6HOAzv+hfllkhaNXkabWeJJf5d/it79Wb?=
 =?us-ascii?Q?r0W+dqBgnfY1PMexi2y2xk8UBC9/5fPEEdPYSh1/paADFeVHHYm5Q+6vDma2?=
 =?us-ascii?Q?H7bywJVkLG1w1ZFZxLVMIU1EXsRs9ARRnX69G82wSJvl8jOkdcc2wCQHWogR?=
 =?us-ascii?Q?cHC1k5Wxv/YD5EWlsVWp4NAUsXseFQLpTnjDOtc5UEE1sYNoO2MlBBf9bSER?=
 =?us-ascii?Q?YfrDhwvu0n/fu0YpMuTRfQcAib+sm0QGve+kjQc6vP1vSBoDHiHsqvikAbPv?=
 =?us-ascii?Q?jJwA7Q5eyg/Smh0aAMyChrNPtOBlp9qIs4DHsrr2yBHcgrGDndKXJb2PbWGS?=
 =?us-ascii?Q?l8aPojH/KTBx2bMg31VxJdoh19IbXoo5aAP1XIFY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee6dca-69b3-48d7-ab7b-08dd0f1f5313
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 20:08:56.8403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVGkMeN/bXO/yj101l1Dmf5akRYsDRLQ4EyUPP9Pk76irESaMVMsZVibfHUDVNgYNRQRXcvykKi7XiYbdIh6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR21MB4196



> -----Original Message-----
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, November 27, 2024 2:43 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Simon Horman <horms@kernel.org>;
> Konstantin Taranov <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erick Archer
> <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] [PATCH] hv_netvsc: Set device flags for properly
> indicating bonding
>=20
> From: Long Li <longli@microsoft.com>
>=20
> hv_netvsc uses a subset of bonding features in that the master always
> has only one active slave. But it never properly setup those flags.
>=20
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave setup. RDMA uses those APIs extensively when looking
> for master/slave devices.
>=20
> Make hv_netvsc properly setup those flags.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Please add Fixes tag, Cc stable, add "net" to the subject.
Thanks.
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



