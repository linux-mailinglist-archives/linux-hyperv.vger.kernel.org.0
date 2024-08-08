Return-Path: <linux-hyperv+bounces-2754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696594C17D
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B18F1C21D67
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4718F2CF;
	Thu,  8 Aug 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BvUXctlE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020114.outbound.protection.outlook.com [52.101.85.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5B18B489;
	Thu,  8 Aug 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131223; cv=fail; b=XmDPk48yIWITODhJrG571zh7kHT2u1jsDZMQD7rH1sLTU+pz0ir6Qkvg9oDCSg8WCIRBLi7QwICbQ5XanXT1gDkeH0g9hDRHli22QASzuRT6ReKgyOAAAjUnXNLL6bjsnsasDRNggYZ8uY7UwARu3i43B8e5A1PpaaWviDCAtlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131223; c=relaxed/simple;
	bh=wIpvJak6ZVj3hHDEzcEBtT8dMN09ugMpGOArBr/uwdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OqmDJgLMG6SRlB/Y9UmJJGricUgUdCPcGh7Z7PZv0VMS6sCSIE1sa2tDVV0InvIbD/pC0PKosgZRoLOjERvlcK+Opx6/612IifAAwqZKUBowDZcOyfcuSgKiUkrFhoypB7I7Hf5spbt2aTsPlPtIzIuWNHQ0/mmbisMTQTc9UKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BvUXctlE; arc=fail smtp.client-ip=52.101.85.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n04nRATfAEira0o+sZ+A2DLIYbtKCm9BDN0TOMyzfDjjoQmPWRupNXqH5fr31gVZaZNvr/ObJsIoYeB2EEPYqwvbAT4xOc4Rj3a5Lk/XMJ3+jrDPwhceVmRK+n4YQ6Oc0c0m8dKgkjaAbRNA1VNpgTX9+DHJgAwRWU9aRRrp1vaX7j5jC7Ce+JxUi4lmrPzxbrZONrVTQ0UlT5tfDYpKp8oBeyCXT/oXY/zkuXAff7WgMkUZwNRn5qv54AeERTNE2G0sVGBOV/oLfGGmEDDhTLabzUQtc548sfsEpcWWtg4AE7qCWg9ml8yoBUWGXz9VkVk7FLIHJ0A/80VY505IXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24oFRjwuRRpNyHExnSDV9xUxqGPclR7fD+O4dt26Wjw=;
 b=DiBSlUeQR/5w+xFl+OeMlR/CMjc43H2Ek1wyT7AuhxBieKr9ruaF+MAfswEzFHO61swrXhO17i5vF14HECIgXZDzgwwWga8rO1cyzN8tRsf31f7W9r8QJsiRJHju4O8nKUt11GIcx6bkF1WVcZ+3vdSK0Mpt7+6lFfnoU6Nu0Pi+AcSGrwNFogjLVgqR3olktokMJCCYk/vbw0+adxGRcP+qMhSKqykVqxTWT35wqRAP25hjprvtccyt9juRO39M6z8ovFYJPjlQ3tWE6WW31vEvPzX/443zUC03Xsip8wTQOrt2V1FuPHw/Z/4gHpzizO/2vfxHneRn4QgQcjVzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24oFRjwuRRpNyHExnSDV9xUxqGPclR7fD+O4dt26Wjw=;
 b=BvUXctlEzX5g1c2GndVopnUEQZLqgXYjnUIoKnW6a9hLovUC++rQ/lU1o6EmMXIcV90XYbOi9GAJl9n3WZPgDKc1Dnq8kwMMARM4qrAQdG63UAQEeuCMCQOvqLoszNebJraHg6yrvlrVOoN66sBQMd/ykOQWi9wgRmhu4UcCivw=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 CY5PR21MB3614.namprd21.prod.outlook.com (2603:10b6:930:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.9; Thu, 8 Aug 2024 15:33:38 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.007; Thu, 8 Aug 2024
 15:33:37 +0000
From: Long Li <longli@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
	<erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Thread-Index: AQHa6R/zQgAE3/VEwkaNHXMnN1gZdbIdMhgAgABL3IA=
Date: Thu, 8 Aug 2024 15:33:37 +0000
Message-ID:
 <DM4PR21MB3536C9A8DE6A2C19C5C15C1CCEB92@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
 <20240808110026.GA25550@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240808110026.GA25550@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e67d904-4d50-43cd-b910-691a080d6b08;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-08T15:31:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|CY5PR21MB3614:EE_
x-ms-office365-filtering-correlation-id: ddc35df9-c065-46a1-3514-08dcb7bf78fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fwaPgw/wZJSbaKATYBqYXHCG81X4PeSYXFDOnIZNW/6kuMhTY4PRNp/ccjiG?=
 =?us-ascii?Q?uHu8cLcYvFoF3XdIGLq0mxAgscgvTpTGliv9e3XAJY+21yNPY+SxjsTiMc8g?=
 =?us-ascii?Q?M1VzKI59o33B49nPSAf+VW1DgutZkeCrKgUCBdOFOcckUeRCYClBy/8F6PNE?=
 =?us-ascii?Q?RBwAVO2XJCP05e+b+ZJaOu9bBQn3oZX3U/gMJrvnkyF2TGee0eEkid7Z1wLh?=
 =?us-ascii?Q?Ao6WjgcE9Z8/pBjWaY3IDk2UrPabVr5DfC+KVSofNGMmc6l2uyPAc5cRGMA3?=
 =?us-ascii?Q?c4AFRU+yukQcak1fTh2iaZBc+Nuq7SaGY+Xw+dQCjqwIEe+S7L+bZUYlkLLf?=
 =?us-ascii?Q?7v5aC6MOJ6n/KUbpAIQjmmOBgEp1UWdfpxMRtyEPZAi5uJlnJvMaEJP/9MY5?=
 =?us-ascii?Q?ysKxRNQ0R0dcvr3VEjZTK4nO+gDleUHKU+zRqQijYjNw2zImBNDQBFyZpiio?=
 =?us-ascii?Q?E30jYzBUG+A1K+bXBty1A1DSL5ZJous1ewc5Nc84JYbCzKQcb4QOx3LqvjeL?=
 =?us-ascii?Q?P6vh9/eH2n0veHcl/lV1t9KpXCepXfgD/R8wNDHGa5vzhzkJZGrlqcin7YPV?=
 =?us-ascii?Q?zWy0owoC39XkY10BtFKYLf6XMzszRWg/pRMJnQWBKU1IxTMA3yXdo70dvUdu?=
 =?us-ascii?Q?dAsE/OYbYwywj4eopRHwLE5hrWaDISndrFdn3Aj1Em+BYyrLAskVyOOORSqd?=
 =?us-ascii?Q?EuYj4ug5l6YBrO2F9Gsc4QOr1OYVqSYvPdiN5C8cKu/FJ6ZVL00trrfVa47m?=
 =?us-ascii?Q?C0dy9TTri+47MnL5gpzNFzioOUzwc4RjYlppewcJJDGoKyjKFQ/FD7AxfjcJ?=
 =?us-ascii?Q?OjXpJAG5jtBijkAjZfslc2DQwOZHNAJKh0zPAq8GlWqroPG/9hwiHLhsWGKF?=
 =?us-ascii?Q?km4Xmcmu6mNdma6Iqjy7wQ8PfUzpneJlSpSbXr1NQsGwhDoI04jxql4P+nvo?=
 =?us-ascii?Q?9f8HbMabyVPXWXKba74VTd30pcoe4Gq1JxmbGEeAlhYpFHK/d7BfwmuHkF7m?=
 =?us-ascii?Q?g9TBrAMCuoUtmH8Gqelc2opixILfWH0rWIXOrEwN+zxnK5zK6/mWfXTx8/hV?=
 =?us-ascii?Q?AgkhEVCaL607Esyx6rvcOLtiN8n7VTiTAjSOmMkM7wm9FH4N4aEIcqk48B6c?=
 =?us-ascii?Q?/LNLRplhsXUz9MlOCD3rkqi9FwF0mNtbQYzI6LeMiih3T3KqCSbnbhEqKIop?=
 =?us-ascii?Q?pf1tB1X4MdhruK4ZZIrOFlA7GltRPsjhyna1UvX3C9LSTu4h8RRBfG3chMxy?=
 =?us-ascii?Q?fZ9EKumjVlP4xnr9I3NFazSYjPYf6k8obXaHI5qcJT7jxaiQXZevjyr9a64c?=
 =?us-ascii?Q?9KNFKFFwEPwrTfYW/lpNppyTD/CWlIWAbtwRC2Rxqe0UWzrUC8XDKehtkxq+?=
 =?us-ascii?Q?FiApK2WwAFOtxM2sPzuVANVP5oIEjrmXY6ncpdtq6ih3+Mg6Kg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J+HDDruG/5e46yz3rgWSQWAnbWt/uoQD5pslHHXhN+EWTzwHaSMpA/KYl22Q?=
 =?us-ascii?Q?yxi+ItNWc1o+GLJnGcNwG0LhQmuamLG9hpyGKd9BHrvWlmt4CPQxe8INKzZc?=
 =?us-ascii?Q?23B+9ymcBwgsWWZ7D/x0lvCFKohjPtmob2QDVcJ0ZkXndbblRiOe5CwLm8GX?=
 =?us-ascii?Q?B6gmfQvcmpUf2lI3Q3hosAQ0HF/UJ3+DS+XeT6aQ728m9zAkTyGaxhjRm0f0?=
 =?us-ascii?Q?2ADoCKZ2g/agsuoYYL/0TLmqjEIiaK5T5rpjB62pm/smqKJCejIuUE14tHfQ?=
 =?us-ascii?Q?+msGxXTtllSUPchvN1JK6YR0f6fvajvQQ5tionGtKPFG/l1WxqimrXsvmmj5?=
 =?us-ascii?Q?v4qA2o0PXAiLCYr8/SuWy6IkPXcnLPVMBPQZ/RlgETyS22N+vTw6i+hbudbR?=
 =?us-ascii?Q?gzFJMuk5C5yxAs2iihvr9UgpyS7EWMvQxqrLuJgrDAv8LjUcMmLSvcK2iH9E?=
 =?us-ascii?Q?rOdlcYIRwd9tlWsryclyNhy6h4erx+CMl5DpOpHdy50YxpEmItaW8bZ/HtjQ?=
 =?us-ascii?Q?LUZGSkN/vTb/G055x55y+fQuq7hFhfLEtNLSP3mes08RIU8lR7ahRKBUp60i?=
 =?us-ascii?Q?8oLmkhi+mjPKkMfCNGEeGB1S09VBBYLCtwJE1KaE4KmTvDNJo0Q1dVJtJvVS?=
 =?us-ascii?Q?ljMmhN86SPRAndN+/c4Ym1FmvGZwJbtqzzrsqH16duOrmCmfEEF1j+iiyEbp?=
 =?us-ascii?Q?UsRDsGSqh90nMA1XxU9B9q4bAoo0cjB4/1Fbgt3L1B/94zWOYciyhj4Ai9VS?=
 =?us-ascii?Q?8MJxbVOuuM1zGi6u+HxXMdj4VvPrZ1bKuWcKTwV6RINYIsfeGtjaS2nfJlYU?=
 =?us-ascii?Q?Fwgdp64nnCHlhjhKuTDWTbOV486iqPx7dqkM+g8z8KAA4+iBDDWS1E+4Jx6F?=
 =?us-ascii?Q?PvTYTBi0sgxhbAPWwJ+PfhmP1rqRaTK0womwVlcoazISzZzhZv78sQ+1fELk?=
 =?us-ascii?Q?BiUk3Zv5LMXdxvfMSFyITgcr72YMnsJl0cl3P0AOSx1EpJqWBsj63DAJEPw4?=
 =?us-ascii?Q?l7XRXzRqhYDe4jBayrxZAtwGzb9uktHV6qaYHIlF9z9/x3+6FV4np5HpiCsa?=
 =?us-ascii?Q?OG+mn/WqJefLy4i2eymT02h9ckuEyTccEee1HBxNMPDucgaNCan8rmKGg8H4?=
 =?us-ascii?Q?kMk7aZ/VI4/2UMJ2DFIIaeo6B6duFmuSRwBDANxHJTcMT+b3TnL/+6KOZiiV?=
 =?us-ascii?Q?QkT/uR3/hBSNHNlkG746zMXorVewioaR9RTe7mxYjpMCPwZEIWrMco3BAMA8?=
 =?us-ascii?Q?xVnyWhrxKjrVA+7JB6Wf0zVzI5NWX9J85OgDxeLq/EICPrP3tKibH+Xi8w8a?=
 =?us-ascii?Q?r8WrQv6Ulzm/1mWAXUWEaKPvHPDeO6p54miqDxEHGpj/X/LZJREnfT6CQ0fo?=
 =?us-ascii?Q?B0bjAU2afoVMk/w2OAwGOuiaMwxmIFKjbCOYGSii3bbZjFj3MXPfx16lXagb?=
 =?us-ascii?Q?SWVGLj0TWwyBtnzZW8spvUmRZ0ZAC7wz9VtheAvQjIr5ZOXazF0kmqC+y3np?=
 =?us-ascii?Q?lcgi3aaGEJvSZnI210HyJN47los6v0otiTobna35nVNSlLU89+CbsD07VCuk?=
 =?us-ascii?Q?JpmVuGE83WASjiuxPErZlGvMzl2cJBy7RIzHo8s5?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc35df9-c065-46a1-3514-08dcb7bf78fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 15:33:37.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vQ2fSeyXcpR7j4BcozZ6sCHeigy65k+UWLKi+WCrVV+InlX4WCJBQXylDtA8DchP0o2sHL4Z5EREVU5rj2LmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3614

> > +	if (w < cq->budget) {
> > +		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> > +		cq->work_done_since_doorbell =3D 0;
> > +		napi_complete_done(&cq->napi, w);
> > +	} else if (cq->work_done_since_doorbell >
> > +		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
>=20
> should we define a macro for 4? may be 'CQ_WRAPAROUND_LIMIT'

I prefer to leaving the code as is. This is the only place it's used, and t=
here is a comment explaining why this value is chosen.

>=20
> > +		/* MANA hardware requires at least one doorbell ring every 8
> > +		 * wraparounds of CQ even if there is no need to arm the CQ.
> > +		 * This driver rings the doorbell as soon as we have exceeded
> > +		 * 4 wraparounds.
> > +		 */
> > +		mana_gd_ring_cq(gdma_queue, 0);
> > +		cq->work_done_since_doorbell =3D 0;
> > 2.17.1

