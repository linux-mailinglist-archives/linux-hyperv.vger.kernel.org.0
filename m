Return-Path: <linux-hyperv+bounces-3345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826459D44C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2024 01:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93BB283A73
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2024 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0611FB3;
	Thu, 21 Nov 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iz0W985F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022079.outbound.protection.outlook.com [40.107.200.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEC230980;
	Thu, 21 Nov 2024 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147425; cv=fail; b=fvruSTGESGJnJkR1ZGobESDL8jExM2fBlryYK5WrVrkTvYSfi6B/3ZchQPwZi3ANNXP3pLXXfGcIk2aU1l0Q8Tw5GRecVk1pGz84+depgi+vH8RfV6qN0JH3N2k5gH89NqYHuugd9zBlJ/7Wg41wqEA21NxUt3O+m8g/S8qztdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147425; c=relaxed/simple;
	bh=IG2gz3IAoaiR+0V82EDQA7THcHytdAu7oFwRGS65ihc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGdt0eco3Q2rzjQVW10anQNSnsXpTa1SiiudF80FyEMqoBQeD81DjDGLSs0Tf+HL6Dee63wB6LIIWkdJX3ph0UtFVWShn8BgDnBNO4NPnel+uAnkGGDePZMVEAOJTusVZB23OSwA59i18cA3lVXXIaR/dhLohd9RsFwvl7b1q/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iz0W985F; arc=fail smtp.client-ip=40.107.200.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORaS3sy2jhIXZ6hS18nUnU3FGv6oJIN9S+O74Zf38sgkqHf6kekvPepUTp+BU1SUh/iE/Mql0AoZdGsUEEfiKw+ij0w57gq4cn+yGxIu0Co6DGEJYDmhjZeTQYn3FZL0Qi3W0PogUaa1fblXsZURxsNYQbN9ZZve9ZQHqzkDaMH+zifwkdSNt7l4qgZGhM29mSLvfCwmMmm4ho1jaJPCbsRpDbv0k2fXH6VKuD2Z8H1UtOJ2m2z+BexDd40og174sSwuyozjU6qoLpHc4YWEIfo9VG/sm3kh5PPdDepvtHbt7gI28ZkQxnMi7p5Nxe5CJC+uvr4/R6srBXITXKJ5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtXfVNu02/tYRP0bTioEb2T/mS79n58AyZ0OnYOGeWM=;
 b=p7PNInvBGkoZgznHJ1Xbx96bA0iU5KJr8yNBqYnU+NC3GBzuxbrh36OUgTseqiqz0JfisOwmIvFKjycXAPUnpAtGNUbvBqbVlGFhizQZwjmwqNmirw6lUmNGD4vpQsXz2/0FwgoKNvfC3OcFRe3uUABTevrRjTQghBCR7sDHekd1mTjYhNdLL8u5dxTWq0vz2Fvu4E2yT77NWgxZxQtxKrkyVMGeLNlRDuYRZA5TJOh+MemgyQMht1TWDeMjVktGBpVp61oDYciOO0uVFOWQE5WsW3GsMs/TPwtgKv6ozEUsNVU7Hn0jViWbnI3qc0qP879SrF6vEyijqjqCuBrbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtXfVNu02/tYRP0bTioEb2T/mS79n58AyZ0OnYOGeWM=;
 b=iz0W985FLI8Xj9+ySeuyGhyiW9gvF3/gBXCAGSWr0dKb5aSpPvrYiUwh4j5tScDV1BisOtSIb3DvakZqB38Rqqw+KtRL6R5aBZ0tysgu0Fi1d85AGm0AgcVZBUVz0dsZJXbpB/cj2uAPg2JUlDS9GfaOvLlJZGn/7NVkvouVYPM=
Received: from CH3PR21MB4398.namprd21.prod.outlook.com (2603:10b6:610:21b::6)
 by CH3PR21MB4335.namprd21.prod.outlook.com (2603:10b6:610:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 00:03:41 +0000
Received: from CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d]) by CH3PR21MB4398.namprd21.prod.outlook.com
 ([fe80::d17f:89c7:62dd:247d%4]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 00:03:41 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, linux-netdev <netdev@vger.kernel.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHaxupwGAu99WXsuk6CZeFbpa7lGLHZiusAgAA3HoCAADQIAIDnyovQ
Date: Thu, 21 Nov 2024 00:03:41 +0000
Message-ID:
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
In-Reply-To: <20240626121118.GP29266@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cef08f22-deab-491e-91fb-37f050d49bbe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-11-20T23:52:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR21MB4398:EE_|CH3PR21MB4335:EE_
x-ms-office365-filtering-correlation-id: 40ce3d65-d4c7-4de6-eefc-08dd09bff525
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7QT1/rSP9QthAauxZNFiWj8ALm5s1YaNo82KhGT0MnAQQu9+J+Eim4Vt9kOa?=
 =?us-ascii?Q?qm+4+wKWrbcRpq84mqFk7B6KE/X0jUC1mK1CzPoLRXUXDfDgzREognrZSBmK?=
 =?us-ascii?Q?+jttMwiFKzY8rB4QBB8S6D4NI5fSxeibkUyVlwY4QwYv/c2O9O2K05Ul1vhJ?=
 =?us-ascii?Q?ddojVnA/mHhW2hk4dmnrum8qt1/ZEzP1nuqFyU9+rccT+hY5b4aIC27lKfnZ?=
 =?us-ascii?Q?+O3QAYeWOlkSTtdKeltii45DaRI1whcfEKFvrM5StEdoryI6cc4t911azJak?=
 =?us-ascii?Q?ptvK/TfCgFQiVQFiQKo8NNhLqQxktleirQ+i/jKtSXnqg/FDnCGmY+W6/Azl?=
 =?us-ascii?Q?sHh86AnSe/YJpq69mrQlxJZIpAKotXIlkRSY2mQgMgdFah6sGF984JEUWF6L?=
 =?us-ascii?Q?pDtZ4f0WFNLL6rXGQkVxWc/zfL6PuSuJCEgaFLt1rApZom42G7WfK2qjBpuk?=
 =?us-ascii?Q?5GytWqgAnuTkn0UoIjlHjjA5dVI9b3rK5V+pes6s9wT466vF0ZF3hpU/imke?=
 =?us-ascii?Q?QUahA3Qt4ytsSBAF2ez2m4BQCSf0Z4bbpFRxUCqbGzSBGpR96CHWIUV6nWes?=
 =?us-ascii?Q?FpKRCPqRiw/3SDtNsp/Al66gF13nvRxNc1aSLh+kWEZpFUPWMA4yIYk8kEog?=
 =?us-ascii?Q?DAPFd+WxeX4V9ynbPXFwhD2x7SQVJP4DUwgTDtEIKcHZFXoPvF8mXeF11U4u?=
 =?us-ascii?Q?EJ5AzSUKIX1LVX+IpKoju3BzEnx9x7lPe5FmP3hBSSSTtXnlXkQEyIXVWXt9?=
 =?us-ascii?Q?CRpiLcLrWQqzMcRf3lYKDB8uYoZBUk+tRc2EfVdxLQI6bfsHMSKO6AtHJ4Ej?=
 =?us-ascii?Q?vDrfKsdgAbJ2o1ZYbnrNREb7ENlQOShQCNlBXqxFNT7nIk6q0ebGGYq9lTHm?=
 =?us-ascii?Q?yBY5BpRtrBMJ1o4cwIDoedHMlAzdOmbPSZwjkjm6ES+qSeLVS5qikM1A/Jlh?=
 =?us-ascii?Q?Cy9PyZb2i7jQwSJr2tFtYd1lahIArrUWbYjdV4LE0GTuqfyCmgm0ZMlnX9b5?=
 =?us-ascii?Q?ByQgB4jd5p4zViSVYtnmemKXYDCfN1JSNNqPoL+Kla7O5D+d2XNDGxxSDtLW?=
 =?us-ascii?Q?jHEGczKQ1/97clrqupoCJYNhuq4z7XaT3izihJw+1PDWJ69ZO5KBHAVL/OB7?=
 =?us-ascii?Q?tkMBOc9nK5MJWC0jOHQSBvcEwab3GxMBB4ApTE0ZeuwzrhIspsOQkXwyDa/3?=
 =?us-ascii?Q?uAGpIeOVNWkpvlnVeXcjWHma+i09UOZuRT33U0WE3THCLXnGQ/bB0lfobRwA?=
 =?us-ascii?Q?jU3P/fgQI3jmwqUIK2DGAiol+zDz0lkB/dHcOD1xEAYyPtU8YSuz80Xq32Kd?=
 =?us-ascii?Q?ysAJGzgvgQOaGvoRbSyN5I3RKZuOdSI3IrgozhpEiynRg2byZtXNiMauNW6V?=
 =?us-ascii?Q?ZYsieU0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR21MB4398.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MnlTjOx4m5Cm/NkQOJkTIvNoYlmujNNIlKlPOF7dxiDGIB+5I/7VNrj1hMdd?=
 =?us-ascii?Q?ni0do5vagEQzdcjkTyfDOds65rv01zhci4rfg8Dgw7cpyrrSC0Yok+tacluC?=
 =?us-ascii?Q?hfbd0OIZEh7bMg8l6wjpNDbNnCp8wj6sZuG9MdhdOEGql0EdBJHwtpwfMXyX?=
 =?us-ascii?Q?hc6/B/TTeyopHeK4DFnG8LrH3ap+8owogzCRfLq4hLPrbPuZ+4MSZBRS8FUn?=
 =?us-ascii?Q?9FP+g74jc9iocanIFJUc55d0cyANEcZZXEqnW7Qn/+hGtbjwPjWwOFo17ztP?=
 =?us-ascii?Q?1V3Oz3JapppRlNt75q6ViWugggCFWw4FLeQElHcjCttmkM0pmXkaQlw326tG?=
 =?us-ascii?Q?RnJWBjhnaLT5zXypGscXI+TVQQKsetdgGvXv4hQMlkHGK72rL1iM8H/U/HbP?=
 =?us-ascii?Q?xt6/QKqC3oiI07wR7JBwR4e8tU0cYFQHhdht5MzCpBPc/4OdQOshnqk8zco7?=
 =?us-ascii?Q?c5tUperDNL8DbDgjmt+4yhbVNIvCW0KBJycfgcs07W2+KJYELrGvSXgmSajd?=
 =?us-ascii?Q?KZE3gBtGVX48l/Feqvd8SlqemI1EbBLdM6eveUzBtxwlqQZgMTU2HOtnXZoV?=
 =?us-ascii?Q?6CSZ0AdWkyhjVLNW+Dz6pu6NAtZFX8qvNpX3fKEvUT7mmG2jn0AoELhGSHOH?=
 =?us-ascii?Q?LgMwrNOQpFLflyjqqKX6KnhXU4hywFEAjJqhSYQdRrEBcgCcJoqDat3RRsaO?=
 =?us-ascii?Q?Iw2INVQPyxNxt/G1zU+Z9VeD/VqxbpBoktaYfcRunsH2mmyh9DvQR+dKllEJ?=
 =?us-ascii?Q?gMBB8FBHZXl3hcCfUE5FT5Ird/utqNoxYfMhWVpnICninkSO1LYNrKRoyVo/?=
 =?us-ascii?Q?Gm8F35JxKPC104EM13SOotrtRbveovLYB5YvD2z4OFTkFJRFnR+7GHLK1HwC?=
 =?us-ascii?Q?GpjSxsNZ4ZBxZFzGjEOl5R1kNxQLMMjW0/W+a7qHGWiGS4zNudnKoZzZV8OY?=
 =?us-ascii?Q?zDXMuG6+uW1KE6yRUmVFv7SLI7N1tq6enJ9qC1ezMvcecTFKJtlEeptIYU06?=
 =?us-ascii?Q?onbsdl5f0O3q/nIls58cKvYwyawwE8tEJa2UAYkKtJEIx6mosaXoKE4AMEVj?=
 =?us-ascii?Q?81QjTEVsYYBKTENGSK6wIvA+BIkzdJGbOmQxgm6rdTvnMHSIs62JAaM6NMAd?=
 =?us-ascii?Q?SamEHmIDMfanlEqFbrQXdfn505Mwtz5Advk9G8r9R+l2+9NHKAsvvIy/ZGYn?=
 =?us-ascii?Q?oK7Z9M9Hnu9iGr9uWJo6yJlMx1N31ZFtYHm5Jm7a5eYW+i0TfXJ9SeYbquku?=
 =?us-ascii?Q?P5+BLQvFKSOODtIZwtcqO1ma344dhxMMRb/mJs+lSPFqDuYOegjM5zQ/Bu0i?=
 =?us-ascii?Q?pF9B8QAkogbrAeEjEovEcaXtnGDlWGk6KKA1pnmGIZTx4+pIMWhQ94ZX46m+?=
 =?us-ascii?Q?ut/qc4RgQ/pACKGE10QTfn45R1oexkTSttCr+l+akdNZsE0mt4vp/mMkL1hw?=
 =?us-ascii?Q?S7l6O9xenqr4YejFkV3lKkBI9ODlsK4EKux1wEKxYdahGRJCxTmvBbzq1pCX?=
 =?us-ascii?Q?UiBB6mcidYkpMK/iAi6r4kyPz4jfbV6864K95q7MsQI45qrb63DxIKL2EIF8?=
 =?us-ascii?Q?YKj4WJ4r3uCGU54AgZMs0aVQXSBCPgfzo+N+ZLqz5bG6ZXKFClrJtybOz08u?=
 =?us-ascii?Q?k1LbiPwQoSS0gShi/eHHF61W6NAwVpUeCeMYqVUqnTLU?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR21MB4398.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce3d65-d4c7-4de6-eefc-08dd09bff525
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 00:03:41.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K44m4HhXbP64pPCrclJfo80R7hIdLDOtys8hej5ET2QDpT9s29y9TUEHfzoEKPSe2awT1xESTu2blQjDx8xVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4335

> >
> > Actually, another alternative solution for mana_ib is always set the
> > slave device, but in the GID mgmt code we need the following patch.
> > The problem is that it may require testing/confirmation from other ib p=
roviders
> as in the worst case some GIDs will not be listed.
>=20
> is_eth_active_slave_of_bonding_rcu() is for bonding.

Sorry, need to bring this issue up again.

This patch has broken user-space programs (e.g DPDK) that requires to expor=
t a kernel device to user-mode.

With this patch, the RDMA driver grabbed a reference from the master device=
, it's impossible to move the master device to user-mode.

I think the root cause is that the individual driver should not decide on w=
hich (master or slave) address should be used for GID. roce_gid_mgmt.c shou=
ld handle this situation.

I think Konstantin's suggestion makes sense, how about we do this (don't ne=
ed to define netdev_is_slave(dev)):

--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device *ib_dev, =
u32 port,
        res =3D ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
               (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
                REQUIRED_BOND_STATES)) ||
-              real_dev =3D=3D rdma_ndev);
+              (real_dev =3D=3D rdma_ndev && !netif_is_bond_slave(rdma_ndev=
)));

        rcu_read_unlock();
        return res;


is_eth_port_of_netdev_filter() should not return true if this netdev is a b=
onded slave. In this case, only use the address of its bonded master.

Thanks,

Long

