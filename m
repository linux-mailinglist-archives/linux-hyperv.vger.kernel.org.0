Return-Path: <linux-hyperv+bounces-3351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA89D89D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 16:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C4D1694C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A991B0F00;
	Mon, 25 Nov 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZWAR05/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEC28689;
	Mon, 25 Nov 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550167; cv=fail; b=QkhYpqEFojNk5m+7bsv5wqLjC/3eVYO8GK+ym7hHNIwzw4RQVoyukXs5XMM4IX7l2KiZEcNcQo4QlqPAFrthVSraG29uKvHNp8vUtW5mA9TSCc8vIxj/B8JPMU9JgVbxeCjJnkKktTgWG9YLWSVUqPr0b/VhlgF3GKpBi6iSNls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550167; c=relaxed/simple;
	bh=RHIC1B0V+B4UXUt0Z2QnhsG1VuugfP2nAMnDtlX8ado=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VU0sZZSwtaWhNZZfQuIEPRvPjuK/dot+eSt88j6OsWW8woUPyni3z4TnyC7SgPGgwo3JG0/6CUWCXxxvMsC6mVfecu2wST/KOWyWERQ6L0r5/Otg25dv+TyhY7Fj2PegN9V8aru4KEAZDylLfbs/wlR58mr9FpWEKYYK92OSIDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZWAR05/; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkzqVM2f9+Fr4oQ6GzS2PQwMgYy7+wTJA/hfzP/6wAW4gzU3yiBKRqE7d+5JRdMnyqYiA1VNzoOYvLEv65ULGfpLJuBrJpLApstikT9CL/s0aS9t5tNvU0K0ZJtbYHEVE5gbIaTOtrIRnxr1wExeok7ED+1816Fghfg3yKgZ7Qg4BUBp6d5+bRSR32TF3NtcBEg0lJDzGDNaDhjfC2bJaEIQvrimFM0T16W4UTcwULhZkSTbNcKkwZ6yzcgZktMXVoaN9swO1XEl63bSWxpFVihFNYXQz4iEnf5Zh0OGNoISJU48ekEfun69mPPq032nzGM/9nDEsjy36WqWj/qZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5qk1KEld6mm9Sb7+W1MkyYVW8HlR/bhCZa1lYI9a4c=;
 b=D2imMUVzUZQf1ivT+q8/6RwehQZxYaXSb7aWPfvXH/jlFDBKI8dmpsyWren1FoPE0sGAyhRzk5g2pvtkNystGQUFmQeEDpBBapf/NhY8kboePfQHRhab39zEh1T/NQ7wyzUwjSnR+DT69oOi2WOQjOCi/Fd1lFiPyjdeVpXek58FOEqqfG0lEZ8p8t8uwalP130HO7ocwerZ/YfysvZpgSJz6Q0nSQZ9Dyem9mKQ/3g8pRabSLqTMBDZe2MBYHIPFBgJWMS5gNd50RPUkEPeB5Z2ZZa9FwKK5wAn/bTJRFijOKRs6Vvfg/sNLZzMM1aRfskfmAbVuv1gklAy132HeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5qk1KEld6mm9Sb7+W1MkyYVW8HlR/bhCZa1lYI9a4c=;
 b=AZWAR05/Mr4lzNjP+GlJ5gz+vmNcDaxlDodi/PxtxqfBb+mThGpMU5Kp4uCdxODLkblRM68CNZU9IKAYHFYYj7MbFtFffwQHrFoHoRoQ0He7JKW+ZOi3g+I65lPnem6r1hWCSLxAxCLCEFZzff2Ecgv6IrToQKlNWzkBYNeT1DZdW9NatnO54L4G8rfYKf+/QYkNBOSo9QyoGxc7P0wdrUr9CD106O66gSe2J0Jhg6aM3A9Z5N0k6Ct7UdZ3jdITweh2UFNwJx9zcOaGxK8IOXwEvhcs34G9khgmClNhas/SaoE0qqyMxI+jvkJBriVwm3EEhvUHeXMtzUPP8NOVlA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 15:56:01 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:56:01 +0000
From: Parav Pandit <parav@nvidia.com>
To: "NBU-Contact-longli (EXTERNAL)" <longli@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, linux-netdev <netdev@vger.kernel.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHaxup1R2lleJnzVk6KuKLvG3YDJbHZiuoAgAA3H4CAADQIAIDnzb+AgAdS3BA=
Date: Mon, 25 Nov 2024 15:56:01 +0000
Message-ID:
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
In-Reply-To:
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cef08f22-deab-491e-91fb-37f050d49bbe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-11-20T23:52:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB8826:EE_
x-ms-office365-filtering-correlation-id: f679e37a-79ce-48aa-9ed6-08dd0d69a8e3
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p5yvi8fz79odu9ay4JtrlnYQJx89ehumq1XH+YFygpvYbrogSFQqB+jEu5jE?=
 =?us-ascii?Q?NMFAAkGcQOx/X9A+AiiWUgg5ZqAiXYQ1y+xcmvV53D+/LBzXhlta3QOJXctJ?=
 =?us-ascii?Q?GmycwBBgSOuKAkP6qy0HcWlfU3o0ZTuJUfpTVaLM5TUrqszAwUAN5dAguavL?=
 =?us-ascii?Q?DSlsrFav0PUmBZhDdcmOHBCcWvI66LL3lBxr6Hh0OUhMBG+WYRtMBXIsHIbU?=
 =?us-ascii?Q?y1sslHgkdRe1d/Z9MK6aQN5xdbwUZ1NfcJt57MNLHujmglldcAyfOvmFvfiX?=
 =?us-ascii?Q?qhv1HbOk2MqQALJl6oUN/un4O+u+oMvTy+dFcHYUR0k55Xmm5htgEcar5urw?=
 =?us-ascii?Q?0bs6conEemHxUdRQEQJiTIwIjhqYDRoAV47/Roa6x88kM2n3/xGL79rJOB8j?=
 =?us-ascii?Q?zsdJTUGji9BsNGXvqsbiQkpQrterExsXdpmuBq5UL4R4GS3oxh5r/oOaEb4g?=
 =?us-ascii?Q?9fXeDOSgqb3Y8Q8KNfI0p0+R5G8cjDX00dZNj1WQMubzh4IKvr8MvOw+jA9q?=
 =?us-ascii?Q?q7A5seJJCDMi+5mD+X5Kpr2RNitfMIVA9XWvLmyZL6s2pg8/WASpGaVrdq4j?=
 =?us-ascii?Q?exbOzAGOAr1Iz5T3DMQpI/dxdEEw2vtKVZmM6dfkQATBym60YJcqRpRPmzRX?=
 =?us-ascii?Q?oCqNiUsLbZ9AecA0g1mHHn2BJizxYlMYxKCLldNiCIGg8YHwCsFXNRiLYjFA?=
 =?us-ascii?Q?m3pmiDyV7VSrXnGkpHBxygyKORh/Dt/bUUulLWkfaJFC0tG+sQxLx8tSTK6m?=
 =?us-ascii?Q?eGDujmUAoKZAHkwVgNdJ+1DJmBf5eAMtI2PVJ3R3DhV0M2SPm/ahXfgc1ZMo?=
 =?us-ascii?Q?E2/Iwagoditz7REa0AEpT8AA4q7CZiVoozQm5XefxYfq3VDa0bdN3oX7dB66?=
 =?us-ascii?Q?wv4rE/CUaz1D6qLR5OnqkuPCullnSUt2wV/xG0r0zLtq0i9mbMdhG1WQ/A4M?=
 =?us-ascii?Q?/qfrR9tv1netsT66cRPWGF4do+63lP5arD+z4a761wtZdLL8EC83ulgUCgcG?=
 =?us-ascii?Q?OjprBT4FGI1fY/iJzPTtJPJlOoT0CSyBUcyAJeWQ/cTiJ9mcY8LqfU8ihdkf?=
 =?us-ascii?Q?LUa9pslac3M3vVa0ZQTkulhj9F9jQZP7H2vCngaGLwTDyuIRcMh5HlXnC8WE?=
 =?us-ascii?Q?Q/ff78oC8AXCSkwKgjmbnkKWnLE4BAYJlpL0JsCQruRW4bPc9L5jiEpe53ds?=
 =?us-ascii?Q?tMr/RIMVOcWbf1hLq3WMaCuPbpM3BgPU9nzXHpS8G6bhCoKGLzMCSs8yJUlj?=
 =?us-ascii?Q?rt4mlzqOcUq1MosNN7NdCFoIDjHUQe4rSgsXqXt/qk1fD+A3XLVNYChmQvbu?=
 =?us-ascii?Q?NR3oI/qw9zyQQow1jTrEj6GSSh/Xnm7Czd6aA1p/sWJAWhneNZZL+32dgAfp?=
 =?us-ascii?Q?JFLMYOsOJ/6vSet2MF/UGKnGTQG4cgjipZHviZI5QIFW0rLWyA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0VFcfBQ1fkv7XvlLwPKfQm3DMxV5BGbdI88wITygGSJG117fRLG5UgKTzOAa?=
 =?us-ascii?Q?8LQOrpaJRpEUmodtHZsu2D0FB+6mtwYM6cttSdlPh6Cy5RlcyUWr1NbSZb1E?=
 =?us-ascii?Q?+gTNHsjHRwwr6Y4fBGVoA+VeTTc+xwxSBHjhHEyp5U0wdpZkjgd/gIW4MRYq?=
 =?us-ascii?Q?Js7S3IhewCwaUjeXbHm4nqH1Nm0i+aFL4TrTKyWkJYXcgusWpN9QwLaC9u0Z?=
 =?us-ascii?Q?ErRXaqPWrkoHybrJI8khTk/eUwC4/wgq/00ckW8P9ZByFcOjEAsnLxaiN2cw?=
 =?us-ascii?Q?27rEyIkf3V+uTykKmB4VnovlehavDuPiyMyfOckDVDa0+H+c5X0rh44Q9FXk?=
 =?us-ascii?Q?zHiuHH9T23UVHp2wG/cGDmpsXbjeALMWvbleTTiGMOjC18Fl2/daXQ265ouj?=
 =?us-ascii?Q?2lHo4EaDRb7MC9XkG6WE8HgCnkP33uMk0uEUlv/qm5hjypQVWcsQNF2SNJch?=
 =?us-ascii?Q?FgQ4vMpgP82QX8DT0a/ZF2ryyWme3Dg5Li2SjtXlcQIldg3FeaBu6EFZmH/G?=
 =?us-ascii?Q?w6IT0qXUbQfhl9MjwO2azXbIIcCww3PNDqi+JLd52FgolsLAyi3eqP2wKjdU?=
 =?us-ascii?Q?pH6biHA0uxhYzYKLK3VuBmuUB4ajNK/+Iou/DlPaC9DwQot9PgpXfXd8aZw9?=
 =?us-ascii?Q?m1LGxaKsSIc7W6q6OGDVOSRPRrnbmeX27A4cbbhDTKQnwtISGoUp0NmkxWPX?=
 =?us-ascii?Q?KBlprv5ZpyI/p3ug1fFj8HHnRXmSnZN+nJpL09+7oTk+drCxfTvnfJGwVqJP?=
 =?us-ascii?Q?PFaeOsZIzEvQuBzFvO+DhXjgoSwWLiDsRBAN63ZTwNpXlgbTQjjkitPp2Vu7?=
 =?us-ascii?Q?Euc0Qz6Swmth6YZ/k1S0mgIY4OwSssbnln1ih69sFFB+Z5apG0TLtCdroZLf?=
 =?us-ascii?Q?xWxYsujdsjqRoXNi/F9ARyxDvJCU4M43AR28VEiwyQKkc5v+NOB90GRI+QX/?=
 =?us-ascii?Q?HvxA6NBRoFXOQgTK0wZbpMmHPCIznM0LMJcgRyuQ8gPP6w4SSOD6p3Y7BeqC?=
 =?us-ascii?Q?JBoInCgGn+7gRA02wSypo5jxtJLUtei1YD/FbEZnUBMeFxWQLyaSyS9cki4W?=
 =?us-ascii?Q?f0lc4Fe5IuBQIGgFpQJETm3XnADPxJhpq4+P+5GxwM0EnMwBriQGC0eUmnXz?=
 =?us-ascii?Q?XlhE3yoRtWZ9Ro0lVsMvNkluAhPQEN7cTI94nnyNS/ZKDyY0sVGLjsJ+1dbQ?=
 =?us-ascii?Q?MxNr6XwF+nZagD6TsM103bzSoaHN/I5XpCBlHtMuJWp6i2lanlooyWi5/l5T?=
 =?us-ascii?Q?ls1zxKgrGiZGv0tMzU43Id9GOYN/5E7z7h7aBYQVUzrK4OFSV6UsNLeqgJCn?=
 =?us-ascii?Q?lhNfwPmsjX1KlmQwT16YpSa6XIe74wnWtuqOvIk0dDe8WYkXuGcQiX2ThyHg?=
 =?us-ascii?Q?zCHpf/C43k0UgP6lMwT+w8hotMQOJUN8yKmX6k9J5B+wzTyjfG4dOOUZMFoG?=
 =?us-ascii?Q?cYfX7aYX19vc1SA8+2ZSVJVthxWPocsoHtbycyG/dlj32AyJFeKwLt1Li6Q1?=
 =?us-ascii?Q?lcMfqc3JVE2Os1utK4SKiC1Ad4+4NGOisXCHdnm162/8cF8MljBhvnA2mnRU?=
 =?us-ascii?Q?V7WwhVDJFLVMs32mo40=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f679e37a-79ce-48aa-9ed6-08dd0d69a8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 15:56:01.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o56AtAVpFa/gkmh3YSalW819GsHr+RxVoZUdZkjqa0V4vHgJf8UE2n5gYLrxQt1yo3dATkuFja700OiGFmOyJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826



> From: Long Li <longli@microsoft.com>
> Sent: Thursday, November 21, 2024 5:34 AM
>=20
> > >
> > > Actually, another alternative solution for mana_ib is always set the
> > > slave device, but in the GID mgmt code we need the following patch.
> > > The problem is that it may require testing/confirmation from other
> > > ib providers
> > as in the worst case some GIDs will not be listed.
> >
> > is_eth_active_slave_of_bonding_rcu() is for bonding.
>=20
> Sorry, need to bring this issue up again.
>=20
> This patch has broken user-space programs (e.g DPDK) that requires to
> export a kernel device to user-mode.
>=20
> With this patch, the RDMA driver grabbed a reference from the master
> device, it's impossible to move the master device to user-mode.
>=20
> I think the root cause is that the individual driver should not decide on=
 which
> (master or slave) address should be used for GID. roce_gid_mgmt.c should
> handle this situation.
>=20
> I think Konstantin's suggestion makes sense, how about we do this (don't
> need to define netdev_is_slave(dev)):
>=20
> --- a/drivers/infiniband/core/roce_gid_mgmt.c
> +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device
> *ib_dev, u32 port,
>         res =3D ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
>                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
>                 REQUIRED_BOND_STATES)) ||
> -              real_dev =3D=3D rdma_ndev);
> +              (real_dev =3D=3D rdma_ndev &&
> + !netif_is_bond_slave(rdma_ndev)));
>=20
>         rcu_read_unlock();
>         return res;
>=20
>=20
> is_eth_port_of_netdev_filter() should not return true if this netdev is a
> bonded slave. In this case, only use the address of its bonded master.
>=20
Right. This change makes sense to me.
I don't have a setup presently to verify it to ensure I didn't miss a corne=
r case.
Leon,
Can you or others please test the regression once with the formal patch?

