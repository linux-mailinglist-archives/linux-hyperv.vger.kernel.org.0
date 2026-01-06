Return-Path: <linux-hyperv+bounces-8167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485CCFB28F
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 22:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69317301A198
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13285229B12;
	Tue,  6 Jan 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K8rQ7w8L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022077.outbound.protection.outlook.com [40.107.209.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79801534EC;
	Tue,  6 Jan 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736237; cv=fail; b=IAT/jSLR+j91CPNDNCp9TAMlmY4n3qBlRTjshpmb6hRDzUI4AzPjdTiEIK/sBV+Zuw0H1t83nnWefZalT3jSSjRdEP/8zTEVlrXH6cn2sER7arYAK4akT9RtOc8m5GzJxo39eGEq0ckJ2R64qDUavQW4RCZNulz8nMSfYdZNLdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736237; c=relaxed/simple;
	bh=iSavtyWakn3IWL5ZSZFG5XH1WPzxtl/SSiI6zODgGg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HULzDoWxeIwIoDmWVThl0SpLgGQumpWLovPF8rz1hJslp81Fzc5GG4dU7pX9vdupNOUJ9I0ROGs6Q/mIhEzDbaUBr8H2MtUmGuIHbK6Dx39uILi6/OlewwrII2dLh6QnbBROtxR87dtrVhn/P8nxX/yyfZGezFxBcV3TNcAlM8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=K8rQ7w8L; arc=fail smtp.client-ip=40.107.209.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neIr0eVb/qbASDn67pnJS45IsojWt6cCK9Q9Df8GssPe4IDkJTcQ8I+pXAKsoByjxA/HYwusICR28HORkAuYJBdYQfTCz7BXLZV38RwzWHqW7b13pE8B9HNJttovw0jZCI5sQeAudZ2XPB3orcyRoLzZKS0lT8gbXDDZ3cWMf2qiE4vzqfv1QQq4YmmcN/g0sbJmg8F6oxUBj5mI+dZraY1q+3E8mfha+5dmcu4T3WKnzPN3HHFkAQ4x+rRiJ+s2QUskKhkY3mYWpfMdiwdW+ggYxuJq66oymlCS6plihI+kYSSLyxT0QMu0niF5u8Rr1VAvytq9zYRkvoJ93D+MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7PxKr6jBiClUcnSXpX3ikzlvzCtswgDKaIAGTP8Fns=;
 b=Qknk10oSQUUX5y1JFYDZys4+ZEvw0d7l76nslELVH7+rWbG9ElqobUjsfjE3KNsKAZs67GjPKDMDLAYV7+Bnfk1uPeu/LKOBsxRFJKEkfYY3SWHdC6rIbaXJMG+M5svAPgv4pReIt3IhaMw2X0FZABB2Oa6dOQpts4M0X2IxLJFFGQI7bQynU/+JxdgjdlMTlBHh546FC5nEEkDmBRXx2EXj4EMSESs2mdgsQiRifdZha3qMznoI9AqaBcQzzbeUMOMT+FIuKv0gisjKujBHCgcSAOl3Apoj1CrqS518RJ+RVC824yp0GM4mswrvYMeBzIGjwqXsxFb2T8epVbdGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7PxKr6jBiClUcnSXpX3ikzlvzCtswgDKaIAGTP8Fns=;
 b=K8rQ7w8L8HPdzLpjr9y1jqW/Ld50e7G8KpPje9OVCMw2PhbUeeADKFLVVLE16YdmX2dp2oPuLhAVz9iD4Sa7ZpxOrGhr+yU4r8S9xdi+PZN11YOobIg374qH8VloQ1ouZ9OqkfLLjlUshMFo14PeeiGlK4mujXztfNpk/WCm42A=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB6894.namprd21.prod.outlook.com (2603:10b6:8:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Tue, 6 Jan
 2026 21:50:32 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9520.000; Tue, 6 Jan 2026
 21:50:32 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH V2,net-next, 1/2] net: mana: Add support for coalesced RX
 packets on CQE
Thread-Topic: [PATCH V2,net-next, 1/2] net: mana: Add support for coalesced RX
 packets on CQE
Thread-Index: AQHcf02osZCDCEjN0kCleL7R3aE9OLVFrjrA
Date: Tue, 6 Jan 2026 21:50:32 +0000
Message-ID:
 <DS3PR21MB573519683081B9E6B1463BFFCE87A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
 <1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=022ed2dc-6fec-487d-9b83-6966fba45278;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-06T21:50:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB6894:EE_
x-ms-office365-filtering-correlation-id: cc1b87dc-69b6-4033-2c66-08de4d6d9d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fvzl8wOLFc9pHGakHBpu4I57CiPVxiLbhCNRZbcRbPyIoqyXf1cSSJQUPtkT?=
 =?us-ascii?Q?wAE+6oQfNRTpGkbGcsP3SfW+PmN89jYp0EtvIDP1POqKL/usrMNoLuGy2Ln9?=
 =?us-ascii?Q?wXddcKl2bs5BZUlMIZM5Me0Nn4LGi2HjQDTm4iV0WWm6elEtMsbif73xtzG9?=
 =?us-ascii?Q?uD1kcKh0ODemGIbVV52P65w7k+Ok9FXpO9IC9M2w0lIdm/vpuW1zEHbFf7uE?=
 =?us-ascii?Q?/R7obZuLQk/B4KVZIKb39sxo/erBg7WmHMuRjULzRJPndOgtpB0zQ/S9Ch1c?=
 =?us-ascii?Q?XhUcm1ICnv8eQ2cbNkZ5tXeSWlgzacVyo+kaEjEve3CHNOR8OTpJuDP0v6vz?=
 =?us-ascii?Q?VZGirO21hfTfBipA0Qgy1zJi5G+d6rzmXqTeq4Hfi8p9aYG+OAklsyfZpQhV?=
 =?us-ascii?Q?zwr0DmwUAH2B/vHHqoLs36IzlM420+Nqp/gNrh9GdMctRzjs/d2lIdO6sOno?=
 =?us-ascii?Q?nCRRYxsrbR4I69wywau27w0SoN4DkTux/2aYNVSO2z7csDgGXS1p9ITQAMe7?=
 =?us-ascii?Q?LSj0XDNGe/cVfAHPBRJcXXu3wMXDbnjAi9EGxXBSNQX7+AWzUsFPB6dfN6nF?=
 =?us-ascii?Q?68Gci/7qxFxbaZ1DT5HH/So8q6nfQ1n0/73LaZfDUzYRFi3Gq7gltwxa0cBu?=
 =?us-ascii?Q?FdX2YoTQe0fRrW5eUHQLoiD9IoUAnhR40pFyYXYGx/JriOf5WzFYe4eqpAun?=
 =?us-ascii?Q?Jt3dFBUs447L4FLmE4sLz2Mk6Ld2L+8BiQT2VcGNEdfuLU7spm3JsSWFm6Hl?=
 =?us-ascii?Q?deS3paIk7v691CaGSi5H9RCsw9xuGc3LHvXAr9WuFavlQ4KbSxn3VUv+6gJF?=
 =?us-ascii?Q?jlu+Oh1dTRJvlqNPmzkBUDLhyzlDtnff7ewwVCtzAPNEDy690PtoH5z+3WYM?=
 =?us-ascii?Q?AxZbRJ3bmVlXAeN2DByTiKho0dB8n5/q2M4o2RUnjnDWsG+p93SG1p10axee?=
 =?us-ascii?Q?mZnT88bbmMat0K/paKUXbBL2KdWAwAAkeaNErcnJqUVRCpzM0QP9mT2LjGSq?=
 =?us-ascii?Q?JVVv8cWwgcG3tt56u1EnKSDd2Y/hz/aVIixwWtzwiAzBOMhE8RYMjpfVP5zm?=
 =?us-ascii?Q?APlPEQcWem4lWjcePTiAlx+6lPPxnodRcDcpnNMBy6xiFywkGfRX5suc8nwx?=
 =?us-ascii?Q?tPayI4ETTG/+cgTfZmqNA9/jfoXwoGlJYjP5z2ONP6eiH7ySU3k6pzA2gVeT?=
 =?us-ascii?Q?xCjbxoB0qcNIonAe+l7Esok1MnK9VPmoQTdvWQJ/31nmb11AJ9eVEdS3eUxO?=
 =?us-ascii?Q?ecAfBIwU+v7utqnZbupFuDhxPdbXknDVEFDRlFZ2hOBZh1YD2UY3fNqUJFjL?=
 =?us-ascii?Q?4ibnxrG9+FaooTs2R/mVTsqqpvFo56tqsDCmPIrRR/vdNNJl+FpyhX1PMYvY?=
 =?us-ascii?Q?CLwuCVAL4ghKipUM47DXkOSv2ffXM1Sa0osNv6y1fXt5cEwbYzUl56juJ9pn?=
 =?us-ascii?Q?xSz9Ye9ks4q/z5IZJZfXqfmKTyrl14PwgPcK7qHd0OPfvNlbbd+D/1cC21Rg?=
 =?us-ascii?Q?HP+6mA9WsfMXoVJtliFQcdBn+KX7yV6p+jNmlK3dYBLzUAiRMY8BtT+phw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tzk2Uc0SZ3P79pX9FqMCsiUR/4rHrSQ3vyMD2Fd/MR7iGhuDRraqXSLOMzPR?=
 =?us-ascii?Q?fJGjPLaYxPx578uha+E2dX3qwlw8BxNGZ3o9NVl41Wd1edSdH1U1qsmK6/vz?=
 =?us-ascii?Q?U2H/odMGipqYUnltIcJWtq7K6H9xRV6GQgBV8b3iqgz9tWwRSW2fLCSqm9oM?=
 =?us-ascii?Q?K7cNyeESmXzALhKZy7emU2cjOGRI9UcXo0YhgJBzS/oZPEIawW3B/n5r7mKU?=
 =?us-ascii?Q?KnXpr+LyJM2GLbDt33rrDMfG9vMKdHQPGh+Yw0ry59HiqY4kSds/1G/a6SJ9?=
 =?us-ascii?Q?+0RsMwgPzuoJtnXZk/ngtSOpcoSZHVaXeyntob8XOMfd+CNQDrraUdZhokBN?=
 =?us-ascii?Q?Lrg4GLt8uIw9jg6ub/PK6nbQFR7556nwV3LJLwQDyNmCKRZEunKbdD5GVRE9?=
 =?us-ascii?Q?VESskmAjg98jlS9ab4H/lzh6d2KGQU3O1qiT7GiNOf6K7aF/ISmw+7GkA4I6?=
 =?us-ascii?Q?Nltxk0WPyH+IqP63dKDCwAyJod+BO2hEF5HPFVUgARqwkhJLa2oClPMBbVm7?=
 =?us-ascii?Q?12XsOITR/qnfWTrxlWhBV8rl5tZSPnyolLjNrWoJIhG9F82kycTpRZHCjYvZ?=
 =?us-ascii?Q?IInGv3esMLgPnFQ3VS22nkDOHiXpq8smSzi0ia0HJ3JBx4Yn4YkXCkho6PW6?=
 =?us-ascii?Q?XICB07O82X3qpv38+1B88UXvH2WxDgSvIHoBfzyHriXmrOkA7L99quEkRB7y?=
 =?us-ascii?Q?5Dl/JG4yhONb45TZ84aekrDSxHEE+Ybmux716DGZnoBvdoXqf3qWFep/EJkv?=
 =?us-ascii?Q?DsHBIkUXmtkK7kmgSL5G3o9Dl38R+mKHUxZ8l+O89xLmQCat5BuXpWmtWlDT?=
 =?us-ascii?Q?GINr21pB5I21qkXjygJJ46asCJw//W/SOecz2imfVVqemZF6jpxWHTKA0+J4?=
 =?us-ascii?Q?arD41FQiyVkU8QN6CTEQj36h0I2oFJ8fOhnzEvlFbr2+StvWjU9K9cttUq3O?=
 =?us-ascii?Q?fqbO1q7POv3yi8BWIVBXgrGjCN/uTGOGmpMe6/IXqISQ9duBs7i0tWfB4d6w?=
 =?us-ascii?Q?+9kr/BaBiMmdEN8Fix9mLadOCMsHWGki8WaUpAy2ByFaAkKAes/ElGf4MGSY?=
 =?us-ascii?Q?0EMRjOhZgwicJmdT0FHxA4xrUvuoDHC1Ic02V3i8xYFIhQr6czuNZuTuFjZC?=
 =?us-ascii?Q?x5+sodiTOYJ882qY08BaQXI9zGdWtmcLM24KhM2bm9V2CdoBc69JNZuhL1by?=
 =?us-ascii?Q?zxouilTIIgy/0IDlIYX0Zu8PEHlsHiiHoO+go48cO3xWDW9w+rrvGCiPMdpz?=
 =?us-ascii?Q?QJxtNMHZuEeD2mh/NQJlW6I6r9hV5Vy1zoKUC2p+4qw+j9e0EtF4w/Bq3I6C?=
 =?us-ascii?Q?7kCQ6KZLjB9VtmVQAMQ6FoMj7gZkmTHKBPytXno6m5foBRsOi/BFF5hBRd1i?=
 =?us-ascii?Q?yQAet3gp2A5EV7U+z+z2SVgtoT8sGcOd+B29GMyZEdArBfUmu3rbDRdsFlfa?=
 =?us-ascii?Q?S6IjiA4dZCiujzBOZ7M0CUs1pN9F8cLTHgNg9Bo3CokuO4TyvIEcezugJAvW?=
 =?us-ascii?Q?Irq8aPtLoMKN5/CrxUvkQ+zn1L+n8juHqJABEBxbBpjS897ujqgyFoK9glbC?=
 =?us-ascii?Q?NCSDR5Y6qFMauWr7cYQJUsjrsVlVL4FkrftWbOUDVLR91j/IbjmvrqebY0Mb?=
 =?us-ascii?Q?Ht/XOJGlyrL31m4I/t+N6cFGodcXZJ42qgMEHujAdFLP+0qZSdD1rweTwxAe?=
 =?us-ascii?Q?mD75Zg85dXcf6DWZ+zd64u962C0DMv3GbPbt9zUD7W5wGVA8?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1b87dc-69b6-4033-2c66-08de4d6d9d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 21:50:32.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 059ezR9dvnmaPjzhxPPCyDSvUiO5C1dAVIQOzhibDFfzPqOW4gnQ3sMDq0bLwxjjo45EnQxAQcKA18abiBVPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6894

> Subject: [PATCH V2,net-next, 1/2] net: mana: Add support for coalesced RX
> packets on CQE
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Our NIC can have up to 4 RX packets on 1 CQE. To support this feature, ch=
eck
> and process the type CQE_RX_COALESCED_4. The default setting is disabled,
> to avoid possible regression on latency.
>=20
> And add ethtool handler to switch this feature. To turn it on, run:
>   ethtool -C <nic> rx-frames 4
> To turn it off:
>   ethtool -C <nic> rx-frames 1
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> V2:
>   Updated extack msg, as recommended by Jakub Kicinski, and Simon Horman.
>=20
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 32 ++++++-----
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 55 +++++++++++++++++++
>  include/net/mana/mana.h                       |  2 +
>  3 files changed, 74 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 1ad154f9db1a..a46a1adf83bc 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1330,7 +1330,7 @@ static int mana_cfg_vport_steering(struct
> mana_port_context *apc,
>  	req->update_hashkey =3D update_key;
>  	req->update_indir_tab =3D update_tab;
>  	req->default_rxobj =3D apc->default_rxobj;
> -	req->cqe_coalescing_enable =3D 0;
> +	req->cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
>=20
>  	if (update_key)
>  		memcpy(&req->hashkey, apc->hashkey,
> MANA_HASH_KEY_SIZE); @@ -1864,11 +1864,12 @@ static struct sk_buff
> *mana_build_skb(struct mana_rxq *rxq, void *buf_va,  }
>=20
>  static void mana_rx_skb(void *buf_va, bool from_pool,
> -			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
> +			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq,
> +			int i)
>  {
>  	struct mana_stats_rx *rx_stats =3D &rxq->stats;
>  	struct net_device *ndev =3D rxq->ndev;
> -	uint pkt_len =3D cqe->ppi[0].pkt_len;
> +	uint pkt_len =3D cqe->ppi[i].pkt_len;
>  	u16 rxq_idx =3D rxq->rxq_idx;
>  	struct napi_struct *napi;
>  	struct xdp_buff xdp =3D {};
> @@ -1912,7 +1913,7 @@ static void mana_rx_skb(void *buf_va, bool
> from_pool,
>  	}
>=20
>  	if (cqe->rx_hashtype !=3D 0 && (ndev->features & NETIF_F_RXHASH)) {
> -		hash_value =3D cqe->ppi[0].pkt_hash;
> +		hash_value =3D cqe->ppi[i].pkt_hash;
>=20
>  		if (cqe->rx_hashtype & MANA_HASH_L4)
>  			skb_set_hash(skb, hash_value, PKT_HASH_TYPE_L4);
> @@ -2047,9 +2048,11 @@ static void mana_process_rx_cqe(struct
> mana_rxq *rxq, struct mana_cq *cq,
>  	struct mana_recv_buf_oob *rxbuf_oob;
>  	struct mana_port_context *apc;
>  	struct device *dev =3D gc->dev;
> +	bool coalesced =3D false;
>  	void *old_buf =3D NULL;
>  	u32 curr, pktlen;
>  	bool old_fp;
> +	int i =3D 0;
>=20
>  	apc =3D netdev_priv(ndev);
>=20
> @@ -2064,9 +2067,8 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
>  		goto drop;
>=20
>  	case CQE_RX_COALESCED_4:
> -		netdev_err(ndev, "RX coalescing is unsupported\n");
> -		apc->eth_stats.rx_coalesced_err++;
> -		return;
> +		coalesced =3D true;
> +		break;
>=20
>  	case CQE_RX_OBJECT_FENCE:
>  		complete(&rxq->fence_event);
> @@ -2079,14 +2081,10 @@ static void mana_process_rx_cqe(struct
> mana_rxq *rxq, struct mana_cq *cq,
>  		return;
>  	}
>=20
> -	pktlen =3D oob->ppi[0].pkt_len;
> -
> -	if (pktlen =3D=3D 0) {
> -		/* data packets should never have packetlength of zero */
> -		netdev_err(ndev, "RX pkt len=3D0, rq=3D%u, cq=3D%u,
> rxobj=3D0x%llx\n",
> -			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> +nextpkt:
> +	pktlen =3D oob->ppi[i].pkt_len;
> +	if (pktlen =3D=3D 0)
>  		return;
> -	}
>=20
>  	curr =3D rxq->buf_index;
>  	rxbuf_oob =3D &rxq->rx_oobs[curr];
> @@ -2097,12 +2095,15 @@ static void mana_process_rx_cqe(struct
> mana_rxq *rxq, struct mana_cq *cq,
>  	/* Unsuccessful refill will have old_buf =3D=3D NULL.
>  	 * In this case, mana_rx_skb() will drop the packet.
>  	 */
> -	mana_rx_skb(old_buf, old_fp, oob, rxq);
> +	mana_rx_skb(old_buf, old_fp, oob, rxq, i);
>=20
>  drop:
>  	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob-
> >wqe_inf.wqe_size_in_bu);
>=20
>  	mana_post_pkt_rxq(rxq);
> +
> +	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
> +		goto nextpkt;
>  }
>=20
>  static void mana_poll_rx_cq(struct mana_cq *cq) @@ -3276,6 +3277,7 @@
> static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	apc->port_handle =3D INVALID_MANA_HANDLE;
>  	apc->pf_filter_handle =3D INVALID_MANA_HANDLE;
>  	apc->port_idx =3D port_idx;
> +	apc->cqe_coalescing_enable =3D 0;
>=20
>  	mutex_init(&apc->vport_mutex);
>  	apc->vport_use_count =3D 0;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 0e2f4343ac67..b2b9bfb50396 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -397,6 +397,58 @@ static void mana_get_channels(struct net_device
> *ndev,
>  	channel->combined_count =3D apc->num_queues;  }
>=20
> +static int mana_get_coalesce(struct net_device *ndev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack) {
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +
> +	ec->rx_max_coalesced_frames =3D
> +		apc->cqe_coalescing_enable ?
> MANA_RXCOMP_OOB_NUM_PPI : 1;
> +
> +	return 0;
> +}
> +
> +static int mana_set_coalesce(struct net_device *ndev,
> +			     struct ethtool_coalesce *ec,
> +			     struct kernel_ethtool_coalesce *kernel_coal,
> +			     struct netlink_ext_ack *extack) {
> +	struct mana_port_context *apc =3D netdev_priv(ndev);
> +	u8 saved_cqe_coalescing_enable;
> +	int err;
> +
> +	if (ec->rx_max_coalesced_frames !=3D 1 &&
> +	    ec->rx_max_coalesced_frames !=3D MANA_RXCOMP_OOB_NUM_PPI)
> {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "rx-frames must be 1 or %u, got %u",
> +				   MANA_RXCOMP_OOB_NUM_PPI,
> +				   ec->rx_max_coalesced_frames);
> +		return -EINVAL;
> +	}
> +
> +	saved_cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> +	apc->cqe_coalescing_enable =3D
> +		ec->rx_max_coalesced_frames =3D=3D
> MANA_RXCOMP_OOB_NUM_PPI;
> +
> +	if (!apc->port_is_up)
> +		return 0;
> +
> +	err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> +
> +	if (err) {
> +		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
> +			   ec->rx_max_coalesced_frames, err);
> +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed",
> +				   ec->rx_max_coalesced_frames);
> +
> +		apc->cqe_coalescing_enable =3D saved_cqe_coalescing_enable;
> +	}
> +
> +	return err;
> +}
> +
>  static int mana_set_channels(struct net_device *ndev,
>  			     struct ethtool_channels *channels)  { @@ -517,6
> +569,7 @@ static int mana_get_link_ksettings(struct net_device *ndev,  }
>=20
>  const struct ethtool_ops mana_ethtool_ops =3D {
> +	.supported_coalesce_params =3D
> ETHTOOL_COALESCE_RX_MAX_FRAMES,
>  	.get_ethtool_stats	=3D mana_get_ethtool_stats,
>  	.get_sset_count		=3D mana_get_sset_count,
>  	.get_strings		=3D mana_get_strings,
> @@ -527,6 +580,8 @@ const struct ethtool_ops mana_ethtool_ops =3D {
>  	.set_rxfh		=3D mana_set_rxfh,
>  	.get_channels		=3D mana_get_channels,
>  	.set_channels		=3D mana_set_channels,
> +	.get_coalesce		=3D mana_get_coalesce,
> +	.set_coalesce		=3D mana_set_coalesce,
>  	.get_ringparam          =3D mana_get_ringparam,
>  	.set_ringparam          =3D mana_set_ringparam,
>  	.get_link_ksettings	=3D mana_get_link_ksettings,
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> d7e089c6b694..51d26ebeff6c 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -556,6 +556,8 @@ struct mana_port_context {
>  	bool port_is_up;
>  	bool port_st_save; /* Saved port state */
>=20
> +	u8 cqe_coalescing_enable;
> +
>  	struct mana_ethtool_stats eth_stats;
>=20
>  	struct mana_ethtool_phy_stats phy_stats;
> --
> 2.34.1


