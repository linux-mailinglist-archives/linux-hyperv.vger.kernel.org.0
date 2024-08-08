Return-Path: <linux-hyperv+bounces-2755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA794C185
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF86B2AB7A
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6118F2E2;
	Thu,  8 Aug 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JuO7xU9c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022127.outbound.protection.outlook.com [40.93.195.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA1148307;
	Thu,  8 Aug 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131240; cv=fail; b=kjiKKpk+2GKQzx2eaBlUqxpfFaig20AFCu4V23z+0fyLQ1xYYua4/odwdDkjcNVVUT8JixEqvzYiSY0lOuTY7Epj+LyJPAXELOx7Y/CcBYr8NjtZ9dvJfnMMj9uicr1BXwksXCPZ7MVN3UOU/t3ekJeRC3enwRDHgW/Qvqg3VVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131240; c=relaxed/simple;
	bh=kglMetnG8tZCTD+a7Mf4hZoS+wBov3VdC+MdGRdI8tA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FS04EwMD47nQKmkFODoxpSNswo2z/5oY9KRTdtG/c41THrYO6vDYU9rlSJ2jJGQXz0s/kzw1gnvK5TL8ox1DlmLZTVGE68TYlSLUAT9vtucIZdFp4Jj+pVvp9QHGkxscHpn7cVXHjD5oxQeg10ZmRTrdj4U8HG2kXkEWRgDEj1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JuO7xU9c; arc=fail smtp.client-ip=40.93.195.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCi8JkpU0rgjsIBZ0VUoSG0bPsAVrnh6DY1b8kz1X1m5+ZyZkn1+YdqMChZnbpgln1zqw4+7s5pfNEzdsuQOqqHeFVV0R3KUuED+sSoWjQdF/IKgGrW/Gq2yolXQgr//oJlsKtS1hpIvBPJ9GsQlcB1Lf2gua6p32duZPON7Rftls2smZDC6vKi9m34OGLyWBL1pkuZcprA9A8sgSretg+yMzJ+jboozSWrejmci5a2hRHHV8FYUcrgz3CVF7CEX/tNyKmpRKnXduWNcTgKgcm5aDDWePZnih+csnjoyYtYl+fIPTIcrULyPwRfe2yEYrw7j5h56ccBG4Uc+cS4CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlPNHijtNGaJxBOjPqOBb4SxmtWXSFrLcg/sDeEyjdI=;
 b=e5nkfYIjGTUo+sAM6gHITjmcGU3DbRRacao3aBnA5CqwclkB2mXMqUVnLx8rJDkVeGk0uKLi6AWqZFsg+pArpme3GwwbS4bROJ5ag4IJdsSpQBn0O4c5ioOSeyRHYznQzW9+HRxAFQO5gZuxR1t5yUqz6Y4vcLP/oRjZAeJNJF1xYmklAlWjUtet53PzMxy+vH9aU/Lpt5iTBRUdftiim8rVru/TS6mVPhH9OW/J5jLqoPaHl5Uj5DuiT0z839HvngNUx9NBGd0LFoHJA3sVnr+CZ9GMVYNih2KIdmONGBbCHdYLZzpcUJy/xAAq3T8vzpOKpfSsaEKDh0dHhpwNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlPNHijtNGaJxBOjPqOBb4SxmtWXSFrLcg/sDeEyjdI=;
 b=JuO7xU9ckppp5a7rx8wlEsFzuNKGlEEbiP13hdMrIEx6gWZLvtZtq2iL+y/7muDgqmljhRYUldfhxFixYfst12khvmBPLbSVK0irTxeo5XEsEuoUJnZIECIKpCqwvJ0XLzXMmTGpnHE0YqWbFJzh89aSSKB/u+ktycs37sdW/LE=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 CY5PR21MB3614.namprd21.prod.outlook.com (2603:10b6:930:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.9; Thu, 8 Aug 2024 15:33:55 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.007; Thu, 8 Aug 2024
 15:33:55 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Thread-Index: AQHa6R/zQgAE3/VEwkaNHXMnN1gZdbIdc6cAgAAKzJA=
Date: Thu, 8 Aug 2024 15:33:55 +0000
Message-ID:
 <DM4PR21MB35367486106C04FA145495DCCEB92@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
 <20240808075504.660a5905@kernel.org>
In-Reply-To: <20240808075504.660a5905@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4e5991c6-702c-4bf6-92c7-a0fbe4c697e5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-08T15:33:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|CY5PR21MB3614:EE_
x-ms-office365-filtering-correlation-id: 12a819ab-e38f-4126-de77-08dcb7bf836c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6RhEM0Nhjck6/Kj1KwysKnACLzaKNIrgU5iSq75yaXrvLgHJu3A851jW49v6?=
 =?us-ascii?Q?DGDr2M+KQqTS+6XmzyAYCZag3oFPMRfCf4GHz2XUrcf83Nz+I9lryp10sJyA?=
 =?us-ascii?Q?QBHGBxPN8qeQnOMwax8N/MpSbq31oAG71k205k4uNIr7xCvYlPsIf0fWb8ut?=
 =?us-ascii?Q?Ap3uDguhNsTSO8q0PYaZZHahEPscXqsYrsMA8CN+3OHmUjIFQt9Gig+zmn/1?=
 =?us-ascii?Q?rdEp6e2xlBzqDHSdIgX6U/v15wuRrcUOnwBAiDBbcuIifXWHSOOyT4llB6tp?=
 =?us-ascii?Q?E+n6+K4YmIFZ9i3cFpb7Hm+oBG72Bvl6gesjhdYj1tLYth5aCdUX4sdrEr1q?=
 =?us-ascii?Q?zMz0J+V/YC7ymPuwkap8BNZoc06ku6rP1uMQhoIep9DYLHsJCSa7ASaxVAOO?=
 =?us-ascii?Q?gFLT+W1jlgkQPQDRP0jQH8YPe3xLsJiUg4jS8deiV/znqDIm53tl67lBKGdX?=
 =?us-ascii?Q?UnUCJRsfV26cbCI3jSzK9ajqbpn1t+o7OQBiy/gWQ8BOoXzmtjddNWw886LB?=
 =?us-ascii?Q?h2xxLZg4gXb+ps+kQ53SHhAsodO7JIKTXRNvTrDIuO+9ct7B+6aWmeAqcuHJ?=
 =?us-ascii?Q?ASe8ek3odX7B2lovNIYK0M7IzCbuA1stYB3X38yF8m9BOqY/srr9xXRz3ElT?=
 =?us-ascii?Q?zNhJSAdGO+3W8KIYO4t6ZKhWLTCEG2/y3azjz9GFMjfMEFyQ7MOVMvuoSl1X?=
 =?us-ascii?Q?KP+B2D3xHDEF2JpKLyVr5IXUfIiMVBWqUPw9TYo3A+rTIDm4TWlOISLF4Myk?=
 =?us-ascii?Q?J09eynoh/lTLhU7enc1QF7iAiLUiu8qQgi7s0piLyG2cwjRHBYxW/J9PZ7Qq?=
 =?us-ascii?Q?8V0RjBHeGMhked6JotlV7gI3cbH5GMmEkKJVS7UJm6i4YV4Bit7uwEp3kXjd?=
 =?us-ascii?Q?HS0fFBYD+QT2JIzsi94f2Wsmc3xuEsfCFmvhyvdwI12HTgNa+qoI+vchJwbw?=
 =?us-ascii?Q?Mk48cFfLYuFNbu7ES0niQGEUK2Pl8eR3R1NHatGKbkbf0Dw+ZFZ/QWtOe1Lk?=
 =?us-ascii?Q?OkEV+NEe4h0ct0aJl1kATUHNJqQcW4om7jM2WHxAGeFwTgrKDXDvy1LuVqPR?=
 =?us-ascii?Q?CCLUEj2la4XLoISOOC3iqQa99itTN5ZuAOEjm52i3NW/PN5RWvQObG6T+Xeo?=
 =?us-ascii?Q?TV6CESa6dFU9AxYLrJ5XPQjFqQFFg28Ob7hdVuHvvEZzWbjoqjWKBDmfLxSj?=
 =?us-ascii?Q?O9ij5D9JtS9XZqkeJ+wQ7lWweOQ17rx0P7MCaFZSoRfuFXU6bA013i+oWzhU?=
 =?us-ascii?Q?s/MlLdEQ8JL3KagHgg+ZKekVdJHU6r1leT2W8mTAIpAxAVa1VKY3veMbrBXB?=
 =?us-ascii?Q?PlEW2fa/LyfiKAVNwh2v8Ml403UmUklIvhlacsdbgMAarzLUVmoCkbT79OWQ?=
 =?us-ascii?Q?MISRZ3BEPkVK+86fzUgg6ZHHo1c1DjjdWXC0h2VUyJZ/wHkUUQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3DRUVSy1EjULPjFkal+psx2IsE2p9i6Jle6Hm5SqHFO5WUVZM9aLAOI9VlXG?=
 =?us-ascii?Q?o+uEPuVLtFuQCFjkNiXqH137dtU+osLSB7NyzsirfXbcnWrj1CMM1xwG5h6a?=
 =?us-ascii?Q?gUJd/1lwxgtC9vU82AHh2LUx5qMtArodceR/Ep0cBjNXozPNyzlkQHTOyrv0?=
 =?us-ascii?Q?KOnT8b0hK3otKOE2loB5FyHeHrNUDLLcO1+Io2HgvbEvLrN9CveWYMtKi3Rp?=
 =?us-ascii?Q?/gGbUxe6ZGZgNbrKGwDnJHEhuU2D7eU6J/PvmmW8w93zL454WqPvb7w9bAxp?=
 =?us-ascii?Q?YlwjQQT29dd5yj/T5QRiIiNC5BgNJ+3meTxq01wl2AEciBWw+SXu13OnaOoz?=
 =?us-ascii?Q?up2m4Yj3Xwvy5UE0KAbfUR85TydVLeYA5OGjQl4H+GLLA7WaTr2NSW/B3trS?=
 =?us-ascii?Q?Qw0lTVJ/YGXoAxt8uHR4AuyaL7WRZdABGXL1mOM0CFnEnCcG+YUSXein2GYx?=
 =?us-ascii?Q?2uAtPTw9inlCcmTBPcG6Rp8+fzdhi9NuqPHcig3glVPnv4XfVQwMi7fp7Vw4?=
 =?us-ascii?Q?pCcqoW2Ks/oBAZiDSmBct8u8IhkMMygGVbNpQbrUWepJtsPCyDaZrYV27lkO?=
 =?us-ascii?Q?QV9o3uD9gPq1bcIRoZmH3lhrLuI+06ZktljHyQd5JPB79DwjQMSY2bzVMCxw?=
 =?us-ascii?Q?DOczPtpz53foK0UdVEB6NI7vFkreq7pILB0YOVF05ALWfWnQg364CyaiQUaH?=
 =?us-ascii?Q?uZC8FRVnQJb3rpatVLMvt0puZAr9SQdj0ozr53d7IdfCbWeGcd1WKzaDrRp4?=
 =?us-ascii?Q?ZGl4WnTa9K428wVUSbmk02VFiPotAWBy5Lj+eCnpVwo5dQtIJ7UPwuMM+hge?=
 =?us-ascii?Q?ZWxU28zYmGVXVbZW+hl7M+OTvrbAft37aDE7OpZ85jZMRfptqEMYpc37s+so?=
 =?us-ascii?Q?FCaqmTAKU8KluJ+uleEvwjq/7Q9THaXHwQwzUIh+s2kQF8BjXToLhlGUOO8H?=
 =?us-ascii?Q?UwDG9Sj7ZGOo3uPOPOOuy7aDc5ANiHx+f4cSHvkBO8hjLpog4cBjbRvbvaz9?=
 =?us-ascii?Q?jbvGQLONnmnb/4i9jn4qUoAVLUAAdK4yrtPdcoCJ9VA8s4D8DzlpNGi8YsJh?=
 =?us-ascii?Q?BVNVPA2AdiCD3sLI29yKQuD2VxdyHKJA0I96oI69dvm+uvQghWQghodq1Kxi?=
 =?us-ascii?Q?44SBRBWMxonq3wluzgYmssYIUrTMuiqKOclHGWCfKkOysJNBrVjwDuNx7tXp?=
 =?us-ascii?Q?5VIyREEAL8JXlfwt1ffHno6mHvKnQMKAVGD6XYXqF33A/qw9sTdCpxBIVsm+?=
 =?us-ascii?Q?ZeChwP7TtEiaOquHltODlJu8hfN/DpsQT1vqbocYfIGhI4ZBlflGQmfrMqrh?=
 =?us-ascii?Q?9NVhLylZcUHoosk7nyzl6sE7OSGiGwuRSsKElCuoXtJHeJrr+OykrHUwSF6q?=
 =?us-ascii?Q?Y1ygm1uZwtXTJYk035aYy4vb6EKsS+xjDkQ6+po5U/ri9XSS/1HdJIEC48mh?=
 =?us-ascii?Q?jZdmXLpv8Y8V9+FRYTb7w9klCDwxhzYDSmf5Zt6LyfIpv9EXZHKw8/LDsUNJ?=
 =?us-ascii?Q?FX45QTH44imT69PhK8Jikva5z3R88YSfLSPU2q4IrwhflRaADa6dLzu2PXnG?=
 =?us-ascii?Q?tiJZsCsxxHpTO4FSYl/dldLsoorspbNlkTIZAcFL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a819ab-e38f-4126-de77-08dcb7bf836c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 15:33:55.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/dyLrt4ZTugRHCM7k+Zlb8w8BI3aaP8AFnjnt7nI30bXCGNIihLfh/LFza/Mz9XoWA9RdiQZ9rv0BAzVQtoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3614

> Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violatio=
n and
> avoid unnecessary doorbell rings
>=20
> On Wed,  7 Aug 2024 16:17:06 -0700 longli@linuxonhyperv.com wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> >
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> no empty lines between trailers please

I'm sending v3 to fix this.

